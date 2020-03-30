Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D93C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 14:20:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 647402073B
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 14:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="A31t88IJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 647402073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIvHC-0003gP-At
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 10:20:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55670)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jIvFT-0001rp-Cs
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 10:18:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jIvFS-0005GS-B7
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 10:18:43 -0400
Received: from mail-eopbgr00093.outbound.protection.outlook.com
 ([40.107.0.93]:10996 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jIvFP-0005Ce-N8; Mon, 30 Mar 2020 10:18:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lyamethgL0i9ygYJyvBG/OvQ2CJja/JHuaKLvAuoV6zTD8vkIHoAn0vkxEKmko+tgUT4IOw4mIx33z7mKHG7xzBkhQXXeVVMIqN+rappplm9ESPYeEs55fKxsEZpMKcWvc5Du6y0xqQjx5GCb/AUfEEqVmSEHGNWnD5gKtk8FqqcOLka7NhdPjD9BvK6qDh3y31sJY+DpjPOFLOykniVfk6kBPJu3VdpQQ95dvRwo+jHhNr5W2g2rHxQiFrbOMxtdACY0+Tp8/hf7dnC0t6+7ZezohbpIo9lKyU80S4orJqjn0WK06Y+0SvXvljKs6SupviDccrEalJcqiquXErL8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZUBok41fvV61/DuWmEisrGzPJIMttEx6IHDzNg3LQgw=;
 b=RMh6Jxe6s6IvUCeCJf+qb4GlBXDXy2qZH9caj7mkjMt2O9sIgaZUQWWjgmT6lADKQOyO5cjCvi+qkAGAhGQ0hIjbUeOHqbWdB1soG/winXdBS99OzuCx4A1ADOqCX97g3lo2owS+GUNjQbMJ3VMq+jNdDz9oeINYKgS3wyz5E4EHCf79Nu0k2cB583hkYWJgqUriDhkbpVeip7dYO2CflcaN33IYx7YznzKjUbyUoxVR20+D9KC4s0ELFIhm2J+/X4GF4yM7FAMku2Mk62rXGH3OIh51ZYXzGw0Jd5SKRz4vUTpC8gUq4Mq3uho6sxvNH5RoykluQ6LTAJkpKNxcQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZUBok41fvV61/DuWmEisrGzPJIMttEx6IHDzNg3LQgw=;
 b=A31t88IJPUMZ3A7zZ57gS7qHzoF27O80/PC2nuT3I4D3EYdZvcz3ZasbS9AmCX0+ZfIAxz2bBP4WsZN/YulIzuAP6MFtS96Lvu4WaJaczVwP7f1Jkm37gsSaCkEhTgYzSJiXHXmq2Nd3GiNJzMfW9bMNJ6KobutAi46s/gHSBZc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5319.eurprd08.prod.outlook.com (10.141.175.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Mon, 30 Mar 2020 14:18:37 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf%9]) with mapi id 15.20.2856.019; Mon, 30 Mar 2020
 14:18:37 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH 1/3] block: use int64_t as bytes type in tracked requests
Date: Mon, 30 Mar 2020 17:18:16 +0300
Message-ID: <20200330141818.31294-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200330141818.31294-1-vsementsov@virtuozzo.com>
References: <20200330141818.31294-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM0PR05CA0064.eurprd05.prod.outlook.com
 (2603:10a6:208:be::41) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.14) by
 AM0PR05CA0064.eurprd05.prod.outlook.com (2603:10a6:208:be::41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20 via Frontend Transport; Mon, 30 Mar 2020 14:18:36 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.14]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9def4978-4928-4629-9524-08d7d4b53d15
