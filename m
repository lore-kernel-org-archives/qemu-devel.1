Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0CCC49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 15:31:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB099206A4
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 15:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/DIsMkI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB099206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9syo-000530-VK
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 11:31:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53549)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1i9sCl-0006Fn-Gd
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:42:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1i9sCj-0007P0-M2
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:42:15 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:54505)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1i9sCj-0007OS-Bl
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:42:13 -0400
Received: by mail-wm1-x32a.google.com with SMTP id p7so59100wmp.4
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 07:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5LrGyDNsdD46INRIIwC8/sGjqFgbKTMxJiEM1s6Y8Nw=;
 b=X/DIsMkII3hFrP7umXvdAJ1b7+gPkvCy/nvQbVAlZFXBmkvmFGJrEHp1kEKwJPbpmJ
 nNZgmSzfaYlRlsjbAWXNt7QW/uBXVrEnbPb8ZNFWm1jI479mnzx8x3FSVNexHeOQPtC2
 ihaRyzOAaZpjH4Cfh8r6hVcKDXE13H6d2vjuKGH8I5YQY0Qe3AtLY1VcCoBFe7vNZD0j
 bn17RDfg+YZakBgsewYghRy7FYJGHsEbYswponG5SEZfi/7cQNhTeYDmnQHvPsxjxEdX
 4ssZmZIWVhvieJWkvVDyOuq8APukDoHhqZOR/4vyhwfW5S667piK3sE2eRiHfpHYcQkp
 DQVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=5LrGyDNsdD46INRIIwC8/sGjqFgbKTMxJiEM1s6Y8Nw=;
 b=EMTeX/5qrp9MiktY9kf0A76kRNNFOxG0GMp9G9wII4zOEyeUPsAAcUrG3JYmABkxUo
 HkrC25MmjVdyYXXXOdCODWbk3bl+8If9k63zJWcyaWQVBB04JNJ8kKJ4o9mIIN1mU+0G
 Cnu3U0r4sKLt3dEBbIm3MwsGAucHiREufT0BSXOCBBAuHbaqVUsMRRvrhXxrMqgLwT5c
 yF7j57QltqK5LiDgUMO545YiwG4/c8VLmfk6MFAb/TIsA/HOBmWzOeWOD0dL4Kq/RbQG
 P3kG9erFNWbSi22IEPqToCqkA4UdQryE5u0nms7Toxt5nyNWL9T62EyplA4XLEQMzGFF
 LQpg==
X-Gm-Message-State: APjAAAXUnxeuGqBBXS1ZEXQsYH+QU3GSwnXyHdM0ooZddsuihZOa5r3l
 ATzmBPMyaytHxHLiN9Ev9a5Yo1HN
X-Google-Smtp-Source: APXvYqya1mAivG6/4d6do6vV0+cxsv4TYZrX4SZLAmuFpxoEOXP6Ner0lPWQGtvjrkdVputw+Jkdsw==
X-Received: by 2002:a1c:c104:: with SMTP id r4mr73159wmf.64.1568644930928;
 Mon, 16 Sep 2019 07:42:10 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id i14sm17024298wra.78.2019.09.16.07.42.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Sep 2019 07:42:10 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 16 Sep 2019 16:41:40 +0200
Message-Id: <1568644929-9124-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32a
Subject: [Qemu-devel] [PULL 00/29] Misc patches for 2019-09-16
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 138985c1ef8b66e4e5b383354e133e05d01d0b5f:

  Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-sep-12-2019' into staging (2019-09-13 16:04:46 +0100)

are available in the git repository at:


  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to b29799d93fde775ef7e4104c834a1c1da15b34c3:

  hw/i386/pc: Extract the x86 generic fw_cfg code (2019-09-16 14:39:03 +0200)

----------------------------------------------------------------
* Fix Patchew CI failures (myself)
* i386 fw_cfg refactoring (Philippe)
* pmem bugfix (Stefan)
* Support for accessing cstate MSRs (Wanpeng)
* exec.c cleanups (Wei Yang)
* Improved throttling (Yury)
* elf-ops.h coverity fix (Stefano)

