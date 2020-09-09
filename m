Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A42C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 19:04:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D454F20C09
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 19:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="EazSl88O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D454F20C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG5Od-0007tA-Ve
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 15:04:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kG5KI-0007M2-OV; Wed, 09 Sep 2020 15:00:14 -0400
Received: from mail-eopbgr00097.outbound.protection.outlook.com
 ([40.107.0.97]:61422 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kG5KG-0001PE-O7; Wed, 09 Sep 2020 15:00:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQg75RVv0hLzhmQPUZ8IXR3FBw+14fkcfRSH9A+wYA16XnNzAliP0YDYzRkBsMkFeulkrRlqjkTb5i5M6cuGaOs7F8cAoRMSs+NmCRcKr41alSTQ7rz8fMvbSE4H/gp16kNT9ezTASGinc6HhyWcRYM0wtTf0+XsxXn9EYjApPciJ0BlaOrmyEAzsg9MyhASW7Q0xz5E4x6iE33gZoGD3ky4Ma/gHCbHqQ0InVcREaHPy+G1BDJ6XFdtrETMrUokFhDY3d03CZTdRIysDIGy3bCUNq8MRJk36IkAJpf/vPBnuURebFbADi93pyAWb5zTSABm/79/xLEozBa+gy7r/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HyJiuyPPPcnsUxyZB0vjhr3BuepffccjNO/Yfp6rZhU=;
 b=T2mZ0rl8wofnqFjptdJ9XtdLW0yw2jZwXiTf8ZWCyOUaZaJjCDWbnAJ07lDI5Y2/6VPkqhTJ5/uPAWKI+wsH0M38IWaerF9AhBt0WJJdQdHtoNKIle55ciPdytv4EkNFQcVmFFZdqlxeZ/t8PZG/MNtYAkPoIiCCNapFnaPyxED44ooX1pss8U4CcfyqipARKVED0t5jkIIJW5Rd4jz61i6tm1do1jhHJIbXUUtA7rfVd5lnTgi3vOnWREf24DzbplOggA5EiKcArUXD0c3TPSIReHXtkCaBnmsfn1yFJ3SUddCw9TOn1P+/2XH9hWexxDwKUen932VCruH0LkVlIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HyJiuyPPPcnsUxyZB0vjhr3BuepffccjNO/Yfp6rZhU=;
 b=EazSl88O9uaWxbPBNuJje2kmuJLnTANwDkzY7O2xPOuOlSHr+JuqLlhQZPK/DxqRzcdR3tgVNDTjwBPDcQFz6JhiMiGIdcVl+z+UhA9gjFnJR2wxeOzChKvc+l1epV44Z0N6l5m6IV1o4p1K7rYFYBb8c0vSUoKSHbALjnayXY0=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Wed, 9 Sep
 2020 19:00:03 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%7]) with mapi id 15.20.3348.019; Wed, 9 Sep 2020
 19:00:03 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berto@igalia.com,
 vsementsov@virtuozzo.com, eblake@redhat.com, jsnow@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, pavel.dovgaluk@ispras.ru,
 ari@tuxera.com, mreitz@redhat.com, kwolf@redhat.com, groug@kaod.org
Subject: [PATCH 12/14] block/qcow2: read_cache_sizes: return status value
Date: Wed,  9 Sep 2020 21:59:28 +0300
Message-Id: <20200909185930.26524-13-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200909185930.26524-1-vsementsov@virtuozzo.com>
References: <20200909185930.26524-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR07CA0054.eurprd07.prod.outlook.com
 (2603:10a6:207:4::12) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.136) by
 AM3PR07CA0054.eurprd07.prod.outlook.com (2603:10a6:207:4::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.5 via Frontend Transport; Wed, 9 Sep 2020 19:00:02 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.136]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 033bc96c-50c3-45b4-c3b5-08d854f28f55
X-MS-TrafficTypeDiagnostic: AM6PR08MB4070:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4070BE5A29E6BC32950E07BDC1260@AM6PR08MB4070.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ITQYp5sUh8Nqt9+8zRQCvx3DneIbS3GAJpgTvksHzXT4U0uU5qRIYK7DTZmSFd648uHpRLLxsGvM8l2IkBbEog2uqQvtj77Weq5/DS7Uj0lawvvC/igqAa4jZNVw6K6zILwbHGRPWDYqCYmwJTfCDaL1cqJ9KHdDqkFrE9HyuJhhI+rJi0ZISw+QcLBRw0lN1xpPHTnJtCd2loP1C+CxSIlxIZ2ww+0+gDSNApE+pzf2uL79/vyzS7a1oKtG7NjtUa+0OfrbLX+YTOEUGmMQtYo9GAUXB4p+NMcRSCKdocMr4RK/OJRSoVJAwV+M8kKhye8E00tF5l8e8+j8eJhH+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39840400004)(396003)(136003)(376002)(346002)(26005)(316002)(8936002)(8676002)(16526019)(186003)(478600001)(5660300002)(6506007)(7416002)(6512007)(83380400001)(6666004)(4326008)(36756003)(52116002)(2906002)(6486002)(66556008)(66476007)(956004)(6916009)(2616005)(86362001)(1076003)(66946007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: fM0Nlz94bmQF49qmx3+sVD4Eb05NznWzmmyz1wNbMc+Bt02uaGgMaMWZUv3Kok6rU0hS3SLpxVFwR5jndgKtrh8kEhbhTmSOEy7fb03P9z/7T0sTKC69PvQTeIKU3QAh+dWYD/p5s5eA9jK1/HkHblCNNGtD1uJOsFhcmCJQSuepzI82ENXinhdKbBd0UNikoB5MXWkHEWzS6RgoLzZJH5FCE1J6JjwcC4zG7u7eC7d8X6g2JHRsm0ydShafEPVpl+iFztbF4RjC6oHukXoqg76erIsYY76xC9Fc1LfJGSUHMRkOjPOqz5QXaN1ZTbAQeQ5DKhR1mbFG5T8dsU6b4nTXVoINiy/9uTdZXoaWDpCQ+dZt8xGm4vZx3xCkcwQAIETGvUJ1Fi/JfUdS+H+4DnJT3hi0wFJ/MImZWkUoYH7tbbAk+AC9mpTOzooicTNOAavflQg2POKdoU60qXWq3N5KLB4KFZVO73aWEMCdYU530MiiboDK6VyY8/qsLqa3BjKoCmJduvKIuvM7j9KH4bdVeu8YVQRye1jjnaNXUYbFPSVMqXbsoxLpNtj8e6uSm7dbLHMPeVNke/DGbatQrnVqoVyZHxps7q5KgvB7OpjqEKUlNxQbCVdecHIpg1HW+ciH9eTTnkEirLCaIvt9Vw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 033bc96c-50c3-45b4-c3b5-08d854f28f55
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 19:00:03.8069 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cNQCmgFZh3XdS32KjSeK68zgU7jF/ivAvLVzt5j10Vr90cblg6toNRMWW9GT0/09LtrMVTA1F9A/LCgQ9WVp/KBf3dBsAbHdKW+ZCq5wd44=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4070
Received-SPF: pass client-ip=40.107.0.97;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 15:00:04
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
---
 block/qcow2.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index c2cd9434cc..31dd28d19e 100644
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


