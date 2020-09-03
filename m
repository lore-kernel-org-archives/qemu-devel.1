Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16A9C433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 19:04:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 844942098B
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 19:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="aSc9D5wR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 844942098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDuXK-0001Zh-Mn
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 15:04:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kDuW7-0007ha-7l; Thu, 03 Sep 2020 15:03:27 -0400
Received: from mail-eopbgr80109.outbound.protection.outlook.com
 ([40.107.8.109]:33862 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kDuW3-0006yc-PA; Thu, 03 Sep 2020 15:03:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ko/kUHPmm52KO0T7r50mjO1OsFROuAKwhTMeKCRVyesD/N2q+F8iSDMUCQJ/dQzeKtWjBUK/bJWt7Ut4OxoOMsdyhk//RJYuzL2Lhr8Tpbxr6k54b98INqgVFj2tKdLq0ORssqMQs6m4bQ7ydhSlUTTM0iRlVEWT+xT3nW9JNfAsOh1yFvWJzRn4a9xizjxrtm/W/QYTWZV36si2e4uWt4XqXc7NVllnn27Gnr6UMpkrqK/C5tfM95Ipl4kCKYulErhU6FuL5xoKGo+jcq3JYCRdvWDflJiOQeHGpvElg8VSBg5no3FyefGseJg0soX6Fi95TfdT+WPi/ZJF3kSLjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdDDpw91rnA5YzULmVUfZNReC0Rokb/Vq8ognO3CxZQ=;
 b=OvLyMJJwF7oVRSwNC3c9SWJjPzv65xF9AtXgsvdOlOv2SBnfIo8OofCqzN4q5bmxHo4HFT0zLCTUX6YP0TOlsBYIAX8aXPXZyU5LtLAQszw9U/XHKq1tg/+3XKNCdT9F0NHV7IntSniejI0prusIVjZqiSAogIHBOO9Z5Q/aFHw+PLnDy4W6DRVscKVdf2LEq3iBXmhBNN+PhyVt2DOs4/yLZViakcsQBd298Aiu2r+VV02B6oQ6Zs0pekn1DzsRuA/9pBndLjKWf0y60C17vijAQcfmNl8JSNiAy/JfR3Zp007U3rwP2JatrJiropVllG2PZISEs02LvJbKKNQndg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdDDpw91rnA5YzULmVUfZNReC0Rokb/Vq8ognO3CxZQ=;
 b=aSc9D5wRA1kxyVdLl7SRmA2JkH4YNTU7ImOESV3R1lMLcPXq8AB232bt+QbOGGMADdnIiBoG/j8nirw6HZ1Vac8xj0pMEMGB7DT01TuBnOzs5NaHjwIi09TdmytqAkmgytlToruD0dM2t2L17J94t5dSXVjU6Ra6CJ1fHyD8xnM=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4214.eurprd08.prod.outlook.com (2603:10a6:20b:8d::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Thu, 3 Sep
 2020 19:03:15 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%7]) with mapi id 15.20.3348.015; Thu, 3 Sep 2020
 19:03:15 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org
Subject: [PATCH 0/4] nbd reconnect new fixes
Date: Thu,  3 Sep 2020 22:02:57 +0300
Message-Id: <20200903190301.367620-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
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
X-MS-Office365-Filtering-Correlation-Id: 189bb739-a8ff-4e10-09c9-08d8503c032d
X-MS-TrafficTypeDiagnostic: AM6PR08MB4214:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4214617662C868E4A24A72B6C12C0@AM6PR08MB4214.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DLCyU6sy5DZawbuTFV5JoU68XNPSRbJQ0HP2ekhQItAGymZRBC6yp8bWaQachiw2dpalem6MGTXw0+LAIt8kkbhiCD+SGt511bcHhzPEF9tJUgd9EDoW5h96C/Nwnuar+vd179soLJ6okqSr/5B39ooRoZN/ZIZtDiT64SXir6IhC0C688VI5uz934Vn/aW9N0A9+EsGHcPzKPW8LYci718O+2dygSxEujKEBfXgZ6wC8f7Bohl17UMThm0eZyVjNfLjXrV5eeln+Lm6Sgb1NPhKk9mDnsQRxi48iwd4Ql1vvgbVN4grVIdraJvulgGdEO6jk4PDmYa3Hd+gNO5Dcw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(396003)(39850400004)(376002)(136003)(16576012)(316002)(4326008)(6486002)(86362001)(36756003)(2616005)(186003)(6916009)(107886003)(66946007)(66556008)(6666004)(956004)(8936002)(52116002)(4744005)(478600001)(83380400001)(2906002)(66476007)(5660300002)(8676002)(1076003)(26005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: feAB7nQZ+o9ZbFzVPWScwn1E5sJFTctBOZrtBazFj0/BL9GhrzBI9xJoJHyF0oUoZb/R8XUXUVbrCzqITT4vQXMsCZdijg3Gic/ql2zCpV7p4o0f4boycgdpZIELXHhbzB7tQS7r0Nz2kmV0PSAkjTTnYT3QGMr7TEynnvs6DMQcGqO+dS+ox6j1brvGZD/iGiVZ3Ydlx6plvfLiexeMMcafGXzRt2cbgHAJ9yn6S6js3FYvGqugpSh70KSBfYpD7AGPh3h9WwigI2bsb5PkVvQ4DfedFgtXLY6hmzUMjhpjMnCpu3ReSXtG9uJXHF+5rQA5i/WBPr2b2G22bFcj2tCexlTDyIRlvihXG3OgnBTONgdelwXQmf8MgBu2PNVvAkaNvMgfF2U14yBLuuQNQI2HnF3TFs17B6rQDYyTEe01q+3kvUcNzibh+aYAzMzR6xUZ0REpltG/ssEIbMxmvQJ2uYg5QIfpONRZ9ne/P1EsR6JGvsXsRevwVCxNhq0MNpUaRsf5GuymoHosknSvVaXSM6LdbRTUyw6N0e+kbxqd81feif6nL/K9kQOSuR76HpwDCrq/EBi6/Xwez89fnhv0g2XXWOsesBccUtiv8giDJAmmj//b4/4K0vkp/CQErVNQVafWVGYln//9ext7eA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 189bb739-a8ff-4e10-09c9-08d8503c032d
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 19:03:15.6738 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ym/RbLHOIFlCs5f/tc0bTvxBILoiucPskYdenwZ4s5WtVJETEP9Tav4Lb5m3aY+BX3BzoOqXMnzYEq2Jk1THuDCOAcTBemPd9FLlieW4/Kc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4214
Received-SPF: pass client-ip=40.107.8.109;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 15:03:16
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_ILLEGAL_IP=1.3, RCVD_IN_DNSWL_LOW=-0.7,
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

Hi! Let's continue fixing nbd reconnect feature.

These series is based on "[PULL 0/6] NBD patches for 2020-09-02"
Based-on: <20200902215400.2673028-1-eblake@redhat.com>

Vladimir Sementsov-Ogievskiy (4):
  block/nbd: fix drain dead-lock because of nbd reconnect-delay
  block/nbd: correctly use qio_channel_detach_aio_context when needed
  block/nbd: fix reconnect-delay
  block/nbd: nbd_co_reconnect_loop(): don't connect if drained

 block/nbd.c | 71 ++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 60 insertions(+), 11 deletions(-)

-- 
2.18.0


