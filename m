Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7908C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 14:13:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82C9D20FC3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 14:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Ux0CBAKn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82C9D20FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k97np-0000RT-NI
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 10:13:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k97li-00056j-7x; Fri, 21 Aug 2020 10:11:46 -0400
Received: from mail-eopbgr50124.outbound.protection.outlook.com
 ([40.107.5.124]:48515 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k97le-00053q-T2; Fri, 21 Aug 2020 10:11:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NIZNTyqkcxEbWMrMFvl5Z4A2gCLSaVtPhAA6IjGSageAi12ib8Bc2h4ljgjW/oBzNT2H3Ty5NQT3Y1hE+VJWQoHfRV2evGsUNktluUE9buYkYtt3Sft1ILT7lewWm5ssxh6Ri2erezNnF1CzRJH+FhkigZbp/hNzmg8rqCjvZhSfha3KtflOXU4SnG+zwZt+900me2b4DEyPxomfdm5yL4NuKsMlMTLQdz8c2UcynncuC7ATDBdGpfIOs8iV+2KJSfk24mi82E9ZZqkVyBGHygJEQskVbRIaFNGSNucpdiqsyrQICBG/ExqtZCPtK2zefNGgIarIYkd0r9E1d35SFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6ADkc6uYMLabKqyv9ENA7/hX8HBJxK5upg5p8B/ZEw=;
 b=g7/CIBOEyA9BttwBp5n4x7UAUWyza9B1d3ch6dFsBLjZWG3b2pqJTxwgtbM08snirZfJHNomB7ob1v1eYuqjiBeW7e8/qwOQJDYDU4xi0PhtgRbbiwDFwoDCAb1zbhiGeTk0kUIirCw7i7qYpWUq4wFbhmD2Hlp2eBE4tHLCcRg4sq0kMx7sb4Kb6TU6cutxvG1u9XFZuTRWhl5efob86qNukxHAx0c0xdXue7eDMd760sFzoHXG5sRSwWSlBfVvfwyFnDxJAA6d8TFjP+BWpV6IXiiFb+znp5majKkPmygLizymPijsnNeNcgknP4x5kMRcQVZAE5sgPXIPhFm86g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6ADkc6uYMLabKqyv9ENA7/hX8HBJxK5upg5p8B/ZEw=;
 b=Ux0CBAKnl+zOgWyAu6DEc//n48WzJg8qckvawh/PvuRy407LB3ICz2VzqUBirHk2fJCW+AGc553nyo/1Z0zf+GkajvmlwlnBM3W9IbtNjK55LUij+PqxWuoslgfiKk6WZ9tHqno+TzxbG574YmBDmB9DFHQH0qhE5YTIy1vEmA8=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB5253.eurprd08.prod.outlook.com (2603:10a6:20b:ec::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Fri, 21 Aug
 2020 14:11:37 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.027; Fri, 21 Aug 2020
 14:11:37 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v5 01/10] block: simplify comment to BDRV_REQ_SERIALISING
Date: Fri, 21 Aug 2020 17:11:14 +0300
Message-Id: <20200821141123.28538-2-vsementsov@virtuozzo.com>
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
 15.20.3305.25 via Frontend Transport; Fri, 21 Aug 2020 14:11:36 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4126218f-d288-480c-c881-08d845dc1e49
