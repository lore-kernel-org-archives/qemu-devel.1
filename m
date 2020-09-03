Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C280C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 19:04:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3840820658
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 19:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="nvGfjGmf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3840820658
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDuX2-0000wr-B5
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 15:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kDuWD-0007v2-4F; Thu, 03 Sep 2020 15:03:33 -0400
Received: from mail-eopbgr20133.outbound.protection.outlook.com
 ([40.107.2.133]:10118 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kDuWB-0006yx-Jh; Thu, 03 Sep 2020 15:03:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e2xMW2TCkIVIR7tNTbTjUXEVwJDuprreNG/GSzFpDIZJuOCquNRRZHzOlWGjbE9iyhhOgmOwGyxSLhz4ULWITdLzzGNiHPzySLw9a+5OkiLSV8jn4SxNvE1aHDhTs/lqfoFUVprOKeugJIneKOWRyedBC+dMkNINObtwDMIMSGuEDIfgZtU44GSoPAiKeZxL7tFqZM6Wuu6IrsRN2wY3aN5O0aWUCqwfceGGQdv5AIgYKDd9gE/c98ehUOhLUd+Er8axlxn7jHOoE6adNzUK83XJh6Hj65FNYF/AaW16rkre/9ti2tbt6BY/QZCxkUKEESpprZWa/V4ySAS/sA3dpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pR6vivg8o57QMBJbTePSo5I5+P2l2+ZnfXdiIxSOdUI=;
 b=OZbuyFF8RGfMKD81L3vpJx10osXKdzWjX3EkC074hFLgrgBPpjJzdXTFQTdocx8TeJoRXC9wk+bQwrEcCbSOU7T107zOM1TmoHzpa0XVHWDx92my9pyyA4XM0LkuAI+z44R57odaHcQXX8Avwc7ghqoKfWsxLDhk/Cen+1UbYdMGHN1yMpoDBlVwks4EgXP3xSQ0wRo8ZiXUTTFfLzZyYumx7N5rX0EhhhvAOKRvUJbmyu+lW5cSaPAAGARH+y1Xoxk8h/U9iZ0yFIczLWW4G/bS683C0XjR+L8zgkLAzDCkLtUMJnqfyaHwkAwP3KC8Rn/+LcbvOUPUrn7Z9U+cHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pR6vivg8o57QMBJbTePSo5I5+P2l2+ZnfXdiIxSOdUI=;
 b=nvGfjGmfDppp8aRI9x/OQPa4roQGCxPHxqK/xgqBGk1Xfm6yWaWoRu65CMbGOU4WlSDBIDsVho+HMarAauFpexOcv33BMCYwEvNy7DlDsqP+2Z7MWu67cEt6Dgg3ICerfZkpYk0AW/m57TxAv37EJXGgx1hFS1EvaZpCDRwmtRo=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3159.eurprd08.prod.outlook.com (2603:10a6:209:46::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Thu, 3 Sep
 2020 19:03:18 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%7]) with mapi id 15.20.3348.015; Thu, 3 Sep 2020
 19:03:18 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org
Subject: [PATCH 4/4] block/nbd: nbd_co_reconnect_loop(): don't connect if
 drained
