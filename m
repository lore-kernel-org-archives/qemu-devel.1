Return-Path: <SRS0=iivN=EG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81E4C388F7
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2020 12:37:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 378B72072C
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2020 12:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="NAbSsHqW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 378B72072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYq7x-0002zd-Hb
	for qemu-devel@archiver.kernel.org; Sat, 31 Oct 2020 08:37:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39374)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kYq6S-0001Wg-3F; Sat, 31 Oct 2020 08:35:28 -0400
Received: from mail-eopbgr130103.outbound.protection.outlook.com
 ([40.107.13.103]:47840 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kYq6Q-0000Bb-5J; Sat, 31 Oct 2020 08:35:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HEd8QfkyHVYIHAwEP732p2E0wbVhJIOVS5gv8pAB4HNc6zfSqRju+lYp0YgF9WQBmsuv0CnPy9LYs23jGE4xvWePZkr2p88aH6s0mhEWzS5/AfmTMMXtsZy2BriUzkjaJIq26hghQGkfsp3aB3VwvuLSal8TkVNU/OG4JBUo3xdgB7cv4g34q9I3zHrSONhVLhWd3FFZ0pz5cAl0Fl8lxpKH5msuq5U22+t+NdNyDTusojifzJIwhimX1VgCqjWQnJlUbbDBtTZBrBE+HmVqPily1kMFwTdSRC0A2m2UURqnttaNlYBAiZGag8+0r397yWUSzHEZcuCxyn62Jn0jPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lhvF4ktTDTUOtmlo8SyG3lrw7VrpYcNC4hi6c834yOE=;
 b=GTLxZlZWa/Rd8wOuFhRmjX44WJwfFx/CgU/AZjMQzWub56PH3nVvY0cjwIi3iEUfDA+uCvsKWdLlNh8CCkD5ziByE0vE+7/7eKMJmqNl/oVXHGtJaKPKgaeASVdUXoa3cmpxMxI7zuybDHIyJ3QTuqGQIT9LGRU+qyvu+hA7zky14n4o66c09tej4mAZ4gwb2ybkNnww7o9z4OGtTZeaNQCc4kwUejR4/ZJgpbGxx+bx0s94HjX3oaoK8grNvhmbplplxl83Vq6w1NEmzHuZ7KD8II03OFfgwqBPLXXzEWVXWeGjCPhtwh3BAhmu9K6pYytqKNT5ohaEjpDbSnAtUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lhvF4ktTDTUOtmlo8SyG3lrw7VrpYcNC4hi6c834yOE=;
 b=NAbSsHqWdACG6IRUkD4QX6/qfp+OmlIB31Vc2vUFCe2I2NiAuyf62lH3ABBrj26S+YFnA5f1xh5gulERcwLCDcPZCuG8voHRCQ/pmoZwLuayYTjDP3MH6g2cNAewnaazH/qEU3b7LKPdZreKRhH7NwFAT26ScFpk+NQnW4TrATs=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AS8PR08MB6152.eurprd08.prod.outlook.com (2603:10a6:20b:298::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Sat, 31 Oct
 2020 12:35:16 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.029; Sat, 31 Oct 2020
 12:35:16 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org,
 vsementsov@virtuozzo.com
Subject: [PATCH 2/2] block: assert that permission commit sets same permissions
Date: Sat, 31 Oct 2020 15:35:02 +0300
Message-Id: <20201031123502.4558-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201031123502.4558-1-vsementsov@virtuozzo.com>
References: <20201031123502.4558-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [185.215.60.113]
X-ClientProxiedBy: AM0PR10CA0056.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::36) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.113) by
 AM0PR10CA0056.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Sat, 31 Oct 2020 12:35:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45ce8f92-67f2-4d3d-9359-08d87d996b56
