Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7967AC28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 09:28:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43E7C206DB
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 09:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="uNBsaVeH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43E7C206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWGM0-0003kX-Dc
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 05:28:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWGJU-0007sJ-2U; Wed, 06 May 2020 05:26:00 -0400
Received: from mail-eopbgr20115.outbound.protection.outlook.com
 ([40.107.2.115]:7399 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWGJT-0006M8-52; Wed, 06 May 2020 05:25:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TS34xdh6r98S+zWpYwym2m8QrI3uJKxysaE320IJA40R72sOfiQ5kw5TPIch+bExJ2pCfkSfeEB3yxTYn6HjYSYz1wcItvjMwOOmDJesTdrNeJXKKq5RT3jZRIbCXAdTTqERUI/aPOiZX8ENE0JBkwUQn1uZBc3qLRjZ6KdoJfXHFPD6qhHxSdbqoncU0spemZ3C4nKiZ2Aacq1zDDND5k3jPq6/Kn9VBQaMvaOFe8meu1JOYM6rpkvq+UzKsZZQGGfVyUGjU84nmiRrlxIMMCer8NfLQ3SsCewz2LL604Q8fmP++KjAgMN4gQ0JnI6jBkMeEgCuezlRG6i4a8fmHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhwpC8Q4GWHznTsW8gfNCsFiPmsjmwh67BhMgluksDA=;
 b=ZTFD+gxP/ycTK/Sg1s9g+hGZTV5JxAJaXFZYdM96AIz2p35MhUHp6BbMptYJQpPn9bb1NTnUe/XytZHChNRUUCAbAbj2rm9BgKUZIsuUunKabiwgVrrF6+oeTQOGuvh+IbnPLB3Z9ZKtgaXKBQSPZVCJe5NHo+nTR7FUr0apbOJwHb1Mq2DCoh+YFwC5zznKpFW+B1w6Y4/qzkiVvPfpo1k6vjgaCkhFnHtbAk1fdomyajlKhjyvb+B//f0BzQ69YzsquWHyUudTt+ae0niorFawaoCmw+6nBHylCBSuU57W/ee8v8upwEdm87u3y232DCwEWcqtThSkmoY+Olql8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhwpC8Q4GWHznTsW8gfNCsFiPmsjmwh67BhMgluksDA=;
 b=uNBsaVeH77s4OoB2NwvNuRj6NEDoMXxk2NoxR4GACLw8jQ5ykeeZfrGMemyVYqpqrQcgy7245q9rKH8NBX9/WxMa9BjMKFcAgakrcbQ9gY3l8Dom7r4o2Uxd+/QsjdnJx5Z1Qkk610q+LTSplr/yp7pgMqMIefoRyYo9AJUSqCM=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5382.eurprd08.prod.outlook.com (2603:10a6:20b:108::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28; Wed, 6 May
 2020 09:25:51 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.030; Wed, 6 May 2020
 09:25:51 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH 4/8] block/iscsi: drop unallocated_blocks_are_zero
Date: Wed,  6 May 2020 12:25:09 +0300
Message-Id: <20200506092513.20904-5-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200506092513.20904-1-vsementsov@virtuozzo.com>
References: <20200506092513.20904-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0017.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::27)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.178) by
 FRYP281CA0017.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.26 via Frontend Transport; Wed, 6 May 2020 09:25:50 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.178]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34b7a7be-9f14-49ff-f0fd-08d7f19f77db