Date: Thu,  3 Sep 2020 22:03:01 +0300
Message-Id: <20200903190301.367620-5-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200903190301.367620-1-vsementsov@virtuozzo.com>
References: <20200903190301.367620-1-vsementsov@virtuozzo.com>
Content-Type: text/plain
X-ClientProxiedBy: AM3PR04CA0136.eurprd04.prod.outlook.com (2603:10a6:207::20)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 AM3PR04CA0136.eurprd04.prod.outlook.com (2603:10a6:207::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.15 via Frontend Transport; Thu, 3 Sep 2020 19:03:18 +0000
X-Mailer: git-send-email 2.18.0
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4de053b4-ec77-4c46-3b72-08d8503c0503
X-MS-TrafficTypeDiagnostic: AM6PR08MB3159:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB31598223726E167CEA2A54FDC12C0@AM6PR08MB3159.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:119;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oKpmMRkGBwS7xaGSLzkyxxiSboWvsZBSDFYvVe2wFRTTk+6iKVg3SFyVjfIqNX4EMm3thv83ZoTdQxWONAer9z7hyFe8WkOCSmEw3ow2TWA9Cox2lSaN6D2HdKZzj/B4ahq7U+uP5t6JlgBlaGAwp7i5SP2UWUMWRmxRgdShLaTezEigvkMo/aM9S1j6SZMworCnVQgnpRf8uyDcWc2GS9aBSAZhTIrEG/YVplL/v90zL6xY7kCp4xNs3ZoK6+IXAhdeTFD28lqBEYeeweUE69uZ+lQF0hE/XxQsiLeDrnSlG3zW2U7UQ3I+n+rlSoOj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(376002)(39850400004)(366004)(186003)(6916009)(8936002)(2616005)(6486002)(66476007)(8676002)(2906002)(956004)(66556008)(66946007)(478600001)(107886003)(86362001)(1076003)(316002)(26005)(36756003)(4326008)(52116002)(5660300002)(83380400001)(4744005)(6666004)(16576012);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: q9fd0Nf3nXcMr88l6JR1+5dyrCFyT5gHd/a8EQ6y2EioCkMMTJSkU8l5z8S029xnjXhyQo6qLnyHF26bHLPcIWAQcD036H4SF0dRkIcq57eZcnx6mrvW+5SnJQ6GzLYXGFz6Pno3B9CAw+b9Em041/i0RP8TiumPch0BFa/RgpK1mvNFIsgBxgzW1/zlCJygREwYuae/5inuIFhLeni0IXsyAjbM74dseb6DMpTs1eBOMiNn8B28cZ2PoBd1zCKzUxGXrXOrDJTjI4UI8SUSn6lCX1qQXiBGwS3IcYGH8Ooc9JvVc/+sakyrctt+fobGo+6DSLykEBXC/AS2kx32jWecUDOBTxSW88mL7czNIgxE917TrBAH9dQoLnsdUVrYgIwsWXMOF6Pb8bs9swR1VSlHSwHWJeNku2FcrrB+cOqCOuInv/mkM/TrUeiN9YXww+UegbBBwGMxdBvcHb4ltFeLZLSbrv7PlskBD0d5AF/Aa/yFUnX01q56Z+ryArlYLiucVIsbX/Z7SZorbr1pvH7JqooXkf0j/JQlA9KnykBP/vZyMbeXZ/MyJ6oJRsHCKnHsW7s2ZpOHW5w/IS8Oejn5Y9PRccRs8sZnV4GjH3Ku7KlacLD6KWoOUWXySSeoQ0ZuikToZGFL7r7SRVuXEg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4de053b4-ec77-4c46-3b72-08d8503c0503
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 19:03:18.6796 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9RCizOLz2O7QWOwRMqekUC8saPj3LcEFhFghWw2o6rTj0S3B+11SwExMPa46V/4YXt48//2HE+qjoCGda8de3i+/+ezfu99j/iijNBWrJO4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3159
Received-SPF: pass client-ip=40.107.2.133;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 15:03:21
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_ILLEGAL_IP=1.3, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

In a recent commit 12c75e20a269ac we've improved
nbd_co_reconnect_loop() to not make drain wait for additional sleep.
Similarly, we shouldn't try to connect, if previous sleep was
interrupted by drain begin, otherwise drain_begin will have to wait for
the whole connection attempt.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/nbd.c b/block/nbd.c
index caae0e6d31..4548046cd7 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -661,6 +661,9 @@ static coroutine_fn void nbd_co_reconnect_loop(BDRVNBDState *s)
         } else {
             qemu_co_sleep_ns_wakeable(QEMU_CLOCK_REALTIME, timeout,
                                       &s->connection_co_sleep_ns_state);
+            if (s->drained) {
+                continue;
+            }
             if (timeout < max_timeout) {
                 timeout *= 2;
             }
-- 
2.18.0


