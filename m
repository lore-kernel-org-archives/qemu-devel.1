Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23574C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 06:10:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E439722CED
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 06:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="AItRwSNL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E439722CED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3Ddq-00066n-E2
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 02:10:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35156)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i3Dbw-0004CK-7R
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 02:08:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i3Dbu-0003aE-9d
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 02:08:43 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:51055 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i3Dbt-0003X8-CF; Thu, 29 Aug 2019 02:08:42 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46JscM3J8Rz9sN1; Thu, 29 Aug 2019 16:08:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1567058915;
 bh=A339JBBqibNc64OccLWX1O5YX1wuV9hH4DRraVO8y+4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=AItRwSNLaiM92pfwaZ/mekd9Arfot6z2AKyxc9tYIHmBzNmIq0tMyjYf//7dF7+B/
 Zm4JJP63ByMbqMzCK5WDAbDQnXncR/4A9RAiN6+GddXpD0Lsu/IQAqV8GxFGGVyV4s
 phanXIrG4W4TcA4AQTfuyvqFZo4Ae2fI8/00HAJI=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Thu, 29 Aug 2019 16:08:11 +1000
Message-Id: <20190829060827.25731-4-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190829060827.25731-1-david@gibson.dropbear.id.au>
References: <20190829060827.25731-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 03/19] ppc/pnv: add more dummy XSCOM addresses
 for the P9 CAPP
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, groug@kaod.org, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: C=C3=A9dric Le Goater <clg@kaod.org>

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20190718115420.19919-3-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv_xscom.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
index 0e31c5786b..67aab98fef 100644
--- a/hw/ppc/pnv_xscom.c
+++ b/hw/ppc/pnv_xscom.c
@@ -106,6 +106,16 @@ static uint64_t xscom_read_default(PnvChip *chip, ui=
nt32_t pcba)
     case 0x201302a:     /* CAPP stuff */
     case 0x2013801:     /* CAPP stuff */
     case 0x2013802:     /* CAPP stuff */
+
+        /* P9 CAPP regs */
+    case 0x2010841:
+    case 0x2010842:
+    case 0x201082a:
+    case 0x2010828:
+    case 0x4010841:
+    case 0x4010842:
+    case 0x401082a:
+    case 0x4010828:
         return 0;
     default:
         return -1;
@@ -138,6 +148,16 @@ static bool xscom_write_default(PnvChip *chip, uint3=
2_t pcba, uint64_t val)
     case 0x2013801:     /* CAPP stuff */
     case 0x2013802:     /* CAPP stuff */
=20
+        /* P9 CAPP regs */
+    case 0x2010841:
+    case 0x2010842:
+    case 0x201082a:
+    case 0x2010828:
+    case 0x4010841:
+    case 0x4010842:
+    case 0x401082a:
+    case 0x4010828:
+
         /* P8 PRD registers */
     case PRD_P8_IPOLL_REG_MASK:
     case PRD_P8_IPOLL_REG_STATUS:
--=20
2.21.0


