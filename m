Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B7BC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 03:35:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2A0E2076A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 03:35:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2A0E2076A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwHA9-0000Hy-WE
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 23:35:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aik@ozlabs.ru>)
 id 1jwH96-0008DF-95; Thu, 16 Jul 2020 23:34:48 -0400
Received: from [107.174.27.60] (port=40576 helo=ozlabs.ru)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aik@ozlabs.ru>)
 id 1jwH94-0006cO-6n; Thu, 16 Jul 2020 23:34:47 -0400
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id 8450AAE80047;
 Thu, 16 Jul 2020 23:24:35 -0400 (EDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PULL SUBSYSTEM qemu-pseries] pseries: Update SLOF firmware image
Date: Fri, 17 Jul 2020 13:27:05 +1000
Message-Id: <20200717032705.100809-1-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
X-Host-Lookup-Failed: Reverse DNS lookup failed for 107.174.27.60 (failed)
Received-SPF: pass client-ip=107.174.27.60; envelope-from=aik@ozlabs.ru;
 helo=ozlabs.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 23:27:10
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RDNS_NONE=0.793,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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

The following changes since commit 1038a309ec829f05a3a3e52a9951cfdb24dfd02c:

  spapr: Add a new level of NUMA for GPUs (2020-07-17 10:36:28 +1000)

are available in the Git repository at:

  git@github.com:aik/qemu.git tags/qemu-slof-20200717

for you to fetch changes up to 7f5258dd8327d574de455a2271788474fa25548d:

  pseries: Update SLOF firmware image (2020-07-17 13:23:00 +1000)

----------------------------------------------------------------
Alexey Kardashevskiy (1):
      pseries: Update SLOF firmware image

 pc-bios/README   |   2 +-
 pc-bios/slof.bin | Bin 965112 -> 968368 bytes
 roms/SLOF        |   2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)


*** Note: this is not for master, this is for pseries

This adds tcgbios (this was posted earlier [1] but got lost)
and fixes FDT update at ibm,client-architecture-support
for huge guests.

The full list of changes:

Alexey Kardashevskiy (4):
      make: Define default rule for .c when V=1 or V=2
      version: update to 20200513
      fdt: Avoid recursion when traversing tree
      version: update to 20200717

Gustavo Romero (1):
      board-qemu: Fix comment about SLOF start address

Stefan Berger (6):
      tcgbios: Only write logs for PCRs that are allocated
      tcgbios: Fix the vendorInfoSize to be of type uint8_t
      tcgbios: Add support for SHA3 type of algorithms
      elf: Implement elf_get_file_size to determine size of an ELF image
      tcgbios: Implement tpm_hash_log_extend_event_buffer
      tcgbios: Measure the bootloader file read from disk

[1] https://patchwork.ozlabs.org/project/qemu-devel/patch/20200513024355.121476-1-aik@ozlabs.ru/


