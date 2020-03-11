Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40862C10F25
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 06:18:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CF8920873
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 06:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="k30kYYuc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CF8920873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBuhF-0006Bs-94
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 02:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51547)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jBugN-0005iq-Pv
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:17:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jBugM-0003v0-2M
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:17:31 -0400
Received: from mail-am6eur05on2139.outbound.protection.outlook.com
 ([40.107.22.139]:26112 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jBugL-0003iL-88; Wed, 11 Mar 2020 02:17:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fGWDgYXsaO1AmQpaKQXWwxoxmGKNwB0rystQ6XypVupMPwOt0gkMMzYj8FPFFP2Zb4YNgopTEvzNdOTYCtwDnvovlJ5gxa9AT+l61OvHM8aRzYUn7u2sF5HHYNAJAxs2twylCmGUGfdO9RggZdSo7E7eJSh8mmx68uZwhm1c4og71emTbNSmLdDnpwOdBrN0klUVKPl/gDcO/5TX/bClB6QY/Ecjw4qftnuqbKYpMjtOSgJm187SaUxxGgU1T+2JSqyPWC+EVir5BJhgqmPQGiFGBAGoAJy62vdYHqu0svqEh5mJsVC2C7TMcmYLD8qM4WQcJY+Npe84uAhPut2vHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CzIgQgsnCIfT56aOoEMnN45DpHYlVnOKUaFyGw4eZ4=;
 b=e0adZJkRRo+6sl7CXEAbBiPG/UthBOiOnidNHk5q9R7zmXMhOP5EL8CmFriePqFeW7o9TYVXeC+YA3YNhM7jMLDp4Z/gxnpaPMxa4A3iydF99nE0p9UByOag/brPyFtInfvx4VxEqUxyzwZhZib6NDRBneGltur+MslCPlAO4dDABkRuZrGw8qWyu7RSzfgbKr40O/R6TCpPixBiDQ5BymhhE9QMiNXnuxuzTwls4FbXW+tjh1vKescoaRj5vH/S25QKrVz7xAykiQ8LuWj2OVbKteaNbyTgCBxKp41aDMF3v0F8DbIjnrm58Rd/2TH9PdD/d8I1K/GHwJzhd18kaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CzIgQgsnCIfT56aOoEMnN45DpHYlVnOKUaFyGw4eZ4=;
 b=k30kYYuc439/4doDNx/U7mvFt4jPEN00o77+TYmQTOEKPqHslxRsIIiLAKvwxezJwfsY/PzCKLGdbppHwCj24H3XXPV2bC0e/E3GNOxadze0clEObeiL11pwge12nqFKKMiLPwB7d8jJ46Q5ZZjykxyNRT1OWZlgVAIMcsw8L/4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4325.eurprd08.prod.outlook.com (20.179.18.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Wed, 11 Mar 2020 06:17:26 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2814.007; Wed, 11 Mar 2020
 06:17:26 +0000
Subject: Re: [PATCH v4 00/10] Further bitmaps improvements
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200205112041.6003-1-vsementsov@virtuozzo.com>
 <4cf33f31-cdbb-cee4-a1b4-4053c88a002e@redhat.com>
 <6b570584-100b-248f-5412-98a5d91f62f5@virtuozzo.com>
 <ca6f95ef-d51f-130a-8ad1-4eba5e0a3528@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200311091723160
Message-ID: <7b655cdf-8c54-b10a-4140-2ad083dec75a@virtuozzo.com>
Date: Wed, 11 Mar 2020 09:17:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <ca6f95ef-d51f-130a-8ad1-4eba5e0a3528@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR05CA0387.eurprd05.prod.outlook.com
 (2603:10a6:7:94::46) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR05CA0387.eurprd05.prod.outlook.com (2603:10a6:7:94::46) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17 via Frontend Transport; Wed, 11 Mar 2020 06:17:25 +0000
X-Tagtoolbar-Keys: D20200311091723160
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9dd875c-99e0-4253-d303-08d7c583de5f
X-MS-TrafficTypeDiagnostic: AM6PR08MB4325:
X-Microsoft-Antispam-PRVS: <AM6PR08MB4325107837575823277AC030C1FC0@AM6PR08MB4325.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(396003)(346002)(366004)(39850400004)(136003)(376002)(199004)(66946007)(956004)(66556008)(31686004)(36756003)(4326008)(8936002)(478600001)(86362001)(31696002)(53546011)(2616005)(16526019)(66476007)(6486002)(4744005)(186003)(26005)(16576012)(81166006)(81156014)(5660300002)(316002)(8676002)(52116002)(2906002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4325;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EPj8O/vjX1tDiJwsxIUijUN0zwhEVrcjarqVFBwMpZpOuO/cZs0Y68HyKeadngvrJe7+oPtTt3uU4cV7nz18FixTa/wmqM46okJ7CyJc3yi6EKchRTC4YvFKBfu9gm1sF3HOVKirwEojSI5fvX7JkEdxBkl71hgn2+5EopWYd2tEza7/fxdrUnYH+wEa6frESdkUJp5NihjTr2xY7dAil9A48qV/ixjaQXefSGMkPwToftAnzDzOkNh/m/3OUcqnIdvh/SwPJ8N1gqOOqQ+NsZDhaEOs/pEXL7HgkVkDJS4b4y9lFAyZ+ZPOsxi4YYS2f2slTbpA3ccWgOXfaDgm4Ybtwpct4KAj73V0aIdmfZPENt4KV+AJSR2HNsHSipQNpv6Q0MK9/IteQudUwpOVBjX+HIo3eLyUXOgsU2xvK7SSBADYvFZmzWEcdXinyhd7
X-MS-Exchange-AntiSpam-MessageData: puZuYrr1lrRh9laK1gomnq6QXj2DLUf8nCUXvxn6m1DnXzoJ4lit8rvGl/TjULsATMCuUh7wC0hMbcZrDcNzmhEUMa1VC/trN/bkaGa8w6UybqQzdBOU1e43OcIOFPhyhOACY5SYrV4GqEw2Nf++mA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9dd875c-99e0-4253-d303-08d7c583de5f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 06:17:25.9703 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 69obwJaW27T6MrZGSLeIoTgsyTW48o3vdkLt74AMDJTw7+pHV6IBK713tDgnOY7mTmS7yAGg1jmhn0oqmmgtlF6NX8gRvZbv43WXdkXLw2s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4325
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.22.139
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
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

10.03.2020 20:17, Max Reitz wrote:
> On 06.03.20 08:45, Vladimir Sementsov-Ogievskiy wrote:
>> 26.02.2020 16:13, Max Reitz wrote:
>>> On 05.02.20 12:20, Vladimir Sementsov-Ogievskiy wrote:
>>>> Hi!
>>>>
>>>> The main feature here is improvement of _next_dirty_area API, which I'=
m
>>>> going to use then for backup / block-copy.
>>>>
>>>> Somehow, I thought that it was merged, but seems I even forgot to send
>>>> v4.
>>>
>>> The changes from v3 look good to me, but I=92d prefer a review from Eri=
c
>>> on patch 8.
>>>
>>
>> Hi!
>>
>> Could you take it now, or do you prefer me to resend?
>=20
> I understand that you agreed to drop the comment above
> bd_extent_array_convert_to_be(), then do the
> =93s/further call/so further calls/=94 replacement, and finally replace t=
he
> whole four lines Eric has quoted by =93(this ensures that after a failure=
,
> no further extents can accidentally change the bounds of the last extent
> in the array)=94?
>=20

Yes, all true.


--=20
Best regards,
Vladimir

