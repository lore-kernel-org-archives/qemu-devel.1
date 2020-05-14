Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094FFC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 17:17:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7A39206D8
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 17:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="R6Fv9nLI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7A39206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZHTq-0006eI-TO
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 13:17:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39124)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jZHSy-00067x-QS; Thu, 14 May 2020 13:16:16 -0400
Received: from mail-eopbgr70125.outbound.protection.outlook.com
 ([40.107.7.125]:38166 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jZHSv-00032B-2G; Thu, 14 May 2020 13:16:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gx+r+2JgANXRcRmdr8bvvgM42amBfHx9DJTRR2BvBY4LzdbHHJoWymQM+/4q9KNB/0RZkSXURFdaM4QDQRqoBzK8/p5e8egmEB2pkzUg/d6Ti3r7hqIU6acYOZo5wR6yhwA6rIMZiaZQOjXlGJESo2R1PoDDdMtmOY/1qh3bbSOTxaGKW38jHN6RHgQZJGzXZR6youATL39e+vOKoniavIqg6J96ngj0bjVYn1RilBC9UmMLuBYQ6PIHYHCuBjzWMqgs/5stQE36nx10x02f8T8kOHlFUxMdbDKclLO9ruyQB1G6acbDcE+CaX7SUm20XT2ooRcUTCmQkH82+TrV/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y13i9qvT/i9pY+jdRILyUYY01ryysN04Wg62vQp2dpc=;
 b=hB8yAzsczcK1ijnDp69pJKzUePT0kIJyEQzWKKHKwojI74Bt35XrTZC1TqA7ZiyJ6n1OJcmk4AeHkGwUrBZKYGaggQj7S3ldqljctnubyPGsFtK2jDPGbqooj+cmenHDNxnzaKx6IJK4KJIPFCFWxV48/t6STfKyo8IAg7X6R6zURnofdyLifT92F9pEQdRrBcKyO+1/LB49EyHA697U/IhtOakmklXea5+p8JQQWeB5h9WXtnDwNelr3pbO+k4WqZ2btOw3fpxQp/K+Yyj7MjpMzPFjQ0IznG7YmrUZEdj1U12yjMUswPRaIJdHCgUAg0srOg4WtSotTk+XzEFUaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y13i9qvT/i9pY+jdRILyUYY01ryysN04Wg62vQp2dpc=;
 b=R6Fv9nLI5hdcJ51cU9Rvc19MyIs7rGT47TG98BP6/CHwld4VwKY/Ubl07RJ098ghMXG25LwcdfzC2OUmzn/yFNIAohi9LJ+P+gkqWU6gsBb55jek4Igr+7ESetg0LkHTeotxC+UddMJ5fU6B2sW2IRlAYLjK1stlqfsT9XvXGKE=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5526.eurprd08.prod.outlook.com (2603:10a6:20b:108::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Thu, 14 May
 2020 17:16:09 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.3000.016; Thu, 14 May 2020
 17:16:09 +0000
Subject: Re: [PATCH] bitmaps: Add myself as maintainer
To: Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org
References: <20200513141407.185198-1-eblake@redhat.com>
 <55059458-923c-505c-d16b-89ff3334c3c5@redhat.com>
 <30070988-e0da-00f2-3780-d4fae816b589@virtuozzo.com>
 <ad142f8d-8d10-1909-c1d4-7ca8441ab3ba@redhat.com>
 <962f8c29-6b42-ea7c-cdf9-ad63288da955@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <9c438f6e-ce63-25c6-72fa-c82732221e00@virtuozzo.com>
Date: Thu, 14 May 2020 20:16:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <962f8c29-6b42-ea7c-cdf9-ad63288da955@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR07CA0033.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::46) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.186) by
 AM0PR07CA0033.eurprd07.prod.outlook.com (2603:10a6:208:ac::46) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.12 via Frontend Transport; Thu, 14 May 2020 17:16:09 +0000
