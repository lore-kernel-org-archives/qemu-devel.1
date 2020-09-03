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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66820C433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 19:04:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3731F20658
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 19:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="pL0qO7ff"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3731F20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDuWw-0000ly-DB
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 15:04:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kDuW7-0007hl-D0; Thu, 03 Sep 2020 15:03:27 -0400
Received: from mail-eopbgr20133.outbound.protection.outlook.com
 ([40.107.2.133]:10118 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kDuW3-0006yx-OI; Thu, 03 Sep 2020 15:03:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gIXs66YGD95CWhkvdxdT2ooEGS6tWqRamVErIDu65ji0Ib/4Uh90eOIL7F3B17mLf0j9uop+qKmRufd+eJia+772/6otyA7+FrD3pcrAiWnBXzRh1C9movaEDOAjhhBqHk1iJ5kBtmIbRmSSScIqhGgKN1yujVm+2M/IXhbG3d6E7BEA/LAsg1U6fE8sQ+xtjlXfxTCdUiYV6iU9sPyVnm7tVVxpxYmiyDqdt3JNXhG5iBp30TcvWT6iCoqaWvPeVxiDs3tp3JRP8p9/DmzbsDw/ywhbwa6XdcGcsX10Td0oaApXDgJaIfvbMUZBrc2FF/x+QYHuQCaTzYvJNvzTAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2DmC55TpoMGZLDIUhubaMNJRY1dQ7Hcx2jgNBEcSs4c=;
 b=iaGcpet6lrqLO3/xI9FYOdW4dNq9san79mFeTRQ6OHqGruqC6XQ9ewj6EjmUFJQq24m3ifZ01ApG9NfAu/adRmygFeWfIXCVRP3ToD8Vj3ljymzB9/4vzjg/XSzg8Uw0/7tp53EVLsVisGPrN8d/lYmT4MfasV2O8YMdGMgoxqwhxfQxzl5XyBzmkgMzGAES/ebp1ecEG97OIxML1qbLcjzaKOmXFYNpIUIUviarY70o/nR8DUh7+d+5at9OhICFNzD6xtEuSufOxyQNqOt6A0zpKgz5KStKG4Qyhlwxx3Sj+R8nkUpmHrcem2gC34FrUo58fkbXKiEvHgTNYqpxnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2DmC55TpoMGZLDIUhubaMNJRY1dQ7Hcx2jgNBEcSs4c=;
 b=pL0qO7ffBTU0bBRYFUNP4gp+MwpjK9hb+uqioCYn1QzXLJH55FT7BL2wxE6pOroxakAA09c5XM9RzeouOXp+kM9BbAm5fllhD7k6JD6vkil4/B7oA6YoIJ/95mGACH0qjq9udNOmBn0Zh18bIMbkN5kk/GFg06PoOlYOT2dssP0=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3159.eurprd08.prod.outlook.com (2603:10a6:209:46::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Thu, 3 Sep
 2020 19:03:16 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%7]) with mapi id 15.20.3348.015; Thu, 3 Sep 2020
 19:03:16 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org
Subject: [PATCH 1/4] block/nbd: fix drain dead-lock because of nbd
 reconnect-delay
Date: Thu,  3 Sep 2020 22:02:58 +0300
Message-Id: <20200903190301.367620-2-vsementsov@virtuozzo.com>
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
 15.20.3348.15 via Frontend Transport; Thu, 3 Sep 2020 19:03:15 +0000
