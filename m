Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29880C55199
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 14:41:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E820D20656
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 14:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="YS9ow0G/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E820D20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48591 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT4wd-0001ph-PZ
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 10:41:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56842)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jT4v4-00089L-AM
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 10:39:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jT4v3-0007kR-Ri
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 10:39:38 -0400
Received: from mail-eopbgr40124.outbound.protection.outlook.com
 ([40.107.4.124]:49833 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jT4v1-0007iT-9D; Mon, 27 Apr 2020 10:39:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yx2DnubE9R6Rlt7g/9roIxuOhmC/icVy7glRoD9KcFZrqtb/nNz9DZK9hLQSJvNkDtzHuhg04pqsmvwY899cKCFSr0148PcSVeCbyDKCvN6a+Be3zTyNv2LoEsww4hWA4mWVvZN/os8NVg76NSaqIkC/RE73DJ3bVuA0PjuCindWlJmbGq9WYvC3r8wf6SNQkdNEpYbI+RLlE2quicNp8q7gOt24q6Bp9j/3+wqAjcLn1n0wYCvZ2jfoJxkd9mXyUz6rR04Qxc5UoBL4+5ahMaLIjChekLf1PIEzJ46ii4HquQu1/2LTVawssTSCsS1UROh0dNhrz7GtOi5boVDVGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Tp/lNrp4pa6NXDHRAe0wN6lAiaVRIBuOBnYuWH7cs4=;
 b=nu1zKfZUlnNlt0euh6np8R/gTH0+yUbz8zN/tNw10qyd6WvshOliscp0jww8VxD17zuuEOzfOS1GCItN5OKnRrPqM81ClNl/LqTkuSNyHsTzrgPPuuzZDzRp9enJV+q26aL0JoHo8wciSluzw2rf+IoX6DsxuzyM7oFPdWOKjCzJDMZRK/V+xHD2UCpwbPHmwAybu6DRvVdo29NGfQFjNU3eqYfU/7mou8LG13L3ciztwzDQ5njWvcsgX3fwy0tBt0CNIhxq+invelz10oj5//SKIEa+MFohAMVLnraqWS1I5NrWHYlH51R0PTFVXnyHSiJZefXHUplwjz3HXJ3dZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Tp/lNrp4pa6NXDHRAe0wN6lAiaVRIBuOBnYuWH7cs4=;
 b=YS9ow0G/RtWp+W7QANmuBdRvVm61I0G+rkbVGv9yUfoRXsje+QChu7y5NDm+HJ/urpxU4lI9HWK0Eazhx0nTYsRKNJnE5CIAOz80VTxxs37uzx34O8vhNiQgXu4AMeZDT9OVj9js36nOfOJj+oOXb24Viivopgq7zK7Y+JJfaKk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5336.eurprd08.prod.outlook.com (2603:10a6:20b:105::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Mon, 27 Apr
 2020 14:39:33 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.020; Mon, 27 Apr 2020
 14:39:33 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 3/9] block/io: move flush and pdiscard stuff down
Date: Mon, 27 Apr 2020 17:39:01 +0300
Message-Id: <20200427143907.5710-4-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200427143907.5710-1-vsementsov@virtuozzo.com>
References: <20200427143907.5710-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0010.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::20)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.182) by
 FRYP281CA0010.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Mon, 27 Apr 2020 14:39:32 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47d9a031-ffe9-41a5-1196-08d7eab8cce0
