Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB71C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 19:03:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B669D20C09
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 19:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="RZZI/2cX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B669D20C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG5NJ-0004S5-TY
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 15:03:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kG5KF-0007Cl-4c; Wed, 09 Sep 2020 15:00:11 -0400
Received: from mail-eopbgr70118.outbound.protection.outlook.com
 ([40.107.7.118]:32002 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kG5KB-0001MM-TA; Wed, 09 Sep 2020 15:00:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hp9h+oEgliJhLurVV00m/StoflWHzBEoRjJ1eO6qO/9rPfm0A6U9osD71ge/85K2e/uqrt8l2Z5eVrHfxZo7unZbL3GQ+3t7DThQsoBoJX3MKzy9vGbsjI/AoBL92NCGLUGeqICDT9Zy9Vi+13VahLPa81Q0IRRoD37xd/ZtX+oaXfsTyrW+P+54wp85utU3S2Lnp78zP1HiFVkBKUfuc6Em1nbqgM+0GWwYYUurQZZqSD/O2ORPJqmOy4JFx/PTA8Ubb+oMlsbpbDxAwfvVB/HxXuoAnjX6pjCaD/DvazQ435G0t2dRsWU6pnIJXN4b92rW4o2qAh83VgeUfOqPJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KH0vRgmj6WybSN3XtnRy+D0LLUR0cMqfBa7zT7UKwdo=;
 b=CEtuxksfP+dCLj8ixQGQCRtTew7I962Z4N6BuqjZF+yNUoHhuHIXyOlmFncKGyfCrFjQaZxSvnoEd8OjUdTHNlCpG/6+kvTc4aQzkNmuCMYrrQsQfZC2sXK38cR5OejlrLqpXklNw6Q84JQ8+QNhcfvCiQkvJ2vO9kXUUzxvAJTvop22Hw5PKskOOlNW1quIo5EmjBxFOceaFO7NVSrsR3GNDrrh9u7bRdjrYetheCRIoIhPW44w+3+KSEpN0Iy/aNIg+gRbmSCdqJcU9OsObUG7k+Dx54+vA3c4e85+dHPZ+o9ZFha42Gs5rcqC/fMKLRnLrVQLGitgC+PPwQuZTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KH0vRgmj6WybSN3XtnRy+D0LLUR0cMqfBa7zT7UKwdo=;
 b=RZZI/2cX+sjsrqkMOdeNughd++6QsnqG6vWbp3rHmB52L6IJO02FPKTkNajl89IgKxnJyETXaIl3MM7ROfCyczA1z+a3U/EqdOOPk8hs6yqOtr4PPT7vHCa/enw9N72bIjnQkfyvz11dkTMxdw5gBooEaipfDMNPWOkwLJS0Dew=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3445.eurprd08.prod.outlook.com (2603:10a6:20b:43::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 9 Sep
 2020 18:59:58 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%7]) with mapi id 15.20.3348.019; Wed, 9 Sep 2020
 18:59:58 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berto@igalia.com,
 vsementsov@virtuozzo.com, eblake@redhat.com, jsnow@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, pavel.dovgaluk@ispras.ru,
 ari@tuxera.com, mreitz@redhat.com, kwolf@redhat.com, groug@kaod.org
Subject: [PATCH 07/14] block/blklogwrites: drop error propagation
Date: Wed,  9 Sep 2020 21:59:23 +0300
Message-Id: <20200909185930.26524-8-vsementsov@virtuozzo.com>
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
 15.20.3391.5 via Frontend Transport; Wed, 9 Sep 2020 18:59:57 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.136]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3821a18-bada-4a3c-46b7-08d854f28c18
