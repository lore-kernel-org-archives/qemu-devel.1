Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22FAC55199
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 08:29:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE83020728
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 08:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ZSCClrZw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE83020728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSz8u-0005LX-QS
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 04:29:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48896)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jSz3e-0002ZC-EL
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 04:24:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jSz3d-0007kT-O1
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 04:24:06 -0400
Received: from mail-eopbgr70127.outbound.protection.outlook.com
 ([40.107.7.127]:7750 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jSz3c-0007bA-0s; Mon, 27 Apr 2020 04:24:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JdIe/23Wow+W+ScKAQZgDYWPO/wkFkcvZasRQ7tvv/h7cW/DthwXXVmKUTiFSazEX8RM6VlU5SrmrgrrhQzG/gOR0qwH3v18Cja8NS/OqJE+BDchXvMoNYLU5z00J2xVC8BeLAhueoL9sY4WEi3VIaZRybCH9kzUL7ir9WN/u3w4vF2FMhJquBwW69RViKWjwqtuvBqehnXfaCP9NQvH//W24aELrZiA7p8CLtl9IFDqie/zp885OI8cR2IaRCKS4hnDawf9hYAnYSYOfE5Y3k+DKwP7Juolr85mtNmbdenCbx6cn74z3h3P7WQ5WcM4RTJUeRW8yemRH69DR9UERg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uHbf3Z3Zw+ddeV34dU1QJI9Zl/VP12Scp41HLEfvowg=;
 b=K9BzOm56ASo8fF9tb5BMl3cdL68K9Lb03b/uKHCY18L3+6JjSFGqq95TXVJgMHwwV9GdLTZ5d6t8XTE6Nt1kOpj+3WcXHKaA2BOIfbAS/cYNFRz/2yYsUAmlia1cLckMYcuYLhY7JXqzEvbJvDmCOOeUVmHWqBpSymkAJEo+pC4Gd49dUgBL2xIyC42kwM+dTqvitDkmaaXIalavViUiS45jNxv0Ez/UfsptOxuRvnmpch0btjEKkoaICHwCjQ8EIlg2n0CajzZdgxBE5PSZucrwEOueVZMxciprH7RyVRlJqQo2p3DWwROhQwUy1ijTaZiMAfD2STWVFMpsVr57cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uHbf3Z3Zw+ddeV34dU1QJI9Zl/VP12Scp41HLEfvowg=;
 b=ZSCClrZwQJccq2ypUc1DiEfDP8MGxjdwA9XnIn20GZM15GQUaGNN01/a788LfI/UMpGWg9OTUt8MiwM5qvSE8WPDJKsU1FQA8AcviVoBRaD5Ne1DIJIT6Ziwdxngx6ZwKbYyG1oZyxnGqfBg3DKFkJVPHnfCSl4NLL1ucx3GNnU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5463.eurprd08.prod.outlook.com (2603:10a6:20b:106::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Mon, 27 Apr
 2020 08:24:01 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.020; Mon, 27 Apr 2020
 08:24:01 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 07/17] block/io: support int64_t bytes in
 bdrv_co_do_copy_on_readv()
Date: Mon, 27 Apr 2020 11:23:15 +0300
Message-Id: <20200427082325.10414-8-vsementsov@virtuozzo.com>
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
 15.20.2937.13 via Frontend Transport; Mon, 27 Apr 2020 08:24:00 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b30d11eb-70d6-4fd5-f566-08d7ea845703
X-MS-TrafficTypeDiagnostic: AM7PR08MB5463:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5463562E11217FC66F67DC86C1AF0@AM7PR08MB5463.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:125;
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
X-Microsoft-Antispam-Message-Info: 69iTiq0Gau3QSD4jSkvE0P5L/mM02dSMJT3NvcHITyiOqb/ybxotCtU3I7dXLfre1zPJfdIorO3eLDW5Dbhs0esYSw3J4LTI/RqgWIkR6upvokvKUm2V8bTcp/ogQUZskuH1mjgE0pzpXVMCszDhGcIUxOwrFQvHNUdftxIgrzPPKPQqg2tsSwlb/O37oD/F19+/6/4ukvsbExubf6OBJdjWYsIn/opWXpUb7ca0ny/6DOrPbgU/l5dKplwsVNEvKm7i41gyLn9LXRpqTpDgJCRQ6KUt5DyZtv0br/RrQBURGPttzC8sxnH9W7+8FdcsrkkfrBMvulvmPmy8B4aFrilDvR1l3lgBLL3WaNtDzBWuY8qZqF1o/1L9orOAdpN+y0ZbvjAfWVlR2roHEqH5kYtSPqZyJakJj9/YhuYeCkFB/o1WQeYl0Ogf9GuA9f3UDfG+1+k211013munbGoTD4MgPR+CqNwEk+45vhAXqyeJY54td2U9kCjphu32B/xu
X-MS-Exchange-AntiSpam-MessageData: WCcfszviwXw/E9fPMieUiXamO7Zu6GVbiQwu/lFLG60DLozatk9LKJXYDLC+YEqHF9Swp6bQ732BEeqFmo1mupbWcTPnl1Xqc2wVWPAOsQ0+7zlfhs/wlnMFc+6rcfjK1avuUdwJEB8BJ3ua31PQG7F2zoz+6tg34p05pgwmhUPYMFlu8GsKYnP7UO84vsMsppH2oeKpoeljXBpz5KfE2LBZcVulGWtJSJONRePOwFkWXP0dA177n8TOIZMaXXYtjeTj/EOioRNITeXL0YRwqeAZ/c18IHF/UkTfdW9yhv0X+QwcDA8Y3SuPWbw3J3MPQWIwDOFqsLvoQhSu9xVNxBLqrNN1R0howId+gpKLk5aVjIAtAnVkZG8nNElOJ1DbMtVyklvRkdUf6h3fVKwedyVeC4Nnp9eieNRsGOtgcnoQV+SadL8fPEidQk0Ni5w39ibJrnabIEuC8P1k7a9zfD+ZKECZOKp+3+7loEDfk8Y21wjGnPFamr07Pe//+lvpRpQOAXPBDrqFLI75ctYfup8mB3EeUfrHXhZBNSddnzw44utuwpJI4wT9VL7HpcVLYRrnLqixLQ2b4Hju6WHivfZfn2/WEsBlWCZkZ4Wj1FXYssAjSnitkQF6DSqPa7GwaP4zVN8AtVwPVn6Rt7MQtr2pYuAnI/WGWJzzGS0zs0DNwK+FzHeSlQ50YCty8uh76SpXa/w9fY2o+quL6FySH6PzmerLnIDGGAaIqRtB+tnJW7y/oDF3TZ7UMaxQmCFeZMoIoUnPd2Jh6zMWSzG8smNl0svG8Vb9K/GRWrMyOrU=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b30d11eb-70d6-4fd5-f566-08d7ea845703
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 08:24:01.4556 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4VwBWAPuXAnq+n9kYpaZ0slOGWOiaNR1eyjJtInwa99KJN1lgI+C9+4qAsYPHVPSFY7ImrtEhYLvwwa2Bj9enmo92lnPnYEGHc1WGiyuq60=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5463
Received-SPF: pass client-ip=40.107.7.127;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 04:24:00
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.7.127
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
on all io paths. Prepare bdrv_co_do_copy_on_readv() now.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/io.c         | 6 +++---
 block/trace-events | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/io.c b/block/io.c
index fe19e09034..ee38c9afb4 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1268,7 +1268,7 @@ bdrv_driver_pwritev_compressed(BlockDriverState *bs, int64_t offset,
 }
 
 static int coroutine_fn bdrv_co_do_copy_on_readv(BdrvChild *child,
-        int64_t offset, unsigned int bytes, QEMUIOVector *qiov,
+        int64_t offset, int64_t bytes, QEMUIOVector *qiov,
         size_t qiov_offset, int flags)
 {
     BlockDriverState *bs = child->bs;
@@ -1283,11 +1283,11 @@ static int coroutine_fn bdrv_co_do_copy_on_readv(BdrvChild *child,
     BlockDriver *drv = bs->drv;
     int64_t cluster_offset;
     int64_t cluster_bytes;
-    size_t skip_bytes;
+    int64_t skip_bytes;
     int ret;
     int max_transfer = MIN_NON_ZERO(bs->bl.max_transfer,
                                     BDRV_REQUEST_MAX_BYTES);
-    unsigned int progress = 0;
+    int64_t progress = 0;
     bool skip_write;
 
     if (!drv) {
diff --git a/block/trace-events b/block/trace-events
index 29dff8881c..179b47bf63 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -14,7 +14,7 @@ blk_root_detach(void *child, void *blk, void *bs) "child %p blk %p bs %p"
 bdrv_co_preadv(void *bs, int64_t offset, int64_t nbytes, unsigned int flags) "bs %p offset %"PRId64" nbytes %"PRId64" flags 0x%x"
 bdrv_co_pwritev(void *bs, int64_t offset, int64_t nbytes, unsigned int flags) "bs %p offset %"PRId64" nbytes %"PRId64" flags 0x%x"
 bdrv_co_pwrite_zeroes(void *bs, int64_t offset, int count, int flags) "bs %p offset %"PRId64" count %d flags 0x%x"
-bdrv_co_do_copy_on_readv(void *bs, int64_t offset, unsigned int bytes, int64_t cluster_offset, int64_t cluster_bytes) "bs %p offset %"PRId64" bytes %u cluster_offset %"PRId64" cluster_bytes %"PRId64
+bdrv_co_do_copy_on_readv(void *bs, int64_t offset, int64_t bytes, int64_t cluster_offset, int64_t cluster_bytes) "bs %p offset %" PRId64 " bytes %" PRId64 " cluster_offset %" PRId64 " cluster_bytes %" PRId64
 bdrv_co_copy_range_from(void *src, uint64_t src_offset, void *dst, uint64_t dst_offset, uint64_t bytes, int read_flags, int write_flags) "src %p offset %"PRIu64" dst %p offset %"PRIu64" bytes %"PRIu64" rw flags 0x%x 0x%x"
 bdrv_co_copy_range_to(void *src, uint64_t src_offset, void *dst, uint64_t dst_offset, uint64_t bytes, int read_flags, int write_flags) "src %p offset %"PRIu64" dst %p offset %"PRIu64" bytes %"PRIu64" rw flags 0x%x 0x%x"
 
-- 
2.21.0


