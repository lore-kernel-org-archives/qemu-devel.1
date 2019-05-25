Return-Path: <SRS0=E2zY=TZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56CA8C282CE
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 06:44:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17A72217D7
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 06:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="PSV6cAHs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17A72217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37096 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUQPZ-0003cc-QM
	for qemu-devel@archiver.kernel.org; Sat, 25 May 2019 02:44:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hUQO4-0002os-Fk
	for qemu-devel@nongnu.org; Sat, 25 May 2019 02:42:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hUQBI-00039z-7W
	for qemu-devel@nongnu.org; Sat, 25 May 2019 02:29:25 -0400
Received: from m12-17.163.com ([220.181.12.17]:41503)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>)
	id 1hUQBG-00032I-VG; Sat, 25 May 2019 02:29:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=qpW5ne0augMm/uJBAJ
	7MnqYEgl6mluJDLveJO/8sKcw=; b=PSV6cAHsqOEMOQrzjeNC24hqu553u2Y6kg
	kNLXsFioH50uuA1lLkgb26qfQHa0Q4PNLVQ2OKaNkNKklNH2dK2bA0h96wSkQoL0
	JgknsnvkwhVVuisjp7GMLepwJhC1FuTuN4OZaINMrAb72SZhO+VLZCnbUcVxYzxP
	nMuR7aUZc=
Received: from localhost.localdomain (unknown [122.233.130.146])
	by smtp13 (Coremail) with SMTP id EcCowABnbx+64OhcgoagHw--.19765S2;
	Sat, 25 May 2019 14:29:15 +0800 (CST)
From: Li Qiang <liq3ea@163.com>
To: quintela@redhat.com,
	dgilbert@redhat.com
Date: Fri, 24 May 2019 23:28:32 -0700
Message-Id: <20190525062832.18009-1-liq3ea@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: EcCowABnbx+64OhcgoagHw--.19765S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4R_a9aDUUUU
X-Originating-IP: [122.233.130.146]
X-CM-SenderInfo: 5oltjvrd6rljoofrz/xtbBZg6-bVaD1p8IOAABsX
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 220.181.12.17
Subject: [Qemu-devel] [PATCH] migration: fix a typo
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-trivial@nongnu.org, Li Qiang <liq3ea@163.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

'postocpy' should be 'postcopy'.

CC: qemu-trivial@nongnu.org
Signed-off-by: Li Qiang <liq3ea@163.com>
---
 migration/ram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index 4c60869226..359dc8f1bc 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2236,7 +2236,7 @@ static RAMBlock *unqueue_page(RAMState *rs, ram_addr_t *offset)
 }
 
 /**
- * get_queued_page: unqueue a page from the postocpy requests
+ * get_queued_page: unqueue a page from the postcopy requests
  *
  * Skips pages that are already sent (!dirty)
  *
-- 
2.17.1



