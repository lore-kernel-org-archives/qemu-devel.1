Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74BEC54FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 12:46:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2CDB20753
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 12:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="qfu2H2q+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2CDB20753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQsIE-0006zQ-R7
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 08:46:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37594)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jQsH6-0006Ih-6e
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 08:45:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jQsH4-0002KT-Fz
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 08:45:15 -0400
Received: from mail-vi1eur05on2127.outbound.protection.outlook.com
 ([40.107.21.127]:30432 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jQsH3-0002HV-NS; Tue, 21 Apr 2020 08:45:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z6Knj/xMW7+ZRYp5lIEcwiF0K5O9RMT6/l9Ly37EiifNGfbPfDeh3LR/6AgXXC4UehKrL4e0Kzlb8CtcGvMYOx6DyDrAmwHYSAM6GxUuQzVF1LRPUTN+vWGpVR0D5nAZXhoqj7BfP8gv4/nOhNU7K5hh3k8EF8hPeUIYgBnyz2w+7vqI30ifCQUkZ+csFRKjDowA7Tz//Oy2tWTBE7Sgee4hMGHGEDgXRxQX9Z4IFodcd/ZHihiAeAM7sPram+FxMszOcZqLd6DIkisw9tCDfAH+fGpM9lUQ0G4Z7I0VPD/d5o3BWRO4umkcIpUnvESkxcje7HtjiPcX746nE6qKsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mrriz1UZAu3WupYJjLeu/ksI2GWbsAY2/DV+EcgKgKI=;
 b=bPahw+lsubRakn0p43aM8els3eh+Q5B76rLRDKLD+UXLVvkigkTBKx2tL6u+LFgbDyhSwhExCgR6Ifzig8XFohWRp3YpfhIlAThDXrU1YOhrxU3PksV/8n8LNk0aUfaW4gUUQl5c9lh1AWrB6tmRgZZZxgr6nm5wFajSNuOzPszhbuanFcub6k17Zslcio9wR4d/ey9C01cICe6Y838up5AgbWPKwDRZraZMPYeZfBdG/STwjOxzBmMjj2gseypINeo3nNzi/GD01ESbwkSDsBsxw3O6D/rOE3YaLzJq+iGrIcif0BeWXP6c7z3Zm4qatm5mRuRh+t2pUj2sUAMFFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mrriz1UZAu3WupYJjLeu/ksI2GWbsAY2/DV+EcgKgKI=;
 b=qfu2H2q+v3h4oKzyMv8cyfJw3lch8+qUmSsqIdYeXY9jVu1UvuYrSuz7QJVhV96BeXu5HVwsr+B41lKf7+sNtmZKaRYboi3qq382hdlk9R43wjHphFKFq+xqU8S49HP3FPi/ohBdoGurgDJmqqvAJpVSEYcjeo2TtImcBXlmlO4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5317.eurprd08.prod.outlook.com (2603:10a6:20b:101::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.28; Tue, 21 Apr
 2020 12:45:10 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2921.027; Tue, 21 Apr 2020
 12:45:10 +0000
Subject: Re: [PATCH 5/7] qapi: add filter-node-name to block-stream
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1587407806-109784-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1587407806-109784-6-git-send-email-andrey.shinkevich@virtuozzo.com>
 <926a8377-a5dd-27c6-4532-ad28a72d56d5@virtuozzo.com>
X-Tagtoolbar-Keys: D20200421154508203
Message-ID: <68794828-2f07-c868-df17-e14e6247789e@virtuozzo.com>
Date: Tue, 21 Apr 2020 15:45:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <926a8377-a5dd-27c6-4532-ad28a72d56d5@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0076.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::17) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.142) by
 AM0PR01CA0076.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Tue, 21 Apr 2020 12:45:09 +0000
X-Tagtoolbar-Keys: D20200421154508203
X-Originating-IP: [185.215.60.142]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0e43f95-9a5b-4852-265c-08d7e5f1d3cb
X-MS-TrafficTypeDiagnostic: AM7PR08MB5317:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53170C07267202C93EE5C118C1D50@AM7PR08MB5317.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:873;
X-Forefront-PRVS: 038002787A
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(136003)(39850400004)(396003)(366004)(376002)(346002)(66476007)(66556008)(4326008)(31686004)(956004)(2616005)(8936002)(6486002)(8676002)(52116002)(5660300002)(186003)(16526019)(86362001)(107886003)(81156014)(478600001)(16576012)(2906002)(66946007)(316002)(31696002)(26005)(36756003)(4744005);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yxX0WofApJoInxoECPYCLTmoOZqHSQzpv2osoagkh2/exzLmcCVwzBc8C/IbhqY6/DEh5gFclBqRsWhBi8P5mxpE9RNFty2/IBFU4KxJ8zkOriB07y9Y34X1SirFxNmOcMLu6xd1KmXTys2AWieIRUzrs85wa0tZMIVhZPpf4/7HNcTRWjZK/jhr+bUW3F+63UoYPSQDEuwQ8hPIve64+ZhIrNwvdc9Oc6X8BjTsKHg1fhKIsco+KR9C5+Fu3Dr0H3fFsgRZLxiVA6/58g75uWiPvB8V9VnFpynaRTKI+4nxTCxFN62OAuLeOOA2tUbo9S1Qtbuau1MJTInOYWphfxyv+2Y9GHUeoVnw57YCKlDUN1z2qU/CAxHsp9txBcSFdBHXfzMdtszl9LlG8/SUGBo2MOYyL4O+qB8d769tA9l0yXI17LbHKUwbW62kN//H
X-MS-Exchange-AntiSpam-MessageData: jf/RHCOJLay0Ohh2mlD5VZJGnGRqF9quG4cBiysxBJxD2RvrjeRLGJPAFFfKYbxgrj7GqtlIzV5PLECRUniVW9IFgSkHH8j9cNywA3fXc3y3ebyMEoMrecpPWhZBSGjgUmt2JQlj1BUnUxpVk0yV2Q==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0e43f95-9a5b-4852-265c-08d7e5f1d3cb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2020 12:45:10.0146 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GioJ0DTGyWo7CLr9Bp0MPxmXLNVZUIszeDT/85fIZ4K+HaKWB4bRKT4VKpSo2/+LDS81yKXVOypTNsk9t9NyXHX1HCa1F0HThwQ8Gpo6+sc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5317
Received-SPF: pass client-ip=40.107.21.127;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 08:45:10
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.21.127
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
Cc: kwolf@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org, den@openvz.org,
 mreitz@redhat.com, jsnow@redhat.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

21.04.2020 15:40, Vladimir Sementsov-Ogievskiy wrote:
> 20.04.2020 21:36, Andrey Shinkevich wrote:
>> Provide the possibility to pass the 'filter-node-name' parameter to the
>> block-stream job as it is done for the commit block job.
> 
> So, you add it, but it actually do nothing for now. I'd prefer to make this patch the last one, so it actually make the change.
> 

Ah, I see, you need it, to fix iotests.. And otherwise we'll have to merge it into 7/7. Hmm. OK than, but note in a commit message
that actual change is in further patch.



-- 
Best regards,
Vladimir

