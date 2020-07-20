Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD61C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 05:45:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 687E520758
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 05:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="JvzaZgmG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 687E520758
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxObs-0001RN-M8
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 01:45:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jxOYX-0005hh-T7; Mon, 20 Jul 2020 01:41:41 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:46257)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jxOYU-0005w0-5K; Mon, 20 Jul 2020 01:41:41 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4B99Zd4JwBz9sRk; Mon, 20 Jul 2020 15:41:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1595223689;
 bh=eBr4bdyEfMI0tJyIfpPTdIOeZRYk43Iz8534158RrmQ=;
 h=From:To:Cc:Subject:Date:From;
 b=JvzaZgmGdrYHT7XPdqibTs8GvfzUwblyZr/0USuLHAqhynXzMow44oy29xPea3pJM
 ehQ+iU8SLLx5OWKPs990Mtjv3YEp3cnKigy74+AKqheP+fEb9l7D1PPsAIrmftCkDn
 jF6UhJ3jVWxfM7UTR/Jpy3f9vBmYYtL65JyMXJOM=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 0/4] ppc-for-5.1 queue 20200720
Date: Mon, 20 Jul 2020 15:41:22 +1000
Message-Id: <20200720054126.258032-1-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
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
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 9fc87111005e8903785db40819af66b8f85b8b96:

  Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20200717' into staging (2020-07-19 10:29:05 +0100)

are available in the Git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-5.1-20200720

for you to fetch changes up to b25fbd6a1302c0eac5b326be3e1f828e905c0c9a:

  pseries: Update SLOF firmware image (2020-07-20 09:21:39 +1000)

----------------------------------------------------------------
ppc patch queue 20200720

Here are some assorted fixes for qemu-5.1:
 * SLOF update with improved TPM handling, and fix for possible stack
   overflows on many-vcpu machines
 * Fix for NUMA distances on NVLink2 attached GPU memory nodes
 * Fixes to fail more gracefully on attempting to plug unsupported PCI bridge types
 * Don't allow pnv-psi device to be user created

----------------------------------------------------------------
Alexey Kardashevskiy (1):
      pseries: Update SLOF firmware image

Greg Kurz (2):
      ppc/pnv: Make PSI device types not user creatable
      spapr_pci: Robustify support of PCI bridges

Reza Arbab (1):
      spapr: Add a new level of NUMA for GPUs

 hw/ppc/pnv_psi.c            |   1 +
 hw/ppc/spapr.c              |  21 +++++++++++++++--
 hw/ppc/spapr_pci.c          |  56 ++++++++++++++++++++++++++++++++++++++++++++
 hw/ppc/spapr_pci_nvlink2.c  |  13 +++++++---
 include/hw/pci-host/spapr.h |   1 +
 include/hw/ppc/spapr.h      |   1 +
 pc-bios/README              |   2 +-
 pc-bios/slof.bin            | Bin 965112 -> 968368 bytes
 roms/SLOF                   |   2 +-
 9 files changed, 90 insertions(+), 7 deletions(-)

