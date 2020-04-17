Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78239C2D0EF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 12:38:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 473CE2064A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 12:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="BAhRkypj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 473CE2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPQGd-0007aE-Ci
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 08:38:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57008)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <saipava@xilinx.com>) id 1jPQFx-00077l-QM
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 08:38:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <saipava@xilinx.com>) id 1jPQFw-0002PR-AU
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 08:38:05 -0400
Received: from mail-dm6nam12on2078.outbound.protection.outlook.com
 ([40.107.243.78]:11175 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <saipava@xilinx.com>) id 1jPQFw-0002Oe-2X
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 08:38:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QWQtRFrK53peRaClEu57J3rAsX3FV/70B/3pCY7WESWKRoMxJTCspUBGGH18RixKVTV/X249W5Kpaf2lZAvEltERFiMS3DVYaZGcUu1xvWvDlBfrKWi2DZRMENTeOUg9FmcMo8Jume0AZ8zczGJrsjSZHeZqQ42G67FByRWvDMqx9/iuo4KTp9kTgUgBVGurIVGbcXpU2bxHPeEucY5X5PXHROm7DyAp+AxwCT37CWJjPv6K9Bz+WrswwgJ7SSiAjG0ROwb5WBnZchv/6wmB6nGLu5/5Oofd6gvecrD75p+HCsDOn8WuadqxKGyXx8v/Jp2Ts06NqXR/nhOQDFrtzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6AXE79RwCh36+dhmLk/FM1S7mOjzQyG6Z9M4uUSYcWE=;
 b=ijuyPD2XYZP/yumowF8FU6R0nERnazCpw0N8M+hc+tBlXjvSzGxqkyjvCkLQLdssvkjVCwj19Jt97S55b5QD7zQ6jpJRbWFyjiBBmrvt91osCawabO3dwenZYs7cc2OMjvMIQai/xQQu/I+IbCc5uasb/KacDIv0rZmpdRKh5AghCFm/brDh/rnPTliWeJU7XzdE9Q26WgV0km6QGubfwu4KedVny/oWPWiNmsYHgpmK6FDOSytq4Zu2I7vlCvBeFTr0c1oHZn0ltfHMiANnryk/Q7yhKt+Da/vnPrTkpUv9IOd4sjyFVkfH+zljCdLSwowhD1CqrPnZtTAN2YYBoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=redhat.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6AXE79RwCh36+dhmLk/FM1S7mOjzQyG6Z9M4uUSYcWE=;
 b=BAhRkypju+ZR08WzzmKKaqKcYTnxsxF0NgLDIpGj+WeqDj8cpJCCfjg/qQJ/+Ob16jqrqwu/LKKJdbnnlVvc9S+NElJNp0w7AV3HORDFb2/rNVbCUrAA0rn57ikk68Ip7hzkz1+kurRlGszOF642eCHP3Cp4iYx3kRmWe296Oqs=
Received: from SN6PR16CA0051.namprd16.prod.outlook.com (2603:10b6:805:ca::28)
 by DM5PR0201MB3543.namprd02.prod.outlook.com (2603:10b6:4:7e::36)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Fri, 17 Apr
 2020 12:38:01 +0000
Received: from SN1NAM02FT053.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:ca:cafe::84) by SN6PR16CA0051.outlook.office365.com
 (2603:10b6:805:ca::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend
 Transport; Fri, 17 Apr 2020 12:38:01 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT053.mail.protection.outlook.com (10.152.72.102) with Microsoft SMTP
 Server id 15.20.2921.25 via Frontend Transport; Fri, 17 Apr 2020 12:38:01
 +0000
Received: from [149.199.38.66] (port=46345 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jPQF5-00050k-O6; Fri, 17 Apr 2020 05:37:11 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jPQFs-0004T5-Oq; Fri, 17 Apr 2020 05:38:00 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 03HCc0tP019120; 
 Fri, 17 Apr 2020 05:38:00 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1jPQFr-0004Sm-Q5; Fri, 17 Apr 2020 05:38:00 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id 2B14B13C1D2C; Fri, 17 Apr 2020 18:01:04 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] chardev/char-socket: Properly make qio connections non
 blocking
Date: Fri, 17 Apr 2020 18:00:53 +0530
Message-Id: <1587126653-5839-1-git-send-email-sai.pavan.boddu@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(346002)(396003)(39860400002)(136003)(46966005)(81166007)(4326008)(6266002)(47076004)(82740400003)(36756003)(107886003)(70206006)(70586007)(356005)(42186006)(478600001)(110136005)(316002)(5660300002)(336012)(2616005)(4744005)(2906002)(186003)(8936002)(6666004)(426003)(26005)(81156014)(8676002);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2460527e-794f-4e8c-4f69-08d7e2cc2aa1
X-MS-TrafficTypeDiagnostic: DM5PR0201MB3543:
X-Microsoft-Antispam-PRVS: <DM5PR0201MB354334B9C17F294B0BBA7523CAD90@DM5PR0201MB3543.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:181;
X-Forefront-PRVS: 0376ECF4DD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2mfVhyVsC2yPIGqwZyiZse7UVt/WXEecIejT1Ex0eqgcejWh7KEyWCKcoRQP/oszF3//Lnttt/Do7l2wrD+WbmTPtrJtCs4W1rVBB+gLGjwrnMEkK+TsCK6SNHOycLwnz9qD4X/ni8HN51IGwHwvfy3ZP43NrQ198LVqWYmnngQNMZxZLm9DU6Z22aY7+z3Z1th0RwhT/i28tfQ5RcFdnfA/k/23cJNxiLILEHIq/zjvAg7JlJu7Xovfg7ijsU3lAHeFp/hdNdtFp2DlyFxcpnxwX8xXjrPrPt6yfaBA1iD50HbeYel+ukNxwAR8kbCngm1cWFV0Uc+HeFQm7yPBsrdtD536TotQx0AaoV31BbtMwqMVT3yRP2YvN2qBpijRvCOHBjiut5fwNRJGP5CqL9uBjOyEtruD1my/O2ztNIChlbPAKuGcfnV9OyCvaKV39LtCji5KFQETQP2hJZlhtcX+SaQqdMhiS5VyonDemZzqzP1MM+tA+mqzUIyTHwznSxMGo78fQycr7uKXTWawcA==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2020 12:38:01.2575 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2460527e-794f-4e8c-4f69-08d7e2cc2aa1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0201MB3543
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.243.78
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
Cc: edgari@xilinx.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In tcp_chr_sync_read function, there is a possibility of socket
disconnection during read, then tcp_chr_hup function would clean up
the qio channel pointers(i.e ioc, sioc).

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
---
 chardev/char-socket.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 185fe38..30f2b2b 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -549,11 +549,13 @@ static int tcp_chr_sync_read(Chardev *chr, const uint8_t *buf, int len)
 
     qio_channel_set_blocking(s->ioc, true, NULL);
     size = tcp_chr_recv(chr, (void *) buf, len);
-    qio_channel_set_blocking(s->ioc, false, NULL);
     if (size == 0) {
         /* connection closed */
         tcp_chr_disconnect(chr);
+        return 0;
     }
+    /* Connection is good */
+    qio_channel_set_blocking(s->ioc, false, NULL);
 
     return size;
 }
-- 
2.7.4


