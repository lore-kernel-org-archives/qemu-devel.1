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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B25C433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 19:06:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5E3D2098B
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 19:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="rQDn5AJf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5E3D2098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDuYl-00036q-Vt
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 15:06:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kDuW8-0007kI-Iu; Thu, 03 Sep 2020 15:03:28 -0400
Received: from mail-eopbgr20133.outbound.protection.outlook.com
 ([40.107.2.133]:10118 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kDuW7-0006yx-42; Thu, 03 Sep 2020 15:03:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WeWP2aSEMQyczpJ7CNYehl1WMp4McqKq4ypg5rrWxaLI+emCYp4AO9y2uWu2QxWVCbcbg4TUHQzQm6HMokkBLAlKFWjljZihjlvp86Pm2zhYXPHxP+y46rMGh37K6v/TwbEFjtPBP53FzkCTYlmMeNURTbEu27Kjp7VKjdtwa4sCGn9f3IRCatRPo30oxEn6jWnQLBoK4USyKYKYVv0aFlMqGXQIJ0soRJzzbDoD8btglPBurtR8xvMjbeoyTaDbzzBxS/EXxi9A9WH+SjkiWk+RqcDSgYPfcmiO2nc58NVbTzWHpJSKSCe20l42Nm+YNU3Kjq2eZte2qYk3jmQQ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FqXCMMp9dondScYl30U2gRZUl30Lwzr8H7dVnXO5HNE=;
 b=WWJbqph5bXGTNFGk8pLEsWHRxL7dUNx8T4434V9miwMY6sObVMYhWZdbqmXsnTilA2Rta6Sf2zgVaoufiJFEnOhUf46muQgId1yX+4It1tIDgCCGAZkw4xlO7HcyCf5vNfa2GkP/y615tdKtzVLdhAXZhLGgMFS5HwTwW/ThoDfa6QoW28ucivMm54pzpssdvW6+udkELGYV4gxyB06aiUC/0yjeQDx6/IGL1N4wc1MoYBdTrZvBRH5DlsSvpIeEMeAuZuNEzEfkAszscOoRu4e63UWTa8ZMdQqcIViCrqj0Jld5BTwKgqjwzSLa9tXlInnVNwvnKb49CGGoSKZ4Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FqXCMMp9dondScYl30U2gRZUl30Lwzr8H7dVnXO5HNE=;
 b=rQDn5AJfr2t2isoDN66pe3lUppvwnNreEAj0XxL5a1TETi47Eujcqn+Kdj7Zm5FUda87ydU/qzqrlkR5xUlypRGbU9MWtwXpbFAoqfqBGcr+278VNy6UKuOIkkJ9dI4hMifJWRb6395o2GcxhelaaaEQH98S2q3IUuayv5L0Sks=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3159.eurprd08.prod.outlook.com (2603:10a6:209:46::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Thu, 3 Sep
 2020 19:03:17 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%7]) with mapi id 15.20.3348.015; Thu, 3 Sep 2020
 19:03:17 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org
Subject: [PATCH 2/4] block/nbd: correctly use qio_channel_detach_aio_context
 when needed
Date: Thu,  3 Sep 2020 22:02:59 +0300
Message-Id: <20200903190301.367620-3-vsementsov@virtuozzo.com>
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
 15.20.3348.15 via Frontend Transport; Thu, 3 Sep 2020 19:03:16 +0000
