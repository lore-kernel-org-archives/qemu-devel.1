Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E576BC11D24
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 03:53:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B72B42071E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 03:53:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B72B42071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4zNt-0000tE-Qp
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 22:53:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39514)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aik@ozlabs.ru>) id 1j4zN8-0000Fh-DT
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 22:53:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>) id 1j4zN6-0002gj-11
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 22:53:00 -0500
Received: from [107.174.27.60] (port=56490 helo=ozlabs.ru)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>)
 id 1j4zN5-0002ei-Ro; Thu, 20 Feb 2020 22:52:59 -0500
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id 06A30AE80016;
 Thu, 20 Feb 2020 22:50:53 -0500 (EST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PULL SUBSYSTEM qemu-pseries] pseries: Update SLOF firmware image
Date: Fri, 21 Feb 2020 14:52:25 +1100
Message-Id: <20200221035225.52777-1-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 107.174.27.60
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 438bafcac55308eef4f9029c94dbadd2c7ac3bb7:

  hw/ppc/virtex_ml507:fix leak of fdevice tree blob (2020-02-21 09:15:04 +1100)

are available in the Git repository at:

  git@github.com:aik/qemu.git tags/qemu-slof-20200221

for you to fetch changes up to fcd350cb4646255845f643cdb1711bb7004038e7:

  pseries: Update SLOF firmware image (2020-02-21 14:20:23 +1100)

----------------------------------------------------------------
Alexey Kardashevskiy (1):
      pseries: Update SLOF firmware image

 pc-bios/README   |   2 +-
 pc-bios/slof.bin | Bin 931032 -> 968616 bytes
 roms/SLOF        |   2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)


*** Note: this is not for master, this is for pseries

The full changelog is:

Alexey Kardashevskiy (10):
      disk-label: Prepare for extenting
      disk-label: Support Linux GPT partition type
      ext2: Prepare for extending
      ext2: Rename group-desc-size
      ext2: Read size of group descriptors
      ext2: Read all 64bit of inode number
      ext2/4: Add basic extent tree support
      elf64: Add LE64 ABIv1/2 support for loading images to given address
      fdt: Fix creating new nodes at H_CAS
      version: update to 20200221

Greg Kurz (2):
      fdt: Fix update of "interrupt-controller" node at CAS
      fdt: Delete nodes of devices removed between boot and CAS

Stefan Berger (8):
      slof: Implement SLOF_get_keystroke() and SLOF_reset()
      slof: Make linker script variables accessible
      qemu: Make print_version variable accessible
      tpm: Add TPM CRQ driver implementation
      tpm: Add sha256 implementation
      tcgbios: Add TPM 2.0 support and firmware API
      tcgbios: Implement menu to clear TPM 2 and activate its PCR banks
      tcgbios: Measure the GPT table

