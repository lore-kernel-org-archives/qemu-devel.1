Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40EACC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:34:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A9DC2072D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="f0ytYKyg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A9DC2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7bWt-0007uR-Bu
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 05:34:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51302)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k7bFv-00082s-DR; Mon, 17 Aug 2020 05:16:39 -0400
Received: from mail-eopbgr140127.outbound.protection.outlook.com
 ([40.107.14.127]:35534 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k7bFs-000882-4b; Mon, 17 Aug 2020 05:16:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMCFrolTsS+Wnd2YrBd0ndDGShJm4YBVFCWbAN2CpRpOa/pRGLrr07ZNQJ16bl359LygTtoOwt2cGKTjvB35ntscBvppJVIs40hHlL9gzZt6pcAwrmUWs5LIldz/QbTuMtBpiDe4c+aLeXF+3YJ2/UlKbLdB6MufF+Gxvl8JPFQc3mOQ7KQqco+t+sB8rnQLV3ZD2/2JNQobTnazOQtXl+eOlbytKy0JbiNpftbCgM3iLNSFPA++aQpIfYPv9Z6oHylOmxdnJE7fGooPALf/2rv2IXitZQUAel2jX0HZVpw78cErXBuUUMSRToZ77xboScy7B12Wi0r6F++ZJV5BRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9umXax7o65jnZOIGs4fX9mg1dWtR2FDxxk8CWQKo7B8=;
 b=hYBGlxB4kWjMZt7bwBjsPggIP1lTz0FNZy3PAzSL+8TNsdJrHXdxpDXye+5LzvFFPDZlwP8BNbjNYBF09KPjeTG/zGTsPq1iSqLQuq3xyUsuQ4YyfwJOgyiAQHXiW9WIm3RsoRO3azTnwirFjWLXWD7xyJbdd2QB77w05Y/P7grjo0xIgIIiPiMlih/A9eV8bfpP1wgvqNua9FgnUrXTBru27x2FwfnQ7YmhHckWxqljuWQj6UmGdLMWsy+IA9JTJBXOtCa/6zxS39GupAM9s1o2HRL/lMpXVjNQPJkzFV+d5FqYUa4fKWuNH+1djRk93jCXYEIGt8B/tUmbY98HdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9umXax7o65jnZOIGs4fX9mg1dWtR2FDxxk8CWQKo7B8=;
 b=f0ytYKygTZ4i+3lSIk5OlxMBV3/LTlnlJTSmsBktEXfbLwx9RohMMJwarQELIFZuMjihDXSe/XarBJEjTJEbLPXDtOig9fnQqsGKYsNLMfNkkabCusoKSRV9PYX4Qdv3rGhCJ/vYJi0cR5bNEENUBtt992xOFmJTGFdXiTyFvXA=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4852.eurprd08.prod.outlook.com (2603:10a6:20b:cc::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.23; Mon, 17 Aug
 2020 09:16:13 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.027; Mon, 17 Aug 2020
 09:16:13 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 12/12] block/qcow2: automatically insert preallocate filter
 when on FUSE
Date: Mon, 17 Aug 2020 12:15:53 +0300
Message-Id: <20200817091553.283155-13-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200817091553.283155-1-vsementsov@virtuozzo.com>
References: <20200817091553.283155-1-vsementsov@virtuozzo.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0015.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::25) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.174) by
 AM0PR10CA0015.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16 via Frontend
 Transport; Mon, 17 Aug 2020 09:16:13 +0000
