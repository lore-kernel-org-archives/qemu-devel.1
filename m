Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87005C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 18:27:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1E2F22211
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 18:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="dbmZnV72"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1E2F22211
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJL6i-00057x-P3
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 14:27:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kJL09-0007YJ-Dz; Fri, 18 Sep 2020 14:20:53 -0400
Received: from mail-eopbgr40122.outbound.protection.outlook.com
 ([40.107.4.122]:8096 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kJL06-0004bq-9F; Fri, 18 Sep 2020 14:20:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DtIeOu++b3EL/neZNydndoUZrg66aKijLhxMwR2R2yT7QayJfQYGL9EBjJhUFykzVpvy+HlYN1DtEr98E+J0TtB3TaIUl+I0s3w9Rl0xmQbs/3OOuc58dmuLItFPqiNBQrQVcUGqeMZP73JlRtRWIl0tjgF1TEubiObv4LIiUUahkzaX+SM5MaMcKuk9595qWVCtfJFiLYNuxnkh0NyAOkcQrdBYVEgty+BNavUluizEEg1cn5K0po22mWaFd9QQGDK72zVuPLrTZglsPLyalevrXVQZ9klYfH7BGNOdrC/0AXyS8nXl3Ay+W3rgwZ2vb17qxuT6UJRYrp/a6Co1aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYasGo5hEM/BWvLHsEUSxKaQxPClGh+OelGjajwrA9I=;
 b=oHcHUDv8P2SvCqTvBt6oRqBUwtb3CF2iNzmebnUqxFYD2h3sD0anrrDIyDunhRKDUcG+a/SeIYzIXxFrauMTDaNlzMLQtWZoVEFj1INIA6EfhDXDO/CCxjcqmem4KdKKgY/2SOIjpHDS+eRd7ZREMGgOQFqBNnYU8nS/jg0s1Du0zWi+PPVeCW/G7ACCAqW5hAFimITbbBd997y0Eu1g6G7BFTwj4/bctP72QFycR4+pQxAL6V333eJbR7J528aPsEN9fkd36003qmzYnHGX8pjV3T/BxQnK+4neT/I07CJgnge/16PiuBkqA5TSD7ABpor5Dhqf34s3P5jMPmiLXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYasGo5hEM/BWvLHsEUSxKaQxPClGh+OelGjajwrA9I=;
 b=dbmZnV72KaxQkcP/UwzS8R6inpCYiwhusiv+0GGLM6d6RMN6ijIYnc59kzh1PQ8XTTP1elWR/0MuiuW91fYGRN/vBeNjdf2zxklOzM3nZ30nnheEp8nz9MMOjn6N2hhQtfSNYyv1qwpHrhna6Dc4n5nTtMuTGELxJpmRRfV+pBY=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1905.eurprd08.prod.outlook.com (2603:10a6:203:43::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Fri, 18 Sep
 2020 18:20:14 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.019; Fri, 18 Sep 2020
 18:20:14 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com, armbru@redhat.com,
 eblake@redhat.com, fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com,
 kwolf@redhat.com, den@openvz.org
Subject: [PATCH v6 09/15] qemu-io: add preallocate mode parameter for truncate
 command
Date: Fri, 18 Sep 2020 21:19:45 +0300
Message-Id: <20200918181951.21752-10-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200918181951.21752-1-vsementsov@virtuozzo.com>
References: <20200918181951.21752-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR05CA0019.eurprd05.prod.outlook.com (2603:10a6:205::32)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.106) by
 AM4PR05CA0019.eurprd05.prod.outlook.com (2603:10a6:205::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.13 via Frontend Transport; Fri, 18 Sep 2020 18:20:13 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.106]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1fef61f7-cd9c-48bb-78d4-08d85bff7c98
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1905:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB19058AB3A99B985647544429C13F0@AM5PR0801MB1905.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M9/Ct3e4otTIhITHAlYLewQUMqhkOzEpUloFhjafawKcJx/KodBzC4bK/d1EWP3im+rw05A6SQouC7anzIuQ4Dfc2Bw7fq8wx9nx2r9sV0YY5psvCutvHPJKFXxEr7OokkHSknnQXVQzuSdlknUMvLfMIA24N9VYQmFHCJ2IYm5ox79CKfFarnxegEwB+GZ8T6tfa7UKrnnjLty0KKXe/IRHH5yxRhrmaTR+QTKYiJWBMyRqBuKv6gY5eF6ntuzD77KtpuWGGe0t9qVEgKa0lvrGn1cpNfyb23b8r1yV/iYNeLjWsVeQSbAfGq7FCRI5AKjFQ0Byvkjf3kCwGifLL+QN+hEjY1B9q12q62u9Rind9GCG7i/cLiMCoGHSDqXi
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39830400003)(396003)(376002)(366004)(136003)(346002)(66556008)(8936002)(66946007)(66476007)(107886003)(6506007)(2616005)(5660300002)(2906002)(83380400001)(6486002)(956004)(6666004)(1076003)(186003)(8676002)(52116002)(4326008)(316002)(86362001)(6916009)(478600001)(26005)(36756003)(16526019)(6512007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 8e/PPmkQLSdhnMiRYOecxmu7jS8szuDWU2XppRCwg7I+P6Y54TvM8zCWmg+5nGCvMtPN3Bk19XfJSRf8CA3ZAWsScVJy9Li5zkkNvzkDcSXXizaYI0YTePRLjx1FENnjHYOta1EjETi8S9KgD7A+lNFBJqLaBho0xxR75VlZ+VBx5f52McXZ97pCYlbQMT6cHDBjoqf4tq5W0yl299lPF/DO3mrHpT0IWRX3XhglWaD75AGRkxlaN3A794HLy/1N/VNhfWsmb8yVseZWLxQTrH8LdUkbgBzVX+fT+euytJXxLmrDqJe0F0nRDFzcKiKzPbGpjuisiNi72MkpkG2iCIC5F5rucITCo+2KTvqjKSEC/m0q08/gG6I6dAxHcTQIMZ7wo9dsYHCTwulxDQ6quN9mDkA3oKwn2B060oPTRBlpbbVcDPw3gBa44T8Lw11spiR6jA40GUMDgR5BD8yl0PVwiL7RuSZMjR+H6JmS6Qgci0E1U1TNfJgapjhYTu0op33alf0yIHqRYdW4/YpuU9e38rNORNqYvg7IvJ0py5s/omBx/zdQ4Wy5S+SK1AjfhLXEcbcq/Hn/tzFCnWobYCXg+Kd0M7GMwy1a9Yi1yli/Japhqp5UAITY9FV/LGjsk2u2SioYbTiUfNlIWoyaYg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fef61f7-cd9c-48bb-78d4-08d85bff7c98
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2020 18:20:13.9962 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lu/GFPdjcqT6c3qHmOm0ai+wtRzJwZcFfq+56+uDHyTAsvsmFwVgF3lRQivqtb0bn6eHOb13qA1rcoM3jKM6RRhNS7tCT3tB93jsRIMV6m4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1905
Received-SPF: pass client-ip=40.107.4.122;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 14:20:06
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

This will be used in further test.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 qemu-io-cmds.c | 46 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 14 deletions(-)

diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index baeae86d8c..64f0246a71 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -1698,13 +1698,42 @@ static const cmdinfo_t flush_cmd = {
     .oneline    = "flush all in-core file state to disk",
 };
 
+static int truncate_f(BlockBackend *blk, int argc, char **argv);
+static const cmdinfo_t truncate_cmd = {
+    .name       = "truncate",
+    .altname    = "t",
+    .cfunc      = truncate_f,
+    .perm       = BLK_PERM_WRITE | BLK_PERM_RESIZE,
+    .argmin     = 1,
+    .argmax     = 3,
+    .args       = "[-m prealloc_mode] off",
+    .oneline    = "truncates the current file at the given offset",
+};
+
 static int truncate_f(BlockBackend *blk, int argc, char **argv)
 {
     Error *local_err = NULL;
     int64_t offset;
-    int ret;
+    int c, ret;
+    PreallocMode prealloc = PREALLOC_MODE_OFF;
 
-    offset = cvtnum(argv[1]);
+    while ((c = getopt(argc, argv, "m:")) != -1) {
+        switch (c) {
+        case 'm':
+            prealloc = qapi_enum_parse(&PreallocMode_lookup, optarg,
+                                       PREALLOC_MODE__MAX, NULL);
+            if (prealloc == PREALLOC_MODE__MAX) {
+                error_report("Invalid preallocation mode '%s'", optarg);
+                return -EINVAL;
+            }
+            break;
+        default:
+            qemuio_command_usage(&truncate_cmd);
+            return -EINVAL;
+        }
+    }
+
+    offset = cvtnum(argv[optind]);
     if (offset < 0) {
         print_cvtnum_err(offset, argv[1]);
         return offset;
@@ -1715,7 +1744,7 @@ static int truncate_f(BlockBackend *blk, int argc, char **argv)
      * exact=true.  It is better to err on the "emit more errors" side
      * than to be overly permissive.
      */
-    ret = blk_truncate(blk, offset, false, PREALLOC_MODE_OFF, 0, &local_err);
+    ret = blk_truncate(blk, offset, false, prealloc, 0, &local_err);
     if (ret < 0) {
         error_report_err(local_err);
         return ret;
@@ -1724,17 +1753,6 @@ static int truncate_f(BlockBackend *blk, int argc, char **argv)
     return 0;
 }
 
-static const cmdinfo_t truncate_cmd = {
-    .name       = "truncate",
-    .altname    = "t",
-    .cfunc      = truncate_f,
-    .perm       = BLK_PERM_WRITE | BLK_PERM_RESIZE,
-    .argmin     = 1,
-    .argmax     = 1,
-    .args       = "off",
-    .oneline    = "truncates the current file at the given offset",
-};
-
 static int length_f(BlockBackend *blk, int argc, char **argv)
 {
     int64_t size;
-- 
2.21.3


