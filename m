Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAACAC43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 18:24:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2592220DD4
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 18:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="VNbk10Bu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2592220DD4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJL3K-0001XY-3K
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 14:24:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kJL05-0007Pl-OP; Fri, 18 Sep 2020 14:20:49 -0400
Received: from mail-eopbgr40094.outbound.protection.outlook.com
 ([40.107.4.94]:32391 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kJKzx-0004dZ-3P; Fri, 18 Sep 2020 14:20:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R/zVnyG6KsW9i+HoAYJUJbuzT6hikN2xQN6UM78vhHxHyOTp5vj8SH+XZhnU1KRBw6R/kmZ6Yzg81a7mhKn1VqrsbT/jpBTAA+FjycX3K0+EMWvtkp90XyQxvgr4lo4mO8Y+i0DvPp7rS1AiUOL3PNErr7VSZabdh84KQ1+2bRBWqtLUbTKYaZ0utdCKq9ZOj9BlwVhFFBEl0vog4CIXTZgv7JKuriHqA8McoPTHkMkMbdL4Tovougw+ioLIwd8tV6+PVeDZNqPAS/uHkG6v8puQcD01QyKQWjWkjBawzRog/lvFmru5eBcHHFZLsCCA3uo6DRCoeehxbaJwjTopCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQer89qlnroTIjR20IfVIS919Z4+wTqk+d3jeX+WZXY=;
 b=WkFMtxVvHga5SCgln4erTgmNM2lOcb+ujuXQPWRNJsahzbd3aE1KNiriW38U85Qif8Y1Ys4kZruaI8X2Lw0qzB9xc44X6IebfjULiIKuyfaYPvvQJuNXxntO750jmK2RstptVcjCG5ahiIbv+hEkySzVmLCutfdaaHl5R1FXlBUFWHJ+Ibp12q9Sbbkxv4Qg2B4aGF8l1D5Jqa0ILnPbqMMk9bA28oBUNcEwWPi+76fFFYNa5NTZCunss4sZRlpyhgL4OtsDsY7xrmfGQxTpQTlwsgdV5+R9Hbgn3PiqNgte3YLt0GoPF0oa0aQmLmv9AvDPrATQFHSSPYkMCr5DEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQer89qlnroTIjR20IfVIS919Z4+wTqk+d3jeX+WZXY=;
 b=VNbk10Buogj5qAG/6mTlCNNgh8WKuARqQAwPWtsOdzBV/HTkZcQEycH2KZR1tQymeDm9zV83Ksv8uOZsmDLXtDgbuNaXw/v4LTkquEtCndbrJ/OWMF80lZCApvIo+Cp7GLbSWcwrWpwJXAqHkPAby9DsvE+usV28TYRsCNWDAkA=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1905.eurprd08.prod.outlook.com (2603:10a6:203:43::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Fri, 18 Sep
 2020 18:20:10 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.019; Fri, 18 Sep 2020
 18:20:10 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com, armbru@redhat.com,
 eblake@redhat.com, fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com,
 kwolf@redhat.com, den@openvz.org
Subject: [PATCH v6 06/15] block: introduce BDRV_REQ_NO_WAIT flag
Date: Fri, 18 Sep 2020 21:19:42 +0300
Message-Id: <20200918181951.21752-7-vsementsov@virtuozzo.com>
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
 15.20.3391.13 via Frontend Transport; Fri, 18 Sep 2020 18:20:09 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.106]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d30fd5a1-c6cb-435b-eed0-08d85bff7ab2
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1905:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB190520C113E5E44236352EB1C13F0@AM5PR0801MB1905.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:669;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S5NiX4Pi78pFkoXJPZQBWh9VLzrjLaYbd1JEcZU04fQRdLLNSljWkZrKc+r4sMsw01MWha218yXNAfDZciWkp70pI8fztR1JS2+4Ps2U7vVHsDNGMX9S7vyMxTV+7j6wA5GZaC5oSCyowG0Pw2GJQ9p7dZlLtzbliPG+lNke33l5Ggly1AwjhtPuPLVbkuugld41oeMlqp5u11kYHhdk8Rf++qGDjSjrGUM1WwvUSiKS6EAqAbAcEyHtABY+rSrBpWu5jsm474FgTAHxgcgkuX9hGcZQP2S+NvB+J2kAeI/VbGLshSSHdst/O+CrHLV9HRALhsUOAxxdHj9l7dDvcsCdsl7fthlHV0usyw+CvPA4MpKnqH6JmmL6Z9Yd/N4H
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39830400003)(396003)(376002)(366004)(136003)(346002)(66556008)(8936002)(66946007)(66476007)(107886003)(6506007)(2616005)(5660300002)(2906002)(83380400001)(6486002)(956004)(6666004)(1076003)(186003)(8676002)(52116002)(4326008)(316002)(86362001)(6916009)(478600001)(26005)(36756003)(16526019)(6512007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: GV5oEtyRaIHu3H5Mhsi2wCAzbXqO8j4P8hPMAG4qaO29WE3cXEWITreVbxcwNvTKksT1eaJXdFO/dyKJTg9QG/RTKDQspjM8po9MrZmJoZcnP/IcBslNivURI36y9bswpEyxZbE8JC1ML/kr1Yz6varTGXGZMF+B3ftEuUcUmcGuh56qONgr+1KzIP8+mvsohSJLuyRwh0HXPIBCCZw2bV1s+oJP3JHCT8Twho750OCSQ8wQRQKHSr0B+ySm+ob9yimbVV4WQfP1zSvlT5sVZ2ip4mBOsV9zljJ/FQMLRYd5wwDnUFBVA4XlxnasRdm/haXP+WNPNRHPqQf4vLjbRnqL1wAbgBxUtOgargvzW/WaQbUaucbLXC1jIatmp9WnMXbtUe6VAcpWTT2ZXZTW3+ruTRlQakBxoBKnZ4jOlDwHjnN6jdsTTwrO2HwpKiB4JPbnt6kun/YAN8t2DLnvH0DwSK+8jBRi7VTUwiy5DWRtyF1U50LAoA60+sghG4BM7jY6mY2yuTAhBBl6pXgkOjc7RRJdzWXYlfU+ZTMzVqM6seaql3ZichpLW/NSxhpNWesJ7OWrfD2t8huLn0Wf4CDwy/iFYNM95tha4NvkGvtXgED9rx7FR37nCfT2UZl5nUByitz74jgBwgtYDhVwzQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d30fd5a1-c6cb-435b-eed0-08d85bff7ab2
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2020 18:20:10.8251 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bszmamVY3MtKpMOCtONfpYHl3DFhbwdCkC94rXGbG7qVTSpyuoeYPIIpAfFUW2kUxM5lFmG9r37VLukD6bQBoZ2KJCNBjUurXUVcVPW2b5w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1905
Received-SPF: pass client-ip=40.107.4.94;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 14:20:14
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

Add flag to make serialising request no wait: if there are conflicting
requests, just return error immediately. It's will be used in upcoming
preallocate filter.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block.h |  9 ++++++++-
 block/io.c            | 11 ++++++++++-
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index ef948e3f34..e7188fea05 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -67,8 +67,15 @@ typedef enum {
      * written to qiov parameter which may be NULL.
      */
     BDRV_REQ_PREFETCH  = 0x200,
+
+    /*
+     * If we need to wait for other requests, just fail immediately. Used
+     * only together with BDRV_REQ_SERIALISING.
+     */
+    BDRV_REQ_NO_WAIT = 0x400,
+
     /* Mask of valid flags */
-    BDRV_REQ_MASK               = 0x3ff,
+    BDRV_REQ_MASK               = 0x7ff,
 } BdrvRequestFlags;
 
 typedef struct BlockSizes {
diff --git a/block/io.c b/block/io.c
index 9b148bb8ea..fdcac4888e 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1912,9 +1912,18 @@ bdrv_co_write_req_prepare(BdrvChild *child, int64_t offset, uint64_t bytes,
     assert(!(bs->open_flags & BDRV_O_INACTIVE));
     assert((bs->open_flags & BDRV_O_NO_IO) == 0);
     assert(!(flags & ~BDRV_REQ_MASK));
+    assert(!((flags & BDRV_REQ_NO_WAIT) && !(flags & BDRV_REQ_SERIALISING)));
 
     if (flags & BDRV_REQ_SERIALISING) {
-        bdrv_make_request_serialising(req, bdrv_get_cluster_size(bs));
+        QEMU_LOCK_GUARD(&bs->reqs_lock);
+
+        tracked_request_set_serialising(req, bdrv_get_cluster_size(bs));
+
+        if ((flags & BDRV_REQ_NO_WAIT) && bdrv_find_conflicting_request(req)) {
+            return -EBUSY;
+        }
+
+        bdrv_wait_serialising_requests_locked(req);
     } else {
         bdrv_wait_serialising_requests(req);
     }
-- 
2.21.3


