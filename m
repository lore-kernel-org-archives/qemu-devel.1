Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8A3C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 16:19:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08C5F20678
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 16:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7nZrsJk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08C5F20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9tiy-00032x-HG
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 12:19:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58699)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1i9shq-00064M-L6
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 11:14:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1i9shp-0003f8-AC
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 11:14:22 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:34728)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1i9shp-0003ew-3L
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 11:14:21 -0400
Received: by mail-wm1-x329.google.com with SMTP id y135so255126wmc.1
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 08:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ueb98aswQZ79aQIE2YKQ9MRnhUs2HLhGCVoxTGHIz6Q=;
 b=D7nZrsJksFkuExPuPU5XQNhb6ZNtsUDdT9PBFZpazA9RAGvay5rJ5fighkRnAGBfTT
 x8cxGBafyHfv0f8AhbdK9lQ9VjU9kXOzcJDw0lz72jfyMzdPniBi5oUPNbHvhO5PApAt
 bozv30fs+GlaAtLL1nc9DFnf+820qz6RBW3z568kUjw0BmVvIMV/iSiK8FvZ3qNS6I6v
 7HsxrdH98w75fUqeJJ44BazoMOahAZ3kjp5jgKjXpatQwpLAP7H/8FCPdIc/mhvtE0ZG
 FreNLBi+BL/iX1FQxt+DgCs1Y0H1qBExzZbjizPBVVsKZ7UNBYykGlSgTRXSDHDBK1Rt
 6kqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=ueb98aswQZ79aQIE2YKQ9MRnhUs2HLhGCVoxTGHIz6Q=;
 b=nNM8JaDHRF4k5TmrZPi8/khkBCGYec5mXastVpBpQyG0/k9x0DM3i6uAaklpQFGd8w
 +8tkkjBD+lUd+T6Jf6G58P4O8+zjxBkOZlHYpwqDyNLZ4Kmk6TWc4MWaq84k8TgcFYft
 xHl199HFk3qr++4MIewuv6AFKHo+6MqlB68PCSuNzv+xG7NNp6KxDU5MPsIgIOMiQeuP
 5u+8SMWhNuZyNP0IAytjupyi7UhuPSGhM4AI8CabkxZpv6v4YX85fyUYBApRwuUj53jY
 0igIIqbC3TO9ikGseda+TbIXtSok1JAy+1PDZe2H3DCO3f+wr+4rgcde/50Aul9NMq1x
 knvQ==
X-Gm-Message-State: APjAAAWfxJsz1vM6emRw6C0DHTtKYgYgDMr8KJP7WkiIgx5QxrvofkVE
 1Zuh1vcmVJVWLKX/8ogNUieuo/ku
X-Google-Smtp-Source: APXvYqwteJC236rqaedRqpP6le+tfJ4CMfGjhKERs/U1UZqo/5lazovMRolFbX8J3JAqSYpST2rP/g==
X-Received: by 2002:a1c:bcd6:: with SMTP id m205mr19748wmf.129.1568646859732; 
 Mon, 16 Sep 2019 08:14:19 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id f18sm14343719wrv.38.2019.09.16.08.14.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Sep 2019 08:14:19 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 16 Sep 2019 17:14:18 +0200
Message-Id: <1568646858-17065-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::329
Subject: [Qemu-devel] [PULL v2 00/29] Misc patches for 2019-09-16
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

for you to fetch changes up to 149c50cabcc4ea46a460d35fc876346ed441304c:

  hw/i386/pc: Extract the x86 generic fw_cfg code (2019-09-16 17:13:09 +0200)

----------------------------------------------------------------
* Fix Patchew CI failures (myself)
* i386 fw_cfg refactoring (Philippe)
* pmem bugfix (Stefan)
* Support for accessing cstate MSRs (Wanpeng)
* exec.c cleanups (Wei Yang)
* Improved throttling (Yury)
* elf-ops.h coverity fix (Stefano)

----------------------------------------------------------------
v1->v2: missing S-o-b lines

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

