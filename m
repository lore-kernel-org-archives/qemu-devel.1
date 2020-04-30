Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435ABC8300B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:18:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E0D82070B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="deXbGbif"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E0D82070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU7DM-0004tF-5s
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 07:18:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57716)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU78P-0006tb-W9
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:14:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU76u-0005Eu-Fx
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:13:41 -0400
Received: from mail-eopbgr70099.outbound.protection.outlook.com
 ([40.107.7.99]:12710 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jU75k-0003SE-3N; Thu, 30 Apr 2020 07:10:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jLDaxp/uVMrJhSh5e3DyroqJKEyFVgNVsvIaRwYs50v95u6SoIfwpuH/fQSTcrUtDVy+Ao2pKyYp6wNMzjKO2Nf8grqEOWCWQpdKeFw2oxu2p0NGA2MF5hMAOW4MMLgVyvWAmIK73ff6Vrr4BES9B8BZDTDan8lvpbx3Ap4q1sETwvl6wu1pofntQhnrrCs6XVgvDkWssLdjM8Thh0pE1EmaVDrBWs4cmKPAVw2B5mBp30XRA7PP9i+wGDJJFo0r8oARnlhQwNkUJGxL91h4s1bKt994U7KLW7NUHbzcFKK2gCQ35BEJD29ngo85IKGqmK+PDV+1/omxup+xW2TpCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qp/+IHrL9SLyfDyjEw0pgqE9JJ2GgJtgzNE8110+KHA=;
 b=kYZBiamoEZ4XtDpyFe8PDlpo7d+xNjeoy7H/w5NwPBX59l2l+r6UX0zoR51I/ao1jq8BaMSMkzfh/L0nTd6MvbAf4EEwQI5B7u843Yol9rd/a02SuCDdH043hzJwl/q9pgXxXnEzNlzfIMobSIRq4S4mdy12qSfV1v6KWsH8j8qWBJUh7tW8B8RETB4n3w16j11e2r6YZbY+awa2yJU2TAkPEVo0X5Uqmt6R+UtGZQncJozQ0MRjHJl/QNe3Y+hqsbbPojtRw7onjFpUlckYQ7qMN7ZKFaDcVzPdF+Y2RHXDi928rA3LlmLpjbv3XZ6wuYByRAfLeh+sMtWX7+YtHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qp/+IHrL9SLyfDyjEw0pgqE9JJ2GgJtgzNE8110+KHA=;
 b=deXbGbifIdW5oKnWXZPt3t9IUDQQAD4JIAbtB4srMJn21v6TrIj8A+GYzsTUbyUkc+j/74PEl/PPvi2UYrI+sD+dTYekp+7l5F3Xbf4PMA5rvyRE1x7h7IZlO/tNi2+rVBj17D9v1qpgWEze2K9eQBYf8mK9rKRS7BCVPQbD3ig=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5399.eurprd08.prod.outlook.com (2603:10a6:20b:104::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Thu, 30 Apr
 2020 11:10:52 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.020; Thu, 30 Apr 2020
 11:10:52 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 03/17] block/io: use int64_t bytes parameter in
 bdrv_check_byte_request()
Date: Thu, 30 Apr 2020 14:10:19 +0300
Message-Id: <20200430111033.29980-4-vsementsov@virtuozzo.com>
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
 15.20.2958.19 via Frontend Transport; Thu, 30 Apr 2020 11:10:51 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.138]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 61618f09-7f52-4731-e916-08d7ecf72539
