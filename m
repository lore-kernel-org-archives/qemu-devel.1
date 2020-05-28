Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3272FC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 09:48:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2D61208DB
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 09:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="a9FwwMs5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2D61208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeF9h-000148-6U
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 05:48:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jeF5Z-0008TY-1Z; Thu, 28 May 2020 05:44:38 -0400
Received: from mail-eopbgr80134.outbound.protection.outlook.com
 ([40.107.8.134]:2978 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jeF5W-0002k0-PW; Thu, 28 May 2020 05:44:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EAz1+pKE/lY4zyL9YOrR9vX6cAric8NPUA5oQtTLrDTDpOnF/Joh8Lx3VNajoQixA8IVXmU84Zwz/J7uP0d77te4+95n4aDjH2ry+J0AMS06jVQt4Qn9P7OWCbU6clJOrS7GsGe84wINySAutInK5F6QR3by+i0c4xPdsJNzevRD/D+WgJDV7j+cLd5/wlWvGg8AHM/fUiivh7SfkIS4RSGsDqMWYjT412YJW5JcypxFF/jIkNZ2psyDPrYL0gWohl7XKUdwcVwp2Zg287PYEbPnrl3Q8kVh4uhbsx45y4RglQwLqmgGi116wC+8wwdw3BEE+hdL7DpulnH3JYqQ1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sRnHMeD2MW2hH0F3F96FcK8yHt50+xxCKvFJzvOyi8I=;
 b=aRnqYUn0jPY8vS5Zkjp/87ZoAlIl+s/DV85knfpVV9/Qn1Qs+QRqW3aq9kEQD2NTK1CRDFsPBvvhZamooZlWcrj6F49b4MFlGOZhgefu5kuThSmxtqHsmf4N9gnrZWCQFIWdYJMGHxiy4Ni5a9pmnqGFRv2b5GqvF0FO9gi1o2oLyngKkZjPTClxRTZJgUoHYPcuVA5botp0QVAS2UtRjcBICzUFhT0a6G8Abm6TpwbKNmb/qrAEnmqMp7i89Xug0UmLqvjaHZMVlKlLXe7zO1fdli+UWlHTit2m+e1H60Eu2fUgvz0XuHeTRfI01rUJiNQY2leaomEqA1G6f+Aa4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sRnHMeD2MW2hH0F3F96FcK8yHt50+xxCKvFJzvOyi8I=;
 b=a9FwwMs565M011cjy0iIETFPoOXmOrStfR3g2Et8m8V0zgOXqIUJuHAmjrukhbnaFstMcceU5s+WGpg/IxaFwgsEvk8QDVQulo4qyoTAw/Vj6oivXDbEU3X7baiKBnNNF9rzF5LElcD5wkxB3Og0JHD59AWMG5dq0Ek2vmVcGNo=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5366.eurprd08.prod.outlook.com (2603:10a6:20b:10b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Thu, 28 May
 2020 09:44:28 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3045.018; Thu, 28 May 2020
 09:44:28 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 08/10] block/vhdx: drop unallocated_blocks_are_zero
Date: Thu, 28 May 2020 12:44:03 +0300
Message-Id: <20200528094405.145708-9-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200528094405.145708-1-vsementsov@virtuozzo.com>
References: <20200528094405.145708-1-vsementsov@virtuozzo.com>
Content-Type: text/plain
X-ClientProxiedBy: AM3PR05CA0089.eurprd05.prod.outlook.com
 (2603:10a6:207:1::15) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.localdomain (185.215.60.178) by
 AM3PR05CA0089.eurprd05.prod.outlook.com (2603:10a6:207:1::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.19 via Frontend Transport; Thu, 28 May 2020 09:44:27 +0000
X-Mailer: git-send-email 2.18.0
X-Originating-IP: [185.215.60.178]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ac82830-3999-4962-1104-08d802ebb6b0
X-MS-TrafficTypeDiagnostic: AM7PR08MB5366:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB536698DD07FCDB22D54E0D53C18E0@AM7PR08MB5366.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:85;
X-Forefront-PRVS: 0417A3FFD2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CBcXqhD4gp0s88nBJ213dsrB8Jg8AXozmMGA+WoYeBbxwjQ7fIeShGA9LBFIGZrHH7p2vbj78zYqodPhqek+yp+MCodh72ox9ay98qTfOu5ES8V+sg2USOObZlKg7/BXIMT7kUspe2YjWN/pNqEkPTIUzXXONDGWr5jLKUquEabhMcCogvwe32/fJX90pjzK1VCnWC77RYpDd9Uz4iXhKy6LJQyEeHfUD0VJ3KVpLXTvNBEJwGxJDPTNL8wqeYNzECb4QcR0u8qF305CiTteDXiG50keQTKJUJ9+4DDzsVfAjh13K08lGpC3DviEA6Q5wbGVpgthuTJz5wOUJcL0cA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39850400004)(366004)(136003)(346002)(376002)(396003)(2616005)(4744005)(86362001)(316002)(5660300002)(7416002)(956004)(1076003)(6916009)(66946007)(83380400001)(6666004)(66476007)(66556008)(8936002)(4326008)(6512007)(36756003)(478600001)(8676002)(26005)(186003)(16526019)(2906002)(52116002)(6486002)(6506007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Wo8T3eoYz3uYY4m+ScIvNZsAKvEpa2ADBLJ2HAWRBKhWknqU7vsn70iJZcql1Q4n6dg+LfwTEvglCUCcpDT8b4giR8HEwoNK7CpBcIaO7Z6BPc9F4k2oijmd6c12HLmWD6HJGB3bbTIQJckBCmkWtktMP/dZ1L8DxQE7zVFwL/a/PH0iTcPr+gOeBfUdJM5ybfR3UO/N82sLt6lLAeYYlQaP/PEf/JswIahwMN5mHih2Zt2Ko0h9gRjj943MctKzhF5zz2zbr0IylyoJBZLQdIbjrUmXCKM/5NjkxEOXm2ZKo/vvKnVCG67FYxb8Iwv7jNh7Rl1PQN4jfaiS5foQihg3jVvBIefpVw7HgJKyEQGQV/Xu9ZzMuJZxvfWmHgQV41f7HBNaIbbeZLQeDdWSD3a8kokJGQhKr5RuhMDXTd6BDN6mR/IEsVhZ78pxxLoajw3xXVsLGpB0dAXLiOyC9tEwdPV4E+vTQbhZl810GYg=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ac82830-3999-4962-1104-08d802ebb6b0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2020 09:44:28.0244 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aJ6NWCrXM6iryhMCvPrUfKi8kars33rCzNC87DsP/R8ajp+/QWOys8ba5r1MFTpWxAIFJ8L9Rkwyx5zwP1T5bPkD2rimxGx8PnUrzMPifNs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5366
Received-SPF: pass client-ip=40.107.8.134;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 05:44:18
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 ronniesahlberg@gmail.com, codyprime@gmail.com, sw@weilnetz.de, pl@kamp.de,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

vhdx doesn't have .bdrv_co_block_status handler, so DATA|ALLOCATED is
always assumed for it in bdrv_co_block_status().
unallocated_blocks_are_zero is useless (it doesn't affect the only user
of the field: bdrv_co_block_status()), drop it.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/vhdx.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/block/vhdx.c b/block/vhdx.c
index fa9e544a5e..645dc4b4f4 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -1164,9 +1164,6 @@ static int vhdx_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
 
     bdi->cluster_size = s->block_size;
 
-    bdi->unallocated_blocks_are_zero =
-        (s->params.data_bits & VHDX_PARAMS_HAS_PARENT) == 0;
-
     return 0;
 }
 
-- 
2.18.0


