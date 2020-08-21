Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCDE8C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 14:17:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A756D204FD
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 14:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="VnGsTS5t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A756D204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k97r2-0007va-VO
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 10:17:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k97lg-00053V-4r; Fri, 21 Aug 2020 10:11:44 -0400
Received: from mail-eopbgr10117.outbound.protection.outlook.com
 ([40.107.1.117]:9536 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k97ld-00054o-To; Fri, 21 Aug 2020 10:11:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RsK7xZeCAoJ77EyRItYhEQQGzEaHUIApDQefMZAAgT4H/iOk4AiFTYeVCJdzqeUnc5+0lw/SVs7SahUou5bIsgf/FaQLo2Y6yLnUddph+pfaPViUjXyPDq+iWWGHdm+Y+d3AhPAbCKG/fRRtKHN3sx9cErCiKJfKH+5+VukVYE3Z9f20p9wIoo0IAJD2B/16rv+PotS48H9nODBNEi7w5sHwullOioaYds7+3P8G5hpBbJtheI2P3ER5UPA8Od3zAVeigA4Z2ssVNhkEYIgQtmrRR9kWDL+5azl20rzDZLn/7juCfjptHaHrFwp+q33807e1PO0eXXK0/7UPhVKGaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0386wauxXmSK63FI+OC2yIics9gF/T4FfYX7cSlvOt0=;
 b=j/nIbCv1eJyLKzp5r0jIiggNgVMctUPSS3fV17YrzYDa9p7CrieL3onYU2YVWJ7cP8cxxST7I6nZxHhFT4tD73mch62syF3mBILHtZhjlofurmUkm/EqofOeEGmQraRnM5AxZFr8yw8ROVLQFSJYy3UqHc6duzeT0v51E1LctPPFuNQQiB6u6IybnnLxNEoKd005VHZqx4MzRTsIy/VpiuYAuQBHODH/1uwP7NyOXyIEA27BrQBLKQqgzy45WR1P6R87pWyprV6c4QuRF4dPeUFQStkTahKBFAi1DkNkjq14dSXR4IbmQ29SEjL4t/9cx+lWGi3FeNQWN/xrlso9gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0386wauxXmSK63FI+OC2yIics9gF/T4FfYX7cSlvOt0=;
 b=VnGsTS5tlaowzaLl4vmyle6IebGXZvsoYK1Mh+kz9m/RyKBMEKVpwjTjnb1YGR9Wgn6aM3pVvMX7f+inG9HpvfJyKQg22pZXpNMiEM6ai6SVBHF+GadhoPI32H94AIlJ+OYnCJQnpq2xcCkFnJxFWqbR7M466MRaqbXa1XbIluY=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5495.eurprd08.prod.outlook.com (2603:10a6:20b:104::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Fri, 21 Aug
 2020 14:11:39 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.027; Fri, 21 Aug 2020
 14:11:39 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v5 02/10] block/io.c: drop assertion on double waiting for
 request serialisation
Date: Fri, 21 Aug 2020 17:11:15 +0300
Message-Id: <20200821141123.28538-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200821141123.28538-1-vsementsov@virtuozzo.com>
References: <20200821141123.28538-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR05CA0139.eurprd05.prod.outlook.com
 (2603:10a6:207:3::17) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.171) by
 AM3PR05CA0139.eurprd05.prod.outlook.com (2603:10a6:207:3::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.25 via Frontend Transport; Fri, 21 Aug 2020 14:11:37 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7954dc6-31bf-4dd3-db32-08d845dc1ee1
X-MS-TrafficTypeDiagnostic: AM7PR08MB5495:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5495974F5D1EB1EA6875380EC15B0@AM7PR08MB5495.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ip/ukdEbWv6vCwhDxP0VRLbnAhgS6cZbHr0nvWylMRCTG3fa/EQGHa7w9Qj04G3X3ebhGq8A2N59srlDx8J0KBc2vMZtOr1BqVI0v9hIjFq4lz69cOwSfo4LD/uu6eu2kCCHwvORDbC0oj6VPdG2ehTRXot+Qkp1jpDNfn3SpgdeDRlNUGM9NtPy9zXZ0RCFF/G8FgnykumFS5Jv6qhU9cRJC07CuIz2gAkCYkvuYnv9sREzwkOc4heL3mTkw34wFjeEZFH/Cu3KgHVpvHoURxIZVpeXhZbzsHbPhOkoq55M247M3+tFtuQhPFgv87n3tpvXB/u1j+RbTvlR4wk1qA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39840400004)(136003)(346002)(376002)(366004)(6666004)(66946007)(8936002)(66556008)(186003)(6512007)(16526019)(1076003)(6506007)(86362001)(2906002)(956004)(2616005)(6486002)(7416002)(52116002)(8676002)(66476007)(316002)(5660300002)(26005)(83380400001)(6916009)(478600001)(4326008)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: nEjllAGbwzjqKvCd0bycWF6ca6sAkWMlDRCR8xzK56Zf6zrrXxIWy2/8vXDeCkcYYFwGVh405o4GaeWeBUHUqr6a2OsmUMmrn8ilTJFiqqouK+Yt+u3DkQzQqmTpcK62gPoQmx0Z3joZ+9+iZ5uz4IxlB8V0dvW5REk+Me45/aPkDSLxCZUSJ8EZc8dsIu5AVxK3zIzFpMv4WRZF0RegK5unbrvEk6hsF9gstqC1m2RZG98IkKyGfaDnabN/NE1caq+3L2sRb7A7LBUnOB9+0X2SvUSkgeGW1QCO6y0GcSIYSWpGJydtYCI7Cg+BCvBmMQziPJzOuIAvQ6qmQEVVkOjNOIRSgcJizQ+5LfxO8qlpUxNrIooZVPyumg01oB6BSLaIg+9lIaUuNKU4F7gB51qc7EA1cMXU54EsQmjvlr3Fs+Rf3rcndPLmR1bXGYZYNOxomdo9fiTq+eyVZ+YTCCEPDzQ/Tq9rdvmyYefCFLvwGT9W8NqJ3UWQDuY1CMMrRaYhs2VEmvua0M7hGaDARkt269ZEe1pLv8faq/N83JOKatAX30pouHbrbprrRbitWQsOPYpO9AvdG42LCLDbUctMZ0pylzQMJllGxuG+vVk+F2babLst3/6nUZ0mZA53nYDZvfK0B1mUZjrPzS4wGQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7954dc6-31bf-4dd3-db32-08d845dc1ee1
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2020 14:11:39.1023 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HBfDwJwc5Qvwerhok7A6rDwsMZ6VRbZEeWBmBTaD6Ew7JjtGoFD47hK42LDgaOKxNfmsX7ccFpd5HqZiUU/gjDuQbFRLDxAze51TBJgXguM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5495
Received-SPF: pass client-ip=40.107.1.117;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 10:11:39
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 armbru@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 nsoffer@redhat.com, stefanha@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The comments states, that on misaligned request we should have already
been waiting. But for bdrv_padding_rmw_read, we called
bdrv_mark_request_serialising with align = request_alignment, and now
we serialise with align = cluster_size. So we may have to wait again
with larger alignment.