X-MS-TrafficTypeDiagnostic: AM7PR08MB5319:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB531918A287BD30E2F3A2092DC1CB0@AM7PR08MB5319.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:397;
X-Forefront-PRVS: 0358535363
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(346002)(376002)(366004)(396003)(39840400004)(136003)(36756003)(2906002)(8676002)(6666004)(1076003)(6486002)(6506007)(4326008)(107886003)(81166006)(81156014)(8936002)(6512007)(52116002)(6916009)(86362001)(316002)(7416002)(5660300002)(478600001)(26005)(66556008)(2616005)(16526019)(956004)(66946007)(186003)(66476007);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 60DZ4ixA4EQt/Oy8+6AoDKZu5/uChN2PN/853/3Fil8X9CPO7S7unmGtcVM2OGi0jZUT/J3fWg37ANpGk6ZjIXFQaFtcjrPX6VeAFxvZ+av4W9IJ6DQ83gcm2FDrbr6cMXabE+LpdHxADiita+9scq0UMpe2VD+4IBEEyAKkqozIsvtsD8j/+/fyVjpsJPHZm0pTSWdPHIYlO1UVuJq1ZVnssnsBtxwpSWh+I81fH4y6MoAzUihRGXderlxQecVclBebzJl8uUbQKl9LaoIMxT2q5dB1vcgyT1OGd25aUUA/SCsMadSdWGwiLrVPuiTGE/AbG4Aq6RMlCnYhnPv/yKDZF/Ru1E1JsER77gpbqMbRL/txLFuUXEfA8Lrkc0owfineRXwUPqGYfTiLSUoGnVZ1OKqapjve7FvfTTnI3IcpCkoX1ZPDZxiN7at2Nzfi
X-MS-Exchange-AntiSpam-MessageData: LxvPNcjkehm/0RKYkQY5qIrSFU/h+NHdxzjijErCEOq9hjOrzOinM4dcc+npMG+JZusHxIcwDsjEAqI323DuXi6D9laN5YWBMjCZtB/YFDg1hdPwZ/g+BNIlmIvZvcq9blnrCJm/0THvgrxNyRT3Vg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9def4978-4928-4629-9524-08d7d4b53d15
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2020 14:18:37.8573 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xoBPqXiGCQ1//Cs1reHjoRocxBs8LDW/Nii2nVcfcYQoSH2YcxqksxPL+ltnl11AdTX7fNIWlCjdOS2qCL5dLCAPUkqpCMCN6NLMtvo4ABU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5319
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.0.93
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 berto@igalia.com, stefanha@redhat.com, pavel.dovgaluk@ispras.ru,
 sw@weilnetz.de, pl@kamp.de, qemu-devel@nongnu.org, mreitz@redhat.com,
 jsnow@redhat.com, ronniesahlberg@gmail.com, den@openvz.org,
 pbonzini@redhat.com, dillaman@redhat.com, ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are generally moving to int64_t for both offset and bytes paramaters
on all io paths. Convert tracked requests now.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block_int.h |  4 ++--
 block/io.c                | 11 ++++++-----
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 4c3587ea19..c8daba608b 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -70,12 +70,12 @@ enum BdrvTrackedRequestType {
 typedef struct BdrvTrackedRequest {
     BlockDriverState *bs;
     int64_t offset;
-    uint64_t bytes;
+    int64_t bytes;
     enum BdrvTrackedRequestType type;
=20
     bool serialising;
     int64_t overlap_offset;
-    uint64_t overlap_bytes;
+    int64_t overlap_bytes;
=20
     QLIST_ENTRY(BdrvTrackedRequest) list;
     Coroutine *co; /* owner, used for deadlock detection */
diff --git a/block/io.c b/block/io.c
index aba67f66b9..7cbb80bd24 100644
--- a/block/io.c
+++ b/block/io.c
@@ -692,10 +692,11 @@ static void tracked_request_end(BdrvTrackedRequest *r=
eq)
 static void tracked_request_begin(BdrvTrackedRequest *req,
                                   BlockDriverState *bs,
                                   int64_t offset,
-                                  uint64_t bytes,
+                                  int64_t bytes,
                                   enum BdrvTrackedRequestType type)
 {
-    assert(bytes <=3D INT64_MAX && offset <=3D INT64_MAX - bytes);
+    assert(offset >=3D 0 && bytes >=3D 0 &&
+           bytes <=3D INT64_MAX && offset <=3D INT64_MAX - bytes);
=20
     *req =3D (BdrvTrackedRequest){
         .bs =3D bs,
@@ -716,7 +717,7 @@ static void tracked_request_begin(BdrvTrackedRequest *r=
eq,
 }
=20
 static bool tracked_request_overlaps(BdrvTrackedRequest *req,
-                                     int64_t offset, uint64_t bytes)
+                                     int64_t offset, int64_t bytes)
 {
     /*        aaaa   bbbb */
     if (offset >=3D req->overlap_offset + req->overlap_bytes) {
@@ -773,8 +774,8 @@ bool bdrv_mark_request_serialising(BdrvTrackedRequest *=
req, uint64_t align)
 {
     BlockDriverState *bs =3D req->bs;
     int64_t overlap_offset =3D req->offset & ~(align - 1);
-    uint64_t overlap_bytes =3D ROUND_UP(req->offset + req->bytes, align)
-                               - overlap_offset;
+    int64_t overlap_bytes =3D
+            ROUND_UP(req->offset + req->bytes, align) - overlap_offset;
     bool waited;
=20
     qemu_co_mutex_lock(&bs->reqs_lock);
--=20
2.21.0


