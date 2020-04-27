Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C86C54FCB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 14:49:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E901E206CD
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 14:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="S7XbetRU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E901E206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT54S-0007ZA-2l
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 10:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56902)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jT4v9-0008HO-1O
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 10:39:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jT4v8-0007ml-7O
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 10:39:42 -0400
Received: from mail-am6eur05on2133.outbound.protection.outlook.com
 ([40.107.22.133]:24288 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jT4v4-0007iF-Da; Mon, 27 Apr 2020 10:39:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CYvxb3xT8AbUoMmigwZ4YXcUdJJgWLnpqNu0A7EqP/IEKlLOaz1m7kFfKl5FGTQhhpT+sPu4kKXZYwfZNSbk51b1M6AzzkzKpNB9sKSXTecNBHj4F0LXo1JQE4vRA5F79eR5KwoFrvKZasb++J0VpLvFrDtvQGyPDFi/Rr3xw8dmiENQBSAgbUnXctkP6ImbTtUMrXCBoM7LvWQFW25Jq1ZJ/T1yyNLKOMZ1zfn7lcroyoMu0fAlW19KuGUVQ0T/+lZ900Au207qJR0y5T5jsjMbDZgk436QBz8OcEdUsCKWwIjUVPaBpnU3UicUbskrSRFCik5g5EBWzZs3qtU9BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/KHxXjLZZosLyhmJd8gaGFYJpbqdCga15U3mqAzN+o=;
 b=Vvu/Gs01zER1/uli+ongeCTLXTeTJsstA3oVH2cUqiVqkv4dE5Vjc5Pu/01k1xSbefvLTTX6daEmcjEK2TdUSYZ3PKp2zZLjXyNmrqWZ1hPdLEYJDdLH75O1nqJJRWBiyh1ebkx4qJiPUVMvDAEZ/adF++DDFQJkse6Wnwz5LZtwaFKy1W/mpesRC3HTM9o7yDt7nncx99sunhJUQz/WZiaf+2yndJSdxF95VOlGpXhtOMJ0fcWgag5VjiabwduLn1k0clIAijk3KP94gHR2HzhcjavU45vqhf0zttgS5lkPPaX8E4ZhhnAhpTeoqXiw7VvoMhm2sExolSRfr75RQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/KHxXjLZZosLyhmJd8gaGFYJpbqdCga15U3mqAzN+o=;
 b=S7XbetRUj3YLAklZk6toOH1HeWDbvoVF9xtxDCLg7v+Dp3pcpvLJHfTbIFKVk0QZvddI2hLJhySL7LNKsOFhwCrYZZ/bPbhjbFJklIOy0/U6FR86A+y70ilPbh5JDmrjzSciUSSLnUEkd3E4zZJ8/vRoSnbq6te6JigIPqpiJDg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5527.eurprd08.prod.outlook.com (2603:10a6:20b:de::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Mon, 27 Apr
 2020 14:39:36 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.020; Mon, 27 Apr 2020
 14:39:36 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 7/9] block/io: add bdrv_do_pwrite_zeroes
Date: Mon, 27 Apr 2020 17:39:05 +0300
Message-Id: <20200427143907.5710-8-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200427143907.5710-1-vsementsov@virtuozzo.com>
References: <20200427143907.5710-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0010.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::20)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.182) by
 FRYP281CA0010.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Mon, 27 Apr 2020 14:39:35 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7eb6aeec-3804-4a4e-8719-08d7eab8ceb3
