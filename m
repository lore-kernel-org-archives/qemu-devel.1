Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7C1C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 05:59:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68B2820650
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 05:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="g9PYGwGC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68B2820650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCGsn-0001X1-HG
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 01:59:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50713)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jCGs8-00011w-17
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 01:59:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jCGs6-00005K-18
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 01:59:07 -0400
Received: from mail-eopbgr80112.outbound.protection.outlook.com
 ([40.107.8.112]:4324 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jCGs5-0008WO-Cn; Thu, 12 Mar 2020 01:59:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WTfokSpB6VxIXl1UGT08fdD3sNk3yj62+d8e0p0bRwhn5R2hlTGDz9tM17Rut3BIdZ/dZWhhOnAxBloRJk5sAYdgoY43wMB70rixmXeo9VmnukGdy6uXpd0n7qTkOyP/5KhW7Nen3DI0fHP4BmABUYrzcrnH64p52ph+3XEmnK+3rvGm15iMP7rysPvyFz7IzV0KVLU6n/5DjU3/yNpGBVwN1XFG4ST2hHxtBAT03YhpIMuXAb0k9OqQNPccUhVv69xyy89PP/1GJ56uAlYz2oy6/9pEqgPdl4ekdFYwTHXUNon0H1sAPh2wbjB3FY79xMWM1mdJIXMWKq3q8VrLBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZDKmju9safAd1FCsxdk5ZUAiJnVlfg1PXgsuBtG4CZU=;
 b=n/XvAHxjbkYAhAQYIlTYLBTmOXRlxoBR8maLmdf1SzUtT8t/uLkrpAdjo0sPa1/r/XHma7A3+CKO7MPCcLGDqGRGadryEzxEcseWMEb4J5DmKzM6Hkzo7fS9UxfSfS78fO+7PRrIvTmDvxzR7+5PSo3uDJxBDMbIHda7wwoIavYt61ogH3OUupwtTdIwTQIgxNXTCTMO0V2/yZVqkPnctJM6wxll8v3CSb9q/yMGUnVJJEn5MlTkX1wlNnidFUfMNcAheNZKHBuBr4OVn2KVFJpq7lE60A3xdHBPPBsFNtWCG0HmBljHgzonBoA+xjDn+zUd0RWAH68Bq3I1fZ8u7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZDKmju9safAd1FCsxdk5ZUAiJnVlfg1PXgsuBtG4CZU=;
 b=g9PYGwGCNsxK46Vsd0EW7NymI58Tz8tbzlopW0omjmCAG/8cCK/aXmZEi2aYZQjQMOQ3G+JpJ3txwFjxfkB4sMPqzQOCJzjuQdRctJJzhBA6GV3ZxhFbnV3O7g4VNmBBVJYE+W/dcuPWIqU9b9d0/0PTkWu+NKxqQ+/gQtMOKW4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4104.eurprd08.prod.outlook.com (20.179.2.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Thu, 12 Mar 2020 05:59:02 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2814.007; Thu, 12 Mar 2020
 05:59:02 +0000
Subject: Re: [PATCH v4 00/10] Further bitmaps improvements
To: John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-block@nongnu.org
References: <20200205112041.6003-1-vsementsov@virtuozzo.com>
 <4cf33f31-cdbb-cee4-a1b4-4053c88a002e@redhat.com>
 <6b570584-100b-248f-5412-98a5d91f62f5@virtuozzo.com>
 <ca6f95ef-d51f-130a-8ad1-4eba5e0a3528@redhat.com>
 <7b655cdf-8c54-b10a-4140-2ad083dec75a@virtuozzo.com>
 <153ff5cc-a929-1aa9-c405-846739b13570@redhat.com>
 <f3068c48-4c59-3328-5190-9e47a792ab57@virtuozzo.com>
 <f8adc071-4226-aa51-5598-abc86af04608@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200312085900009
Message-ID: <ad32a4c0-976d-0f8c-18a0-17de9fc615f8@virtuozzo.com>
Date: Thu, 12 Mar 2020 08:59:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <f8adc071-4226-aa51-5598-abc86af04608@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR0202CA0033.eurprd02.prod.outlook.com
 (2603:10a6:3:e4::19) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR0202CA0033.eurprd02.prod.outlook.com (2603:10a6:3:e4::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.15 via Frontend Transport; Thu, 12 Mar 2020 05:59:01 +0000
X-Tagtoolbar-Keys: D20200312085900009
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf02bf0f-707c-4576-c4a9-08d7c64a76eb
X-MS-TrafficTypeDiagnostic: AM6PR08MB4104:
X-Microsoft-Antispam-PRVS: <AM6PR08MB4104EAA4080C29FB3591041EC1FD0@AM6PR08MB4104.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0340850FCD
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(376002)(396003)(39850400004)(136003)(366004)(346002)(199004)(66556008)(5660300002)(31696002)(86362001)(66476007)(66946007)(52116002)(53546011)(478600001)(316002)(2906002)(8676002)(8936002)(81166006)(81156014)(110136005)(16576012)(26005)(2616005)(956004)(4326008)(186003)(6486002)(36756003)(31686004)(16526019);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4104;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mrdOATifUKOLNHfXJJC+52u2YMfDtPgJqpfKQ5v34v0ozWv1S7uk8/l+ChRs0Z3aHDr2tpn7Zt2RYR19+V20izI/Xy7MbGnSK8zfItV+aYtExxJS2YJQdIWUvBVQ2qweeU5zfnYiB/Izgwd2PIxQprWIb5h6UZJ7HzZBNKMwkYvXT6QMudzJ65RFn1oPSCNFffxYqWDCK0+6RePE+7h0PIfrbdXW9mzZU/6VA3JTQF03heCpKt5lJqzT8++eDqmXDAGlTVdO3dIgAMFBcNHIxURsV19HxlfOTcdRqFNumomqkG3yvhPNsgdJ5QWPtuaTYkhLMy+8f42k1WC1ZR7DTaapZ2yqLLuPcPrS9lu1ZebXc6T5C/dD4KGfyVb5nOKZEzWmm2ZE4TZjn84fmRJLAjIBK9wsqbZF0PHNhSXypU6LRoQvA130weZ2yVRt0NDX
X-MS-Exchange-AntiSpam-MessageData: jUZ6ErsVurAde4m8/lxqKA8RNqbdUwelR5f2pFad7p3Yda+TcmLmjmOk/Wut7ie6uuL5SIhnU2qTSJDeeT5vnDniNYAUQjJR/Zom5ywqexWsENNCxz6qojqB944gnSJptNI1gyp3iSXwNk98UryeFQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf02bf0f-707c-4576-c4a9-08d7c64a76eb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2020 05:59:02.5674 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ya4lZavGNRwEBsV+pufLLPOXLC3THG5uGuILCQrtlMeE3B756EtIdS0zCZTtbGa039APaHo+Ktk1PnuRiejixpi7rM7puIMHM01myhf+iYk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4104
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.112
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

11.03.2020 20:03, John Snow wrote:
>=20
>=20
> On 3/11/20 9:58 AM, Vladimir Sementsov-Ogievskiy wrote:
>> 11.03.2020 12:55, Max Reitz wrote:
>>> On 11.03.20 07:17, Vladimir Sementsov-Ogievskiy wrote:
>>>> 10.03.2020 20:17, Max Reitz wrote:
>>>>> On 06.03.20 08:45, Vladimir Sementsov-Ogievskiy wrote:
>>>>>> 26.02.2020 16:13, Max Reitz wrote:
>>>>>>> On 05.02.20 12:20, Vladimir Sementsov-Ogievskiy wrote:
>>>>>>>> Hi!
>>>>>>>>
>>>>>>>> The main feature here is improvement of _next_dirty_area API, whic=
h
>>>>>>>> I'm
>>>>>>>> going to use then for backup / block-copy.
>>>>>>>>
>>>>>>>> Somehow, I thought that it was merged, but seems I even forgot to
>>>>>>>> send
>>>>>>>> v4.
>>>>>>>
>>>>>>> The changes from v3 look good to me, but I=92d prefer a review from
>>>>>>> Eric
>>>>>>> on patch 8.
>>>>>>>
>>>>>>
>>>>>> Hi!
>>>>>>
>>>>>> Could you take it now, or do you prefer me to resend?jjjjj
>>>>>
>>>>> I understand that you agreed to drop the comment above
>>>>> bd_extent_array_convert_to_be(), then do the
>>>>> =93s/further call/so further calls/=94 replacement, and finally repla=
ce the
>>>>> whole four lines Eric has quoted by =93(this ensures that after a
>>>>> failure,
>>>>> no further extents can accidentally change the bounds of the last
>>>>> extent
>>>>> in the array)=94?
>>>>>
>>>>
>>>> Yes, all true.
>>>
>>> Hm, I could take it then, but on second thought, John is the maintainer
>>> for 8/10 patches, and Eric is for the other two...=A0 So I=92m not sure
>>> whether I=92m even the right person to do so.
>>>
>>
>> Hmm, true. Let's wait for John?
>>
>>
>=20
> I am *VERY* behind on my email, and this patch series is sitting in my
> to-review folder. However, if it's ready to go and reviewed, I'm willing
> to merge it, test it, and give it a quick look-over and get you on your w=
ay.
>=20

It would be great, if it is convenient for you. Thanks!
All patches are reviewed now by Max or Eric, so, I'd be very glad if this g=
et in 5.0.



--=20
Best regards,
Vladimir

