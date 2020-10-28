Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87E8C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 21:54:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E26D524724
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 21:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nonterra01.onmicrosoft.com header.i=@nonterra01.onmicrosoft.com header.b="tftKvGs2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E26D524724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nonterra.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXtP2-0008Rv-KD
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 17:54:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51084)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tobias.koch@nonterra.com>)
 id 1kXtO9-0007vn-5h
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 17:53:49 -0400
Received: from mail-vi1eur05on2046.outbound.protection.outlook.com
 ([40.107.21.46]:35297 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tobias.koch@nonterra.com>)
 id 1kXtO5-0004qG-VR
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 17:53:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oDkMTwrvLaSDsKX2pKD6gAGn4ZESjaGoXsMjFsm9duNzQ8M8DrMb04LZ4t8HlNnE1fUcBYV46QOETX/h3ulYc7h+bPUeb/olhDgZp0ae0wVR9GQrpkRWg9i5QWj5qQf4AptZp5lUgh6YSdVRW0EzVPBBWX67IcXMWAEROuO+LPikMYolcUWKhhRee/sIpofaDaDblfuuA3nr4KO7zjmOOkboGFplg8BHzkrHW/uNUtJXXRYBVwiJoSfrfbH7eicTUKtGE6u4tvTUubrdCdO+LpasLdahqEeeDG2Sg2rQavc6s9qVUMt9ecIj/Th/p9hqSWd508qyHw71IImznwAbeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+eIZUjxY2zBeFZIbgiEJcHjY+K8CO9AznyrDIzuqww=;
 b=nYzwXinAp7QSqMp+PfZbfli2DvuEq2oZ/VUfGvGaZEgL4Ta1ohWTEwpp3CKeH4SfLQm3PxIUV93Iw0VBk9Z11LRQYqInoS4wDTWBNYjN/06WH386OkOylavSfPwK/alBl84vm875cr/rel5VyhPTbddgBSK7ICarwPerwXBuHzKHOzMiA2Pqj3yJ8+ACTGF8pjBj4Lo+csCX7/7T8x4G5opU0aDOrU9XR9LiATjoYN/Tltsw8OkQ75S3YSvEwKtUEhkvPX7Y0UZdiB54NMYjPryOySDK7UM8G6wZv6REiJ7OaVNYiIaYbetNL2TvHu8K0nNlbc0npJ9CMjTIaphkkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nonterra.com; dmarc=pass action=none header.from=nonterra.com;
 dkim=pass header.d=nonterra.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nonterra01.onmicrosoft.com; s=selector2-nonterra01-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+eIZUjxY2zBeFZIbgiEJcHjY+K8CO9AznyrDIzuqww=;
 b=tftKvGs2CZx+rXsGpuXFKsAyvFZQNbYRM396e++hIuf+ksACffvjxl1QDJ9Gm6G+RGmz+0N45K0qYb0kHtqotKqDPlgwuu80LsbIcf8JOQs8XhHvxA5POm+/1nbsrcbMZdBDEpQCBbN4LbSX6lDizWvO6P5VwoSoceOBqHsDCag=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=nonterra.com;
Received: from AM0PR08MB3300.eurprd08.prod.outlook.com (2603:10a6:208:65::14)
 by AM0PR08MB3297.eurprd08.prod.outlook.com (2603:10a6:208:66::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.24; Wed, 28 Oct
 2020 21:38:40 +0000
Received: from AM0PR08MB3300.eurprd08.prod.outlook.com
 ([fe80::cc58:8f3a:963:bfe0]) by AM0PR08MB3300.eurprd08.prod.outlook.com
 ([fe80::cc58:8f3a:963:bfe0%5]) with mapi id 15.20.3477.029; Wed, 28 Oct 2020
 21:38:40 +0000
From: Tobias Koch <tobias.koch@nonterra.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] linux-user/mmap.c: check range of mremap result in target
 address space