Note, that the only user of BDRV_REQ_SERIALISING is backup which issues
cluster-aligned requests, so seems the assertion should not fire for
now. But it's wrong anyway.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/io.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/block/io.c b/block/io.c
index ad3a51ed53..b18680a842 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1881,7 +1881,6 @@ bdrv_co_write_req_prepare(BdrvChild *child, int64_t offset, uint64_t bytes,
                           BdrvTrackedRequest *req, int flags)
 {
     BlockDriverState *bs = child->bs;
-    bool waited;
     int64_t end_sector = DIV_ROUND_UP(offset + bytes, BDRV_SECTOR_SIZE);
 
     if (bs->read_only) {
@@ -1893,15 +1892,7 @@ bdrv_co_write_req_prepare(BdrvChild *child, int64_t offset, uint64_t bytes,
     assert(!(flags & ~BDRV_REQ_MASK));
 
     if (flags & BDRV_REQ_SERIALISING) {
-        waited = bdrv_mark_request_serialising(req, bdrv_get_cluster_size(bs));
-        /*
-         * For a misaligned request we should have already waited earlier,
-         * because we come after bdrv_padding_rmw_read which must be called
-         * with the request already marked as serialising.
-         */
-        assert(!waited ||
-               (req->offset == req->overlap_offset &&
-                req->bytes == req->overlap_bytes));
+        bdrv_mark_request_serialising(req, bdrv_get_cluster_size(bs));
     } else {
         bdrv_wait_serialising_requests(req);
     }
-- 
2.21.3