X-MS-TrafficTypeDiagnostic: AM7PR08MB5382:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB538214EB57C69DC1ADDAFF0AC1A40@AM7PR08MB5382.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:262;
X-Forefront-PRVS: 03950F25EC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M9uv+C/hxoBjoOWDk0Aqn/I/mJ8UtYyTk3eXJNowbAKb6tOzVPETJTxSlAt9xUQc2bG0Dnk8zcHR/hNKfr1j1ODt2tjS9DfeqvzwCsBipAqQrlCwL/p+ax1nU2VzgNS1Mx9sqik6UOgXnfQn64Q11xCbAIGiqZw2lscdZOz/I5v9/BZ4oGxF7jFKaYJ7hnZ385CAP19BOzil6w4tEPgkgFDqp/Lvw2umVOooi6+1QBKiRglq+oviXqiPzIqbWE/OZzKhuv4iDbk4Nc3jV3k1/fYPx4gaxHTylfzA4EM9cqhejBSNeS6u3DOX1MzwtcSCIRJwBx87rRQkujgjGWzvPsh2NAAzH8dHhFuKKBm9de8IvxhLBXczqGNp+Lmy2B9cZfnvtkk0Qy3H6FxytFcC4hoInJiM8onCjTgEkCJ/8AON+Ir4nwGnKEfpghTuRpNzUUHbFPZe1rUXyPs1deqr1Jj6DMxFUBZDW0UmH+0I/Nt+HhIYTCsIGUSbHI2wA8V2hsQXtuXUUzO4pND0WE0zSdOEsxJQPxpGpwINF2FsgJfrgRpntIXFIMxWpAFbByKn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(136003)(396003)(39840400004)(346002)(33430700001)(6486002)(6916009)(52116002)(956004)(2616005)(6666004)(8936002)(86362001)(26005)(107886003)(2906002)(6506007)(5660300002)(36756003)(478600001)(16526019)(7416002)(69590400007)(186003)(66946007)(66476007)(33440700001)(66556008)(4326008)(4744005)(316002)(1076003)(8676002)(6512007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: KDGJiKbHyjYm5y/LRTaASqVeKv31jKMxfzPBolVdwyCJc42wFeNBiR0E8MdnMIBdQ0N4jKeMB4/iwzdzmVX80fa65paz1guwuJ77PMTY3QmaeoOOE7Vgu73gPpsEDijnldahXmfiRJyUbsO8HAo/cHF8DCrZT0LC49/oLZ6UVT1jPKQ0Xx/Tg8ASrDgvslLluOaZpha/f+ymptiJn3XCXj4CaphIP6JPFNtM8+/FY9GewFt0Um4EKlvCskSE8ci6NXM73U8EHmKxGoRQInbNgBkLoZjyB7iWgGaItP828Z0RsQG9mTEpP99R3SIs7DwdNyJgvmwCc240A4R1GQ9D19Fq0MQOX/qXhJrb9iLdXCckaYrXR40HsHKkRMYdLmANAsxD7JYlyhFPXNwPgTrVOP+9MVL7Y3sKwR+/5VNQXnrRqjPDSJ9MNapyY7E98sZODz86tI6N7e4Opas0DaZqcj8YCOxKoZ27mE+ECT4YHYrmDwLHy54f2IuK+SxCfk57f/CUevEz5rVHlRD9XIZlSoItgwDmZeVMvz2cjPFErlP52U2CswbP3Ozl78emmsamCUp8Q4OHoVHOLlhCdREhvNGASAzhl07bb6K2Zwlyfj0MBdMREDd+/zi0sorXOM9gmfNtRjLoHwsyzoWybawiicOq0pPnHMiNu3WT9CYIl64CjnMQApTt+1k/2W6fIz5MaCYG+Cc1lO/pjTJuJLtp2aM3DIfDE8R3j1/EMUOYWXF/wV0RxlRcw32u37kpg/+MJLwz0EBHLKlFDW/FFGCRsN4Jn1ACZkCcMI+0iDPK08Y=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34b7a7be-9f14-49ff-f0fd-08d7f19f77db
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2020 09:25:51.0336 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SqGzsvmsTI6heQdCtyC1FIC5aQQEz5hjns2G7UwpUBiBav0PXQe1I5PpvjKXedXW+j4Bp8Sg6Uz/33J9zRSkOYG62W5Tm7CLy3dXzx6s65A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5382
Received-SPF: pass client-ip=40.107.2.115;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 05:25:49
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

We set bdi->unallocated_blocks_are_zero = iscsilun->lbprz, but
iscsi_co_block_status doesn't return 0 in case of iscsilun->lbprz, it
returns ZERO when appropriate. So actually unallocated_blocks_are_zero
is useless. Drop it now.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/iscsi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index a8b76979d8..767e3e75fd 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -2163,7 +2163,6 @@ static int coroutine_fn iscsi_co_truncate(BlockDriverState *bs, int64_t offset,
 static int iscsi_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
 {
     IscsiLun *iscsilun = bs->opaque;
-    bdi->unallocated_blocks_are_zero = iscsilun->lbprz;
     bdi->cluster_size = iscsilun->cluster_size;
     return 0;
 }
-- 
2.21.0


