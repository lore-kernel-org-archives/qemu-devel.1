Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1F7C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 09:45:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8D64208DB
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 09:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="n0hieR+l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8D64208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeF6h-0001hy-O9
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 05:45:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37606)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jeF5O-00084t-6O; Thu, 28 May 2020 05:44:26 -0400
Received: from mail-eopbgr80134.outbound.protection.outlook.com
 ([40.107.8.134]:2978 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jeF5N-0002k0-Ci; Thu, 28 May 2020 05:44:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VR7MblqJbfZnwpomGo0GrKUhpYaUSab/kYHgoL70aPAy8XQFNmS57Vqhb8wMeSULXj/GRHpyGQls+ki1mdzoLJ1kOzM2sPWOSwRk3O43HDtw9muwu7oqyfqbikej/68qoi3Ca5w/Ro11MQvsFf0vwpNdafAbVlKRakN6lqPpBZYiB6zlImL1aaBZqMj6FmVLaOU77Mfr/PMxu6vB9VvaIPOfFEmdxMnnVbfxcxvh+eOTHl1KgfqC59CTej4bm96Rf1/D7kWeoWoVQ0pBrYpZ28vGSdIlO6TN+oEK4cP0kXlDuM5sYnOimfwgUVaUrilL6KFuMbFB+HplCZQsORwU8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MfC4Cz4jbnChRj77AzLGlNCwKOcwXVbPBerKDlE+nPs=;
 b=ViTe8I+7Jf0FBKDS0oOc0yadZWN2KqRrtmapF5qXZv4mMXQsqe9PgNggleuTspXwkfBX2hYU7mUhVEWXdGIQskg/HUi55LFNlFCy/yWTTGCooALb8qvMNUWku8WkRH7LE0hmS0Cwr2mhlIaxmtw3edK/MzObiDXNFbO3bVrO/iC+VPteYt0hxDauflIjQKwDxtGA05jr48gJK/vS5r1KKIyxv0oDKjJiQMPKm+JRp1D3gb/LppPXaJeZ6iKVEjPjsI0ZZmOBrrxaAVhtgZ6gS/byxZTVUIx+aIgkLPytwaYq5hFTKMIPr5xAJ18SRgNkEnhcxcep9r5fEHMfPQM0nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MfC4Cz4jbnChRj77AzLGlNCwKOcwXVbPBerKDlE+nPs=;
 b=n0hieR+ld6vsIVU2z4UHOjuvey0qkLw0xbil905NCSQTQwDhzhS8kI0gEkWMc1dYO1SDZ0fBMZwsOqpvLTyJvh8XpT53FbxFEAKJ0k8cBvcw1aOSbXEsnMC2UWhIKeqitwlwabP02rjoDk8jITGCle7G15fY/f5l0XWBAKhzz+k=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5366.eurprd08.prod.outlook.com (2603:10a6:20b:10b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Thu, 28 May
 2020 09:44:21 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3045.018; Thu, 28 May 2020
 09:44:21 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 02/10] block: inline bdrv_unallocated_blocks_are_zero()
Date: Thu, 28 May 2020 12:43:57 +0300
Message-Id: <20200528094405.145708-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200528094405.145708-1-vsementsov@virtuozzo.com>
References: <20200528094405.145708-1-vsementsov@virtuozzo.com>
Content-Type: text/plain
X-ClientProxiedBy: AM3PR05CA0089.eurprd05.prod.outlook.com
 (2603:10a6:207:1::15) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.localdomain (185.215.60.178) by
 AM3PR05CA0089.eurprd05.prod.outlook.com (2603:10a6:207:1::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.19 via Frontend Transport; Thu, 28 May 2020 09:44:20 +0000
X-Mailer: git-send-email 2.18.0
X-Originating-IP: [185.215.60.178]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ddb745b0-ac18-4ec2-58b5-08d802ebb2c8
X-MS-TrafficTypeDiagnostic: AM7PR08MB5366:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53660F14CA82CA744753FCE3C18E0@AM7PR08MB5366.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:334;
X-Forefront-PRVS: 0417A3FFD2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CkYbRTSOWI5jb/e2Z8KnSGJ0aBKMQcfr3JzCnz86iATGdoYYRWcHxnqlsUyO8Ja7upufhwRztzf2/i0MvrTlHARkyGaUMe3d4jWVPP+QmxQKn8tOahU4DlV6UGlk6eppYZ6+kagZEnipr/4i5hHFMINhsyygvmzpEQdMVhrgUuPwiosBqYKddTz98lP+NSh/FnJb+iL6rMrdbkRPVTHxKDjL4czW5bp+EEUlszvxczm22UsarPUtK42sAlHU3dxEIp5M8b8dBXSlRIWlsgxY1tL8jXqJ0Yx0fOg+H1jwWv4ePOovoJe/20KxuWnQlm2iRdCaM6DF41dv2kYhppwpCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39850400004)(366004)(136003)(346002)(376002)(396003)(2616005)(86362001)(316002)(5660300002)(7416002)(956004)(1076003)(6916009)(66946007)(83380400001)(6666004)(66476007)(66556008)(8936002)(4326008)(6512007)(36756003)(478600001)(8676002)(26005)(186003)(16526019)(2906002)(52116002)(6486002)(6506007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: l1ktUWUCL7mgKJ0Xc6k8Hok07mYOGcRGJSJg2HfIHHtNH7i0KNwypAxRQy/JTc2vJbE8iFkbAiRXbDpS9wYWt5LYmB2JugZl6m1L+qWSZf9c5WrJJBCFCJ7Yd0IYUQ73jbRL+5Q8EU4aikV5LOwte+sQHSe/plueY2YZWPyEDSslS6B1cpF9Dtoa/WMQ86vRIsixy2NrP0YMo37mYxeCIzpFuLbekrlx+RyER/cvXqMKX8fqLipEhI3fRvu1BQ94DCscn6p9kMndHG/JVl2XDvnGhheu5LdLqiRUtIo9dldZDMxAjTFUhlJCvZ6WeKvcmyAVuZuK6z93/mKCA0CpOFOHz/2aH2be5Dj5fVV0Rvf/DOFULrtk9NLLrF+AekB8LGYOKd7Gcwt035D58EKEKbGlyIs9qT335PGcbfy++iZ2vqnofEsuP1JODTGDUs2fPmeGQrGeFcgOKiGURPLwGbBFLjC6P/Nvwky1qt7QrSY=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddb745b0-ac18-4ec2-58b5-08d802ebb2c8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2020 09:44:21.4766 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PgOQ55wtGxCGvqRCUgtkFVxkrBMSwtNztr/1tsakpM+o0/WtHKn7re3VThWpche4fSI+ovmj1JgS0LjN2pqthy8NZBkTdnn26NnrX06HATc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5366
Received-SPF: pass client-ip=40.107.8.134;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 05:44:18
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
 ronniesahlberg@gmail.com, codyprime@gmail.com, sw@weilnetz.de, pl@kamp.de,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The function has only one user: bdrv_co_block_status(). Inline it to
simplify reviewing of the following patches, which will finally drop
unallocated_blocks_are_zero field too.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/block/block.h |  1 -
 block.c               | 15 ---------------
 block/io.c            | 11 ++++++++---
 3 files changed, 8 insertions(+), 19 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 25e299605e..68699ebbfa 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -488,7 +488,6 @@ int bdrv_pdiscard(BdrvChild *child, int64_t offset, int64_t bytes);
 int bdrv_co_pdiscard(BdrvChild *child, int64_t offset, int64_t bytes);
 int bdrv_has_zero_init_1(BlockDriverState *bs);
 int bdrv_has_zero_init(BlockDriverState *bs);
-bool bdrv_unallocated_blocks_are_zero(BlockDriverState *bs);
 bool bdrv_can_write_zeroes_with_unmap(BlockDriverState *bs);
 int bdrv_block_status(BlockDriverState *bs, int64_t offset,
                       int64_t bytes, int64_t *pnum, int64_t *map,
diff --git a/block.c b/block.c
index 8416376c9b..34adf1298f 100644
--- a/block.c
+++ b/block.c
@@ -5408,21 +5408,6 @@ int bdrv_has_zero_init(BlockDriverState *bs)
     return 0;
 }
 
-bool bdrv_unallocated_blocks_are_zero(BlockDriverState *bs)
-{
-    BlockDriverInfo bdi;
-
-    if (bs->backing) {
-        return false;
-    }
-
-    if (bdrv_get_info(bs, &bdi) == 0) {
-        return bdi.unallocated_blocks_are_zero;
-    }
-
-    return false;
-}
-
 bool bdrv_can_write_zeroes_with_unmap(BlockDriverState *bs)
 {
     if (!(bs->open_flags & BDRV_O_UNMAP)) {
diff --git a/block/io.c b/block/io.c
index 121ce17a49..6f9507f718 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2387,15 +2387,20 @@ static int coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
     if (ret & (BDRV_BLOCK_DATA | BDRV_BLOCK_ZERO)) {
         ret |= BDRV_BLOCK_ALLOCATED;
     } else if (want_zero) {
-        if (bdrv_unallocated_blocks_are_zero(bs)) {
-            ret |= BDRV_BLOCK_ZERO;
-        } else if (bs->backing) {
+        if (bs->backing) {
             BlockDriverState *bs2 = bs->backing->bs;
             int64_t size2 = bdrv_getlength(bs2);
 
             if (size2 >= 0 && offset >= size2) {
                 ret |= BDRV_BLOCK_ZERO;
             }
+        } else {
+            BlockDriverInfo bdi;
+            int ret2 = bdrv_get_info(bs, &bdi);
+
+            if (ret2 == 0 && bdi.unallocated_blocks_are_zero) {
+                ret |= BDRV_BLOCK_ZERO;
+            }
         }
     }
 
-- 
2.18.0