X-MS-TrafficTypeDiagnostic: AM7PR08MB5527:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB55279FD1DBFDA05B5F8E900FC1AF0@AM7PR08MB5527.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(376002)(396003)(366004)(136003)(346002)(5660300002)(107886003)(316002)(2906002)(6512007)(478600001)(6486002)(66946007)(66476007)(66556008)(69590400007)(1076003)(2616005)(956004)(81156014)(16526019)(86362001)(6506007)(52116002)(186003)(36756003)(8676002)(8936002)(6666004)(26005)(6916009)(4326008);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u8FZb1i8zi50jL9zXrxZP4bUsmruYJSewcNOtLVDKVPbBa9WeYqs24kk4PGlazbwr1pxu9xvaRN49SOyrUMm/MMYA+ApBkHW48glbx8szulFp3iKMwvpU8lLB+4KPy//5pCj16JTy70tp6dR3RVEeUBHbmsUfWWRcIm7Q6UAu2RU/mQJ6pB3fWcv3hRF1yVZscLoiyVUcg53kBhlQ+dslaBR8xkqYNHyztif6hyDsSwE99UgnlypAAszaZLGRG/lpffuMw6hHtHltmVEAoHpDlmYDXRJxV11t5Vhl+M5h2eLq5pkWlcxMILHgkH48ayrdxKOazWmdeiC7ircfYkOEBGvGKikCgd0m2WVAiYZxZSKeYOF8fnXlv9qhO5H4z0VxjsbFxkJd2Pvc81+db4v6k3sy6Z3AKbyG5wLfKldI4BA1UNxoXpp7e1BvSJN/hqFZWb6kMo5DGl6z19w4sJTM/UsKMT0ocbP/uHSd8nuCtNE7LCcmkVszVwNWpkJAPm9
X-MS-Exchange-AntiSpam-MessageData: Os+RFQWs6a6HWHyucP5wmfxKpPhlMjtCaXdQac6g0PC4GBb178RlzsHbDQXTCHdKyL7PvZNLYeG/MNAl4FUnYsoCAFvmJCdhDMbEsTidw6PHKqqyENAR4GbYmzZ8SUrlboyAtij6Zv25TN80GavH18cxlUW3dZuKu/3A9mk2h84oh7IwC2wZukKPD/H/iJ7nUKotL5SZILhtVX9RSbzP4sqAxNLCl9oa1i2gxPNOJM+CQB8w7zm4ZaMjinMbsN1KLHxHjqhKXcG+wWAXqIi+myzC2HFsxBeLyC3+GJxDqshspLjq+SXkxzkrkBVHlWk5O/+jRtOrwFginTQj9kULsa02umNbKpbvZ1WIASmbCYFxGiZ+sijCyBr4BdVRIR392tWlKMvX9mrnF55OenXc9Q+FhIQdA/MvjxbhEuk5l7ONMsXhe71PBUeMgbeOOg3JkEC9UYcwuwu3zLXC75VAoLSpg/uhx7+G1j7Z5zeGgl6oZBQ2ImdEOrXPBNkFat+E4o8ox8qMd3gORWCCrLhsyTwQYLzJ9HmTzjrCds+cRVV655NFGJFDddy2j7leTV7P3T0cpMaDe0abA3KRVj9YVpzOjYbcBhJEq/vWsFHbLjbMth1aWM99p3b0NE6/OFD1+NnfS1P8RBRRr9QP24vFtKKQgCdrdsg1c3R/64RxUL23Vn4k6QHmQYeWDHTKk6pMXLQitMxAapNtD0r2Tb/EmmkkbXa2SamHjWNsQcU7oVpMaw2tW0VMJMF5BOPcP2gZIPr2JDKA9MQnBRtJe7+D5dPByXQQhqHlozBOD4SlE+U=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eb6aeec-3804-4a4e-8719-08d7eab8ceb3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 14:39:36.0233 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yr45yQ912mG2mc991l6oMhT9QzIuSMh+oo4EGp0JvAbDtiLyKFkp5eYvXYRNgRzi+7ArNtF5KcL/s7KQYBOWVOx5abdddAnXZIGdFHhXqP8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5527
Received-SPF: pass client-ip=40.107.22.133;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 10:39:31
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.22.133
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
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We'll need a bdrv_co_pwrite_zeroes version without inc/dec in_flight to
be used in further implementation of bdrv_make_zero.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/io.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/block/io.c b/block/io.c
index 1cb6f433e5..e6a8ead46c 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2016,8 +2016,10 @@ int coroutine_fn bdrv_co_pwritev_part(BdrvChild *child,
     return ret;
 }
 
-int coroutine_fn bdrv_co_pwrite_zeroes(BdrvChild *child, int64_t offset,
-                                       int bytes, BdrvRequestFlags flags)
+/* To be called between exactly one pair of bdrv_inc/dec_in_flight() */
+static int coroutine_fn
+bdrv_do_pwrite_zeroes(BdrvChild *child, int64_t offset, int bytes,
+                      BdrvRequestFlags flags)
 {
     trace_bdrv_co_pwrite_zeroes(child->bs, offset, bytes, flags);
 
@@ -2025,8 +2027,21 @@ int coroutine_fn bdrv_co_pwrite_zeroes(BdrvChild *child, int64_t offset,
         flags &= ~BDRV_REQ_MAY_UNMAP;
     }
 
-    return bdrv_co_pwritev(child, offset, bytes, NULL,
-                           BDRV_REQ_ZERO_WRITE | flags);
+    return bdrv_do_pwritev_part(child, offset, bytes, NULL, 0,
+                                BDRV_REQ_ZERO_WRITE | flags);
+}
+
+int coroutine_fn
+bdrv_co_pwrite_zeroes(BdrvChild *child, int64_t offset, int bytes,
+                      BdrvRequestFlags flags)
+{
+    int ret;
+
+    bdrv_inc_in_flight(child->bs);
+    ret = bdrv_do_pwrite_zeroes(child, offset, bytes, flags);
+    bdrv_dec_in_flight(child->bs);
+
+    return ret;
 }
 
 typedef struct RwCo {
-- 
2.21.0


