Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29E1C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 12:45:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 860662074D
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 12:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ALjeddDg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 860662074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZZiE-0000Vb-Kc
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 08:45:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44914)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jZZeD-0002PX-DA; Fri, 15 May 2020 08:41:05 -0400
Received: from mail-eopbgr150102.outbound.protection.outlook.com
 ([40.107.15.102]:11310 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jZZeC-0008VJ-AW; Fri, 15 May 2020 08:41:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=clAKot/fn4znR6Gk7K7XqgqT2WxEGMfnWN+5if1YIFUXTTMR008DsPmRRTpGHEmLidqyncU8FWqq5BZ0uHtOJMAaGsZLObM29zI7OGx9VOPW2lIOhQfTEjLA36GIYNgKkXajVBw25Yk0nzTPZPqxVvnkoqWvHj9gOXqPKl/lj4qQ7MVy7SBkN5Ff/pW3mlP84SA9Zf3Fy17RRG+YgqyL5gK5yy13rwML/vD+vxv6ZHRKHTS2WbNnDGfVrt7aXcrlqMMHEE8yX9uO1LStgoztttAMNXGu9N6hBBNbvZielV8xAGJx3YtM1v8to2NhuF6QSLuUlnjMJ86jliFOJkXNsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KoR51FPmK9iPU+aqvkBnJNpHY102FTaddia2Fp3H8sg=;
 b=dVCh6MlTqAxYUz9VX9YtgKuhU2eKj6yVPOIlu4do/Dtn9LvR1PBjNjvRXDYHUB82lDXm/cG0If0Ke1qlWJlM2YiNgsbEwQ2xk+B5P6Y1KIx0iQr+/Yc0//OQmidWfQ5ifLE6KjwXD7mhO8rYU1MYJ9f78Efyl/i4KVSquyIKi+Yw/x9Keqnt6P2PlijCCiZLIK+clqIwd6w2lZgqm+aN8V7EHXwrehzPTL9eiuX5V/MjRm1myjo5QO/SqYPcSvlqi6HvU6Xq9MnZ3+6uGLQ8MFSK2tpilKBsbePuJwjtEF3Nj6ITYAweRWnE/h7jB7bUO3zr7ePFjxjDT60/ymOgZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KoR51FPmK9iPU+aqvkBnJNpHY102FTaddia2Fp3H8sg=;
 b=ALjeddDgW3WqoEcI9/F3BWmz56seqWlBq0bHnmCqL2y9+TSW/R5UuOeVOxI0EgwNGSJ2DhNUnvLVLdC0DqHRnI9lgg/LoiwyB71n/imUVbZapTy0Br0ueOEEP9b8hXR68EZnoBXxcByl8VWEuJkJx0mvQDP5DII51NUIljFUmAo=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5381.eurprd08.prod.outlook.com (2603:10a6:20b:105::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Fri, 15 May
 2020 12:40:58 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.3000.016; Fri, 15 May 2020
 12:40:58 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 6/7] migration/block-dirty-bitmap: add_bitmaps_to_list:
 check disk name once
Date: Fri, 15 May 2020 15:40:23 +0300
Message-Id: <20200515124024.3491-7-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200515124024.3491-1-vsementsov@virtuozzo.com>
References: <20200515124024.3491-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0039.eurprd03.prod.outlook.com (2603:10a6:208::16)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.184) by
 AM0PR03CA0039.eurprd03.prod.outlook.com (2603:10a6:208::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.20 via Frontend Transport; Fri, 15 May 2020 12:40:56 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.184]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f47c8cc-88dd-42e7-e23c-08d7f8cd376c
