Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 432CCC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 06:44:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1131A2072C
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 06:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="JAVw87nL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1131A2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCe3O-0008J6-A5
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 02:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37862)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jCe2P-0007UP-LD
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 02:43:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jCe2N-0002OY-Jk
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 02:43:17 -0400
Received: from mail-vi1eur05on20700.outbound.protection.outlook.com
 ([2a01:111:f400:7d00::700]:64880
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jCe2L-0002Ib-RO; Fri, 13 Mar 2020 02:43:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XJKue6AZywzv/AaIsZQYM0TCDVBf+f/ujvzxKSVGQssBQfRkdxxZIRqEtS3Nrpypd/19Gax4VlKHSNp+uWfFB5dsv27AHDNnrbkZpazjrw8yS762cRkDZXzzh45UnFJb2mGOcevQd2pcGNu9KoO3dKaWaRvxsh+k5Jy/9jxguKaXcqef40/HXGpqL7T1940531cPKCEcQyjUFV23yiqd3WxxsCGEhJoXJY312ygGzDVP7PJXPohBgDa9mmRQurFo7ksqlV9r9YQ1IA+/ZqRblWXpisvsp/j+hiK8v/ghu3OdY42hxs/bhh8xYxmO7UbDvUwYeMp6vm5a/iGVZcnfyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0735o3Bl7JVWE1+E0vcnXEWqRENct2QBEwMGqhtJT4=;
 b=B2PpG4NbRMvgJ3aWBi/v4StI4A/KW7B/lzmLcVEh4Pd8r/v3LLM14Ikh5+LEaEpPeWOtFShY/ASzv7OtAGuwqDA1F3Nm+n4CCQBHsSu1BDIy02XKCDkflRwoyPxe9dLE+bfRGaHHGk1lyiMOK560BG8DJQlWaWpd8XFIILMeeNwZVwqLEweZdI1wop3HfXHtSzl9Sget0/CqPNB16Tbl3QD6bEGoXB+CfJEzzajNrCxxkTgiQ+AtD9xnq8G6TeQJsTsHLu83O7poxjhlE+2vUINKYZ6EGAtqx2DuR1eCXG1gsdSE2CbP8HFXRnub/M5TxwVDM/7ifFB9Egh8rP9tFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0735o3Bl7JVWE1+E0vcnXEWqRENct2QBEwMGqhtJT4=;
 b=JAVw87nL5sGbhJeze2Ie4XJ4hIgqxSvKJeOl9w6CfA8e9DJR0GgNXhPfhcgiRB7hIGC/54+3bzGO+bYmSUm6+ghi/7YnoizZI5TbofNPi4QYk8n1498BoAndxgG2jC7xWBV8MfyEb40qifDlGyWXV2IEQKXz5f2NTFqw7KBeIMk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3797.eurprd08.prod.outlook.com (20.178.89.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14; Fri, 13 Mar 2020 06:43:08 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2814.016; Fri, 13 Mar 2020
 06:43:08 +0000
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
 <ad32a4c0-976d-0f8c-18a0-17de9fc615f8@virtuozzo.com>
 <8aae511e-c09a-49e8-2b3b-da22ef5a0bd9@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200313094306335
Message-ID: <e63cbd33-d168-1fcf-8b33-47c3f5e0d038@virtuozzo.com>
Date: Fri, 13 Mar 2020 09:43:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <8aae511e-c09a-49e8-2b3b-da22ef5a0bd9@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR05CA0293.eurprd05.prod.outlook.com
 (2603:10a6:7:93::24) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR05CA0293.eurprd05.prod.outlook.com (2603:10a6:7:93::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.18 via Frontend Transport; Fri, 13 Mar 2020 06:43:08 +0000
X-Tagtoolbar-Keys: D20200313094306335
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad8b0ab3-efee-4577-8936-08d7c719cac3
X-MS-TrafficTypeDiagnostic: AM6PR08MB3797:
X-Microsoft-Antispam-PRVS: <AM6PR08MB37977E1D5B1548BA4D933DF1C1FA0@AM6PR08MB3797.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 034119E4F6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(366004)(346002)(136003)(376002)(39850400004)(396003)(199004)(52116002)(4326008)(16576012)(66476007)(66556008)(66946007)(36756003)(53546011)(2906002)(86362001)(31696002)(316002)(110136005)(966005)(26005)(6486002)(5660300002)(8936002)(16526019)(31686004)(186003)(81166006)(8676002)(81156014)(2616005)(478600001)(956004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3797;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WkYnaQHAudQTyIYYX+7/pCbJEfLYWweCK0F5i/ueR8j0RzpntzDE+GWPTVg9gWct0sjx5GElkQ7NOzCCS9ta6MR1l3k6PNETWrniAUZPYRKRb7bxLb6LAY4I8XXyG/2W80JWvgyh22NjBOukHjXZbxsgrwt5StBPF1EjgeJrgEtHpMo47Nwrb4lRF5zIM/MfEnYdj+oaF/kfYJZy0i4t8TuchVZ5tPQ+H1TxjvBowWVKFlbCIfSbuWs3PB+POsX2Z9rKadoxHeSN6eHAYNf4S7F7KCSiYfg44DPMZz1j/3dn4/iP6Ncn3zbpKRlsWuZ0M0Ad2A0WyEqpXSEkOd788ehZW39be0H4s8e2/8o6a80/PofHWTd4QxqQ0KxI3kTvPDq5+OPOJg6EbCwAQzx9fet2ZJf59hGk5T6piu8hZaIpYKHV2O7qj0WendA7tHk0pVyAzMapmEodwz8mPga8JiOzQYfUInH8VM659awrYkqUPf8jOZxHg8z+t0D+wBRr/sniP7kd9v5agTFAlcr0Dg==
X-MS-Exchange-AntiSpam-MessageData: OoIM9rhse6t557tgp72q3B4pdIy07LkK5ejSYncHRHM396kdNdJhvjB1hoEbMPKLuFH8rCiYgLHSRLcorslMGVrlPs7rFOY6c4wrajfGVb+H9EUcVyk7v4YwJY/mD53PRqj7uJpOW9oO0R+Nqln/og==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad8b0ab3-efee-4577-8936-08d7c719cac3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2020 06:43:08.7116 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OC2ELOx0g0vJEh8B8ncyaYhP8HBsfS6MwH3Ac/CRecX2wYT2ii2Eo5AVTZcgYtNdJ2eOiJHGQ40LTI7c55i2IWxe63cVryEjSua7v5zxm4E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3797
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:111:f400:7d00::700
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

12.03.2020 23:41, John Snow wrote:
>=20
>=20
> On 3/12/20 1:59 AM, Vladimir Sementsov-Ogievskiy wrote:
>> 11.03.2020 20:03, John Snow wrote:
>>>
>>>
>>> On 3/11/20 9:58 AM, Vladimir Sementsov-Ogievskiy wrote:
>>>> 11.03.2020 12:55, Max Reitz wrote:
>>>>> On 11.03.20 07:17, Vladimir Sementsov-Ogievskiy wrote:
>>>>>> 10.03.2020 20:17, Max Reitz wrote:
>>>>>>> On 06.03.20 08:45, Vladimir Sementsov-Ogievskiy wrote:
>>>>>>>> 26.02.2020 16:13, Max Reitz wrote:
>>>>>>>>> On 05.02.20 12:20, Vladimir Sementsov-Ogievskiy wrote:
>>>>>>>>>> Hi!
>>>>>>>>>>
>>>>>>>>>> The main feature here is improvement of _next_dirty_area API,
>>>>>>>>>> which
>>>>>>>>>> I'm
>>>>>>>>>> going to use then for backup / block-copy.
>>>>>>>>>>
>>>>>>>>>> Somehow, I thought that it was merged, but seems I even forgot t=
o
>>>>>>>>>> send
>>>>>>>>>> v4.
>>>>>>>>>
>>>>>>>>> The changes from v3 look good to me, but I=92d prefer a review fr=
om
>>>>>>>>> Eric
>>>>>>>>> on patch 8.
>>>>>>>>>
>>>>>>>>
>>>>>>>> Hi!
>>>>>>>>
>>>>>>>> Could you take it now, or do you prefer me to resend?jjjjj
>>>>>>>
>>>>>>> I understand that you agreed to drop the comment above
>>>>>>> bd_extent_array_convert_to_be(), then do the
>>>>>>> =93s/further call/so further calls/=94 replacement, and finally
>>>>>>> replace the
>>>>>>> whole four lines Eric has quoted by =93(this ensures that after a
>>>>>>> failure,
>>>>>>> no further extents can accidentally change the bounds of the last
>>>>>>> extent
>>>>>>> in the array)=94?
>>>>>>>
>>>>>>
>>>>>> Yes, all true.
>>>>>
>>>>> Hm, I could take it then, but on second thought, John is the maintain=
er
>>>>> for 8/10 patches, and Eric is for the other two...=A0 So I=92m not su=
re
>>>>> whether I=92m even the right person to do so.
>>>>>
>>>>
>>>> Hmm, true. Let's wait for John?
>>>>
>>>>
>>>
>>> I am *VERY* behind on my email, and this patch series is sitting in my
>>> to-review folder. However, if it's ready to go and reviewed, I'm willin=
g
>>> to merge it, test it, and give it a quick look-over and get you on
>>> your way.
>>>
>>
>> It would be great, if it is convenient for you. Thanks!
>> All patches are reviewed now by Max or Eric, so, I'd be very glad if
>> this get in 5.0.
>>
>>
>>
>=20
> Thanks, applied to my bitmaps tree:
>=20
> https://github.com/jnsnow/qemu/commits/bitmaps
> https://github.com/jnsnow/qemu.git
>=20

Thank you!


--=20
Best regards,
Vladimir

