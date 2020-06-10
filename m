Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A545AC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 18:24:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7835D20656
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 18:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="rMNVRXtG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7835D20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj5Oo-00040b-JL
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 14:24:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48202)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jj5Nm-00021Y-6V; Wed, 10 Jun 2020 14:23:26 -0400
Received: from mail-eopbgr30109.outbound.protection.outlook.com
 ([40.107.3.109]:7846 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jj5Nl-0006OY-I5; Wed, 10 Jun 2020 14:23:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DmaQjcKSK7LzfcbLZNVMFOYy8sBrwn/I7Gej9Xy/3EDvVRH1IWUleshew8SwqESTIzu8dwlWAgjyirjIkzizvfA5lgEFdUXwRtM8uOyrcMBmYtBYJrN3wMu0rg5PwYHq+F/08Aqg4Mb5F0mmsYYg1WvqLecV2bs8VkGt8jAxYzQexIWVlgAaG5iVNVDDL5zC2AYh2+zIZZQ83+iRY+YKLY5ftxZYLx5U11ed+MyP/TgHLixN8lxiOoMQFiVXXtpBUs8MmojbTSN13SL4KMXB/y/GGxty2wPntFhQW7klR6qnoqV5a5xlMsAf/LAqKo9YOaXsRDo5Au6ujOlhJS3OdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0xrQeysTFjb+GCyru1t/kK/l7QxTARdCZVDvohnjes=;
 b=T/m5TExMPXh8Y+2VDWgJAApKhfv/KqmlEiPltGyApalRxW2FR6cAWhW6FgjUEdqsKMJkW+bornDnsoyTRqjuUXodcy6oh1BWKcVDho925JyjnUHRiraHuyFRgTUJI3ObRxSy29kckHyD+E2pTLc7ZDXMitTNetJZ3MhMkcerwX6Gv+xudbwA9Re0/lCsCLuJ1YCsJZPNudpw7Qp6L0RiNJZO3wJ/rNrrt8zPgOKsn1xrU9lPMVKexIbC/S6AAIj1k7+D8lz1fByogPjxYu89goXoMc49W/8X60sA2OnSprAhGXH+YHoy0Epr2NNwf+Npr6+4D+J866TbM/6Btuj1vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0xrQeysTFjb+GCyru1t/kK/l7QxTARdCZVDvohnjes=;
 b=rMNVRXtGXAbqYrPjYxWiLCRla1mYeWxfPtJeXRPnHvwypHkPJHJv1q6V1VA9aqq5CDrLyl5qiHD8eebHczVbgYpWY/3FZJOqVJ7hV0ktDbDyEpl2px72k6x3FC2Vqn2dWlFcYpPHmkZC2wpq4H+XjAkN52lcpgtwaRUpvtnAASU=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5350.eurprd08.prod.outlook.com (2603:10a6:20b:101::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Wed, 10 Jun
 2020 18:23:20 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.023; Wed, 10 Jun 2020
 18:23:20 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 2/4] block/nbd: define new max_write_zero_fast limit
Date: Wed, 10 Jun 2020 21:23:03 +0300
Message-Id: <20200610182305.3462-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200610182305.3462-1-vsementsov@virtuozzo.com>
References: <20200610182305.3462-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR06CA0138.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::43) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.166) by
 AM0PR06CA0138.eurprd06.prod.outlook.com (2603:10a6:208:ab::43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.21 via Frontend Transport; Wed, 10 Jun 2020 18:23:19 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.166]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1eebd316-b5dc-4e0e-fe2d-08d80d6b5a23
X-MS-TrafficTypeDiagnostic: AM7PR08MB5350:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53500F3ACC965BBBC4101D00C1830@AM7PR08MB5350.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:206;
X-Forefront-PRVS: 0430FA5CB7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jko31KdaU8DaFXWD5EMwWfi2Z1hzLzQ9BaNAsGDiYgjKtiVn0wOSvSvOi7ExFMoWzlJhrxhYnAF2/v1AzgNnDChyHv8rGFhO20oQ8jTSx0wsB3GiSk0qLYZWGEcn1ugyIx5encftyIrcoSWdK6urzDv5Kl2/F5b1CqB4QaGOvhojPprubDIAXVTB5RylHFqhkX4kWjUsGG8kmD/mJhK70mHxnedvCx17KHpGPH41Vjtujx2Rlklhl7LCtefdB0pejyn3sMGtUudJFacqWus2y/bbuCDrMMnfNg0XdI7fwVufZm///4uVhEMFS/QLcBnu55+WJtnRWNlA4k4XEZhmRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(136003)(346002)(39850400004)(396003)(366004)(1076003)(4744005)(956004)(8676002)(52116002)(8936002)(83380400001)(86362001)(4326008)(2616005)(478600001)(107886003)(6512007)(316002)(186003)(5660300002)(26005)(66946007)(2906002)(66556008)(16526019)(66476007)(6666004)(36756003)(6916009)(6506007)(6486002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: D+mjseAnGIoSFqbNrg4mcRznKd6S0xHSXTlSgfzZuxjjygBhGPZFcd9udGFjXJwnawCouTQrVvrw109RGeU8t4JB2KGsmO/hmCGGScmV0A6E9Qw74DoDFo43lXjQI2DOd6cnRLahGN+7nJ6m8MKPC0qelltOkcfqLGPomEz7FsXCdzQtEFTQE31zlpoQk7HxHQkCTcgIZOejEjXQhM8CcxIOaK6X+b4kjZAkCNFEc+bOY46xAL2fkgj3yyH1oIkZKSCvAE+ZP6H4/vACIj3YY7B7+v/3K3foRkQeAPuFk+KT4Wt1ybDGIZ0j7tipiQhqxe7DAyPmzls60nE9c86DPwIDKPMS8n+cB7vOnHg5fpAeyD5SE+IdCwsRBBWwHwEVh7KKC3bMC82C0GufRFx5t43fYjcq+POqlcDuv2aI6skIPp4kxIdTKOq3TPTT9+QlkjsXSeDnHoJ04zwiHoMIdn34VfOe495f/Ex2Q2IHzJlgSIc0+X2wbr6p6UbTJZRh
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eebd316-b5dc-4e0e-fe2d-08d80d6b5a23
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2020 18:23:19.9876 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1CzrBhXStu9n4mGqXpkTrqPwfnv79r8sYF9KusU1y5uZMEM1Xx9dLe8NMoKsSVAWU2YG3NtpFAjgAHtJXuiV5roYrmaxyi4iSZdBfyUfb5k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5350
Received-SPF: pass client-ip=40.107.3.109;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 14:23:19
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The NBD spec was recently updated to clarify that max_block doesn't
relate to NBD_CMD_WRITE_ZEROES with NBD_CMD_FLAG_FAST_ZERO (which
mirrors Qemu flag BDRV_REQ_NO_FALLBACK).

bs->bl.max_write_zero_fast is zero by default which means using
max_pwrite_zeroes. Update nbd driver to allow larger requests with
BDRV_REQ_NO_FALLBACK.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/nbd.c b/block/nbd.c
index 4ac23c8f62..b0584cf68d 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -1956,6 +1956,7 @@ static void nbd_refresh_limits(BlockDriverState *bs, Error **errp)
 
     bs->bl.request_alignment = min;
     bs->bl.max_pdiscard = QEMU_ALIGN_DOWN(INT_MAX, min);
+    bs->bl.max_pwrite_zeroes_fast = bs->bl.max_pdiscard;
     bs->bl.max_pwrite_zeroes = max;
     bs->bl.max_transfer = max;
 
-- 
2.21.0