X-MS-TrafficTypeDiagnostic: AM7PR08MB5336:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5336B4281475886033EDF1DFC1AF0@AM7PR08MB5336.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:248;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(136003)(346002)(366004)(39840400004)(478600001)(52116002)(6916009)(2616005)(956004)(4326008)(8676002)(36756003)(107886003)(6666004)(5660300002)(2906002)(316002)(66476007)(6486002)(66946007)(6512007)(8936002)(69590400007)(186003)(6506007)(66556008)(16526019)(26005)(86362001)(1076003)(81156014);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zz7KO/VoX7ZtrOij+B5VMurGtIXXRzIFDeqmkWwedfoUpqoMB7gDGylA2BHU3mn+p9evtNUz0qphe8Hpj9mjDEtpWZUsUWEKBLuryr8wsTxHC2we3a9nH23p1Gj9uW1sh2pHf+CDkccVJ7U2llQu9KWVJHXc12SqLEYniQrWSTQ8XY2wQ4/TtnR0y4kH+r4qYlJCFovj3wQxDhgwlM/QgZ8A9r4GuCgoVqe+9UPD/RE1fSG7+5UrJ4qMqkrw8tK9ruMnuYfiUyddGSoG4Fys5kBw+lTX/evpUDESWp1oajo9eIJlKlMHicGrPpWm6Lu0R6++DVwiGLbuRkRlkGKbDN2i8fSGiKmZ0aeST3x2iTS+YSx50lrVq2Asp1uKx2EcKqOgcwiVtK2TZw1pJsruXd02tZYcYXUSj3KXPHcJ34yNGAoU/GvmPAU3yczvxX/ycm1f5i5JDJLxHJATqcy2UrqrS5IoQvS2yJm4Cb7MT9PidLKEifp9oTO6B1cfdXQN
X-MS-Exchange-AntiSpam-MessageData: hJNu7Muxmr5Ihve8CMMcUuZZxbEpNJsFLOXWFrMuH43gZFlztc/CCwLUIoA2itsev7HgR+1Za4zqGWvB2cwcvb1tYyyVmv9HzmrZLized5oRfLXi59/FdTZvCZ+BzRkMQ4lCtsDbs1Y3mQJgZF1+vPQxknI3KtO6NjkoU7WpJrufXZsvJr14TzyAx+wBVoXfb/tx9BH1lppRzxBIDt69KhWtLnjZbrpmbPwgBN9179Fsj6daAPZmfS2hph18m/k1WAiolWA44EPU9Gjee3DlOGdrpXuEIzZjr2bUZw96quIYx0sr+9S23Fs7lfcJtSvMKtRMiF7umfjdc1bSue98/HXCP5nbtxbqNNfpkrPzqyoT14cYkQiU5YrUKaYk4hueD82dC8HlkyeDTVdL8A2w9rpxrbrw+gH2BmttDXol8DGRWZTbJ64uD4agFNxtUUf4xkq7yXzWzvrDSPHzE3FYqlgdteroel3t0adzsDllu6XhQgAJG4HE8Dyv9RUciWksCSj+qFu2ikUx6620FyEXnFIEazERkF5wftCB0b4WylfZzpSNgtMhR60nu9VsATfY//moWXJ65bxwwKo5JvZLwLRcmrsIv3itrd75/wRayfT/ZmoOCLB01kvq8toLPrd+RlhisaJUpDeZGJG7M3teYnIdN6pR4X1YvMGZ2Wm2OFtwEnNkR8tUn2aw5ir5JcEDoxbnyIaUUMcJOYyc6W0Te5TFzXQgEH7wy7OU1oRu+DX4s9CixXlIbaJwmIM47INShFo6+6sZnboG2DYvvWkentSw+Sk8Y9YxeCE3oP1P1LM=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47d9a031-ffe9-41a5-1196-08d7eab8cce0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 14:39:32.9667 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BCoDqRyiPGSE9CVzxTXuZsK2s+ce7FRkzaBGfhHZ5cijP4RRa+ejQ9/Khor/2Vmq74+3kl83cEL4edci31m4VvTzTjwaMUKOg3iyyjSRFaw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5336
Received-SPF: pass client-ip=40.107.4.124;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 10:39:33
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.4.124
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

bdrv_co_flush and bdrv_co_pdiscard will become static in further patch,
move their usage down.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/io.c | 56 +++++++++++++++++++++++++++---------------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/block/io.c b/block/io.c
index 880871e691..1134f8144a 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2827,20 +2827,6 @@ void bdrv_aio_cancel_async(BlockAIOCB *acb)
 /**************************************************************/
 /* Coroutine block device emulation */
 
-typedef struct FlushCo {
-    BlockDriverState *bs;
-    int ret;
-} FlushCo;
-
-
-static void coroutine_fn bdrv_flush_co_entry(void *opaque)
-{
-    FlushCo *rwco = opaque;
-
-    rwco->ret = bdrv_co_flush(rwco->bs);
-    aio_wait_kick();
-}
-
 int coroutine_fn bdrv_co_flush(BlockDriverState *bs)
 {
     int current_gen;
@@ -2953,6 +2939,19 @@ early_exit:
     return ret;
 }
 
+typedef struct FlushCo {
+    BlockDriverState *bs;
+    int ret;
+} FlushCo;
+
+static void coroutine_fn bdrv_flush_co_entry(void *opaque)
+{
+    FlushCo *rwco = opaque;
+
+    rwco->ret = bdrv_co_flush(rwco->bs);
+    aio_wait_kick();
+}
+
 int bdrv_flush(BlockDriverState *bs)
 {
     Coroutine *co;
@@ -2973,20 +2972,6 @@ int bdrv_flush(BlockDriverState *bs)
     return flush_co.ret;
 }
 
-typedef struct DiscardCo {
-    BdrvChild *child;
-    int64_t offset;
-    int64_t bytes;
-    int ret;
-} DiscardCo;
-static void coroutine_fn bdrv_pdiscard_co_entry(void *opaque)
-{
-    DiscardCo *rwco = opaque;
-
-    rwco->ret = bdrv_co_pdiscard(rwco->child, rwco->offset, rwco->bytes);
-    aio_wait_kick();
-}
-
 int coroutine_fn bdrv_co_pdiscard(BdrvChild *child, int64_t offset,
                                   int64_t bytes)
 {
@@ -3101,6 +3086,21 @@ out:
     return ret;
 }
 
+typedef struct DiscardCo {
+    BdrvChild *child;
+    int64_t offset;
+    int64_t bytes;
+    int ret;
+} DiscardCo;
+
+static void coroutine_fn bdrv_pdiscard_co_entry(void *opaque)
+{
+    DiscardCo *rwco = opaque;
+
+    rwco->ret = bdrv_co_pdiscard(rwco->child, rwco->offset, rwco->bytes);
+    aio_wait_kick();
+}
+
 int bdrv_pdiscard(BdrvChild *child, int64_t offset, int64_t bytes)
 {
     Coroutine *co;
-- 
2.21.0


