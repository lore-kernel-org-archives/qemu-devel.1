Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BD6C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 06:43:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A25622076E
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 06:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="o3NjFEML"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A25622076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joi4o-0005tc-Tm
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 02:43:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49730)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1joi2O-0001Pb-CX; Fri, 26 Jun 2020 02:40:36 -0400
Received: from ozlabs.org ([203.11.71.1]:38655)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1joi2K-0001EP-JQ; Fri, 26 Jun 2020 02:40:36 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49tS1l3vFwz9sSc; Fri, 26 Jun 2020 16:40:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1593153627;
 bh=Ws6WPAfD6wiH7b15S4gArdEi5/jRjb5OfT645wiMVxI=;
 h=From:To:Cc:Subject:Date:From;
 b=o3NjFEMLu3rzQvSYoMBCIBFXpV5SztyZrCOOZ7OilMOi7YD8YWBcnricfcPJhZ+OI
 eUvvM3l73rf+FIJMQC0aqU8OuUPo01gYPidRrMNHWo1bhd+EtxIAuPERw4s0qBjlEo
 QaZ/vKDIgxa+pWa6szhM5FyUDDM2IoCLPMyd6q1w=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 0/4] ppc-for-5.1 queue 20200626
Date: Fri, 26 Jun 2020 16:40:20 +1000
Message-Id: <20200626064024.383996-1-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 00:31:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 63d211993b73ca9ac2bc618afeb61a698e9f5198:

  Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2020-06-25 16:52:42 +0100)

are available in the Git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-5.1-20200626

for you to fetch changes up to 737ef968d442cb287b1fcc7da94b53284b0ad1e9:

  target/ppc: Remove TIDR from POWER10 processor (2020-06-26 09:22:30 +1000)

----------------------------------------------------------------
ppc patch queue 2020-06-26

Here's another pull request for qemu-5.1.  Not very much in this one,
just a handful of assorted minor fixes and cleanups.

I'm about to go on holiday for a couple of weeks, so this will be my
last PR before the freeze, and maybe the last for 5.1 at all.  If
there's some super important fix we need, Greg Kurz will handle it.

----------------------------------------------------------------
Cédric Le Goater (1):
      target/ppc: Remove TIDR from POWER10 processor

Greg Kurz (2):
      spapr: Simplify some warning printing paths in spapr_caps.c
      ppc/pnv: Silence missing BMC warning with qtest

Gustavo Romero (1):
      spapr: Fix typos in comments and macro indentation

 hw/ppc/pnv.c                    |  9 ++++++---
 hw/ppc/spapr_caps.c             | 28 ++++++----------------------
 hw/ppc/spapr_vio.c              |  6 +++---
 include/hw/ppc/xive_regs.h      |  2 +-
 target/ppc/translate_init.inc.c |  5 -----
 5 files changed, 16 insertions(+), 34 deletions(-)

