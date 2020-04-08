Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9AB7C2D0EA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 09:37:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1B232051A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 09:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Hq4VErDz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1B232051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jM793-0004zx-PZ
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 05:37:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39623)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jM73M-0007st-KB
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 05:31:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jM73L-00061l-FD
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 05:31:24 -0400
Received: from mail-ve1eur01on0705.outbound.protection.outlook.com
 ([2a01:111:f400:fe1f::705]:64128
 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jM73I-0005tu-PW; Wed, 08 Apr 2020 05:31:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZi9z0FTmqaPGNXvTsjTlT5qWNUT1uaMay3phHPdPeSlM5YYpQD0LBHZU6fyCx++BpNjL7Juc6g0rkQo60OIXzFDXyk1WB5snYOleijTeHqMpO1jNi5a6QQH8O3YfMsgpnes8dWNTt9u3n1g3ShQjKE+hJXMnlDBabs54lYsifn7waWUv38gHLv0nn/SSiO8GKBrIhKmdvwb47erV1BDRH7JMMHpY+BZDc1vrWI3GJP1s/qZQN5XY0qWyLUbk4Ef0Yw4xUiiL0Pwm5rkxaE7lKZgGVpX0Let5AY74sH72d9NvVruFTyLtQZXLuAP+TgJsuZksr9ogJInMvZEH+wTFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/m0nfvxHVbem+siSZZ9JyxXaSxHFQx0Md3EKtMkcrA=;
 b=SH3Hrmuxq/wtmlF4vSm9gZnMqlEVdcoJQ0XR2/pAuh8PPVeT1p9vtXwao1RAfRFoNhIYXINrCTpJK4FBA0CWDIZ9KDHnaAKUY688XPlxOYiQmcdYoaUSxza34zi7WAYP/FwkDoRvN8STLm88C5H/4gNoTtiSi0Fyjgm0KE8TscWMtmNp9IxLcptvGguTnr6dapYT9EWRXy+dJP4nufT4G7H1Ye30xp7WHKoJLfBUHZ4ji2BRVTCBhNySgCWoAkEC/x4dU94BoylKEk+q9cSSZzsXFIqOd9Z8jBNpz1WLg4nSRbv1jueq8XiwktQSBT6KMj5mYFBhGgds+yBFmQmLEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/m0nfvxHVbem+siSZZ9JyxXaSxHFQx0Md3EKtMkcrA=;
 b=Hq4VErDzRp0WQhZuhVIHES2tl/JkbZfjC+/lVNNxNT9tyrZWRyxx1VMGi+64BlEjWjZzwfeFJGkGOvpAX3HBw32C6x3Dn9YFtveYNxWQhI6koD8l7wrVdah4A6YVMhVOm/UnG35ijtyOr3y8JRyLoW0tjSXPJWNKBWGdLT3gqqA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5365.eurprd08.prod.outlook.com (10.141.173.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.16; Wed, 8 Apr 2020 09:31:13 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf%8]) with mapi id 15.20.2878.021; Wed, 8 Apr 2020
 09:31:13 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH 9/9] block/io: expand in_flight inc/dec section: bdrv_make_zero
Date: Wed,  8 Apr 2020 12:30:51 +0300
Message-ID: <20200408093051.9893-10-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200408093051.9893-1-vsementsov@virtuozzo.com>
References: <20200408093051.9893-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM6PR01CA0041.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:e0::18) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.139) by
 AM6PR01CA0041.eurprd01.prod.exchangelabs.com (2603:10a6:20b:e0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend
 Transport; Wed, 8 Apr 2020 09:31:13 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.139]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dce19073-ef83-4976-68c1-08d7db9f949c
X-MS-TrafficTypeDiagnostic: AM7PR08MB5365:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53655E2A68B5A73BCC969CC3C1C00@AM7PR08MB5365.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0367A50BB1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(396003)(346002)(136003)(39840400004)(366004)(376002)(52116002)(6506007)(5660300002)(2906002)(6916009)(2616005)(956004)(478600001)(16526019)(186003)(26005)(86362001)(66946007)(66556008)(66476007)(1076003)(6512007)(6486002)(107886003)(4326008)(6666004)(36756003)(8676002)(316002)(8936002)(81156014)(81166007);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PjxySw0d4xXECFAosK24NR9C/7goMP5594+HLR89TfLZTxmESpAYKLBvkLX73yDx9W+LZHXy6/bqsxGjXxoqS2gQYKp18pE9rtwmKz7tqQi0KN1Mucn/RhOlpJd/DXTymXpBtt8cn6yg9U08QpOIma0SJEj0rF+jkswlLIahH48/bqdJYqYOI9msH5jkjdgKMTbTre3eF8Uw5dljMCrsBRzJhfhkHfL4zstc6G/zjDEa5uByUtl6bT2jQ5/Ns3EP1cbVW6onEHxyAu4pLu/i4QVvqFV/uTGN3cM263dIVTlaA7ifV57Egt9ze3kB4twwlsROCo5LWPzpQ8NCatNk/oXW308ey8vnhwgKHgxGCxkTSx1SYcIawVBN6a7BTwb9CnQdyiKEFUKyiHE3AnOr9X+vBHAXS0CtkUBIl6fNZAJjWmdXJmVzf/QjKYrItuqg
X-MS-Exchange-AntiSpam-MessageData: HLFidz/h6tsScSovR3cwMr2Ipu4WVlGdINVkDzq2Jhap9f0z+N46QSnqPeHjZW0xIPBeSc9f1Q0a345458+l8Phy567BtQmGNfdgJDtjZLBO5mMtKdn/BmXOuWq9EoYVI2eTEaWbvZKuII/5YmWCpQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dce19073-ef83-4976-68c1-08d7db9f949c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2020 09:31:13.7289 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1K9HJvtqsrD01xtPWXP3mbpnqVQgWWjMh8gbg65aWzeOf8z+xvVkd0wddMItzZ8Tnh+ilZs1xcam1ld4uMfBetUjOgnkopLo9s1wpMmCuFE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5365
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:111:f400:fe1f::705
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

