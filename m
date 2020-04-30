Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD28BC8300B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:15:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90C992076D
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="suvHPPo4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90C992076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU7AR-0000gq-IG
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 07:15:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57712)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU78P-0006sl-GM
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:14:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU76t-0005Ek-TX
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:13:41 -0400
Received: from mail-eopbgr70099.outbound.protection.outlook.com
 ([40.107.7.99]:12710 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jU75i-0003SE-2D; Thu, 30 Apr 2020 07:10:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fKbOWzS9f6vPRtO+Z3rewI9DHSqS5masQ4EAhDnzux+3acp/+IMofdjdoXFhcEeGMIzWsgrr12z3LZX8uE13F5xISLbq1PNp7UvYHraHp+z+sXFnr6UMCVI5hWjQS9IEQ83o20Exa5mpKo1msK8B85zY4joksKwkag2IcVQXfdcIQ8+9Lufbw7iu0lytKlQyyfkVMd2sB2apCqavjMpKgFe8JPPIwCSqEHQ8Qkqcuru420k9I5+VxwccASgWlUk9USv2CEJObrZlBIBLZFvN9Cvs3EHYnD1OXpn32J2YPii9+craD0tgmoLZU56Q/rfTDThYqNbdlFzytTgaxSGa8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LL3Bz10/NFJ05J9+HBjGU50uN2HqJxcTOa1wXkkplME=;
 b=Mx3rIu3v65WgcUyyXbKFHoBghMfbHPFxZqGndKTBS1IF5qgD1h/gZKpFrrcgLF1ijqAIG8vgYCG/0kSAz8N5k7829LQpBjfy0M5kYtO61gCPZ5OMRA9OlesrAvjkYjXFKGh0npXyWIBVtieouj+CDX1xd+SpmE6bvM9GljbrCvJuv7gPFa/t6z1BLEXgsbXPSE/B+SlCDOT1oeQIKMkcBwXVbI18f15zIgfxloGc4Vh5grB97EzjWN4rxQDYviprZLPSGzlD2b0za17ssgG8fwLagXfD0YmltYQpo9/yhwHLnwLjeo0Jq7/fiu9oxlH026z7hFtOVspDVPSyybWfZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LL3Bz10/NFJ05J9+HBjGU50uN2HqJxcTOa1wXkkplME=;
 b=suvHPPo4capZD7WpA5/xEHXwn8ZOuE2wn7vuk5OJ7LEEe/ASFvvdWWwsEAU3oN0Suu0YCYhJtBi46PAxE+y56I424o+d85JDR1RqLTiFbDCsdVQBOuFzANpjDKY36jYuJ7NW9LBVKkH9BDk3U8pZLxdLXJbpMzfro47MriwW45o=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5399.eurprd08.prod.outlook.com (2603:10a6:20b:104::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Thu, 30 Apr
 2020 11:10:50 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.020; Thu, 30 Apr 2020
 11:10:50 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 02/17] block: use int64_t as bytes type in tracked requests
Date: Thu, 30 Apr 2020 14:10:18 +0300
Message-Id: <20200430111033.29980-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200430111033.29980-1-vsementsov@virtuozzo.com>
References: <20200430111033.29980-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0021.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::31) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.138) by
 AM0P190CA0021.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.19 via Frontend Transport; Thu, 30 Apr 2020 11:10:49 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.138]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 61844c1c-9c52-4ff1-050e-08d7ecf72432