X-MS-TrafficTypeDiagnostic: AM7PR08MB5381:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5381ADD30CA1D6B83F6211BFC1BD0@AM7PR08MB5381.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +YiIjw5L03lr/ah5BESd1h09Xai7Nnmrw8u+7HMRCaLZrXxSPxDN8aX084vWuQixgBbexyaIXP1YdEoUVwP1+YDpNFzyFh+CSTIEi1mndf2hjWRoqgCT94ERA0/xgTC9FZKAhWMGn3fow8Lss8pSGdBdJ46Diuwi4uXlrNhp3NWKpaBIv4ZcYDa8ILArWR/8K1X+iSO5fwN+iTBUXUbvdzSGIwdAqP7WWW8C0t5DOxeZtQDrcUv9DOfNtknvC3s2nPz84b8HacW/v7Hx7Yg28gbUcN/CqMzCZkEC+CTKM5lonFQDV9D6HxZO7GIAs1RP15A7WpN+/Tx5dbXcpsW5sgwoFAsWHWQpJwTJE9ZQaFbfp6/lCZcJpr2ciX8VksyigyUyNjojKcOtOeZ3QovMeX4YUsNHbQSpiDF7mSA2UcnMPDtKTjigKCLm6Nu3qRfig6bP8GF+MA3WyFBHIezw+ty1O0zpuKc4eDjs0dRiZXY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(136003)(346002)(396003)(39840400004)(52116002)(6486002)(36756003)(8676002)(7416002)(8936002)(6916009)(478600001)(6666004)(86362001)(6512007)(4326008)(316002)(107886003)(26005)(5660300002)(16526019)(186003)(6506007)(2616005)(2906002)(1076003)(956004)(66556008)(66946007)(66476007)(14143004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: jUMBTK63BFYIXV65bYMkLNo5e0eG08k7xfBZqIKUxdXurQKK5xwctadptwwF53RvUV6gNSm98SDM7+DlP3VMy4R36JftHxxJj3QGq+PsX2RJce1R8ZmUdFZywleItUaN7pmvz/gKuqqqWNTlGwINtzjtL3HNgh6dUBW7OcC6w9YihFBxHiZfULOu9A07gxuHs2r5hslbUpQnzwrLcIXbExNXz2EpRaEk2vhxCwh9te/ITNsvKbK1hANLrt60ll4BOyOWQlw2sI2kYADDJh/o0tZ1ZeL2uCohzqVTqlXgn7gSp6f7+PDzZeAHdae/FKFgPcG3Tjy34ca7D1mvms2ao8TXZHOHjTjm5uIUtKZIs2WAXrIxRVzC83YBQ4DrxGYkiQSmTgFzBSfNYXrc9VjClNu3/u6lAUymvrLp0qbBIgxG+bxLUp5THnepPXFEvqX+KT+kZswR2WqnREpYFnw81wxziRSQSG5twzSYVrUlOME=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f47c8cc-88dd-42e7-e23c-08d7f8cd376c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 12:40:57.9286 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xD3K89714+YIrSJ/ROwJWzEUFkP4J0fyWDOFrYb6Go4mK5mBX6lJ/RZ6+c585aW7X22DJTL4b046nK8m6kpJpedJp9EJJEVb/LA2mZZ1d+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5381
Received-SPF: pass client-ip=40.107.15.102;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 08:40:51
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 stefanha@redhat.com, quintela@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, mreitz@redhat.com,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, pavel.dovgaluk@ispras.ru,
 den@openvz.org, pbonzini@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 migration/block-dirty-bitmap.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 5d3a7d2b07..e0e081ce60 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -274,17 +274,22 @@ static int add_bitmaps_to_list(BlockDriverState *bs, const char *bs_name)
     DirtyBitmapMigBitmapState *dbms;
     Error *local_err = NULL;
 
+    bitmap = bdrv_dirty_bitmap_first(bs);
+    if (!bitmap) {
+        return 0;
+    }
+
+    if (!bs_name || strcmp(bs_name, "") == 0) {
+        error_report("Found bitmap '%s' in unnamed node %p. It can't "
+                     "be migrated", bdrv_dirty_bitmap_name(bitmap), bs);
+        return -1;
+    }
+
     FOR_EACH_DIRTY_BITMAP(bs, bitmap) {
         if (!bdrv_dirty_bitmap_name(bitmap)) {
             continue;
         }
 
-        if (!bs_name || strcmp(bs_name, "") == 0) {
-            error_report("Found bitmap '%s' in unnamed node %p. It can't "
-                         "be migrated", bdrv_dirty_bitmap_name(bitmap), bs);
-            return -1;
-        }
-
         if (bdrv_dirty_bitmap_check(bitmap, BDRV_BITMAP_DEFAULT, &local_err)) {
             error_report_err(local_err);
             return -1;
-- 
2.21.0