X-Mailer: git-send-email 2.18.0
X-Originating-IP: [185.215.60.174]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a351dfca-edaf-43d8-bafb-08d8428e304a
X-MS-TrafficTypeDiagnostic: AM6PR08MB4852:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB48523E4042C33D3AA03CA42AC15F0@AM6PR08MB4852.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:147;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9+fTdxWIfkf/FKu21duaEEOoO5fs5hDNrmHMz1t/yD404NncxgUzzdYJYsNnk9fNgkluE7562gEJXneQEX3aM0x2TNyA2Mh4sPlNsR+5ZB5xhD88uwyrkr3AXUVKMaoJ8IdXCQvrC5ltxf0C0zYz2FK5jODQ1o0p0HuXyGCR2e0C4YsiX+WU37Lj0R3sWm9Vj94E7bIH/p6/kUFy4/8mlkQFIQ7u0rGotuI+wdDdjyGzC+HhGwILBo6q9ldH4ln0zZD9hySaujOz4KumD6A6YUWzpbTIf5VYdw5LqZgNdGvANwQ4qaZktjfUfjIcn4Lb4skpGag0wy8/nCjPfaJmUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(376002)(39840400004)(396003)(52116002)(26005)(86362001)(16526019)(6506007)(186003)(6486002)(107886003)(8676002)(8936002)(478600001)(36756003)(4326008)(6916009)(316002)(2906002)(1076003)(6512007)(5660300002)(2616005)(66556008)(66476007)(6666004)(66946007)(956004)(83380400001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: nPc2WCf96fFFr6tRi9bqKiJ2GGClIveXqenZKcWzfac10p+cCBQY0+pRkdaSj0pyRpWXiMvf2oNHzBoHXncDZDX18f3NNBxLD3yRnFPnLhiO6bi0R4d/+peZbqE0e0ES+UMexyNDA6oRfyisziEZoT+wetPH6gP63B7sY2Ul8DHdgBGUB+HvezC6nKt1o2wRzEb4b7MfVn+laOj4a0GgEopZRU2G/afl9so+j+2J9Oh8/FLidpTQdnQ+PiCux5haHu14etyMIF4sLGQTKxTMPQ/jmRrJyVh98SvctdfnIDP/kiW3W40xAfBspFbbsg+ICOBIfhiRAN4ER/yvqIZzTztvxn1woqCdGJaRxjR0ziA8UuawdzGhk6fcEhRieHAERu1RiNW2BIqrijiI8g+Ymd6k5FNnTvfDVHUSDjJCLpLPvGUCEWoXrrRuBa5NRs72M4ZMIE9NWpNLrinQ/pdf3LLZ7r+Wel9W6Rg/X2vLL1Qyo7VzeRzvP8BKnO5fmFtrHTMf+k99m4WsY1nlEjZM81Sm3VNKxzHCeOKT4rxRXcZrnluNp2gtwUxjS3Xp9cD8H3yBgZab3zBfBu6PD1OpxB2gaXTTMEkFGeWVzLDnkLhSpClmg/tY7tzTfu+ygYn9YwdlwlRxVs+OnF7SPIxq/Q==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a351dfca-edaf-43d8-bafb-08d8428e304a
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2020 09:16:13.7790 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ni+EczDfT0UQ/RFcrUgP3m3KsLqkHLDhjpAoTAOLMGBOssi8X5cuX/55rQ7vh2wi2Dhldkdu+DX8Wpoc0qCUS0aPH3ChIaFNPuC9TwumJXM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4852
Received-SPF: pass client-ip=40.107.14.127;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 05:16:17
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
 stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

vstorage has slow allocation, so this patch detect vstorage
(I hope, we don't use other FUSE filesystems) and inserts preallocate
filter between qcow2 node and its file child.

The following test executes more than 10 times faster
(43.2s -> 3.9s for me) with this patch. (/newssd3 is mount point of
vstorage, both cs and mds are on same ssd local ssd disk)

    IMG=/newssd3/z
    FILE_OPTS=file.filename=$IMG
    COUNT=15000
    CHUNK=64K
    CLUSTER=1M
    rm -f $IMG
    ./qemu-img create -f qcow2 -o cluster_size=$CLUSTER $IMG 1G
    ./qemu-img bench -c $COUNT -d 1 -s $CHUNK -w -t none -f qcow2 $IMG

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/block/qcow2.c b/block/qcow2.c
index 6ad6bdc166..f56507158e 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1868,6 +1868,40 @@ static void coroutine_fn qcow2_open_entry(void *opaque)
     qemu_co_mutex_unlock(&s->lock);
 }
 
+static int qcow2_vz_insert_prealloc_filter(BlockDriverState *bs, Error **errp)
+{
+    QDict *options;
+    BlockDriverState *filter_bs;
+    Error *local_err = NULL;
+    int flags;
+
+    if (!bdrv_is_file_on_fuse(bs->file->bs)) {
+        /* Nothing to do */
+        return 0;
+    }
+
+    /* Assume it's a vstorage */
+    options = qdict_new();
+    qdict_put_str(options, "driver", "preallocate");
+    qdict_put_str(options, "file", bs->file->bs->node_name);
+    flags = bdrv_is_read_only(bs->file->bs) ? 0 : BDRV_O_RDWR;
+    filter_bs = bdrv_open(NULL, NULL, options, flags, errp);
+    if (!filter_bs) {
+        return -EINVAL;
+    }
+
+    bdrv_replace_node(bs->file->bs, filter_bs, &local_err);
+
+    /*
+     * On failure we want to remove filter_bs, on success it's referenced now by
+     * qcow2 node.
+     */
+    bdrv_unref(filter_bs);
+
+    error_propagate(errp, local_err);
+    return local_err ? -EINVAL : 0;
+}
+
 static int qcow2_open(BlockDriverState *bs, QDict *options, int flags,
                       Error **errp)
 {
@@ -1886,6 +1920,10 @@ static int qcow2_open(BlockDriverState *bs, QDict *options, int flags,
         return -EINVAL;
     }
 
+    if (qcow2_vz_insert_prealloc_filter(bs, errp) < 0) {
+        return -EINVAL;
+    }
+
     /* Initialise locks */
     qemu_co_mutex_init(&s->lock);
 
-- 
2.18.0


