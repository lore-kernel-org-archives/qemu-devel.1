Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B2DC54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 08:31:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE94B20728
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 08:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="PNtYeddk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE94B20728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSzBE-00020R-KN
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 04:31:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49118)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jSz41-0003X9-91
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 04:24:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jSz3t-0000GA-Kr
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 04:24:29 -0400
Received: from mail-eopbgr70099.outbound.protection.outlook.com
 ([40.107.7.99]:65188 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jSz3h-0007mE-Iz; Mon, 27 Apr 2020 04:24:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eaADaIIr9kUfGUkkrJNucJWzjC1TS5wLXdJYaYF61PruyXiP5TTPUlbN0Y7Z+4ZM9nAO7gQOgZYtM0Bc6THAQHxWY0rq5dQ8bB1+7VdFRG8haEjxlMyYMUPFCyBtdSrfm2RJupigLnSdazEQjRuPdDN/HtkIX42FItf1xBsLRWFflXAqVGPgLvltO6M3Wx+uKQLHyMttFoxjCne1rhufckOymKv+sVuX5Ppk2HOQnuch8Y77S6FYNqOiyNHCpJ576Vc4YqHrQhtMiEscQj6yno1Rpgj0X8ZYvRFwqkDNk02y9N0Lv80j1X9OwIcYm230wgt2+zz93VFE9t6iIZfM/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jmFQHF+mLcCi6WpqQgc+kmHUGsKoeQBvNVET0b6l+I=;
 b=drZwlzr55pYxgI0dhf8N8zVKkrYyqeGf5RZ33cdrduGAyD+Jyjy2OHyf+Q1erZpt+q+j6xX8sMUGyglIR0rjs/T7ajFPrTmZVrVQjSGXoQjJb1pEUPWr4xFjzjA11zHkGM2OEqG97mrJ/nGFu6kLnYQYpLebstNcRHHEtIQlfa7HQY1u2k9/Sozav5c4Av3Kz+9N6RDfAmrhFoQv4O8YzXqJ9vOeJ3yCE1o1aERJf1Dgo/FW0XeHcpI+foy85hXoSa3xi1029KbM6YKzjP5NU3W3Wg31HJfmafuaj/N7d3KqBy6bmd9xVk6FYWDfta6ndtH6hXoA3iK0yqDk/jsWEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jmFQHF+mLcCi6WpqQgc+kmHUGsKoeQBvNVET0b6l+I=;
 b=PNtYeddkAZjXWzZgtgDrDj+5EoT0Ii1Sr2pvhT6QieQ/BOKkj5/XZNC0Rm+a4t+AHnVqGa0yI5kLTy37pKnmSfT3tgv+G2HvpPM7YV34Mq9qWDL56fvbrgC8ZmzBu4sqBPEQwY/tmwQ95tF4R9nFcYNds/+weVDR4Re675O28eo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5463.eurprd08.prod.outlook.com (2603:10a6:20b:106::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Mon, 27 Apr
 2020 08:24:07 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.020; Mon, 27 Apr 2020
 08:24:07 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 11/17] block/io: use int64_t bytes in copy_range
Date: Mon, 27 Apr 2020 11:23:19 +0300
Message-Id: <20200427082325.10414-12-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200427082325.10414-1-vsementsov@virtuozzo.com>
References: <20200427082325.10414-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::14) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.182) by
 FR2P281CA0004.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Mon, 27 Apr 2020 08:24:05 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1bec70e4-fe60-4c11-05f1-08d7ea845a5c
