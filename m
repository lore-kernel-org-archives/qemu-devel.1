Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9240AC433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 13:13:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 152A62245B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 13:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="KCOlpPXy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 152A62245B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUrSO-00065Y-33
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 09:13:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47426)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kUrIz-0001nM-ST; Tue, 20 Oct 2020 09:03:58 -0400
Received: from mail-eopbgr70134.outbound.protection.outlook.com
 ([40.107.7.134]:56643 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kUrIu-0005bG-8s; Tue, 20 Oct 2020 09:03:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FuiG5nLJVapt70PFJQghcUk9GeiQKzQCG9D2mKK+3+/MjdEYl6Fm71tn+6gJrFH8FPNWPK/DqBhPCcc5y+FbI3JYaavwCkGHK/AAh2GJAqhHwZkiq2LiGH6aBqoeuDEj48voJ8o4s673JoSXrVmfGSpxXmFBHt9w2rExIGGKkTIApMZTDvK0khUW1iOoKGLKeUnyrDBScTu5+eWwOBsUd29M7OKqv8hNkk4jrZQCJACb++9LxWBo4P0wvBVKsU9J0g+mK39NQFKmVVy2h9O54GlFVfCQTlcuBO15Q9QGBR2jffzCY1Pjx6HuEqa3CFD+2010Z47/kt7MzR/gyRsdoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7jSfM5fFUJgLtB7sfni8JewNTroG6CKzKQYJDhuoTw=;
 b=DXk17K0ci4IeE3RIBgig+TsnSJjVob82Q1Eiat6vXWXnV2XnUDmV4pRCSqctlXJFrUmWcRa97q1bbqNEZKu5mw1Uf48DF5FFzxOHPgJtrKEnkx4lbwOzzT630tA8El2/2fvPKMzhhvH8GWPwTH3JG6Fqv2meH9PqXmdtGjucm+MD4ibW966/LVg+lnTkuAFjaQ1LPXyCBb+Ntv1D395MKSEm/n82gRXBDufNE+iQ8dJFClPhwtQWYYh7FBY5zJwTzrT68s1vTA/RLjxEfM+iLeSA5UOPiIw7TJF8WQfeQZPbtyCdRYX7htVqkF9MXMhGoFCzSR7BZRUJ1PgRsZqyeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7jSfM5fFUJgLtB7sfni8JewNTroG6CKzKQYJDhuoTw=;
 b=KCOlpPXyv6bCuqhgATkV1dKGX7S5K1Kknt4tHQErM650IHpyqp/twHFHrNnrc8wJzjWftiMQEKjH/xYEc0zG393EG7kHjpAm5Qgikk2KiKkf7oqWYVw3oncRAr5ShfqcR6ZmEdTLwfbTqbRc6l3+8RykkqQ8Kcq+ZSdOe4NOs88=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AS8PR08MB6168.eurprd08.prod.outlook.com (2603:10a6:20b:294::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 20 Oct
 2020 13:03:39 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Tue, 20 Oct 2020
 13:03:39 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berto@igalia.com,
 vsementsov@virtuozzo.com, eblake@redhat.com, jsnow@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, pavel.dovgaluk@ispras.ru,
 ari@tuxera.com, mreitz@redhat.com, kwolf@redhat.com,
 Greg Kurz <groug@kaod.org>
Subject: [PATCH v4 11/14] block/qcow2: read_cache_sizes: return status value
Date: Tue, 20 Oct 2020 16:03:08 +0300
Message-Id: <20201020130311.14311-12-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201020130311.14311-1-vsementsov@virtuozzo.com>
References: <20201020130311.14311-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [185.215.60.66]
X-ClientProxiedBy: FR2P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::10) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.66) by
 FR2P281CA0023.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.9 via Frontend Transport; Tue, 20 Oct 2020 13:03:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f061bd31-7497-4674-22c7-08d874f88f11