----------------------------------------------------------------
Cole Robinson (1):
      hw/i386: Move CONFIG_ACPI_PCI to CONFIG_PC

Paolo Bonzini (4):
      win32: fix README file in NSIS installer
      test-char: fix AddressSanitizer failure
      memory: inline and optimize devend_memop
      hw/i386/pc: Replace PCMachineState argument with MachineState in fw_cfg_arch_create

Philippe Mathieu-Daudé (14):
      hw/i386/pc: Use e820_get_num_entries() to access e820_entries
      hw/i386/pc: Extract e820 memory layout code
      hw/i386/pc: Use address_space_memory in place
      hw/i386/pc: Rename bochs_bios_init as more generic fw_cfg_arch_create
      hw/i386/pc: Pass the boot_cpus value by argument
      hw/i386/pc: Pass the apic_id_limit value by argument
      hw/i386/pc: Pass the CPUArchIdList array by argument
      hw/i386/pc: Let pc_build_smbios() take a FWCfgState argument
      hw/i386/pc: Let pc_build_smbios() take a generic MachineState argument
      hw/i386/pc: Rename pc_build_smbios() as generic fw_cfg_build_smbios()
      hw/i386/pc: Let pc_build_feature_control() take a FWCfgState argument
      hw/i386/pc: Let pc_build_feature_control() take a MachineState argument
      hw/i386/pc: Rename pc_build_feature_control() as generic fw_cfg_build_*
      hw/i386/pc: Extract the x86 generic fw_cfg code

Stefan Hajnoczi (1):
      memory: fetch pmem size in get_file_size()

Stefano Garzarella (1):
      elf-ops.h: fix int overflow in load_elf()

Wanpeng Li (1):
      i386/kvm: support guest access CORE cstate

Wei Yang (5):
      exec.c: replace hwaddr with uint64_t for better understanding
      exec.c: get nodes_nb_alloc with one MAX calculation
      exec.c: subpage->sub_section is already initialized to 0
      exec.c: correct the maximum skip value during compact
      exec.c: add a check between constants to see whether we could skip

Yury Kotov (2):
      qemu-thread: Add qemu_cond_timedwait
      cpus: Fix throttling during vm_stop

 backends/hostmem-file.c          |  22 -----
 cpus.c                           |  25 +++--
 default-configs/i386-softmmu.mak |   1 -
 exec.c                           |  54 ++++++++---
 hw/core/loader.c                 |   2 +
 hw/i386/Kconfig                  |   1 +
 hw/i386/Makefile.objs            |   2 +-
 hw/i386/e820_memory_layout.c     |  59 +++++++++++
 hw/i386/e820_memory_layout.h     |  42 ++++++++
 hw/i386/fw_cfg.c                 | 137 ++++++++++++++++++++++++++
 hw/i386/fw_cfg.h                 |   7 ++
 hw/i386/pc.c                     | 204 ++-------------------------------------
 include/exec/memory.h            |  19 +++-
 include/hw/elf_ops.h             |   5 +
 include/hw/i386/pc.h             |  11 ---
 include/hw/loader.h              |   1 +
 include/qemu/osdep.h             |  13 ---
 include/qemu/thread.h            |  19 ++++
 linux-headers/linux/kvm.h        |   4 +-
 memory.c                         |  18 ----
 qemu.nsi                         |   4 +-
 target/i386/kvm.c                |   4 +-
 tests/test-char.c                |  44 ++++-----
 util/oslib-posix.c               |  54 -----------
 util/oslib-win32.c               |   6 --
 util/qemu-thread-posix.c         |  41 +++++---
 util/qemu-thread-win32.c         |  17 ++++
 util/qsp.c                       |  20 ++++
 28 files changed, 456 insertions(+), 380 deletions(-)
 create mode 100644 hw/i386/e820_memory_layout.c
 create mode 100644 hw/i386/e820_memory_layout.h
-- 
1.8.3.1