X-MS-TrafficTypeDiagnostic: AM7PR08MB5399:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53999C9F1B73970ADA15564BC1AA0@AM7PR08MB5399.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-Forefront-PRVS: 0389EDA07F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3jOlWzf/KSHmoY2xq9ASMOLQp0URbcg33ms0K0gfxwDTtbCK2e0VAhPJAT9ZdkXjOP47b+CcvgPxAQjxqiPGnOewvpBXGmOHMWMwWOm7fko+7Btrclp21Na/p/KaKSmDWZpA7l5QHS6Zjh5EpvdKnWa72MVLYxrJssNEeVkjBl1LG5dzhkogU37mYyYnz/QqwAPjo59FwjS1fJOXZXvDCFSsKiJ9BIdS450+uxPf+vCNa+5bA48wSEJCtj0dikCiMEtokoUqYTFL12buMwxuyc79lWy5If6lo2cldSSWUUaIfwchXJJ4shUmaHw33HI7a/rIPfn2PEIXdryh0JYlnW3BI+Ou94gEuilZhkX20JtuOy405+o8/1RoznBM6z78CZRwu1KudZ6G6Gq98hf9e460a4YEimuZQbBQ5JsUKFkjuQdhj3PdtzxfyVztyx4i
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(39840400004)(346002)(136003)(376002)(1076003)(36756003)(478600001)(8936002)(26005)(6512007)(7416002)(5660300002)(107886003)(6486002)(66476007)(66556008)(86362001)(6916009)(6506007)(6666004)(8676002)(316002)(2906002)(186003)(66946007)(16526019)(2616005)(956004)(4326008)(52116002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: K+GAmFXeK+CwR7twgATmU5LHty5Efqm9tTys2JmI5RIk205gqM0GyM78bYHKRiuqJKdyWoHT3da/9Jsz3iB4NYjCVzn6dcOQogKDW9ado/onggnWPPG7OzKHfF30Ijzi3rjd6H8uU53q1LWYNUf5FmFwJPUFTtPhaB+hGNOk9k7GIYWkN22Gr4rt4+CGOJG80thMDsoXkkQMTroCY7wif5+rqLYWboEXHQnhEF+YXsPHDekGbTEi+fgixI5Jm6IPueGZUBPhRfsQXwnpI0iluJC5z6tq2i6JWIFAEIbtHJidSbPSYOcTpN2QM+dELavQGQSYKLK1JZM5SgR7xXanlAz8jU89AThYWAFC363mDTJqPSU3rULB7dVm0unkKhIKUCua5r+4xB6D2N2bKLxf/QkpKCm9O0An0JnjA17XnOnjwlTQ/N6yBQ2bC1J2MelRB1WjZdYjlWafCoQ7rB90EytemZXH3jqqx3GDtYfenOX3xrd+Af6TCPRmbGcM7ZDBPIsFQjEfqIrW99Dg626rHvwgwXcOs1S1/rZi1/6LkFiyTHKpPm1oBTk5s4RKwQ1kBiaGXaOLPjpbfWnyQUz2LjbtCUdsrsJiMNR+wqSfIe94Sf8uG2H8c+yXo1/c4NV9sWjSQykRQ+zjX33BtsPpyGWl8HmpZAsKpfhSilcQMkQhq5FbkZgy17utZ8S74TsEAGOcEGW2eiQZrXjSBcCKQMFiLC/xCiP/v7v2dfqLW0jP3KtaMDxkMU/T+Rf+v2MJpIpdnB50a6JrIAP00WhSIEukihf8+b4P3AiHgk1RMQo=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61844c1c-9c52-4ff1-050e-08d7ecf72432
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 11:10:50.6262 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QCnOTIvzQ5gaQxHWje2SanYqBfmm5O1UE3KWa+ue0X4z96hmKV6yLIdzzOEajtb9xA1/I5KjqlbT9tG4LdUs9TO9PEW4XLVmD8hhxd1drgQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5399
Received-SPF: pass client-ip=40.107.7.99;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 07:10:48
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
 sw@weilnetz.de, pl@kamp.de, ronniesahlberg@gmail.com, mreitz@redhat.com,
 den@openvz.org, sheepdog@lists.wpkg.org, vsementsov@virtuozzo.com,
 stefanha@redhat.com, namei.unix@gmail.com, pbonzini@redhat.com,
 jsnow@redhat.com, ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are generally moving to int64_t for both offset and bytes parameters
on all io paths.

Main motivation is realization of 64-bit write_zeroes operation for
fast zeroing large disk chunks, up to the whole disk.

We chose signed type, to be consistent with off_t (which is signed) and
with possibility for signed return type (where negative value means
error).

So, convert tracked requests now.

Series: 64bit-block-status
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/block/block_int.h |  4 ++--
 block/io.c                | 11 ++++++-----
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 4c3587ea19..c8daba608b 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -70,12 +70,12 @@ enum BdrvTrackedRequestType {
 typedef struct BdrvTrackedRequest {
     BlockDriverState *bs;
     int64_t offset;
-    uint64_t bytes;
+    int64_t bytes;
     enum BdrvTrackedRequestType type;
 
     bool serialising;
     int64_t overlap_offset;
-    uint64_t overlap_bytes;
+    int64_t overlap_bytes;
 
     QLIST_ENTRY(BdrvTrackedRequest) list;
     Coroutine *co; /* owner, used for deadlock detection */
diff --git a/block/io.c b/block/io.c
index cd5374e6c7..20ebf3c536 100644
--- a/block/io.c
+++ b/block/io.c
@@ -692,10 +692,11 @@ static void tracked_request_end(BdrvTrackedRequest *req)
 static void tracked_request_begin(BdrvTrackedRequest *req,
                                   BlockDriverState *bs,
                                   int64_t offset,
-                                  uint64_t bytes,
+                                  int64_t bytes,
                                   enum BdrvTrackedRequestType type)
 {
-    assert(bytes <= INT64_MAX && offset <= INT64_MAX - bytes);
+    assert(offset >= 0 && bytes >= 0 &&
+           bytes <= INT64_MAX && offset <= INT64_MAX - bytes);
 
     *req = (BdrvTrackedRequest){
         .bs = bs,
@@ -716,7 +717,7 @@ static void tracked_request_begin(BdrvTrackedRequest *req,
 }
 
 static bool tracked_request_overlaps(BdrvTrackedRequest *req,
-                                     int64_t offset, uint64_t bytes)
+                                     int64_t offset, int64_t bytes)
 {
     /*        aaaa   bbbb */
     if (offset >= req->overlap_offset + req->overlap_bytes) {
@@ -773,8 +774,8 @@ bool bdrv_mark_request_serialising(BdrvTrackedRequest *req, uint64_t align)
 {
     BlockDriverState *bs = req->bs;
     int64_t overlap_offset = req->offset & ~(align - 1);
-    uint64_t overlap_bytes = ROUND_UP(req->offset + req->bytes, align)
-                               - overlap_offset;
+    int64_t overlap_bytes =
+        ROUND_UP(req->offset + req->bytes, align) - overlap_offset;
     bool waited;
 
     qemu_co_mutex_lock(&bs->reqs_lock);
-- 
2.21.0