X-Mailer: git-send-email 2.18.0
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c657bace-3773-4e34-ee27-08d8503c03ae
X-MS-TrafficTypeDiagnostic: AM6PR08MB3159:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3159B6AA322B3ECA2E83FE6EC12C0@AM6PR08MB3159.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:139;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pkMfn9p54gnX7jRRVOJL1F0vHaqVBpLuiKqW7otSjbXLyU/tmEaKCxT+VugnlNE+2CCM6h3MGtE8jjAFLJ8G48uTTc2pq3QEX9Kt6lQbI+BpmE/YuPhpykrt1pOCLb5+9CF9buQF2gGDyG0mVYahs3QMtdKH/0IS9AmkAe+b3VaDL7n6zwOvcWpd4e2RTL2dgrEx4ZjQVNmqIstfCuYB0cOD7IYBDvifIFAwyh1Akra4NjobYlmvicbd9Fui9Kbi2vY4zy/nh6Pq3oEVGpv8sskzvNrIJR29uUY12vwnIFf1Y6HTXtxV8TFoXODQim0HGlOBTn0yl97TCQN3fkw0ZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(376002)(39850400004)(366004)(186003)(6916009)(8936002)(2616005)(6486002)(66476007)(8676002)(2906002)(956004)(66556008)(66946007)(478600001)(107886003)(86362001)(1076003)(316002)(26005)(36756003)(4326008)(52116002)(5660300002)(83380400001)(6666004)(16576012);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: lMMfWvqu/ko9+gzG7raJSPxXM3w84d+4TcBQYTXAPDIgcy5ygFwXofBVZIsuKvZfznFEyJ/IzOuiC2P/qqR61FhLHhvfOQQ6S3rH1jgofTO8BrMOcswd5TlJxnLIH/pqbETW89K/qaMmhU29WXHLDvSIB2/iTEu5A2vJVNxWAsAifhIGbzzWZVsDWDm09Iwe7ZK6FtbLDm7znkDy5GUHGRpSUq9UJbqf5q8RAPr/TjL9OQdotXAYhobw0ZRkOVPjMtm7wWVLHgASikbYis6trYTZrRCdZJOlVbGlTk4rcfbH2qpAXPnyEesEDw9ISaA8L1xY28nHBajIDUrkGc8FbOXjCbPbAIydaxwmZ/WWSx4CKRRoYAReEohcT3bOaFinqXUblByEmuhBsdQZyPzRBmVoxdprogE4BOUCXsej4TMYr/w61GHbwYxcBvhwOye8aqel7atHNy22f4PnfbqunC7TbbDPTIiZbZecRlXEgY5dvTrzYpOv1ckC+C7jPEtvAof+2EBFwlNum3GlHTKnbYUOOet1a7AgXkubS1ywOz7ss1ZYVklxWNKI9AQOfowyaXuIddU04RNDBlDyg3bsn3fwrAXMLnVNgG3zlrORINMgl2cTNRWejHlX+JktFeXvLqGkTSvhIRItC+7M6cGJhQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c657bace-3773-4e34-ee27-08d8503c03ae
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 19:03:16.4743 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QhuXH5z1ByotXpKdLl6O90V3UyuMqOhGiWaZ1WrkSCxfkKQq6si22FIkJlqwu7PiD4e46K9VtUlheCqv+RUfCg/zOsZiNNiaZbIc1G0MGuw=
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

We pause reconnect process during drained section. So, if we have some
requests, waiting for reconnect we should cancel them, otherwise they
deadlock the drained section.

How to reproduce:

1. Create an image:
   qemu-img create -f qcow2 xx 100M

2. Start NBD server:
   qemu-nbd xx

3. Start vm with second nbd disk on node2, like this:

  ./build/x86_64-softmmu/qemu-system-x86_64 -nodefaults -drive \
     file=/work/images/cent7.qcow2 -drive \
     driver=nbd,server.type=inet,server.host=192.168.100.5,server.port=10809,reconnect-delay=60 \
     -vnc :0 -m 2G -enable-kvm -vga std

4. Access the vm through vnc (or some other way?), and check that NBD
   drive works:

   dd if=/dev/sdb of=/dev/null bs=1M count=10

   - the command should succeed.

5. Now, kill the nbd server, and run dd in the guest again:

   dd if=/dev/sdb of=/dev/null bs=1M count=10

Now Qemu is trying to reconnect, and dd-generated requests are waiting
for the connection (they will wait up to 60 seconds (see
reconnect-delay option above) and than fail). But suddenly, vm may
totally hang in the deadlock. You may need to increase reconnect-delay
period to catch the dead-lock.

VM doesn't respond because drain dead-lock happens in cpu thread with
global mutex taken. That's not good thing by itself and is not fixed
by this commit (true way is using iothreads). Still this commit fixes
drain dead-lock itself.

Note: probably, we can instead continue to reconnect during drained
section. To achieve this, we may move negotiation to the connect thread
to make it independent of bs aio context. But expanding drained section
doesn't seem good anyway. So, let's now fix the bug the simplest way.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/nbd.c b/block/nbd.c
index 9daf003bea..912ea27be7 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -242,6 +242,11 @@ static void coroutine_fn nbd_client_co_drain_begin(BlockDriverState *bs)
     }
 
     nbd_co_establish_connection_cancel(bs, false);
+
+    if (s->state == NBD_CLIENT_CONNECTING_WAIT) {
+        s->state = NBD_CLIENT_CONNECTING_NOWAIT;
+        qemu_co_queue_restart_all(&s->free_sema);
+    }
 }
 
 static void coroutine_fn nbd_client_co_drain_end(BlockDriverState *bs)
-- 
2.18.0


