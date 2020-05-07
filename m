Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A68C38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 08:52:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E115C2073A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 08:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="jrHo+C0e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E115C2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWcGQ-0007Ur-3E
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 04:52:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWcDF-0001yV-Tg; Thu, 07 May 2020 04:49:03 -0400
Received: from mail-eopbgr40111.outbound.protection.outlook.com
 ([40.107.4.111]:2308 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWcDC-0006ET-WA; Thu, 07 May 2020 04:49:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YIJtBW6Zj+VyX+/03ECgVG2YsrA1B1lvMXu48QCuxyBruDLDQdMVfYXAOPNn/Lh/r2IODRhUDQ2FgsPGnLLKxieyir1EssRm5ZU3RlKOost6Ue11depn2VMGQkuMLQqyxhTBeIPAksC1aNxYTyYCtvtTnaNG3JtDdtsD00rmR9R/QvbBxU7mI24lAYCfycLqBJ+yVdIX7wZpBsAwEFZmANcLNlxRfqg1fZb68hCmeEu47Rsf9cI25eko1p7qmEuTNsWC6bSfTo4k7Z4Q5yrJ2BCOmaloNX6MbGSIGToV/vLFwklGkV/WwOjlYcoxZmg0P1mUGxZ+yiE0NeWVOhKQxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VOaypRfiO7/3OqqGZj2p4/wH2ojzLpzi22c9NHEezSA=;
 b=MMmddUa7lgHY6X1phFIqLPW9XeBUuEK4lJVhb1vnPoapjaiRJAHe81L9MBrNnZDOjsVD07b8DyyeAfirzrO73vhZIMAtxuhlKSTOf4rSxtMSlLVKtPAQ6VBRXpTjaadS5TfRlt8bVjZozSXt1BIl8m183XwEe66FQx+wdqIMT61K4z+IiOgP0wK5f2v7Ogg3Q4dDMWC0taopjZYBc8s711i4W1UtJML4h52TyppluhWPDwW8N1qalmUnN/Y4WQ2+/niNfT1x3n2TYwhS6Vcv9mh+HDF6eGt6GnVUsOWNFE2D+715ZX94W8GQIUiFHd31zkBGnx6Leew9fJmLrVe0qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VOaypRfiO7/3OqqGZj2p4/wH2ojzLpzi22c9NHEezSA=;
 b=jrHo+C0eydLuhqBTSifXKvqhGGj58rODorn+BkpAGhdtOOJrumfib+/YgR3YxB2AP4gdZ1alem/UE2XTZbE20YKr6t0HDndTyAIcKejxvlyk2RHjLaIFqhoGBA3pQTO8ZYMwZOIZqdM2vNiXf+WL2ItNdlLNTNXUn2EguwWNv54=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5495.eurprd08.prod.outlook.com (2603:10a6:20b:104::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Thu, 7 May
 2020 08:48:40 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.034; Thu, 7 May 2020
 08:48:40 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 5/9] block/crypto: drop unallocated_blocks_are_zero
Date: Thu,  7 May 2020 11:47:56 +0300
Message-Id: <20200507084800.20596-6-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200507084800.20596-1-vsementsov@virtuozzo.com>
References: <20200507084800.20596-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0034.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::21) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.171) by
 FR2P281CA0034.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.26 via Frontend Transport; Thu, 7 May 2020 08:48:39 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1524f8a-6960-4497-f37a-08d7f263707c