X-MS-TrafficTypeDiagnostic: AM6PR08MB3445:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3445627CFE7CDD279E9DBF37C1260@AM6PR08MB3445.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:608;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s+qmynvTWu4LmLvOcNDjED+AEVFJlWhB2InNLEScBiw7xoCuXJjjHjk2zibxiYnDrJvfruD8n1nz46sDmJgpgWCXvEgD05TSDennnkKts3XOxVXC6+CFPbTclSt3w170aikdJRL4zl+16WKdQ63sVm6lXy6X5EJKXB2NfdpV4JvlIRqZPpAihoeP/o/jvgOTuvBaqKCQ6kKBHoF7x5W7aBpIKREez5lZtX34ljqvSS4bACQbxW5gdOIDtSyJ9pcn5Oh0DI2Np57srMF3jSNtIsol1J37MdrduQidV0NXVQ1/wMexYzOoUCUw/JG8NsgHrTEeOvaeCLNMa5g0iiqQiA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(39840400004)(376002)(346002)(66946007)(52116002)(83380400001)(2616005)(956004)(2906002)(6666004)(8676002)(6512007)(1076003)(86362001)(5660300002)(26005)(36756003)(6916009)(478600001)(6506007)(8936002)(316002)(16526019)(66556008)(186003)(66476007)(7416002)(6486002)(4326008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: ndWOkFmi+OiCWBSoCnqh/suVRxuu+f364sb/Jj4+wp1UZy9N7rbf53dgo/6ownqHKZcIKTEzA0blxayh2tW9/+xgvXVsgCbH73aC5OkAvFtbWGEWwNfmlOiPrAgvPuUFsvixBA5bQoWUsfnr9aaiToqEL8KU1YZ8rqaV4BP7Sn6j9vJ53WgX4PfG8RGsIQO3hNj2oh2CAB0TpfU8j1NVwl2rgJm6e9Z4hDK/R3QoMsZByLhNK9ekY284p2Ts/sGypcaJ2d+PwUV3Uq/bt15P3xSjqi+at8HI7LvuTbsrbBOEid1OL7G3tRQxP6lPZu5MkWlwB/tmAb6LbVK12AQfOJj8e2PHnoLrKk0svBpv6X1Qz847NSDhKwCXman+tKp5UgySL+6mIZZTDygGFUu8yAvv/gqqUwk1BNvHb2ltFrbzCT/3ZQraBg9j/MrhNXLsfYZtHoucmmKHG2I5hUrmt9ckOL4LPHPrL1FyrkvskyZlk0NdWtOC/viMYNwcjCjXz1MgONps8E0wEyV4YWBH1cEP//1ElC9FTKntq7Uqsq36KqrQglI9XpNT3iH0lzwbrwZ7i8Y+Etp7dw0U0sF4qYgdB9f4VbtkHdrw9tlVUSUhF6P/fbZ1+hZ98sn1v+nMij8wAvyM+cdjNDhs9jH23w==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3821a18-bada-4a3c-46b7-08d854f28c18
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 18:59:58.3867 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gb+93sz8mSgky8axzvXmNOGkOesaF/OsgvjC6Z6hIr/avIJ/zY8LPSvKy1Fj/Zb6joKa2SqL18AA5t5eR1Pifx6/zUWPs0a5omJbXeJUcAA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3445
Received-SPF: pass client-ip=40.107.7.118;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 14:59:58
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

It's simple to avoid error propagation in blk_log_writes_open(), we
just need to refactor blk_log_writes_find_cur_log_sector() a bit.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/blklogwrites.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/block/blklogwrites.c b/block/blklogwrites.c
index 7ef046cee9..c7da507b2d 100644
--- a/block/blklogwrites.c
+++ b/block/blklogwrites.c
@@ -96,10 +96,10 @@ static inline bool blk_log_writes_sector_size_valid(uint32_t sector_size)
         sector_size < (1ull << 24);
 }
 
-static uint64_t blk_log_writes_find_cur_log_sector(BdrvChild *log,
-                                                   uint32_t sector_size,
-                                                   uint64_t nr_entries,
-                                                   Error **errp)
+static int64_t blk_log_writes_find_cur_log_sector(BdrvChild *log,
+                                                  uint32_t sector_size,
+                                                  uint64_t nr_entries,
+                                                  Error **errp)
 {
     uint64_t cur_sector = 1;
     uint64_t cur_idx = 0;
@@ -112,13 +112,13 @@ static uint64_t blk_log_writes_find_cur_log_sector(BdrvChild *log,
         if (read_ret < 0) {
             error_setg_errno(errp, -read_ret,
                              "Failed to read log entry %"PRIu64, cur_idx);
-            return (uint64_t)-1ull;
+            return read_ret;
         }
 
         if (cur_entry.flags & ~cpu_to_le64(LOG_FLAG_MASK)) {
             error_setg(errp, "Invalid flags 0x%"PRIx64" in log entry %"PRIu64,
                        le64_to_cpu(cur_entry.flags), cur_idx);
-            return (uint64_t)-1ull;
+            return -EINVAL;
         }
 
         /* Account for the sector of the entry itself */
@@ -143,7 +143,6 @@ static int blk_log_writes_open(BlockDriverState *bs, QDict *options, int flags,
 {
     BDRVBlkLogWritesState *s = bs->opaque;
     QemuOpts *opts;
-    Error *local_err = NULL;
     int ret;
     uint64_t log_sector_size;
     bool log_append;
@@ -215,15 +214,15 @@ static int blk_log_writes_open(BlockDriverState *bs, QDict *options, int flags,
         s->nr_entries = 0;
 
         if (blk_log_writes_sector_size_valid(log_sector_size)) {
-            s->cur_log_sector =
+            int64_t cur_log_sector =
                 blk_log_writes_find_cur_log_sector(s->log_file, log_sector_size,
-                                    le64_to_cpu(log_sb.nr_entries), &local_err);
-            if (local_err) {
-                ret = -EINVAL;
-                error_propagate(errp, local_err);
+                                    le64_to_cpu(log_sb.nr_entries), errp);
+            if (cur_log_sector < 0) {
+                ret = cur_log_sector;
                 goto fail_log;
             }
 
+            s->cur_log_sector = cur_log_sector;
             s->nr_entries = le64_to_cpu(log_sb.nr_entries);
         }
     } else {
-- 
2.21.3