X-Mailer: git-send-email 2.18.0
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bcead24e-d78c-42eb-b7fc-08d8503c0420
X-MS-TrafficTypeDiagnostic: AM6PR08MB3159:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB31593C1073D62C9C0C522603C12C0@AM6PR08MB3159.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:350;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vrhs3FOfbe+t/RKeBWraaZnVKHZk7UkJQeKE8GFDvKENcg7Bg3I2S8mPo4q3oxV97H/Pt8MrZdnnWNWLSq4kCwh/heU/SR55sPCo4EdGp6A+lgqAUOyRKEV17A/30GQUFX4pAUK9hJHNuulwL78MourTnQ91lNWTHQd1lZFDauLqSoCfUlTS4CFWBFO6xFPgZ+ILEJjBob6tpykTUu/0jnqRMfDMFV6AcKJncyzUy7esItOzzLdRqmLmEwFgmkfiACNBl94ZJAT94QW1cqIYCdb7jzMynYvphUVBC7Ixwiw2+Qg9syTsZXg6XJWVxXrUfF8u7ZlD/1SdoVTuMZff8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(376002)(39850400004)(366004)(186003)(6916009)(8936002)(2616005)(6486002)(66476007)(8676002)(2906002)(956004)(66556008)(66946007)(478600001)(107886003)(86362001)(1076003)(316002)(26005)(36756003)(4326008)(52116002)(5660300002)(83380400001)(6666004)(16576012);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: YzQjwygy54Wfd2nDSVl4dqt5nYVs1jxOZm/m8L6VADwGa8Lg7ipJb+wNSQYT+3cYr4CpizOKc/otG9TqrbIXDEqfLiyWwwskLaheModt/xtp7pEJQ9B9fOXuxeRsjHk1NmBFqESUpnEt/w0fXz3zThLsV07StBJJEeuLPJ21jmkpTr64C6ikOhAvZkvKGgDpraJcGHaKP6KhOfx84+37LpEJl7jgW1UjBgY8yzrevfA/NaS/jGbCdKtsjdawkKKHEDEG29xfVblE7tTaSEozbDQSEI5SN5iWi5smYcXlDVTQUCGaiJ4yLUfBRK3adXGhfblVPN23vOr26L+7ZAn5cYB9CQEVTSDQzNA0Z763KAiNyp5nJiLgUybOJw3XsEan32o2d606i9nl4TDkqpblSMOBIp/kYUrysgRhw+uryr4RzG+jMlJJFvR00po1uP08pDTC6Lqw96ypxaMcUpvZxtMI4EzhSo4/BhfbhY3qYI1/VpTO6fcLOv9o8v2sFz0BzaPxIdDfh+apovveNfNmFYGAgtTrFR/L2jupfx0RhBeVEIuRJNh5zmk4hw4GPIptcz/BRST9I8Wm/BCCyKBrwOPYzkgnPmc9Fr6Rw8sFZJj8fj03tk4HYIdfUw1kgOKdiozV9tN464DkQeRSj3CZqg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcead24e-d78c-42eb-b7fc-08d8503c0420
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 19:03:17.2011 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TF2ZYAwpGAhAnc+XwnsZI/qH5BYZEQBSL75ooFVTBGHvczbkxYjL4a0O0XtYU7Pc5CfLp5tVHk1ZWoM3RoisBYL3lYjRenFDdX3XpJjwj50=
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

Don't use nbd_client_detach_aio_context() driver handler where we want
to finalize the connection. We should directly use
qio_channel_detach_aio_context() in such cases. Driver handler may (and
will) contain another things, unrelated to the qio channel.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/nbd.c b/block/nbd.c
index 912ea27be7..a495ad7ddf 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -549,7 +549,7 @@ static coroutine_fn void nbd_reconnect_attempt(BDRVNBDState *s)
 
     /* Finalize previous connection if any */
     if (s->ioc) {
-        nbd_client_detach_aio_context(s->bs);
+        qio_channel_detach_aio_context(QIO_CHANNEL(s->ioc));
         object_unref(OBJECT(s->sioc));
         s->sioc = NULL;
         object_unref(OBJECT(s->ioc));
@@ -707,7 +707,7 @@ static coroutine_fn void nbd_connection_entry(void *opaque)
 
     s->connection_co = NULL;
     if (s->ioc) {
-        nbd_client_detach_aio_context(s->bs);
+        qio_channel_detach_aio_context(QIO_CHANNEL(s->ioc));
         object_unref(OBJECT(s->sioc));
         s->sioc = NULL;
         object_unref(OBJECT(s->ioc));
-- 
2.18.0