X-MS-TrafficTypeDiagnostic: AM7PR08MB5463:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5463AFD32BBB0C7F9514D441C1AF0@AM7PR08MB5463.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:541;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(396003)(376002)(346002)(39840400004)(2906002)(81156014)(6486002)(26005)(8676002)(8936002)(4326008)(6916009)(478600001)(66556008)(7416002)(66946007)(66476007)(6666004)(16526019)(316002)(2616005)(1076003)(186003)(5660300002)(52116002)(6506007)(956004)(36756003)(107886003)(6512007)(69590400007)(86362001);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +VUUVn4BEePzfTqfyhVPCKGeM8YlDSXIItwO+CdKYF62L/oCwCPJiRj8GhndQVrMvUD1jiDCZmgMqY57MdCkXajV0M4QCiKIKT9MQwmG3kh0UEM0J+sfg+VoMjDN7pnVq6kurhVY/+qpUJLyGMMs2mgggaieXK1N/U6pT3I3uiNkt+p3O90BgH7R6WmL5s+PIq8FeulmxwZjYG7lAMuI9sSz8Mz18CwP5cg8VjKAYmFbxCGt62Ed1t1H1AlxniWZuOJXjn4tyYG3jpkiydMSGJyKIwQtWIMXW1E3UxIiWaHaW+if+KDnG/aZuf+M8lEBd1DMHpJFv5WY5QD2TaG6oIlDI/DG8px2+jshx5TDbgb9TFOCohqibSNX4hlge5JkbYMh/mOa9OBG791PrEkaOdxzRduzcqVWWT+TtqeSqmr+GhthWrloikJ/ADjOchv7mt94k8gHs1fgt90ehDW4hssKwTtq7zIzTNQyyIZCJDZ/o2e/wZxrZE3rptdXZ/lJ
X-MS-Exchange-AntiSpam-MessageData: YXkcb4CAkV/NvP1dJAACF6YuXIA/XOpNw31DxqMDRJ8S9cWcBLKBjok2k8D2ZodgII1MLqolDGbCvQ+dhKbSVGQDsJ8vw06axnNRK375j0dQa0lw9OK30ov1lI5EWpg9SivqW89L3tF9YkQpqMSgIalyvThr/zwGr6EG4UaNY13RGjuyFrBCH3wPXg9hkfmrFE86c8eMQSZCwncAjOclDG7PEmtwj7ZvhvJTxa7mj4t/QSRxQ2tI3bpwbTd+6mFFCvKuL02CPrK8Us4IuIfWMxxVjeIvUS4w0C06nPkM5Q4hAN2ujmkTfQmRog5TzRiZtGMnNPgrDSQ8LHAhoMr0+7XsVzF1TFTtAatTZPpFcYFImG6wcGToN//vUF9qNb0y1temPFDmLvY7lJBO+KbqwjMTKvVe0qxZNv4AGustDeBvgSZheZxqzKTrJR87vLlsIeClYBeif0sYWv8l2xdXMHsTgmt0tYOC1Yf5ZACkENYN2GXkxg4xZDkP1yq0X6ejPzoCl1G60HbHm8mKdO4RYE8Zc6uXGso/3ZQtKlTfQgvHZ8dETVg5mLZ+Z1AIRCenVhLnOhj1d6LWg3pII+JnPfs8BumqVRnp8Tmu6OfEvFYsGm66yK80ftgKNOEdd3OeUN0UN0EadKiIc5iTuRD+KeRLhFEUsJDu8qctBtah5KiZd9XMDymIFy0cqSOyjnp0QHMzQFgaTkG9ZlygmNRUWdDYa8foFOwXZ/MbICpi7o1fHBXdv+RCnXWZTaxwvnqfxvhWmsETcr6tEnoRqofRAtQqHOFE0BvJLI8GRaQ8rFE=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bec70e4-fe60-4c11-05f1-08d7ea845a5c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 08:24:07.0300 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8jksoZTmZyghj4kqUVsrDuNNirsHk3tIv8TW7d77/iSp0Rngv1rueXGk6RHaOjBIFvDSNr+61ZQ/y9+TjNJvcMZiTONC8/JWqY3fP6CNi0o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5463
Received-SPF: pass client-ip=40.107.7.99;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 04:24:06
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.7.99
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
Cc: kwolf@redhat.com, fam@euphon.net, integration@gluster.org, berto@igalia.com,
 pavel.dovgaluk@ispras.ru, dillaman@redhat.com, qemu-devel@nongnu.org,
 pl@kamp.de, ronniesahlberg@gmail.com, mreitz@redhat.com, den@openvz.org,
 sheepdog@lists.wpkg.org, vsementsov@virtuozzo.com, stefanha@redhat.com,
 namei.unix@gmail.com, pbonzini@redhat.com, sw@weilnetz.de, jsnow@redhat.com,
 ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are generally moving to int64_t for both offset and bytes parameters