X-Originating-IP: [185.215.60.186]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2bf4efe2-e2d0-40d7-6028-08d7f82a7ebd
X-MS-TrafficTypeDiagnostic: AM7PR08MB5526:
X-Microsoft-Antispam-PRVS: <AM7PR08MB5526A1A1FC520E87CE461EB2C1BC0@AM7PR08MB5526.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 040359335D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HPl48PBZIO/SzM7VLW8mSUWt1Hihd5b16qokGK3Cdf15BauD41Yr/SYWSeCkbYGJ7CMCUBJsXik5xTFeUBz7bGAVbtpgwvDzv0UyYVMa+Oa5Te3/wAdyjQrluIkaK1WZyb+rEJsSJTaieGlxj/viYyUdob4029JCmhI8+JYn27oxRwGNoQMsaTT1OraLg03XOv+C3p4TkY2c1sCjxi/DXthtlMWV4SajD56Lx88snMiOK/cskwSUVhOBXNvgiS2p5ccFzvfqnSl3EqdmQE50NR3HfypUOnqQGArCgL8TMpieVv43yNQd3RZZpxcRGAiQMZxAypWcF2TfTpv28sdx03UJ7oIfnNaSH8Sqr7gUlz/GtqEFNYGmibjM5VyTbXVCOwQx3fHZiT5+xnYDkP5M/TZWKbaxyxUvjdqzbEG2gyEwRoe1O2p05cVx7zmqaWUaSTCsLctnBKq+d6xnhLyP8HNxCYwXIK1MgLLMm+4xdB+dLpQlqjPgBij0nEcpH6aD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(396003)(136003)(366004)(39840400004)(36756003)(186003)(478600001)(6486002)(16526019)(31696002)(5660300002)(16576012)(66476007)(52116002)(86362001)(956004)(53546011)(8936002)(8676002)(4326008)(110136005)(316002)(66946007)(66556008)(31686004)(2906002)(26005)(2616005)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: VegzB+JF2/E4ROg/x2svkV9Re3NzBG2JoG3W4U0AkpfCSeyByuup7aAUB9gffgybVGBJsSxb2dftf94dGr9N1IV64DINQbBB0sYGGuhoIvXbIzfArA9K5t2ui1V0E7CyHh/fKtuAd6EXLOjGHus4afZc1T/QAH8vEoOHVpPy0nGOOP4u5CQWjyBBYuCZ8rZRFfU1ZXRYAYpVeUHyFR8BY1FD0zPBTKuJOCnorfdXreXSCZhm8nJDV9IjFkrerVgPJI7oRrKYQs5bx8xAFzek6Ulr4z82VutKKoz86KPt/kmoILbvsB9TqlLq+uOrnR+ODD1fmfV1lLSNhBEA4cm4/YYCx17Hk6caQ42aIrViKclD0dop8CKkUQsL6O4DGW9uGZsg0sY+HWWMVKX79jVE4MqLV3LvmOV++EjVyavTHC3xV/6QHBdlydMtCWJY9ubyXqCQkP62Yw3ObFkuSeHWVsqJ4UvvkVoXwcv/gZHWXdFlMrBC39B7gT5W61DfvvEC
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bf4efe2-e2d0-40d7-6028-08d7f82a7ebd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 17:16:09.6074 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZdWXQJBBjW0g7a1B5fZwJLR9cz4QRmQyWh+HkfSVdw4+7vRFrKpKGtO26dLEdPgY3y9Yl/cnO8FWyWvSMMa0ld6pSpNEogBX5T2RxOd//tc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5526
Received-SPF: pass client-ip=40.107.7.125;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 13:16:10
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
Cc: qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

14.05.2020 16:52, Eric Blake wrote:
> On 5/14/20 12:08 AM, John Snow wrote:
>>
>>
>> On 5/14/20 12:49 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> 13.05.2020 23:24, John Snow wrote:
>>>>
>>>>
>>>> On 5/13/20 10:14 AM, Eric Blake wrote:
>>>>> Dirty bitmaps are important to incremental backups, including exposure
>>>>> over NBD where I'm already maintainer.  Also, I'm aware that lately I
>>>>> have been doing as much code/review on bitmaps as John Snow, who is
>>>>> hoping to scale back on this front.
>>>>>
>>>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>>>>
>>>>> ---
> 
>>>>>    Dirty Bitmaps
>>>>>    M: John Snow <jsnow@redhat.com>
>>>>> +M: Eric Blake <eblake@redhat.com>
>>>>>    R: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>>>    L: qemu-block@nongnu.org
>>>>>    S: Supported
>>>>>
>>>>
>>>> I'd also like to point out that I wouldn't mind if Vladimir became an
>>>> official maintainer, but I can't remember if he wanted the title when we
>>>> last spoke at KVM Forum.
>>>
>>> Actually, it would be nice, I'd glad to get it, thanks :)
>>> I can send a separate patch, or we may s/R/M/ in this one?
>>>
>>
>> That would be very good!
>>
>> I'd be quite happy to be demoted to reviewer; it's about all the time
>> I've been truthfully able to give lately.
>>
>> (I won't speak for Eric!)
> 
> I can post a v2 that produces the following results:
> 
> M: Vladimir
> M: Eric
> R: John
> 
> Does that sound reasonable?
> 

Great!


-- 
Best regards,
Vladimir