X-MS-TrafficTypeDiagnostic: AM7PR08MB5495:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5495147357B12891AB7B3913C1A50@AM7PR08MB5495.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:632;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CvyA7cFmzc396adzgQB2RNSrBrgGevptgw9hYoUdiGZHvCd2/EeCOWVWBt2/ND81sOpApe96sksZjRZt8I5GQLc0/IFH2MFxIetXyPS+5H7n5Rt++DchRYxMXX3dY8SlC7Fm1UVD/tC2JLPPod52fhCy3tO1gOrh3ZZ3hHMR7k2ZofzxIx7xg1cUlhzEYw9wX9+VJNvlKBHNe/1/kmEIEs4SJYTOCSnvsuE0IYbVt3kVRuEkxydqZZqzW5QR7jLWG6pBXsPPp/5/7UMLkEEmkg7RcQj0su2ABJMar54MQowy8JC6sghJD+Lh4uSVmMkjHzrKRlpsqcFt8AfGXPwen2WhApY2mr3J8ZZIV3D/xY9cb2257yNbKY96Nn6tF8yi4SGX5a/f61JW0eIcnbIBOEDZSTGXHFT3PKOW0cgGtyPWr8mvhcKvyfXcoD6sSlWfNoN++qz5BuxcbiKbVZ0rBuF3VjUNQwXcMylR5Psee47Vs+31PkRQ+CwwgPr4El2S+mn61nzrIuwEVeaW2wanWWIcaXvpRC1P6Dfb9NuAx1NATVcR4rHuWTfVTx/QhpwL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(39850400004)(396003)(366004)(136003)(33430700001)(4326008)(478600001)(66476007)(66946007)(66556008)(4744005)(5660300002)(69590400007)(2906002)(52116002)(7416002)(6486002)(1076003)(36756003)(86362001)(6512007)(83280400001)(6916009)(186003)(16526019)(83320400001)(956004)(26005)(33440700001)(8676002)(83300400001)(83290400001)(6666004)(2616005)(83310400001)(8936002)(6506007)(316002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: T2l/B+c/dop2L3u/Z407y39iPCWtkcvAP0uvtaC00EAIkX79jsx5HJ/wNVGFvIVd6fQSdF9IwjBw1dFlklRw5EW5Y+qFzKTVhU0aZPjsK0OYLlglTju2ACxT6Uvbt0m59JwH/PcwwJmAJu5PAmP6hWjWhpG90QIllWESvbjxcrUkNVwB4XVm0WbGtIbHM4xRG6FTlqsQaVezH6I07Jo9LIEVow/icG2a4d6Yk4L/0sxN6r0MR/RqkXj34kkdXuYmlva8ICfD91UgYYFh2Mbt5cMcV8u+RCNEQtrl0S0d3i8lmb2P+OdrAAtM0ZW4i23GLevo1itpU0si5c4imES7RbnVmZ/eX7Y1fFq9oSWeyIQCGUUhGummKVlNlBopdBbcQm1KbEiEEELjUPj9CbwKamJ1fcJko/bRtSTolGKTtyGPsMg/FKIAUthGH+0L6c0yDDxznueEMS4onOGm/Bk+5Ll+QSxcFjyDoNlXmwnUB4SIDznutpCdpUNC6pL+YA53GxLaZK2Br5+wVqFnw7ugyqoi8P9kVEcZ6dB0OuFKiDuwhulA5m6lVGmufqHZTwDp9d7icfHc2++vWjtCBqqehQ6qatUD735R87rW1t7q5M8rM2vj5Ct9qg/+9ZguJ0tv7vzH3C53HV+rlC4us86+I980iV+t8HyZTpY/fMCxBGie7Qv8v786QZ+jQbeew6OnDXXVnbf/sl5+OufUaCftHg3rxRsulv2TAjHYIs2rzBtaOJqsSBHZBQ6FcuR+MZ0KLi3ZOYKklCFufsS9q5a+iCbmP3CzkF+5H5ERHMHmrew=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1524f8a-6960-4497-f37a-08d7f263707c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 08:48:40.1096 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p//2NDnIcwMbThHGkRA2R7+JURJfWoilStCQcmeO4J8mjKtOH5mg8TB5ypDfdysLGV7QVhLxCvv+OlnEtVozQnAFbwkP+rV85j4c3MH5ss4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5495
Received-SPF: pass client-ip=40.107.4.111;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 04:48:35
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 stefanha@redhat.com, codyprime@gmail.com, sw@weilnetz.de, pl@kamp.de,
 qemu-devel@nongnu.org, mreitz@redhat.com, ronniesahlberg@gmail.com,
 den@openvz.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It's false by default, no needs to set it. We are going to drop this
variable at all, so drop it now here, it doesn't hurt.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/crypto.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/crypto.c b/block/crypto.c
index e02f343590..7685e61844 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -694,7 +694,6 @@ static int block_crypto_get_info_luks(BlockDriverState *bs,
         return ret;
     }
 
-    bdi->unallocated_blocks_are_zero = false;
     bdi->cluster_size = subbdi.cluster_size;
 
     return 0;
-- 
2.21.0