X-MS-TrafficTypeDiagnostic: AM6PR08MB5253:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB5253BE28C43ABDD4CBE98C9CC15B0@AM6PR08MB5253.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jjldiDGEnMqe+I5RF2cmcABvHBHzIRm5UVUiG9v66g93PiWruTtjVJGCY+cN0UyXiZksDH1jTOwqYFcdR5/dbg1njnm388fXXaDI4rI+44HCBA53b7jpv1bzxzGVe8B6+wZBoXwNXi5FwbsH4M/eaQ3PzBgguM3tHf4qAUGaZu9bBC3sV3o71CVv9H1krdemmfh5soEjJw5T+RPvFnoOspP+A8+ru9vG5RB66kYyHEquw/TE2DPbLu9ib4oGlBF/VwuxdAOaBKKLn07MM5qXiTIgSDcZ/VQMXKM69SeinX2+g7E9lVlwqYeyKk4jhnz9Q/IpEGqnTXokZhJ2tV5d6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(396003)(366004)(376002)(346002)(136003)(5660300002)(2906002)(2616005)(186003)(1076003)(316002)(6666004)(26005)(956004)(16526019)(66476007)(6486002)(6512007)(66946007)(66556008)(8936002)(83380400001)(8676002)(6506007)(36756003)(52116002)(478600001)(4326008)(6916009)(86362001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: fZa0M9J0oBIQ8B44TRw9V0LUAL5UnwRXWgFd6KWVBuzdFFP0VPjCXO2RahWpPp2eknml1wB0WkumUXWtJj6VGhrJjoSAXCiO3CXYbAy0Clv6qRwPjWy2FUPVHcVDBLBUVxusxOlN37mgsM5gUaNpL7u3KOu/4GBnVa65mwlz3yi8RHo7dvrwqn4gRP4qpMzYBBog0Fq4dQ1m2grUlhKp/bqd2TN4V9TuY5oaCb8WYou1Qb00mt3e1JSO1d/lBqHdEcfYmCoiFdRMe5EZGL5JG5bgZ99I7C89KH9k6SQ+V2oryDScl0CwNhg8on5fJMimm/DXBhx/hkeifGiOa0F9/NkL7CmHuJy7zWGP4V+VrMdDzljZwQ8BJnJODJgDi5S6IpwhHXy7RM6d9+jVUmLQMnQhfCoLvqqiIjjoDEF19ivCfSvYrOOyu/oKM/78gwYsXmVGAIVJARtsc1Tx5+7ROtuxRDnLh1i+UGTrlmDSUq3G9GYSE9Agyy6fa4RI58cxuQpTlUt/uOHbYvVNJ0krc3eA638L2p/gdsZx3tev+tyZuMyV5fo/kD5R0QgPCraDFK3uuHq0Zj5A1wN8VuIbFknQZ08XncQ+pyvgsHwfhqZqbebo8vSUR2uNsL6JvgrCPXI0iJs+rNBe58ulCoL83A==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4126218f-d288-480c-c881-08d845dc1e49
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2020 14:11:37.7393 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JUQkbaP7+fEEv8oBRTeCHrxaG3BxNCYA6g3j7nU+Xcqx7DXjgzNKiyfMcExbT0EcRSwbDUsgMDQdQi9I/TleT8GeaWMSJGr+lIpoym2zwPs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5253
Received-SPF: pass client-ip=40.107.5.124;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 10:11:37
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
 nsoffer@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

1. BDRV_REQ_NO_SERIALISING doesn't exist already, don't mention it.

2. We are going to add one more user of BDRV_REQ_SERIALISING, so
   comment about backup becomes a bit confusing here. The use case in
   backup is documented in block/backup.c, so let's just drop
   duplication here.

3. The fact that BDRV_REQ_SERIALISING is only for write requests is
   omitted. Add a note.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/block/block.h | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 6e36154061..b8f4e86e8d 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -53,16 +53,7 @@ typedef enum {
      * content. */
     BDRV_REQ_WRITE_UNCHANGED    = 0x40,
 
-    /*
-     * BDRV_REQ_SERIALISING forces request serialisation for writes.
-     * It is used to ensure that writes to the backing file of a backup process
-     * target cannot race with a read of the backup target that defers to the
-     * backing file.
-     *
-     * Note, that BDRV_REQ_SERIALISING is _not_ opposite in meaning to
-     * BDRV_REQ_NO_SERIALISING. A more descriptive name for the latter might be
-     * _DO_NOT_WAIT_FOR_SERIALISING, except that is too long.
-     */
+    /* Forces request serialisation. Use only with write requests. */
     BDRV_REQ_SERIALISING        = 0x80,
 
     /* Execute the request only if the operation can be offloaded or otherwise
-- 
2.21.3


