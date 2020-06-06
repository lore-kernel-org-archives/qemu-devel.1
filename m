Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47427C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 08:19:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14ECE207DF
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 08:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Re3E9Ak2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14ECE207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhU3R-0005hs-CG
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 04:19:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43628)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jhU2J-0003CQ-7A; Sat, 06 Jun 2020 04:18:39 -0400
Received: from mail-db8eur05on2120.outbound.protection.outlook.com
 ([40.107.20.120]:7488 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jhU2I-0000Zf-D4; Sat, 06 Jun 2020 04:18:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9vuaL2Q8W+lXRrIcwy0Qe2eezG3JZQfx2mZY2Z3guykxnAl9biNxYtso7oHJOBTSq0fjpKNlhPKa+SnB6ApRxSd1LOU/yX2CqPCzqUyv4yvfrGhxdFypnU5wyHRLovNGZZpRgDwhJC3ddU94aReSkCETzIFWg6Of7Aevas5bsMa73KicANlxUoaV40BUSXJYffpuF07fo0w+RWBWWWzsfrBtFFywjCqL0MHGY9Tfodyj5+V5nNIIHEUsptpNWWxkbqwgUPOSZo0vz+qYebWI/g8TUE1KKAG6K3jCQ2/tqoww6pSl+rBfjtphaNSVlkezxaBgYd6L5TyztmkIN5gzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZrTuEZSP71gDjAkAdyTteEbsPsgCIEKlj684dtwCzFY=;
 b=oN58eraLi/IpQ0SbroGIVVAxDAF8DCZuflGfuBiDaQw0Jd6rvjZVJ2nxwvd6rKs3UiigU4w7zXirHbxUv0hHnttgiZ7UPx2mQlPV3vf2qxYHKP2dpkV7UHJD2JknSHFheUQ+1FUO92NY3Anqd84r7bg8Fe9PduEDF0nlv3tTRikxAARbVp9m49N/PgLtCtdPEZiiI9Xdw4sMnklHqmkInlkrA/KvrI4z8L9KTEu51u9wSEVHlUMLVrPTjmop8zlwIwQXH6KrlZjuabN7Zk+2LHqtmdz6FzYpB999C/I9tC4hk6/cA9b7l7s2Ke9CfwPfQ4qGPRZo4dZ6i6hB3s9pyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZrTuEZSP71gDjAkAdyTteEbsPsgCIEKlj684dtwCzFY=;
 b=Re3E9Ak2FRma2+w6JVyKE1ZvMAjfoNMzVku7G4aYLBdSDP8HUO/29jsfkrZGnPo8TqBSbfhzdgYtiAQM/1qpAZ4rZHGXB4KLmxr/qsSWnva0IWrfC6A02wXmWwLbswbq75zO68FnkdsivcfL8hP9nBmZfQi0G/2NO/m36RbHh1s=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5480.eurprd08.prod.outlook.com (2603:10a6:20b:de::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Sat, 6 Jun
 2020 08:18:26 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.023; Sat, 6 Jun 2020
 08:18:26 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v5 05/13] qcow2_format.py: use tuples instead of lists for
 fields
Date: Sat,  6 Jun 2020 11:17:58 +0300
Message-Id: <20200606081806.23897-6-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200606081806.23897-1-vsementsov@virtuozzo.com>
References: <20200606081806.23897-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0036.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::23) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.130) by
 FR2P281CA0036.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18 via Frontend Transport; Sat, 6 Jun 2020 08:18:25 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.130]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99602822-71da-4b23-fcae-08d809f22fe7