on all io paths. Convert copy_range parameters which are already 64bit
to signed type.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block.h     |  6 +++---
 include/block/block_int.h | 12 ++++++------
 block/io.c                | 22 +++++++++++-----------
 block/trace-events        |  4 ++--
 4 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 03abf30d1d..2eea27bc99 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -731,8 +731,8 @@ void bdrv_unregister_buf(BlockDriverState *bs, void *host);
  *
  * Returns: 0 if succeeded; negative error code if failed.
  **/
-int coroutine_fn bdrv_co_copy_range(BdrvChild *src, uint64_t src_offset,
-                                    BdrvChild *dst, uint64_t dst_offset,
-                                    uint64_t bytes, BdrvRequestFlags read_flags,
+int coroutine_fn bdrv_co_copy_range(BdrvChild *src, int64_t src_offset,
+                                    BdrvChild *dst, int64_t dst_offset,
+                                    int64_t bytes, BdrvRequestFlags read_flags,
                                     BdrvRequestFlags write_flags);
 #endif
diff --git a/include/block/block_int.h b/include/block/block_int.h
index b4b42d0cd6..28aea2bcfd 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1315,14 +1315,14 @@ void bdrv_dec_in_flight(BlockDriverState *bs);
 
 void blockdev_close_all_bdrv_states(void);
 
-int coroutine_fn bdrv_co_copy_range_from(BdrvChild *src, uint64_t src_offset,
-                                         BdrvChild *dst, uint64_t dst_offset,
-                                         uint64_t bytes,
+int coroutine_fn bdrv_co_copy_range_from(BdrvChild *src, int64_t src_offset,
+                                         BdrvChild *dst, int64_t dst_offset,
+                                         int64_t bytes,
                                          BdrvRequestFlags read_flags,
                                          BdrvRequestFlags write_flags);
-int coroutine_fn bdrv_co_copy_range_to(BdrvChild *src, uint64_t src_offset,
-                                       BdrvChild *dst, uint64_t dst_offset,
-                                       uint64_t bytes,
+int coroutine_fn bdrv_co_copy_range_to(BdrvChild *src, int64_t src_offset,
+                                       BdrvChild *dst, int64_t dst_offset,
+                                       int64_t bytes,
                                        BdrvRequestFlags read_flags,
                                        BdrvRequestFlags write_flags);
 
diff --git a/block/io.c b/block/io.c
index 02632eaf59..7c979eacd8 100644
--- a/block/io.c
+++ b/block/io.c
@@ -3209,8 +3209,8 @@ void bdrv_unregister_buf(BlockDriverState *bs, void *host)
 }
 
 static int coroutine_fn bdrv_co_copy_range_internal(
-        BdrvChild *src, uint64_t src_offset, BdrvChild *dst,
-        uint64_t dst_offset, uint64_t bytes,
+        BdrvChild *src, int64_t src_offset, BdrvChild *dst,
+        int64_t dst_offset, int64_t bytes,
         BdrvRequestFlags read_flags, BdrvRequestFlags write_flags,
         bool recurse_src)
 {
@@ -3288,9 +3288,9 @@ static int coroutine_fn bdrv_co_copy_range_internal(
  *
  * See the comment of bdrv_co_copy_range for the parameter and return value
  * semantics. */
-int coroutine_fn bdrv_co_copy_range_from(BdrvChild *src, uint64_t src_offset,
-                                         BdrvChild *dst, uint64_t dst_offset,
-                                         uint64_t bytes,
+int coroutine_fn bdrv_co_copy_range_from(BdrvChild *src, int64_t src_offset,
+                                         BdrvChild *dst, int64_t dst_offset,
+                                         int64_t bytes,
                                          BdrvRequestFlags read_flags,
                                          BdrvRequestFlags write_flags)
 {
@@ -3304,9 +3304,9 @@ int coroutine_fn bdrv_co_copy_range_from(BdrvChild *src, uint64_t src_offset,
  *
  * See the comment of bdrv_co_copy_range for the parameter and return value
  * semantics. */
-int coroutine_fn bdrv_co_copy_range_to(BdrvChild *src, uint64_t src_offset,
-                                       BdrvChild *dst, uint64_t dst_offset,
-                                       uint64_t bytes,
+int coroutine_fn bdrv_co_copy_range_to(BdrvChild *src, int64_t src_offset,
+                                       BdrvChild *dst, int64_t dst_offset,
+                                       int64_t bytes,
                                        BdrvRequestFlags read_flags,
                                        BdrvRequestFlags write_flags)
 {
@@ -3316,9 +3316,9 @@ int coroutine_fn bdrv_co_copy_range_to(BdrvChild *src, uint64_t src_offset,
                                        bytes, read_flags, write_flags, false);
 }
 
-int coroutine_fn bdrv_co_copy_range(BdrvChild *src, uint64_t src_offset,
-                                    BdrvChild *dst, uint64_t dst_offset,
-                                    uint64_t bytes, BdrvRequestFlags read_flags,
+int coroutine_fn bdrv_co_copy_range(BdrvChild *src, int64_t src_offset,
+                                    BdrvChild *dst, int64_t dst_offset,
+                                    int64_t bytes, BdrvRequestFlags read_flags,
                                     BdrvRequestFlags write_flags)
 {
     return bdrv_co_copy_range_from(src, src_offset,
diff --git a/block/trace-events b/block/trace-events
index 13ad9af0d8..e4d68438af 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -15,8 +15,8 @@ bdrv_co_preadv_part(void *bs, int64_t offset, int64_t bytes, int flags) "bs %p o
 bdrv_co_pwritev_part(void *bs, int64_t offset, int64_t bytes, int flags) "bs %p offset %" PRId64 " bytes %" PRId64 " flags 0x%x"
 bdrv_co_pwrite_zeroes(void *bs, int64_t offset, int64_t bytes, int flags) "bs %p offset %" PRId64 " bytes %" PRId64 " flags 0x%x"
 bdrv_co_do_copy_on_readv(void *bs, int64_t offset, int64_t bytes, int64_t cluster_offset, int64_t cluster_bytes) "bs %p offset %" PRId64 " bytes %" PRId64 " cluster_offset %" PRId64 " cluster_bytes %" PRId64
-bdrv_co_copy_range_from(void *src, uint64_t src_offset, void *dst, uint64_t dst_offset, uint64_t bytes, int read_flags, int write_flags) "src %p offset %"PRIu64" dst %p offset %"PRIu64" bytes %"PRIu64" rw flags 0x%x 0x%x"
-bdrv_co_copy_range_to(void *src, uint64_t src_offset, void *dst, uint64_t dst_offset, uint64_t bytes, int read_flags, int write_flags) "src %p offset %"PRIu64" dst %p offset %"PRIu64" bytes %"PRIu64" rw flags 0x%x 0x%x"
+bdrv_co_copy_range_from(void *src, int64_t src_offset, void *dst, int64_t dst_offset, int64_t bytes, int read_flags, int write_flags) "src %p offset %" PRId64 " dst %p offset %" PRId64 " bytes %" PRId64 " rw flags 0x%x 0x%x"
+bdrv_co_copy_range_to(void *src, int64_t src_offset, void *dst, int64_t dst_offset, int64_t bytes, int read_flags, int write_flags) "src %p offset %" PRId64 " dst %p offset %" PRId64 " bytes %" PRId64 " rw flags 0x%x 0x%x"
 
 # stream.c
 stream_one_iteration(void *s, int64_t offset, uint64_t bytes, int is_allocated) "s %p offset %" PRId64 " bytes %" PRIu64 " is_allocated %d"
-- 
2.21.0


