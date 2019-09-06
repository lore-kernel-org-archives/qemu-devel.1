Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33A7C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 01:54:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8985206CD
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 01:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Rl3UlQ6B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8985206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i63Sa-0000qC-MV
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 21:54:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53331)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=4152e791a2=amithash@fb.com>) id 1i62lf-0002wq-Km
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 21:10:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=4152e791a2=amithash@fb.com>) id 1i62le-00011b-EF
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 21:10:27 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:22314)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=4152e791a2=amithash@fb.com>)
 id 1i62ld-0000xa-Lt
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 21:10:26 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 x861AJDa014230
 for <qemu-devel@nongnu.org>; Thu, 5 Sep 2019 18:10:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com;
 h=from : to : subject :
 date : message-id : mime-version : content-type; s=facebook;
 bh=mphrkCK8PHgknx4G4mNf76pijc2fJDXD3SASQAgFHkM=;
 b=Rl3UlQ6BHaP8kGuB4LStl4oOQKzQjIOmUNYcsvY5n7aekrl8U3znEZwlTAckRobwrJVz
 K4MWsHf7DAXhUhInn+lYuSKaG9uX50Mx1pijarVQBrBPJf4pBRowYIKMCK39kdIVwupV
 2YcGeEellSMq28Eaz3PbDHbRay0mVgPkvqY= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
 by mx0a-00082601.pphosted.com with ESMTP id 2uu8mds8k7-6
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2019 18:10:21 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Thu, 5 Sep 2019 18:10:15 -0700
Received: by devvm1607.vll1.facebook.com (Postfix, from userid 122613)
 id F022F2A1CDDE; Thu,  5 Sep 2019 18:10:12 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From: Amithash Prasad <amithash@fb.com>
Smtp-Origin-Hostname: devvm1607.vll1.facebook.com
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <amithash@fb.com>,
 <clg@kaod.org>, <joel@jms.id.au>
Smtp-Origin-Cluster: vll1c12
Date: Thu, 5 Sep 2019 18:10:10 -0700
Message-ID: <20190906011010.1135084-1-amithash@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-05_11:2019-09-04,2019-09-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0
 adultscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 mlxlogscore=818 clxscore=1011 mlxscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1909060010
X-FB-Internal: deliver
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 67.231.145.42
X-Mailman-Approved-At: Thu, 05 Sep 2019 21:53:42 -0400
Subject: [Qemu-devel] [PATCH] Check correct register for clock source
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

When WDT_RESTART is written, the data is not the contents
of the WDT_CTRL register. Hence ensure we are looking at
WDT_CTRL to check if bit WDT_CTRL_1MHZ_CLK is set or not.

Signed-off-by: Amithash Prasad <amithash@fb.com>
---
 hw/watchdog/wdt_aspeed.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/watchdog/wdt_aspeed.c b/hw/watchdog/wdt_aspeed.c
index 9b93213417..f710036535 100644
--- a/hw/watchdog/wdt_aspeed.c
+++ b/hw/watchdog/wdt_aspeed.c
@@ -140,7 +140,7 @@ static void aspeed_wdt_write(void *opaque, hwaddr offset, uint64_t data,
     case WDT_RESTART:
         if ((data & 0xFFFF) == WDT_RESTART_MAGIC) {
             s->regs[WDT_STATUS] = s->regs[WDT_RELOAD_VALUE];
-            aspeed_wdt_reload(s, !(data & WDT_CTRL_1MHZ_CLK));
+            aspeed_wdt_reload(s, !(s->regs[WDT_CTRL] & WDT_CTRL_1MHZ_CLK));
         }
         break;
     case WDT_CTRL:
-- 
2.21.0


