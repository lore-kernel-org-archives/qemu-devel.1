Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C9ECA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 16:55:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CC4E21721
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 16:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="UrNpSqop"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CC4E21721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP8Io-0006zK-0C
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 12:55:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34443)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@sifive.com>) id 1iP7PP-0004wb-Jp
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:58:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@sifive.com>) id 1iP7PN-0003hf-S8
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:58:19 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f]:42534)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@sifive.com>) id 1iP7PN-0003gn-M5
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:58:17 -0400
Received: by mail-pg1-x52f.google.com with SMTP id f14so7151993pgi.9
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2019 08:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=subject:date:message-id:mime-version:content-transfer-encoding:cc
 :from:to; bh=FWutZqaKlOMCwD9mfXUehfygMNwllC1f40Q7KkfNmq0=;
 b=UrNpSqopBHkLgITH7t+pnmokMPAlpNAlkmk4xCi/wUjN5DLCdTpTLDXMLbEEXBDzCe
 DtiVf7vV8eKpaFl1J7wKBY5Si9SuH3FiJeqlKv/8fdLODyKVBo+O5aCJzgMti+4g63gO
 klVVAigz5IRV+ue0DZpz0ckf7djx8nAfmggWICKKICyPFK6iYC1lK6GKSIKsQsZgaV7W
 LKMT4fxWKDDXi00TNN53k3jL0y5XncqUTENpThFNzwOSq00qJYRVeV1Y1Xl8tlGhRAFP
 tlutiVBSq3FTM5fH9SeSmVsxgXtFMctcDT7xKA9e05YqNaMkA66UtEH7Eu+T7PRAvdhm
 UZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=FWutZqaKlOMCwD9mfXUehfygMNwllC1f40Q7KkfNmq0=;
 b=f3AQ9/jviPbmCxk80iXrbxnSY6ck42z9m7GozKoub7ix+CxqbuUdB1DNQB0vZgQt2p
 zuomsFp0/Z37gIy6HrizlliZ8Rs4AI1sWzct4Y3vwJwL5w8LavcOeyw306xhta5nc4/h
 Qbnn4q+mogEEDwlhDaZPVlbjN5Txi6CHh1/erLsK7lGvEdrK3ZekKWfTKK8psRgpvor7
 MGSWSk3GHtn5WglE6smbLaYj9KZ7l8q6vPxIrDOO7MWuIUHma73Pelwim02e6884G0IN
 YKe4tHNYLcWBUKNEaoA3LsXumGq3vMBIEDDMHsnH77WC+18Czde8Hs1lsEQPbsaXNkCJ
 NdAg==
X-Gm-Message-State: APjAAAUTONoSi3WSGmnwi/HWlCYSlAm+siDgNuiSJY4M0tBNZFdVmqi6
 zAcHpNuuK8whonSFrtt1+hmzhdtRRWU6wg==
X-Google-Smtp-Source: APXvYqyVhzbKqXK5nqoDzpGDhFer1L4nvkB5E4Pc/LPVWNW33P6mfeztpoMsA9vzof8VB/f3wfWuxw==
X-Received: by 2002:a63:1c4:: with SMTP id 187mr21794646pgb.57.1572278295579; 
 Mon, 28 Oct 2019 08:58:15 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id p7sm11262841pjp.4.2019.10.28.08.58.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2019 08:58:14 -0700 (PDT)
Subject: [PULL] RISC-V Patches for the 4.2 Soft Freeze, Part 2
Date: Mon, 28 Oct 2019 08:48:44 -0700
Message-Id: <20191028154902.32491-1-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::52f
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
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

merged tag 'for_upstream'
Primary key fingerprint: 0270 606B 6F3C DF3D 0B17  0970 C350 3912 AFBE 8E67
     Subkey fingerprint: 5D09 FD08 71C8 F85B 94CA  8A0D 281F 0DB8 D28D 5469
The following changes since commit 9bb73502321d46f4d320fa17aa38201445783fc4:

  Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2019-10-28 13:32:40 +0000)

are available in the Git repository at:

  git://github.com/palmer-dabbelt/qemu.git tags/riscv-for-master-4.2-sf2

for you to fetch changes up to 9667e53573f907d4fcd6accff1c8fe525544b749:

  target/riscv: PMP violation due to wrong size parameter (2019-10-28 08:46:33 -0700)

----------------------------------------------------------------
RISC-V Patches for the 4.2 Soft Freeze, Part 2

This patch set contains a handful of small fixes for RISC-V targets that
I'd like to target for the 4.2 soft freeze.  They include:

* A fix to allow the debugger to access the state of all privilege
  modes, as opposed to just the currently executing one.
* A pair of cleanups to implement cpu_do_transaction_failed.
* Fixes to the device tree.
* The addition of various memory regions to make the sifive_u machine
  more closely match the HiFive Unleashed board.
* Fixes to our GDB interface to allow CSRs to be accessed.
* A fix to a memory leak pointed out by coverity.
* A fix that prevents PMP checks from firing incorrectly.

This passes "make chcek" and boots Open Embedded for me.

----------------------------------------------------------------
Alistair Francis (8):
      riscv/sifive_u: Add L2-LIM cache memory
      riscv/sifive_u: Add QSPI memory region
      riscv/sifive_u: Manually define the machine
      riscv/sifive_u: Add the start-in-flash property
      riscv/virt: Manually define the machine
      riscv/virt: Add the PFlash CFI01 device
      riscv/virt: Jump to pflash if specified
      riscv/boot: Fix possible memory leak

Bin Meng (3):
      riscv: Skip checking CSR privilege level in debugger mode
      riscv: hw: Drop "clock-frequency" property of cpu nodes
      riscv: sifive_u: Add ethernet0 to the aliases node

Dayeol Lee (1):
      target/riscv: PMP violation due to wrong size parameter

Giuseppe Musacchio (1):
      linux-user/riscv: Propagate fault address

Jonathan Behrens (3):
      target/riscv: Tell gdbstub the correct number of CSRs
      target/riscv: Expose "priv" register for GDB for reads
      target/riscv: Make the priv register writable by GDB

Palmer Dabbelt (2):
      RISC-V: Handle bus errors in the page table walker
      RISC-V: Implement cpu_do_transaction_failed

 configure                       |   4 +-
 gdb-xml/riscv-32bit-virtual.xml |  11 ++++
 gdb-xml/riscv-64bit-virtual.xml |  11 ++++
 hw/riscv/Kconfig                |   1 +
 hw/riscv/boot.c                 |  11 ++--
 hw/riscv/sifive_u.c             | 105 ++++++++++++++++++++++++++------
 hw/riscv/spike.c                |   2 -
 hw/riscv/virt.c                 | 129 +++++++++++++++++++++++++++++++++++++---
 include/hw/riscv/sifive_u.h     |  12 +++-
 include/hw/riscv/spike.h        |   4 --
 include/hw/riscv/virt.h         |  14 +++--
 linux-user/riscv/cpu_loop.c     |   3 +-
 target/riscv/cpu.c              |   2 +-
 target/riscv/cpu.h              |   7 ++-
 target/riscv/cpu_helper.c       |  28 ++++++---
 target/riscv/csr.c              |   5 +-
 target/riscv/gdbstub.c          |  36 ++++++++++-
 target/riscv/pmp.c              |  13 +++-
 18 files changed, 334 insertions(+), 64 deletions(-)
 create mode 100644 gdb-xml/riscv-32bit-virtual.xml
 create mode 100644 gdb-xml/riscv-64bit-virtual.xml


