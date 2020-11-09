Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720ADC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 10:06:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94F2720658
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 10:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="a+wZvki4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94F2720658
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc444-0005Vy-Cs
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 05:06:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36780)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kc42r-0004tk-6y; Mon, 09 Nov 2020 05:05:05 -0500
Received: from mail-eopbgr00092.outbound.protection.outlook.com
 ([40.107.0.92]:43431 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kc42o-0001Ec-34; Mon, 09 Nov 2020 05:05:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ivgPcAaDJ6FdKRE3C1qzBO7nLGOxIWfCnkaShsFCr2Ods3hjdXNAl7iklKs95a6mGj80I6nsRL/6XwmD1ujFc11d01epCZMjmguiZMk2MiiJuNbtSr4LTvNqpNGU83Dh8grcv+80t9cO3yQrOXg3G8L1/NDUMro0XJ3QS18CuIPEoqtOClR0R0Nfm1s2ZiTD0A0Ych0b2q13FLpjv0jF+m7pz/G9graU/8LJF5at+F/Psxog2h57HNQRnuafCjYDJECfvNaSeoQeAs3evxF2UyGsAc3qdDctJ5EE71mCkcvYU2yKoAFQL0MPaJG5M/gWfLaHTxTnu8wXt3727Sx7Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlzukIDxJ/vE2pIO0DDvrI/JcXWaR+/NgCHxBL6eTuc=;
 b=ogYAAq9djE9QbmYDBAAJu5RR+r+mwww4reaV5hQTcGroxE1JQvImoaMoRG4o1RRw+C1cEdG/mjSRY/bUb3H7AkGElOahTHhELMWkTp2V3vIVVBW6XnJcsZQYOvVjo3NoTWi7GfmktcZBbKJcH+v/dAzpnA90MgUQm6CBpdT2MrzQFsCtZMN7VGiS6X1dgfke+FUJ4O545piVwYDrzGKOGAYgiecZwVPp1ZL4oXtPcKnxC9/fic5KZIisJwQDAqGHgl7WElXKoBpElxQDsfov+x/DtaTyMlaEUADWggsQeKpaapbVxkM3fph3PlEnQkZnjJx9+0R9NkfJ4nDmXknkMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlzukIDxJ/vE2pIO0DDvrI/JcXWaR+/NgCHxBL6eTuc=;
 b=a+wZvki4NYxxOMXw19jN6pHIg+A2U2BLJbVhtdUlc1XWAekb4V9E1q1oITXpiNGl3UusZtF1YhmO7GNGqFpv7MCeNZyRNSxNjoc6/GiFhb941l4h3CIBJaNqLrGkqqsTo95U3iODDN/nRj7YIXEEhsabr07PvIbFfsk/sKC/Aig=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3093.eurprd08.prod.outlook.com (2603:10a6:209:41::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Mon, 9 Nov
 2020 10:04:58 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.032; Mon, 9 Nov 2020
 10:04:58 +0000
Subject: Re: [PATCH 0/2] Increase amount of data for monitor to read
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, jcody@redhat.com, kwolf@redhat.com,
 mreitz@redhat.com, armbru@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, eblake@redhat.com, marcandre.lureau@redhat.com,
 den@openvz.org
References: <1604666522-545580-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <0f18a6c6-5eab-3ed2-98e3-04969da7bd7c@virtuozzo.com>
Message-ID: <d48af433-a39d-27ba-8aed-a6957c89d2d1@virtuozzo.com>
Date: Mon, 9 Nov 2020 13:04:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <0f18a6c6-5eab-3ed2-98e3-04969da7bd7c@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [185.215.60.85]
X-ClientProxiedBy: AM0PR03CA0087.eurprd03.prod.outlook.com
 (2603:10a6:208:69::28) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.85) by
 AM0PR03CA0087.eurprd03.prod.outlook.com (2603:10a6:208:69::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21 via Frontend Transport; Mon, 9 Nov 2020 10:04:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ce2e15e-222f-4e5c-8879-08d88496ea36
X-MS-TrafficTypeDiagnostic: AM6PR08MB3093:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3093E2CB3B9C339EC647507FC1EA0@AM6PR08MB3093.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ck+zHzamxA3hVra6/Ct5BdLYQA8018Ir1QoWEFfquuOZwpmJ7oWS8WtYRV7jqkApCoUYqgNK+tKsJlVUHIDaY0wtVudYTofOU6mMeZ42lm8FzGwIeIrsfdkTE5x/1+Q3yVeobT4b7BxOiAOkGC2WtzesRk4lwyheHy2pGD8gmWYPQKJJVuYdBjoEa8L5YkEUhgRrKFzzU095ImgGZBl56iIN0Um56bpTSqvDczA2vHwcYB21LCMQJRnBKShsmlChX7Q/UiCOreTtIZbI5fw6mWojdlh3eQXVybWgDJkHb8ZUUh8yKoM2/QhhExbun6DPAonEcAiLt0q4BrSRCFW3+tz6LL/kvXCqvFVwfseg1kcQWbvtSa4aTOcWigKCWaaQ758r6tPkrwf+3tbezTvUjkhpKNOCWVX2hC+AgFTEWZHbp6+7INopKODshvS29NOJ59wL4rDDBSMzGyrTZoFI9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(136003)(366004)(396003)(376002)(346002)(966005)(2906002)(7416002)(26005)(107886003)(52116002)(83380400001)(2616005)(16526019)(8936002)(186003)(956004)(4326008)(478600001)(316002)(66556008)(5660300002)(86362001)(6486002)(8676002)(66946007)(36756003)(31686004)(66476007)(16576012)(31696002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: +4DSrgca9EhwIVkmA0dWlng6XFFQm7HsyOecZzutg7P3wv16QKdQTD7FSYUO69aGphfrU9poaNNIxW2KYYgXn1eHKiAsQ3o7E6Eg7e6KfFR1ClWveJZrp/23NZ66hksBLI3mJgwriB+RX/86xNklK1rBu1Gcrigh2CJM1cPaCeU+Jv+kRZZ6XmltZScI1VKmSTFcRHwEzOqo6JSwgWNXMuP/R04BcF0KnUCCN3yn+uwobnEGCvVf0L5jRf4n8av26bquVZdVyFMew2xo+LXoHUijIBxj4aD0NHnnP9l7b+G5lFAXTAhElMZX+qdNxODW/npNHW/NsK0oh4Akb+G74o1SUI34f91LXjWDUNBnJJZuW+bm7+ubiu3n+nv4uRAmS9HwaTz8/KQNtiaTZ9Z+7oJrck01uix1B8PpYWGm1YazuGd/RDH/S5CHytpO7T9PgxqgSKYZveicokZYqh5UuWHBBmSY6JFUtlKSQ3/H/WhZ86L8GfVilM+FsnZ0RCXLCaIChYcIfLUzrGJmkg3DHJYWb6XwmHepsjOE0wzoc8HTmZ+LrPM2Ea6ueqFl9JRM8gEu30atevSaMTFMKFODU3yi7snXa4ca5BuBm2bcCq337mIFGZW+GEI6Qy3nKnJ+FmwyKFma7BBcRIXCg4DmMg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ce2e15e-222f-4e5c-8879-08d88496ea36
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 10:04:58.3543 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q3SbJD7q1PFaT2ogs5u6Yf/vOfZ6uYPkupf3HBa7yJyxu5v8c3BO+ZqmfILm8fv09D2ZC7mhWn7ON6MT7lXslOrXO3mM8e0QFEseLhRum5E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3093
Received-SPF: pass client-ip=40.107.0.92;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 05:04:59
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_LOW=-0.7,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

09.11.2020 11:50, Vladimir Sementsov-Ogievskiy wrote:
> 06.11.2020 15:42, Andrey Shinkevich wrote:
>> The subject was discussed here:
>> https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg00206.html
>>
>> This series is a solution for the issue with QMP monitor buffered input.
>> A little parser is introduced to throttle JSON commands read from the
>> buffer so that QMP requests do not overwhelm the monitor input queue.
>> A side effect raised in the test #247 was managed in the first patch.
>> It may be considered as a workaround. Any sane fix suggested will be
>> appreciated.
>>
>> Note:
>> This series goes after the Vladimir's one:
>> '[PATCH v3 00/25] backup performance: block_status + async"'
>> To make the test #129 passed, the following patch should be applied first:
>> '[PATCH v3 01/25] iotests: 129 don't check backup "busy"'.
>>
> 
> Hi!
> 
> I tried the following test:
> 
> start qemu:
> 
>    ./qemu-system-x86_64 -qmp stdio
> 
> type the following in one line:
> 
>    { 'execute': 'qmp_capabilities' }{ 'execute': 'quit' }
> 
> press Enter.
> 
> Without your patches, the qemu quits immediately, printing double "{"return": {}}".
> With your patches applied qemu prints "{"return": {}}" only once and doesn't quit, until I press Enter the second time.


Positive thing: the patches do increase performance:

for me, the following command:

(echo "{ 'execute': 'qmp_capabilities' }"; for i in {1..10000}; do echo "{ 'execute': 'query-block-jobs' }"; done; echo "{ 'execute': 'quit' }" ) | time ./qemu-system-x86_64 -qmp stdio > /dev/null

shows 2.4s on master and 0.6s after patches


> 
> 
>> Andrey Shinkevich (2):
>>    iotests: add another bash sleep command to 247
>>    monitor: increase amount of data for monitor to read
>>
>>   chardev/char-fd.c          | 64 +++++++++++++++++++++++++++++++++++++++++++++-
>>   chardev/char-socket.c      | 54 +++++++++++++++++++++++++++-----------
>>   chardev/char.c             | 40 +++++++++++++++++++++++++++++
>>   include/chardev/char.h     | 15 +++++++++++
>>   monitor/monitor.c          |  2 +-
>>   tests/qemu-iotests/247     |  2 ++
>>   tests/qemu-iotests/247.out |  1 +
>>   7 files changed, 161 insertions(+), 17 deletions(-)
>>
> 
> 


-- 
Best regards,
Vladimir