It's safer to expand in_flight request to start before enter to
coroutine in synchronous wrappers and end after BDRV_POLL_WHILE loop.
Note that qemu_coroutine_enter may only schedule the coroutine in some
circumstances.

bdrv_make_zero update includes refactoring: move the whole loop into
coroutine, which has additional benefit of not create/enter new
coroutine on each iteration.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/io.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 50 insertions(+), 3 deletions(-)

diff --git a/block/io.c b/block/io.c
index d2ac9ac7b5..220b5c04d7 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2735,8 +2735,11 @@ bdrv_is_allocated_above(BlockDriverState *top, Block=
DriverState *base,
  * BDRV_REQ_FUA).
  *
  * Returns < 0 on error, 0 on success. For error codes see bdrv_write().
+ *
+ * To be called between exactly one pair of bdrv_inc/dec_in_flight()
  */
-int bdrv_make_zero(BdrvChild *child, BdrvRequestFlags flags)
+static int coroutine_fn
+bdrv_do_make_zero(BdrvChild *child, BdrvRequestFlags flags)
 {
     int ret;
     int64_t target_size, bytes, offset =3D 0;
@@ -2752,7 +2755,8 @@ int bdrv_make_zero(BdrvChild *child, BdrvRequestFlags=
 flags)
         if (bytes <=3D 0) {
             return 0;
         }
-        ret =3D bdrv_block_status(bs, offset, bytes, &bytes, NULL, NULL);
+        ret =3D bdrv_co_block_status(bs, true, false,
+                                   offset, bytes, &bytes, NULL, NULL);
         if (ret < 0) {
             return ret;
         }
@@ -2760,7 +2764,7 @@ int bdrv_make_zero(BdrvChild *child, BdrvRequestFlags=
 flags)
             offset +=3D bytes;
             continue;
         }
-        ret =3D bdrv_pwrite_zeroes(child, offset, bytes, flags);
+        ret =3D bdrv_do_pwrite_zeroes(child, offset, bytes, flags);
         if (ret < 0) {
             return ret;
         }
@@ -2768,6 +2772,49 @@ int bdrv_make_zero(BdrvChild *child, BdrvRequestFlag=
s flags)
     }
 }
=20
+typedef struct BdrvDoMakeZeroData {
+    BdrvChild *child;
+    BdrvRequestFlags flags;
+    int ret;
+    bool done;
+} BdrvDoMakeZeroData;
+
+static void coroutine_fn bdrv_make_zero_co_entry(void *opaque)
+{
+    BdrvDoMakeZeroData *data =3D opaque;
+
+    data->ret =3D bdrv_do_make_zero(data->child, data->flags);
+    data->done =3D true;
+    aio_wait_kick();
+}
+
+int bdrv_make_zero(BdrvChild *child, BdrvRequestFlags flags)
+{
+    int ret;
+
+    bdrv_inc_in_flight(child->bs);
+
+    if (qemu_in_coroutine()) {
+        /* Fast-path if already in coroutine context */
+        ret =3D bdrv_do_make_zero(child, flags);
+    } else {
+        BdrvDoMakeZeroData data =3D {
+            .child =3D child,
+            .flags =3D flags,
+            .done =3D false,
+        };
+        Coroutine *co =3D qemu_coroutine_create(bdrv_make_zero_co_entry, &=
data);
+
+        bdrv_coroutine_enter(child->bs, co);
+        BDRV_POLL_WHILE(child->bs, !data.done);
+        ret =3D data.ret;
+    }
+
+    bdrv_dec_in_flight(child->bs);
+
+    return ret;
+}
+
 typedef struct BdrvVmstateCo {
     BlockDriverState    *bs;
     QEMUIOVector        *qiov;
--=20
2.21.0