Date: Wed, 28 Oct 2020 22:38:33 +0100
Message-Id: <20201028213833.26592-1-tobias.koch@nonterra.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [95.217.122.90]
X-ClientProxiedBy: AM0PR10CA0007.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::17) To AM0PR08MB3300.eurprd08.prod.outlook.com
 (2603:10a6:208:65::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from build.nonterra.com (95.217.122.90) by
 AM0PR10CA0007.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Wed, 28 Oct 2020 21:38:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b3c90bb-252f-492c-716b-08d87b89d605
X-MS-TrafficTypeDiagnostic: AM0PR08MB3297:
X-Microsoft-Antispam-PRVS: <AM0PR08MB3297D31548C2929823A3764089170@AM0PR08MB3297.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oLQ3VDrYCRP3/h+nj72fzCTl8x64gvBp1QXPJ4ra4vbhAAmH0y7+CH4iKaiOWAyuF9GngtpsYoiFXzBBvrTCKnevQIzk8G/flmZg5pACc2nYPmnB3eKEb6FkqcVq2lAnI5vR/+7B0nywOzYPC/ZqEN5BGgiR96gZaX7aC0c6es2gst7l0yyMInYp2IpjX6oly4pn8TXb4PRwXY755MZsjF6gb2gvji/rKsHApAZkK4AFYT9E77fJcrPpBalYgeC53SDM41qjNsKGstLA7y+n6Y2nOmyAfANkinpdlWWSSRdKAogfdo/4AfkOGF4APLGJYZDXiuUCAClmgs0ZPgFQTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR08MB3300.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(39830400003)(136003)(346002)(376002)(396003)(52116002)(66556008)(956004)(6916009)(1076003)(7696005)(66946007)(66476007)(2616005)(86362001)(44832011)(6666004)(36756003)(478600001)(4326008)(316002)(2906002)(6486002)(16526019)(5660300002)(26005)(186003)(83380400001)(8936002)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: tw7O70n1e5aNa8wgeGG8j7PsUMpcAXZCqMeuAD3ofAtus8lq7nTSZCOtcDubDTrqtEJGts/mHht5CMMDgbkfvQG+xNeVUip2b8foDaB9a7MCl0dwSq/mMRlmN9Ij9gTfAaz44G5qU4skryxEIiUZGDkcHLTWE/hTH3JMUyIv2S5FCuHtMLQHM2t4QqpqODHySJnZhJS9xKwAyT+6ASwYihu5L073kbdSNPdNCWfUywOz3XOZdrOs9qDzHnKv18pz0Q7v9wnwQ45NudHQAG3ayKAsgyUzXougqyhW14jx9Yb/7a0sBA99vTnUjf4TzrAjUAtpRIDug4lEE6pUrMmC9QWxDcu5gmDcqn4Q5E2hNKr669JDC6uJtRpWnxZ8ZozeJtf0rZ1w9ihOhLxi2dt01rye5ngAmjpyN5K8vM3yGcKbMIMb3B3Gz9sJx42E55S3OIZdS0N8CyWYth7uFIDih1BhlOTGv2pNme3q9ESLyZosCrhZHb/N7LE1fcbZZG7sr1arXNCLQA5zV66z+Oc0S1cor7aUDJtFQ10LMQOwmCUnC6clpHssOxLtGreojCLlBbHvIVgq4VAJxumgijSxwFu+BDWQRpdy5c9+fmrb1HKSUT3oIvo6C6Ztf3VUdIxWcguWdqMYWxsHRCOFl8jvLg==
X-OriginatorOrg: nonterra.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b3c90bb-252f-492c-716b-08d87b89d605
X-MS-Exchange-CrossTenant-AuthSource: AM0PR08MB3300.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2020 21:38:40.6550 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 76ec9478-ab84-4eac-917c-c1a3242376a3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hDna9rU1LgpeHp/tWDfFa367ddg2wNA0P7p27iAC5dVpzdmeyuBriIY8jFhvq6ZsMKsPAj7uXouY4b49uqN77OSC3Z7SYEs0bcxXMuE+kts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3297
Received-SPF: pass client-ip=40.107.21.46;
 envelope-from=tobias.koch@nonterra.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 17:53:43
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7,
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
Cc: laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If mremap succeeds, an additional check is performed to ensure that the
new address range fits into the target address space. This check was
previously perfomed in host address space, with the upper bound fixed to
abi_ulong.

This patch replaces the static check with a call to `guest_range_valid`,
performing the range check against the actual size of the target address
space. It also moves the corresponding block to prevent it from being
called incorrectly when the mapping itself fails.

Signed-off-by: Tobias Koch <tobias.koch@nonterra.com>
---
 linux-user/mmap.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index f261563420..101bd013a1 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -751,20 +751,23 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
         }
         if (prot == 0) {
             host_addr = mremap(g2h(old_addr), old_size, new_size, flags);
-            if (host_addr != MAP_FAILED && reserved_va && old_size > new_size) {
-                mmap_reserve(old_addr + old_size, old_size - new_size);
+
+            if (host_addr != MAP_FAILED) {
+                /* Check if address fits target address space */
+                if (!guest_range_valid(h2g(host_addr), new_size)) {
+                    /* Revert mremap() changes */
+                    host_addr = mremap(g2h(old_addr), new_size, old_size,
+                                       flags);
+                    errno = ENOMEM;
+                    host_addr = MAP_FAILED;
+                } else if (reserved_va && old_size > new_size) {
+                    mmap_reserve(old_addr + old_size, old_size - new_size);
+                }
             }
         } else {
             errno = ENOMEM;
             host_addr = MAP_FAILED;
         }
-        /* Check if address fits target address space */
-        if ((unsigned long)host_addr + new_size > (abi_ulong)-1) {
-            /* Revert mremap() changes */
-            host_addr = mremap(g2h(old_addr), new_size, old_size, flags);
-            errno = ENOMEM;
-            host_addr = MAP_FAILED;
-        }
     }
 
     if (host_addr == MAP_FAILED) {
-- 
2.20.1