X-MS-TrafficTypeDiagnostic: AS8PR08MB6152:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8PR08MB61524C4306D455D50B8E6E33C1120@AS8PR08MB6152.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:165;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o9e23219Bv/ps0U5Nr7SdFavGtxwiIjS3QMxLIu7b4EyG5pBJ0rD4xJiYXV+ZCDjy5+8C98ll8naFrRecXXswRa8C32cgj7tsSoew2flqiee5jewRQjOHa5ihIPnev3vh5nrdM9GLQGYdQbGJNzVmuwKSn708qPFbtw6/+C35lrLnBg1UehW9ACJAtEQtv2PUH4SyzkXRNIZjAOlS687pokXRpYdktKcl0c/1CBu/aPJ5CcDT56gbMZ+pjmVD3I2XC4EDnMUrdlcVyvucsSey0kqALLzpNZss//59IZSJawEgxJw06CdCAK8igeD/YS1FtR4/kT0E4Z3ux5cksF85Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(136003)(39840400004)(366004)(376002)(6506007)(8936002)(5660300002)(8676002)(36756003)(1076003)(107886003)(83380400001)(86362001)(66556008)(6666004)(2616005)(66476007)(956004)(2906002)(16526019)(52116002)(316002)(6916009)(4326008)(66946007)(6486002)(186003)(478600001)(26005)(6512007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: PutXVSF5uQHAYZGLmbyzam04rYHbW9bDB4NY5+XU/QnQPT4r4VkkphupcHVv4OQ3EVNXWBatLfdlFkLQ6ZyUVYkLo0H5o0DBytKdWbzsWTb9i+58FvgxbMkH+U7x9U+StNFx2S470WjXOT3F97tZMf4pbIGqt3Gx+4rRD2RHhGtrQNnnPYyupgcBCFN38vBWCyYKDhZ69R4IAQbn4ku2F2h/+HqEEi3X0VzVqMCrmhOY3pQ2BGD6zwS1a2cE3eQLQFJhUSdeDUbT922aPLdI75Nw6N+Ama5p9mwR5Chb8NjfqAC0Jld8ZV4y47JBfn9VRZxYlzyNS4onWlvvX9BNoyU/17eHgNKHtjzgcmj7GBfO0DYSAHSpYjJlA4hjq6+ge6+rn6M/lbE03Xv+ad2z6Igl7lS+bkWIEB8v8+d6/Vn/F7RcRmKd862dGZvpEcVV1P42cPafrP2j+S9HFly+e/kZDzWxKltHuK+MVZdJZ733Y0WbW89Wa5024bJI531NMJCIgpCkt4cYmcN6AVXmrhslR64PDRveyfgmq/eYrVspbTKJysHbYngQgGuupjFTrYwFJjflbVusnzoo3hdes9I6ZGs1baeK7IfZ0WHvPcIqmd1akI57pEHSfsgM4A32DsGRKmwLHBPxb5gZsl6Tsw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45ce8f92-67f2-4d3d-9359-08d87d996b56
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2020 12:35:15.8673 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: apvdGogttYgr6OplgQ4qebWJpDX/TOjUiDNRWoSdcXV/6/3t2A5KKDmOMVFkMhbmRDAArWv4kO0VYC6NMuEDrFQioYnpq+fufpCcdhR+2ts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6152
Received-SPF: pass client-ip=40.107.13.103;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/31 08:35:15
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

On permission update commit we must set same permissions as on _check_.
Let's add assertions. Next step may be to drop permission parameters
from _set_.

Note that prior to previous commit, fixing bdrv_drop_intermediate(),
new assertion in bdrv_child_set_perm() crashes on iotests 30 and 40.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/block.c b/block.c
index bd9f4e534b..0f4da59a6c 100644
--- a/block.c
+++ b/block.c
@@ -2105,9 +2105,10 @@ static void bdrv_abort_perm_update(BlockDriverState *bs)
     }
 }
 
-static void bdrv_set_perm(BlockDriverState *bs, uint64_t cumulative_perms,
-                          uint64_t cumulative_shared_perms)
+static void bdrv_set_perm(BlockDriverState *bs, uint64_t _cumulative_perms,
+                          uint64_t _cumulative_shared_perms)
 {
+    uint64_t cumulative_perms, cumulative_shared_perms;
     BlockDriver *drv = bs->drv;
     BdrvChild *c;
 
@@ -2115,6 +2116,10 @@ static void bdrv_set_perm(BlockDriverState *bs, uint64_t cumulative_perms,
         return;
     }
 
+    bdrv_get_cumulative_perm(bs, &cumulative_perms, &cumulative_shared_perms);
+    assert(_cumulative_perms == cumulative_perms);
+    assert(_cumulative_shared_perms == cumulative_shared_perms);
+
     /* Update this node */
     if (drv->bdrv_set_perm) {
         drv->bdrv_set_perm(bs, cumulative_perms, cumulative_shared_perms);
@@ -2301,6 +2306,8 @@ static void bdrv_child_set_perm(BdrvChild *c, uint64_t perm, uint64_t shared)
 
     c->has_backup_perm = false;
 
+    assert(c->perm == perm);
+    assert(c->shared_perm == shared);
     c->perm = perm;
     c->shared_perm = shared;
 
-- 
2.21.3


