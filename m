Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532BEC83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 05:25:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14771206D6
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 05:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="OK8WfBfA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14771206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTfEL-0003gK-98
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 01:25:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36170)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jTfDU-0002mN-IY
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 01:25:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jTfDT-0002mu-C8
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 01:25:04 -0400
Received: from mail-eopbgr00137.outbound.protection.outlook.com
 ([40.107.0.137]:44614 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jTfDP-0002m0-Ln; Wed, 29 Apr 2020 01:25:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BciO+5L7jDSTrh64suagBkB29rzCP5Fei7sjEspyPR8QyOhyAEmk8OBclXocrQRFnDE55jTd/ryJmN7e6Je73mR0NpL9rLSCqD2K9SZYb94oN4PrHSlzW2WhbzhXaCn3m/saUELwOW1j78ADDgJc43pnrxzUKJI43t9ZRqEwf9UCMtVuXEIhyaRb/DVVkmoVamgzMHB3VsLuZ3bpnR1cFLidjQyOZOV34WXegVVoEpVvGQnBry0pDni8oB9z9KUVnm6Mx6v4IsZ4xiWcCrl0/Oul2UkoHglzNzxxOTy4iQB/9bjY7KBsysucWYugrrofUXABMZkTrt/09VVqUsv6sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0OGyfelSmtCoB0AK3skK145MdlCUQs1OzkISLUl780=;
 b=Q0f4M1uTlhvvdck25hSI1dnkE6vab26CJ03rEmAAc2VbyHpm+Pl/OKffoy2rjoP2TcKgQI6gMCBoO7g4StkFKAOY5VrtKGf57GnXhP2lT50WfMP5um2OHeAC5S8bNaN5Cx1UX2aAOsNR/NB4cecsQskE4hKgUGGE9MEPhFsINemTJM7355994bIw7z+l9+wz2p8y3mxu1e+h7JP9b9ws30tT+O3EZGmb1k3O4Tpog5uDvVRBUyrhjOSMepA4yPs4H0rFAXyGLbwcmTYs6yQL6MfrUoiFeDeTBJ+uxWvJQz4pL9/O30zGmQmeehhX1vlYLEg8Kt97YEOfcTsdgweX0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0OGyfelSmtCoB0AK3skK145MdlCUQs1OzkISLUl780=;
 b=OK8WfBfABHuwDhytHmTlF0DnpZpPYjIUmH437NQsMJfnwriBsApL8ZfBhGJCWK0gvmiy7eEzkVrjkAmOk4ozHmejF577Lo4fBxF5iqo+bmdpLnHIkl5MKMMNMc1BQ0DG4dy7rheGyJu9trNXlTvUhi0nOKHxlFcGEmqYfZb/KnI=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5368.eurprd08.prod.outlook.com (2603:10a6:20b:103::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Wed, 29 Apr
 2020 05:24:56 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.023; Wed, 29 Apr 2020
 05:24:56 +0000
Subject: Re: [PATCH v2 00/17] 64bit block-layer
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20200427082325.10414-1-vsementsov@virtuozzo.com>
 <4bb8e5d2-8ac5-bee2-7128-8c7cccf8f653@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200429082453873
Message-ID: <93a006cd-eed0-2665-c017-b888bc60ca5c@virtuozzo.com>
Date: Wed, 29 Apr 2020 08:24:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <4bb8e5d2-8ac5-bee2-7128-8c7cccf8f653@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR01CA0126.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::31) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.184) by
 AM0PR01CA0126.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Wed, 29 Apr 2020 05:24:54 +0000