X-MS-TrafficTypeDiagnostic: AS8PR08MB6168:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8PR08MB6168D106C8BFFFBCEC846454C11F0@AS8PR08MB6168.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DAdnBc/1xK62/pzmSmtLEpawNXB0B02fE8HBOplp7LrkLCGKPptT0DPfCj6xcHpMk8Yk9B0mXoeqpCGSYiN/RRo1ShKt5w2x00TZZszI9LxOniv/A+t7Uv2BCvyBEvaQ9MDcr+79WYvwgSQJnxAD/xQBkwe7j4CgWjo9CkMm04ZB2mGSazQl1xDdICo8pZRRQgAwU5izfpcXuV0H5jwhAUWSD262EakEtDJ0IVvogN27pYaeFkvBy7OqilWKjUtWyYIMvLKrmq2rbHAYB8c8DKJZGW7pczvXregTW7rGueem87kvZXcsK/asHvg1ao3CAyoXGVOH+AMxd4TdyCgk4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(366004)(136003)(376002)(346002)(396003)(8676002)(66946007)(16526019)(478600001)(8936002)(186003)(5660300002)(52116002)(6506007)(6486002)(2906002)(6916009)(316002)(83380400001)(36756003)(2616005)(26005)(7416002)(956004)(1076003)(86362001)(66556008)(4326008)(6512007)(6666004)(66476007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: BIuwjEh+txOdxr0FrfN4g4NNJhAmdtI8rHeEigaMRbENIP5O1fTiHLQtcK46Zbcay8v+DiJOeY9pOJUjYP7tyVstOY212aJXBFOio6pVirQMRthkIbCd9zyH+kCvNbq+ZiFu2cPWuKjYb6l9c/qG9UUSyi3RKuzRQHtzTsoUGQw9u9uqu0Bcw1BoWhPL9cHEXsLCSVO3glI4qEr6q5qw0c91qwnn2t0TNSKqPDmhmEhlycysh0k0FEnHdj6dwIOS3SUANe1iYDfu88orLRb3IxiN2OvGuSO1cXow+wtnPK/z6SCGV1yyv1nnLVhmL8AV5Bi0zhajTufQR5V6p7EpTzPA113t3pp1xpfFNYKrjAaXxYHfgyga3+KFNTXW2C+Yfn94QHWHGbr9gTOm6MhJZguMMiq5OSK2rdyobgEuyyfv7UW/ROObDxO+ZVOK5VIoM0XAIwp4aw2WJZjmKknA/mgEvZJ52Ww9NYGMBKZWAfDPzfSqWnpuQ+EBLVc3siX+YthIu4ZsplEW0HCiyDxZzsNLCx/hUyWS6m1RvcVDZP1buJXGbcMX9pi61SuhgsfYvpSOkdjvMu6f+Oaq7/ppUnp/obPZXMGPo5TX4vfzNEfrbgileelozMuNA3bA5PALN0lZ+WZ2pY6ufv7PfNkIog==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f061bd31-7497-4674-22c7-08d874f88f11
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2020 13:03:37.5355 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zWWRMLB530vec/bIUCpatae5G6sWlu71AStlktccdoYkIhYz8tgpxMZxwixN40P/rIc9iUIKRP0SYxjljG6il1gCI/3iu7ajA+CcWRcgyyw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6168
Received-SPF: pass client-ip=40.107.7.134;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 09:03:42
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It's better to return status together with setting errp. It allows to
reduce error propagation.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index c4b86df7c0..2b6ec4b757 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -869,7 +869,7 @@ static void qcow2_attach_aio_context(BlockDriverState *bs,
     cache_clean_timer_init(bs, new_context);
 }
 
-static void read_cache_sizes(BlockDriverState *bs, QemuOpts *opts,
+static bool read_cache_sizes(BlockDriverState *bs, QemuOpts *opts,
                              uint64_t *l2_cache_size,
                              uint64_t *l2_cache_entry_size,
                              uint64_t *refcount_cache_size, Error **errp)
@@ -907,16 +907,16 @@ static void read_cache_sizes(BlockDriverState *bs, QemuOpts *opts,
             error_setg(errp, QCOW2_OPT_CACHE_SIZE ", " QCOW2_OPT_L2_CACHE_SIZE
                        " and " QCOW2_OPT_REFCOUNT_CACHE_SIZE " may not be set "
                        "at the same time");
-            return;
+            return false;
         } else if (l2_cache_size_set &&
                    (l2_cache_max_setting > combined_cache_size)) {
             error_setg(errp, QCOW2_OPT_L2_CACHE_SIZE " may not exceed "
                        QCOW2_OPT_CACHE_SIZE);
-            return;
+            return false;
         } else if (*refcount_cache_size > combined_cache_size) {
             error_setg(errp, QCOW2_OPT_REFCOUNT_CACHE_SIZE " may not exceed "
                        QCOW2_OPT_CACHE_SIZE);
-            return;
+            return false;
         }
 
         if (l2_cache_size_set) {
@@ -955,8 +955,10 @@ static void read_cache_sizes(BlockDriverState *bs, QemuOpts *opts,
         error_setg(errp, "L2 cache entry size must be a power of two "
                    "between %d and the cluster size (%d)",
                    1 << MIN_CLUSTER_BITS, s->cluster_size);
-        return;
+        return false;
     }
+
+    return true;
 }
 
 typedef struct Qcow2ReopenState {
@@ -983,7 +985,6 @@ static int qcow2_update_options_prepare(BlockDriverState *bs,
     int i;
     const char *encryptfmt;
     QDict *encryptopts = NULL;
-    Error *local_err = NULL;
     int ret;
 
     qdict_extract_subqdict(options, &encryptopts, "encrypt.");
@@ -996,10 +997,8 @@ static int qcow2_update_options_prepare(BlockDriverState *bs,
     }
 
     /* get L2 table/refcount block cache size from command line options */
-    read_cache_sizes(bs, opts, &l2_cache_size, &l2_cache_entry_size,
-                     &refcount_cache_size, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!read_cache_sizes(bs, opts, &l2_cache_size, &l2_cache_entry_size,
+                          &refcount_cache_size, errp)) {
         ret = -EINVAL;
         goto fail;
     }
-- 
2.21.3


