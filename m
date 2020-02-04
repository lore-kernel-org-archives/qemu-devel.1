Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8F4C2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 10:10:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A8C224125
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 10:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="qx6PpGxw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A8C224125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyvAI-0002Px-B3
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 05:10:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57757)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iyuum-0000t8-Kc
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:54:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iyuul-00038Q-Q0
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:54:40 -0500
Received: from mail-eopbgr150097.outbound.protection.outlook.com
 ([40.107.15.97]:43492 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iyuul-00036q-K9; Tue, 04 Feb 2020 04:54:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g5YmrY5ywhSGxuouBYViXJVCVogqZX41jYQuRlEHWn12vme9+OzKnp6kCVWntst/WMHCWFv7G6N3cE6dJoE1Y5UYRnsnG8HvG2XiruqqRaYA/0Y8yxM6ISqlNlwqyDw8NecrX+Rix2qnng66dWuAt/2r8T4L1UAl1WBV8Ejnlt3t/08RPlr5cZc/Lvvwb5xCcaZd5USNAi8tziBl4LrbubpqEwdHMLdBKOQ3y9e6h5gVeFUUYgtOSJNRi8hzaCjj/PmhZqYNGis0BzHJ3Bd+JDbHqHhy/3ckPTyvo+r/m6GAQgZGzWsydT1RNYuScgOTwZUnCybV8R/rbPj/pWGn9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJW35SjyvW42Knwi5eJtnrwioDM049QSmgqr+5n0Vpc=;
 b=I2dcxly5/g0CTWj3H+Ji67iydqX0AvxvyMgf8ugCdMlJyBgHK0Fuzy/SWIt5wnVa5EDemqpGR84kHLnt9MR4DTDsZaEUitid+vTtQjfMU8jNazLsv490llnEcZPEtMvTaDJR4BNi7W2IsqFJ/fyNeTp2XzGk5uopE+s0PgW5QVOTX5etROOaD3/sN5DrEZg6iOz4wUCjTvUizYr+67GPG2yGyBez6DSRGTkLPgfSoVyvpL6LKYum51kzk87e8ZSQHKOx3qj0kYyGbLpW5N2LM+lKjQWFecVotPrPH/mPXWfyTLyKsvk+YjLHaSOh0vUf3W22VGVI3rFXlMx+ucE/3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJW35SjyvW42Knwi5eJtnrwioDM049QSmgqr+5n0Vpc=;
 b=qx6PpGxwbeBE4GJa930b7kwm62naNvou86yeudb5msu6zIKNcylBwHjYO5SgdSnTsZZRz+JS2lTA/i6oeIZCYWPFkeySsU6dBGv+ipzC/w/nbPQJVLMnkwRgWb83ER98HQz8n1fGr9GP1B81njDdIetC+ejR/O3tb4szbcFQ33s=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3461.eurprd08.prod.outlook.com (20.177.113.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.30; Tue, 4 Feb 2020 09:54:35 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2686.034; Tue, 4 Feb 2020
 09:54:35 +0000
Subject: Re: [PATCH v3 18/21] iotests: Resolve TODOs in 041
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200130214431.333510-1-mreitz@redhat.com>
 <20200130214431.333510-19-mreitz@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200204125433545
Message-ID: <c176453c-3c34-e7cc-f48e-7eac0646240e@virtuozzo.com>
Date: Tue, 4 Feb 2020 12:54:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200130214431.333510-19-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0701CA0082.eurprd07.prod.outlook.com
 (2603:10a6:3:64::26) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR0701CA0082.eurprd07.prod.outlook.com (2603:10a6:3:64::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.12 via Frontend Transport; Tue, 4 Feb 2020 09:54:35 +0000
X-Tagtoolbar-Keys: D20200204125433545
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aacc9e0c-e151-4a6d-b362-08d7a9583dc1
X-MS-TrafficTypeDiagnostic: AM6PR08MB3461:
X-Microsoft-Antispam-PRVS: <AM6PR08MB3461DE68ECC7501E283E77B7C1030@AM6PR08MB3461.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:400;
X-Forefront-PRVS: 03030B9493
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(136003)(39850400004)(376002)(346002)(396003)(366004)(199004)(189003)(52116002)(31696002)(36756003)(86362001)(81156014)(316002)(16576012)(6486002)(31686004)(81166006)(8676002)(8936002)(16526019)(558084003)(186003)(26005)(2616005)(5660300002)(4326008)(2906002)(66556008)(956004)(478600001)(66476007)(66946007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3461;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6XDn68D1Bn3ccHiyo449aS28vATpeIv3FJhuhugqH0OT8pbnZAJCXDmJwD6CFjiRD/yvTpKTLfVdzPGL3CxilkW4FQcmbU0sudCurPOsGnS+241CrP31wlauiNSdjEmMD8gxO5QoSf5tezMl++XEJobb/XoUiDsjGU5SVsyFTt4RyfZDgYpRXyf/roGIBaOlRsgPX4E1gRUW2mSqhUnJM761IpRAs4mOx8aG+XawREgI9SAkAt2uyegsaB/2oPFJgq8PxrAeyu2wWC1eoQeEQoQbtD0j+mek3iIeT7kGcFAMqsd2w+8TdBYxUW/pNW0hoKI4IXH4+R4szCKSLuYRKoWxXW7DLaJaLk4VupDB33SN539C5A0gbKccYz/ki6OzZRqZA08dL84E2eKSRhYEBE2IN328TJXScOwfi5vq8plGsxm+/gofKaZeO9uIFa/m
X-MS-Exchange-AntiSpam-MessageData: CATVGvvyKLatTXZFKGs/joFtnLXjmzvZd2m2YZsUCpBE78d1VfNdZSO8PvyGyDF9J5auWJP0aaXeoHmfW8yQvegwZOCWLqpVxj+fu5kfI/+CbB93eI5ja7TU/JPtN8suUSmFqiYM1jU1qIlLhj3Yog==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aacc9e0c-e151-4a6d-b362-08d7a9583dc1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2020 09:54:35.6204 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kHIDikrKZIy7f6+XnM3pfbO5sGvKcBhFfgWtnORk1EdMv0x/XalSxcwWb8rxj1+asSEmRR2PhfKFbhqQfhlhaAy3NTwb70z0mUSMYliuewk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3461
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.97
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

31.01.2020 0:44, Max Reitz wrote:
> Signed-off-by: Max Reitz<mreitz@redhat.com>


Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