X-Tagtoolbar-Keys: D20200429082453873
X-Originating-IP: [185.215.60.184]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: accdea96-a688-41ef-8f32-08d7ebfda70d
X-MS-TrafficTypeDiagnostic: AM7PR08MB5368:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53686E084CDF3EF3620671FCC1AD0@AM7PR08MB5368.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 03883BD916
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TFQyBYeajrUM8RG4GodAdZL9WdgpTiAbtU0xsyIEwtefPsDaVyf9NVksUl2924rBXx6Nv1N1po/Pu0u5lrw0afprrYFr3/L4EFWEgGYUgUjnVEAgtFk8+o0bhRk1uiJT7nt7tV7Lx45p+yFRYR+clhfWhwc+rZYsuK67bduUqURPVgP5p7ezUASIig7R4FIRNS6p1ZTfoad+Ro0P/tkNJnwKd+0/ZHbbUmGx+zIuzvLcNPm+CruPZrlHDs/Pr696OmQxtC0LR9inFMvMJYqWCDmw9xUGcH9+CWEszs/3UPdsUGEkYY9tGa4JRRyK5EXC3TQPHOf7vnjxtC5foepVtbBzI7R50DHRAUfc1dBs00WOB1Yk95ySuJtUeliMqcucw8xlZYT5GbdtyyjMXMqtfAeIkSn2glocDmF/hNp4X9D17V6lP0Fr7b1sWWoTKOK+rD5hSlXIA0ebae9fTMP10GjG1cN4Io52Y9IB/gvgJmQ2zWFxzWhDwy/tLMPNxubVtleyFHFwoP8bUoZPIMINeg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(396003)(346002)(39830400003)(136003)(5660300002)(16576012)(66476007)(66556008)(31686004)(316002)(4744005)(66946007)(956004)(186003)(8936002)(16526019)(2616005)(52116002)(6486002)(26005)(2906002)(36756003)(8676002)(31696002)(107886003)(4326008)(7416002)(86362001)(53546011)(966005)(478600001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: MqCWQ4k/Za2l45GhC/TlJj+7qDzkNv58VhVdIFCJXvxXSABtCQM+UcSdLcA1zeSaAnWIJuLBj3CZyvmUNAwr2Ge/9nOgH6DgFMDNEJD0Bwo7tC5T1id8SGV3X3yKLQKgkTGJ6iQEI3XzsmanqgBUs0cLzRuOcdgZKtPd9MOXGgiOME2jfhWrjq+mNAutjyQCAaIV35nYN+njB3FMQEFnIXcu7FIwFI5I+kvQ9KHAzvfR3vnJhhp5oOvUkEcx4w8WY4bZDk1rXoMnGNgLKGaCV+boMpKpfPUFDsW7lWUQLANZolhci7bj1kDVFsy7027iwncIpBs/e9K8S5B1VJAquPJeaSzkd7u/PEMYAFfTH3QYJW8cdKzQia6T1acVvvaFD7ZTDci40VToRvgW5lW7UIyVXGuxgascwuKgh9q7q7jcble8j62llmRx01LNWB0pLjWkaoevBxIyFKs7B7ivtpordGoRPxLGJezpiC5/FT3DXCJNrMeHcemRVnW7WEj/T4cAHC1oejcGkDanNQd1O31k7t9wwGUHmdurvtxExyuH2BZqMX57WvZFcOcoPp3uXzkOvDmEFuvjQbgVM/eaWm0X+A/phYFrlZOUBb5cr9g//Pg3qtWmJhz+/wERV8/irPfEOlOLZtcdTmwZCgZXepv3hhZb8MmXPiqnleoKeiAl1KrrIHOthRjfc8JJZukI2GxqxaJufQzZMmdmYe46eVqa3/lxfDywxv0WT37aJZP3+WuO6GIcMd415LT6OGQyDK5yL6lTumTxzizx4qmGbjgoUBVc2xIiP0OTmqukVxg=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: accdea96-a688-41ef-8f32-08d7ebfda70d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2020 05:24:55.9595 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ggfzxmyqd7C3OfQqME666mRuq2HbQeSj5NjPmut1zgrFnj25x8WdIvBHrDhbc/OI4U7sXpoTcJgP5qyq3SwWaFMFFEtGKvYD68bFGBT0LMw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5368
Received-SPF: pass client-ip=40.107.0.137;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:24:57
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.0.137
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
Cc: kwolf@redhat.com, fam@euphon.net, integration@gluster.org, berto@igalia.com,
 pavel.dovgaluk@ispras.ru, qemu-devel@nongnu.org, dillaman@redhat.com,
 pl@kamp.de, ronniesahlberg@gmail.com, mreitz@redhat.com, den@openvz.org,
 sheepdog@lists.wpkg.org, stefanha@redhat.com, namei.unix@gmail.com,
 pbonzini@redhat.com, sw@weilnetz.de, jsnow@redhat.com, ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

29.04.2020 0:33, Eric Blake wrote:
> On 4/27/20 3:23 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Hi all!
>>
>> v1 was "[RFC 0/3] 64bit block-layer part I", please refer to initial
>> cover-letter
>>   https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg08723.html
>> for motivation.
>>
>> v2:
>> patch 02 is unchanged, add Stefan's r-b. Everything other is changed a
>> lot. What's new:
>>
> 
> You'll also want to check my (now-abandoned?) posting from a while back:
> https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg02769.html
> 
> to see what (if anything) from that attempt can be salvaged.
> 

Hmm, looks close :) will keep it in mind, thanks. Or, may be you want to resend? First 4 patches are not needed now, as bdrv_read/bdrv_write already dropped.

-- 
Best regards,
Vladimir

