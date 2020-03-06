Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFEC9C10F00
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 07:45:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9CC4217F4
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 07:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="T5wUoGsZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9CC4217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jA7fu-0008Ux-Qw
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 02:45:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59425)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jA7f7-0007cl-5E
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 02:44:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jA7f5-0005TT-EJ
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 02:44:48 -0500
Received: from mail-am6eur05on20708.outbound.protection.outlook.com
 ([2a01:111:f400:7e1b::708]:27584
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jA7f4-0005Cr-N8; Fri, 06 Mar 2020 02:44:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y8rnpvkqyYDUEWITK+xbMt8FRdy2lcnFE6xlkHaH6tznXnuCQtNrmkkMPDqOmUsqvRbsueWyJcFWwzp/u37t7TNiyft5P0HwIKZc9c30shTcIhm8csCPhMEpfcIHlo2V5b17jniZylP6tL8bAFliAOyCsm430drTXzNNBH5XpzVE777fUpovxd5SIaBKs7Pv5nO6Gu40tfuCtz6U3DyDwFIg5qUrKs9nP1blMiN/YaNkepMwGB13k3GM3R+oAx6X0o5gORDlzCDDsJ8ecfJi4uAx56jpvXjTGUwHx+XGkDyIlLVnBqZ0m/EOJOdzs+mzR5aWOmJJtkC7DbDWoCNaIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2grnelnXuWVhOlEqMk/BKhHdOVWhqscM9nNUCCHu6EY=;
 b=K5m2FxmHbStqPb8uK2gp6ERhwb0Bk30+9C0PyeIHZnpd5ffvE9Se0uMOfzUM81CTcT2dgT9Hoxm+5cDHX8Ujdo3jjDRtsSKr3jB02FyqmERIgxiE1mbejxB7LGNsYz+wyXQ29J9OczyOYYzYJHIhwlkkgJUX1o6mxAhMdM0liPW1uNKgSUhMuZw5y68jmKS+YqpAICR/obXCwvCVZfigdlHoWv5Io2lAvvsrxWA3VwqSL6one7kVuVfIdIUG/EJxzZWkzBBub9pCodO3BP94ZVRNAdD6V3ZehidClY+06++QaX6h8zSihqOUf77XwVAZFcqFVF58WuD4Jk44gbyuaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2grnelnXuWVhOlEqMk/BKhHdOVWhqscM9nNUCCHu6EY=;
 b=T5wUoGsZbyeo/Vg/eK2hbVj7AvKVWKgtY/xNp1dxdPmJ063rFyBFITuJobOoLUO5gPoK6g0zvtzTKkWOP689Ft7bDhK/8K3nTSdI2QqYDnP6KCXx644OYxomutN4CxXWQz519IfjPrhySrVtlkrIgk+XqYiM5ooJWUI6BUjqsdM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3270.eurprd08.prod.outlook.com (52.135.169.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.18; Fri, 6 Mar 2020 07:44:42 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2793.013; Fri, 6 Mar 2020
 07:44:42 +0000
Subject: Re: [PATCH v4 08/10] nbd/server: introduce NBDExtentArray
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20200205112041.6003-1-vsementsov@virtuozzo.com>
 <20200205112041.6003-9-vsementsov@virtuozzo.com>
 <6396ff32-16a3-62fe-1001-fde8b5a4f431@redhat.com>
 <f23161d4-0bff-30aa-6700-70c532ff8db5@virtuozzo.com>
 <18b6e7e8-c4a0-0c9e-e4f1-aa5d460f3592@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200306104440495
Message-ID: <64606846-d9cd-d08c-c4eb-5ef3a2382547@virtuozzo.com>
Date: Fri, 6 Mar 2020 10:44:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <18b6e7e8-c4a0-0c9e-e4f1-aa5d460f3592@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR05CA0211.eurprd05.prod.outlook.com
 (2603:10a6:3:fa::11) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR05CA0211.eurprd05.prod.outlook.com (2603:10a6:3:fa::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.14 via Frontend Transport; Fri, 6 Mar 2020 07:44:42 +0000
X-Tagtoolbar-Keys: D20200306104440495
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4a72d34-5b06-4df5-aafb-08d7c1a23b9b
X-MS-TrafficTypeDiagnostic: AM6PR08MB3270:
X-Microsoft-Antispam-PRVS: <AM6PR08MB32709402D5E2F6635CFA5D04C1E30@AM6PR08MB3270.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-Forefront-PRVS: 0334223192
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(39850400004)(136003)(346002)(396003)(376002)(366004)(199004)(189003)(2906002)(186003)(16526019)(52116002)(6486002)(8676002)(81156014)(81166006)(478600001)(8936002)(4326008)(31686004)(26005)(5660300002)(66946007)(31696002)(66476007)(66556008)(956004)(36756003)(86362001)(16576012)(316002)(2616005)(53546011);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3270;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xcHFCTzajP+zWLTCIDUkG0XOnx+dx8DUbOVW0yDDx5XxLl0VkHQY9gO6t5H/ngju6aK+j6omuF86h4b9J/YHs4LjZr5qCQnkWmay4c/0hYIY/VpG3gi/0o7ZHLWgZPuXLY5fXFDulKrbpPouKTUZg9TCqiYHZ2HWrtH0kPbVsfVpZ5M8KaWAMxNeZmmhiqY75OWzGZ23esTo64r7LOVFG+SjXfaGxlx/hCW8E3BRGiVqa9iTl0ns7jKPGal4//pNDiUivEo2S0N0zY9jbNbOTzKX8cVx3ZxmyCqzcE8l/isFFUZcL7dJaSLtdLwdbEfB+ZXABl0k1Vq5uycz+IfJBRD0hELzCQq3qR7gCwOEQjutNnBTIXfCylCFY+wDrkAvR1zGMjaCfANm6ZPNOExju8DUumo6Ti3U1CB+s78oAG5P8efpEGfxmowtvHhGN9dX
X-MS-Exchange-AntiSpam-MessageData: puRSNtwAsoicJHnrpauJfC36mvBfSJOIsZjBw/73Usp0C4V9iO4KDLquSf+wrDEaH2R3EYqNwDjibU1lkCwoWxPARDQ9Z3ZUftfrXz0w1Ry6NeL5NMeCQv4vzyMjPT+FbEjkO6+oDAND19/yT5a5XQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4a72d34-5b06-4df5-aafb-08d7c1a23b9b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2020 07:44:42.7283 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cARsWdUIPgZfVAR9aGlzBECOBij3WtVXg3MOUKGGqNugObZ0Y2tV+zhGF/A6QjI8f7tve/xzrK9kQQ1Dqq6HceYUDhb0x//1RlW43yXVf7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3270
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:111:f400:7e1b::708
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
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

27.02.2020 16:21, Eric Blake wrote:
> On 2/27/20 6:46 AM, Vladimir Sementsov-Ogievskiy wrote:
>> 26.02.2020 18:06, Eric Blake wrote:
>>> On 2/5/20 5:20 AM, Vladimir Sementsov-Ogievskiy wrote:
>>>> Introduce NBDExtentArray class, to handle extents list creation in mor=
e
>>>> controlled way and with fewer OUT parameters in functions.
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>> ---
>>>> =A0 nbd/server.c | 210 +++++++++++++++++++++++++++++------------------=
----
>>>> =A0 1 file changed, 118 insertions(+), 92 deletions(-)
>>>>
>>>
>>>> +
>>>> +/* Further modifications of the array after conversion are abandoned =
*/
>>>> +static void nbd_extent_array_convert_to_be(NBDExtentArray *ea)
>>>> +{
>>>> +=A0=A0=A0 int i;
>>>> +
>>>> +=A0=A0=A0 assert(!ea->converted_to_be);
>>>
>>> Comment is stale - further modifications after conversion are a bug tha=
t aborts the program, not abandoned.
>>
>> I always thought that "abandoned" is something that must not be done, so=
 the word works here. But I don't know English well).
>=20
> Rephrasing my comment, further modifications are "a bug that aborts the p=
rogram", rather than "an ignored action that gets abandoned".
>=20
>> May be:
>>
>> "No further modifications of the array allowed after converting to BE."?=
=20
>=20
> Yes, that wording is better.
>=20
>> Is it better?
>>
>> Or just drop the comment.
>=20
> That's also viable; the code reads fairly well even without the comment.
>=20

OK, let's just drop it.

--=20
Best regards,
Vladimir