X-MS-TrafficTypeDiagnostic: AM7PR08MB5480:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54807EDDBD691066E68FF326C1870@AM7PR08MB5480.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-Forefront-PRVS: 04267075BD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rnBbefJwwaSdHTIRTj9rbpT0ozi+wlBsZzJwseTrZN8MEkAY4hQJpJZgN4Ggu4f9/JLPaXdM/N8Tcu704uh8+w46JSL5LeFv4saPp8NP7OGbYW7fd/JmELCGO3p1CI60FjNW5e8+EbAEMnXhZl4pFHvuxmAj9FFHOSlpslQAGWuBS9AbR74VYaLWqpdULXUG+XLZtA8vzJZ3fUyVNtgOt+trVfMRPpdD+q3vA9aAprqaFCxMP+4of+khzsUbF6rKG83rbK6r8P/X6N0YP7v77B1igVDXCXJcSjdTiIZs4jxHKtU9C+cFiESg1BlvBJ+OVnqPHdUGh0ygbVXFT25+lQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(39830400003)(376002)(346002)(396003)(107886003)(1076003)(4326008)(2906002)(36756003)(6512007)(66946007)(66556008)(66476007)(6486002)(5660300002)(83380400001)(478600001)(86362001)(2616005)(956004)(316002)(26005)(6506007)(52116002)(6666004)(8936002)(6916009)(16526019)(186003)(8676002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: v5w6Iz9ims88wcDnSlVWJogkGh2ppDTFftgafI3GGB5bBeqOugTyw4EYGcQfRJO4phSw7a+UmMasHqLrPUyIlsz31Ry4TPBAUbR50yMWGWmo4TWDtkAW98XhINYAmxYxg7COL3KaZPzINE2CAhe1j3kO6UO+rIChfoExbRsh2XF56ZthQc/kn10/wZe0bClsnnnL6KSAhvoKNjVygisNyFdeu4urXgkvoBVUl2gU2GXE8Pu1gYtfxOf5a+TaF8y0BYScH35TLaV/bMJxHewh/Fvsf20AbYd9/pFK3TpQwPO70mfD+FI96QiyBqP0pP/+C3XWADNoER0ZgdhYWWJyK2uuJdwUoilyMsePpN1jGli2u0KR+KdQdFssBQVqduI/KndxyAc7YLIq3qm9Djx8VP5V5CEAc2u3pl6unC+3Y0M/Q7aO1fUgRq13JaHKb4MFvryRU1oN5upzBIa0ZWU4HvRLjhPgtSG2mHss6lcb+ZOuJzD1vpU9tP+v11l++Ai8
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99602822-71da-4b23-fcae-08d809f22fe7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2020 08:18:26.4936 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RdUYO3pSAUqSi/Zhc1Z5T8qHnCyr5j4gP4oxVT7bnRHkWqM1q1cWBuzgUcIWpud2m557CnPAIo43InruxcGgO544jWITyvoXq4DYour5Gls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5480
Received-SPF: pass client-ip=40.107.20.120;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/06 04:18:29
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, andrey.shinkevich@virtuozzo.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

No need in lists: it's a constant variable.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 tests/qemu-iotests/qcow2_format.py | 40 +++++++++++++++---------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
index 2b6c9612ae..e2f08ed691 100644
--- a/tests/qemu-iotests/qcow2_format.py
+++ b/tests/qemu-iotests/qcow2_format.py
@@ -39,29 +39,29 @@ class QcowHeader:
     uint32_t = 'I'
     uint64_t = 'Q'
 
-    fields = [
+    fields = (
         # Version 2 header fields
-        [uint32_t, '%#x',  'magic'],
-        [uint32_t, '%d',   'version'],
-        [uint64_t, '%#x',  'backing_file_offset'],
-        [uint32_t, '%#x',  'backing_file_size'],
-        [uint32_t, '%d',   'cluster_bits'],
-        [uint64_t, '%d',   'size'],
-        [uint32_t, '%d',   'crypt_method'],
-        [uint32_t, '%d',   'l1_size'],
-        [uint64_t, '%#x',  'l1_table_offset'],
-        [uint64_t, '%#x',  'refcount_table_offset'],
-        [uint32_t, '%d',   'refcount_table_clusters'],
-        [uint32_t, '%d',   'nb_snapshots'],
-        [uint64_t, '%#x',  'snapshot_offset'],
+        (uint32_t, '%#x',  'magic'),
+        (uint32_t, '%d',   'version'),
+        (uint64_t, '%#x',  'backing_file_offset'),
+        (uint32_t, '%#x',  'backing_file_size'),
+        (uint32_t, '%d',   'cluster_bits'),
+        (uint64_t, '%d',   'size'),
+        (uint32_t, '%d',   'crypt_method'),
+        (uint32_t, '%d',   'l1_size'),
+        (uint64_t, '%#x',  'l1_table_offset'),
+        (uint64_t, '%#x',  'refcount_table_offset'),
+        (uint32_t, '%d',   'refcount_table_clusters'),
+        (uint32_t, '%d',   'nb_snapshots'),
+        (uint64_t, '%#x',  'snapshot_offset'),
 
         # Version 3 header fields
-        [uint64_t, 'mask', 'incompatible_features'],
-        [uint64_t, 'mask', 'compatible_features'],
-        [uint64_t, 'mask', 'autoclear_features'],
-        [uint32_t, '%d',   'refcount_order'],
-        [uint32_t, '%d',   'header_length'],
-    ]
+        (uint64_t, 'mask', 'incompatible_features'),
+        (uint64_t, 'mask', 'compatible_features'),
+        (uint64_t, 'mask', 'autoclear_features'),
+        (uint32_t, '%d',   'refcount_order'),
+        (uint32_t, '%d',   'header_length'),
+    )
 
     fmt = '>' + ''.join(field[0] for field in fields)
 
-- 
2.21.0