X-MS-TrafficTypeDiagnostic: AM7PR08MB5399:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5399FC6E6210F4515D8C8570C1AA0@AM7PR08MB5399.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0389EDA07F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DTqOAL4V1LZg+8gMp/mq/2nYaVLm4CZBCCMm0aPdyiJ5xxnTjBFGT0o+dZj5EsL/M6nlGQzFHHD9X0AGLFlIdZFgS7dnYBv4Cwh+IKdjBZ0L5YW5vVovXbMUP3vOPH64BVbvoEJ4Hnc9GZx2qH/nLKB6fz/MydsBYPatZZjNSzWIAdSrBUEZS+CM8wAF3zJsG+OK0QDnfEDRRN1id82C8JcE8OBZsyb32Ub7++gSPrCOljdAXnVdvW2ox7wqsiSU7GIf90TQFrQvJF00Rg9tbRAb9EEzeSB6ySrQB74rkGHRq4o2VL+3tW3NU60nY2U1NqB/Tk3F4w3kHY4Nc2HmX+v1P+mylvzx8UyftvXuhrUpv8rI7Shl5NdSnElbDmUJW6fW7fFDzpclqKU9MHaWvB0NNz437o30Ie2VorAg+xQpcgXW1DSY03yKdMQoh0kn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(39840400004)(346002)(136003)(376002)(1076003)(36756003)(478600001)(8936002)(26005)(6512007)(7416002)(5660300002)(107886003)(6486002)(66476007)(66556008)(86362001)(6916009)(6506007)(6666004)(8676002)(316002)(2906002)(186003)(66946007)(16526019)(2616005)(956004)(4326008)(52116002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: NEO79wH/Ic4haz7MxOgTHIqRwC6DknjlVJIP6YABlsaC0v19krHzH6G0rzhtvX7MCJtUuS0ol5//8+2Xt7tpDOGaRpiCac8KwyORPwjPKAGMDYmrvPNKyG2Bj0fQwYrJP3px8rItYqkKWjL0azZHgpf4Hx9x+oyt/AeoUH3Mcrtf4k91ESAi0TnKYgIP1xREEsBDJsgTaksOKH0GTwC1Ec+kH00edkyPAWlxjCA8GlJjhfxGMCOHo07NlOzB6e+Pno/OT3wW4E7P5pwh9xztiYPQBPnHZ6AQQJi0RuhVU2L5EAqtiNiu4Ttr2J6rQ9B7lvdHcJhM11Yuk/31SJRwZbTA6oHmmiTTdIVO8hqZfzMEypeFY0P09peatDBxfSELT1SegRMNZosCeLJ/+Op65XOQs4kCV1sKhsFsccR6WxechLASlKfpnh2NDLygF3egwxw2tKbkuTdUeS0oAqIegDpq1Blg7zRNKja5wjmpyHgInHOhWxNc+EIoDTz76tV6igWoPmqBD7eZKIw8Wx/2vh2xRsrQQXC6JH7e2BdFBD2XaUJiZTAZKxuXzgWyEPUZfZMtrbsfnBZW9LD9TGrXQFMvbulcxCp2d1yisk8a8Ho8NM4c/sVLnAyepeRCNrXbvg1mSuCompbLj3NG1htvjMjuK/6rRJhfB4eQrs+Wlcium7p5NS1URLVEhqIXz1du7FuoUmE0GIHSNtIi92NbCYTWrtuFUF5kQUczuG/VSlA/NYuG3ueyM4moAxrMdDzDugF9mXudRPxU9cKX6ZD+NUWl8az2jQrtYw5U03pwZp0=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61618f09-7f52-4731-e916-08d7ecf72539
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 11:10:52.4233 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WDe7QdQej1ocX5e9O3bpZMWGnQvZeBsh8/W1y670CY8eJWlTBW9HVjADv7iZ/AjExm855HBy+/c+aYfAffCGIkUYcYLn30bwGIBXmquX9EQ=
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

So, convert bdrv_check_byte_request() now.

Patch-correctness audit by Eric Blake:

  This changes an unsigned to signed value on 64-bit machines, and
  additionally widens the parameter on 32-bit machines.  Existing
  callers:

  bdrv_co_preadv_part() with 'unsigned int' - no impact
  bdrv_co_pwritev_part() with 'unsigned int' - no impact
  bdrv_co_copy_range_internal() with 'uint64_t' -
      potentially fixes a latent bug on 32-bit machines. Requires a
      larger audit to see how bdrv_co_copy_range() and friends are
      used:

  block/block-backend.c:blk_co_copy_range() - passes 'int', thus < 2G
  block/block-copy.c:block_copy_do_copy() -
      passes 'int64_t', but only after assert(nbytes < INT_MAX); also
      it has a BLOCK_COPY_MAX_COPY_RANGE set to 16M that factors into
      its calculations on how much to do per iteration

  So it looks like at present we are safe.

Series: 64bit-block-status
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/io.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/io.c b/block/io.c
index 20ebf3c536..7a7d4e578d 100644
--- a/block/io.c
+++ b/block/io.c
@@ -875,9 +875,9 @@ static bool coroutine_fn bdrv_wait_serialising_requests(BdrvTrackedRequest *self
 }
 
 static int bdrv_check_byte_request(BlockDriverState *bs, int64_t offset,
-                                   size_t size)
+                                   int64_t bytes)
 {
-    if (size > BDRV_REQUEST_MAX_BYTES) {
+    if (bytes > BDRV_REQUEST_MAX_BYTES) {
         return -EIO;
     }
 
@@ -885,7 +885,7 @@ static int bdrv_check_byte_request(BlockDriverState *bs, int64_t offset,
         return -ENOMEDIUM;
     }
 
-    if (offset < 0) {
+    if (offset < 0 || bytes < 0) {
         return -EIO;
     }
 
-- 
2.21.0


