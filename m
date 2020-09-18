Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A17C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 18:23:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36C4620DD4
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 18:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Be1xUyQc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36C4620DD4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJL2W-0000jw-1q
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 14:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kJKzY-0007GB-Jb; Fri, 18 Sep 2020 14:20:18 -0400
Received: from mail-eopbgr40122.outbound.protection.outlook.com
 ([40.107.4.122]:8096 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kJKzW-0004bq-HU; Fri, 18 Sep 2020 14:20:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vf7eK4VGLIZvHhavYHm8lBcjTENn8unfeVQklC848xUAoIYJ9C9WtaLYOYHVeDFvL+0DyvRi+ouqJQkifCU/dotgXlXsHP5gTvTty1tczocCE6E+fjFXSLOonDE7sxgYNPr4QEuXJ+mdxG2tKCv7pFYAS+HaSkJQdgOAqfs9javZDttzokmfGzG7tE4fKIRAMEr+AHSaiKBmGJJ4+HVDhgTsYeJFEKe7nILuW69D6Repd0WQzNzCP1vZbjfWjwrV3rH+TIOAqY5f3bEbujtQEO2xX2USParQ7TsaZ8TV5EB2+Sie38ANsuCObV0VCYvkdXQ4HbaWb3pLXhqHiJJOQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y8NLhSWjzvLoAdEPcy6v+2cO7JLMwXB4I3aVRrNXRwo=;
 b=WDX2qLrcnEv27/S4+GZMJWAhyetL6OnIbUaVObaaz/B5AUnYD3huTO95YAF3I9D6lAt5iSP9zDeaBABSwJ0qiP/XV0oh7QvQKutBR5lgOuF/ENUeo8yTKaVHxdS/HQVq/2IpPTefwdDN0O0qn5woSSvR1RNXrXTCxikD1yeaOZHOz2ocw88bwEnrmx0aU+KgF6sV2UCa1WJ2bSH6/jwcazchbeWO5+0Hhq+JpyBzy5lpQmLWNrhYgHJYxBzAUsg3qJGQYCW8VO6BdxAS3j1+uMTij0OUCiPrPSYi7qdqmgciUS+xAbt27u53OQTJNdM7+chrNBnxtb00A2TnAyC1ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y8NLhSWjzvLoAdEPcy6v+2cO7JLMwXB4I3aVRrNXRwo=;
 b=Be1xUyQcK5+dV7j+jQqvbGUxVBM//r+YNi3O16mzE+o+giakPoenJrz7y2hOjDyfHt8rXfbYb0JBkuRzh/csUWVdmJ5zybiKME0bbnLg6P5zRDMjBN09JPlHXKRv7VJ7MqD33/kn3q7De5Xb1BZkcvsX3Ise3wChDdw+TU5QaoQ=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1905.eurprd08.prod.outlook.com (2603:10a6:203:43::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Fri, 18 Sep
 2020 18:20:06 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.019; Fri, 18 Sep 2020
 18:20:06 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com, armbru@redhat.com,
 eblake@redhat.com, fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com,
 kwolf@redhat.com, den@openvz.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v6 02/15] block/io.c: drop assertion on double waiting for
 request serialisation
Date: Fri, 18 Sep 2020 21:19:38 +0300
Message-Id: <20200918181951.21752-3-vsementsov@virtuozzo.com>
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
 15.20.3391.13 via Frontend Transport; Fri, 18 Sep 2020 18:20:05 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.106]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08a4f461-8c4f-4624-c055-08d85bff77dc
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1905:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1905F8BDCE99C425F4F30CE9C13F0@AM5PR0801MB1905.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7ko5mMpqLjU+a1NX6W3AB5tEPfl+L25Zqox7l9C8yLdf2iyUohgPLy3jcr5WebfKI8NW2iQs+FBML2ztKVotTUfA91evyKhMayTAY9j15XMQey7E3Iw9lA5rFBhU68NXH0EJHTtERixaf7jqc14DFJP103JgfhSbbE9mcaWTX1rdB53nE8jYVMNsfjGP8ABIiJbbUaLu13F04sTS8G8awP5pRoxSFsFflmBA3ou+YlqikiMzHCSiOOS/kPkuvx9JccdTqtpx4eJzEvGu4tzIiiFZiXD3Qj9HN3FCKKeRUfc6FR33NIDj9ITGYfxI3PfxXybzN2GQ8sC2kVpuW1KPQJ6PMWBvz0pL5D6WMU7rB9M++FCCTeKWk14fNu5mnZYL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39830400003)(396003)(376002)(366004)(136003)(346002)(66556008)(8936002)(66946007)(66476007)(6506007)(2616005)(5660300002)(2906002)(83380400001)(6486002)(956004)(6666004)(1076003)(186003)(8676002)(52116002)(4326008)(316002)(86362001)(6916009)(478600001)(26005)(36756003)(16526019)(6512007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 8I6SmDWuJqvmFVt/Gir82h37fzwUPpDyvGoFMzc+5As9I6j+q2wa0iOtXyLUwWRpHfCll5Tr607jq1Y9DCeTE/hNU8M71z9O8mKavK3eSM9BKkfIcbWHQfpZjz9WPnE52Ti9Hzwje72AWTuoBZsO6fl9lYwdMHbf/l/H0fYJT4bZC7Rlk0Iwqd4yOJJQhNbw8RIzia+0/tR/zyPLWTj68FZGIjWn1/3lKH5dMDgod1RXrY1kiu8P9rrUmtIXlRzDQCE3jiCRp9Lrfiif3UcWYFoTVD0IlJj3dnbJB9/DsJKP4TfqgoqPKqj5FggouBvtgWTR0AxZM14wIbHq46vrLg+DIhbiA98G9lN0EwhjcorrD9Jyl1BnslVfGHTMRqwoan7t+fPGRX2+kSaNsGpEL0GPacXu3TSG+3bMiS5oCDXA8m9rmvMT5g+ScwxktqsSwSNkVSuxLmv8dwZffpVFutdYfB+HlOYSC/8fKaYKYC2tTX43UzcDkrjYw5ZHe1btRKtnLpGjgrrn8MmxEBxIl6FK0Tnn7e4IA9ym3TrtXZaDxiel9BTxhCo8aS9M5leT7XNnRpHxRfqbayN4qv/7RciZDaT16TSOd+DmRavAy4Gw5RKED3WHSCwc6ljjrYd8cEu/oP37GrdQ2tLUzJE8Ag==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08a4f461-8c4f-4624-c055-08d85bff77dc
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2020 18:20:06.1158 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /f/O6B0MmHEtkUYYfx2B023MmuJ+MXb4rEN2QRkIe6AQssy41tWYHYLPyYUzPhfVyHjNF2UySXQ5qKk2pv1R2CsXnEDorxEAkNIt7f5vGbA=
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
index a2389bb38c..67617bb9b2 100644
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


