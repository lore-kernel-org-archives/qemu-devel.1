Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C749C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 18:16:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A44A20CC7
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 18:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="h2FPDIG7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A44A20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixaqA-0006JH-Gf
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 13:16:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53704)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ixapR-0005t7-26
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 13:15:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ixapP-0001YQ-OC
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 13:15:40 -0500
Received: from mail-eopbgr50113.outbound.protection.outlook.com
 ([40.107.5.113]:43540 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1ixapP-0001Rj-1A; Fri, 31 Jan 2020 13:15:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cD279Tb9pjR7psZdg1WE4wId7igUTsdkIcDwm9VDllOczZUtRD8UJGDJSk40ysQ8xMbrD5+jPqcDLWhiffGasFav18svIPet7Xe/XwND+Ijq+5sqZBBuj5h2t/4pxWMwuD7wIzBzThsQ4cFFj7Yo7V07rQBudKMCKoacVKmmiK0vFzVQD5qYY+CZmefwX+nZ6vZ5Xdy2RFSjRgdniy38ZgGm7XLtEnXneizN/Sa/xXaRiLFugYjaox/zkHeh1tisuI8540M+CGyo2tMLBd4YTpWt8+NntziRXmR+HvD3CgyLZfeIgo1KjusXIkNA09VKu/oUiYeImBQNV8o3r1OtQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=04QGv3P+TUtYwypi8j4VBy53rs8z7EvwIMe+R4U94Vw=;
 b=mm1let7hKXlL0VSdzKKhsGVA+Tgt4yfu2wrIa5venSj9sxJh0iyPJteTL1EOwXAqwkZzMe1Fb38Hge5f029EzDB/tKE2loRUIFmBxMqsgDwcfFgajfSoC+hmHURwAoZB1itWjy0ihEaV84SyScHnfPWT6Mlmvddo0lsz/KnQnXmJpGyj+hKR6UafE0g7vCXNbbYZ/Z7aE7DMWrAHfuPfT+jFs9mO8lDMLNmyQFOUMSNEkgbGpClvW0DGZwr1TfJDgJeyqCJDdFGhvB0GLRkaH9dfsYhgGmMzZNzqn3ChEB3fRasHBp0MVDiheBwyYD6+LNamt0hIkc5cM75tB4VOIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=04QGv3P+TUtYwypi8j4VBy53rs8z7EvwIMe+R4U94Vw=;
 b=h2FPDIG7k/Hp+ITt2niaF6i7Vd2o3WN/AvvnR4lEIL8bLmscbGySQNMDm2evCOvoVJDR/iwqOaxY4/XjtaGvdXjy+Mq/fjZ3rMA7qr3pNKTfOssjyroHoZJLJSt805pVLFZC/KIURnF+H9FYw6dANAA6Ge2/vsWZk/9tqUMSn1Y=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB5029.eurprd08.prod.outlook.com (10.255.121.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.21; Fri, 31 Jan 2020 18:15:36 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2686.028; Fri, 31 Jan 2020
 18:15:36 +0000
Subject: Re: [PATCH v11 2/2] docs: qcow2: introduce compression type feature
To: Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-block@nongnu.org
References: <20200131142219.3264-1-vsementsov@virtuozzo.com>
 <20200131142219.3264-3-vsementsov@virtuozzo.com>
 <ee6b018a-be33-ed77-c4b9-4894c685d30a@redhat.com>
 <w51mua3zg16.fsf@maestria.local.igalia.com>
 <18578060-2c1f-6c63-31e1-dee51387210a@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200131211533699
Message-ID: <aa9050a1-b071-6e08-bb91-8b513de09180@virtuozzo.com>
Date: Fri, 31 Jan 2020 21:15:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <18578060-2c1f-6c63-31e1-dee51387210a@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1P190CA0026.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::15)
 To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
Received: from [172.16.24.200] (185.231.240.5) by
 HE1P190CA0026.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.20 via Frontend Transport; Fri, 31 Jan 2020 18:15:35 +0000
X-Tagtoolbar-Keys: D20200131211533699
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed38061f-1ce3-4eef-22c4-08d7a67991a1
X-MS-TrafficTypeDiagnostic: AM6PR08MB5029:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB5029D7DE8CF1CA8A1B5A02F0C1070@AM6PR08MB5029.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:422;
X-Forefront-PRVS: 029976C540
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(376002)(346002)(366004)(136003)(396003)(39850400004)(189003)(199004)(8936002)(186003)(16526019)(66946007)(16576012)(110136005)(66556008)(66476007)(36756003)(26005)(31686004)(2906002)(52116002)(956004)(81156014)(53546011)(31696002)(86362001)(8676002)(81166006)(478600001)(4326008)(2616005)(6486002)(5660300002)(316002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB5029;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Y7+YWe7YZ33Qc5E0nY1z8vCKzc5ht8ukOijb14UGwFsgniPaSDsjcl5022EZJ0hOvI5AwoNdh9WtOUd9T043LG8suLD7bbuhp9v81hWYsBJJnNFKWidcXFBYJcEF9zhX9ELS9q33uRmOxZCOhUcRD4ZA17aJ1UfNuEH+s/7PfyRpBj1N1W0C0Z0MMzn6BckAI6rtBou3n60OIOYwz3sOrZxktkwheey0KMR+pfg6XXaKEFH5HykfPiTvR25Oj05NOw2AQ6Ia9gE+T0KLpMDiw8iL4/y+gfSywZfmbhcwMO//0Ooo4cluOk4xUb+wYJvTrhH9N/8RaVtM+hxWvFFQuN4axSh0jk4enJuXEob/vzcagIW6igIrgdxp8CBDjdlqH/rU3byR67FGbuqAIbBJRluzNkGUIb3lOlyf/Mmopp7a8FV95HDGNwphfo6u++8
X-MS-Exchange-AntiSpam-MessageData: BShUYmqrVPVchh6fnTbkYXaHBVsWV+b+sRQCnWw8wxJDBUh1FnSJGmXTV49nGqt/1qcFE4prDyqJH5rHNLNJdcnj5MvimqP1HMHAHFki2OR2gRUbuftLU9qA1Xe7e5Yrwx+yOGdcF36sG1o27V1BuQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed38061f-1ce3-4eef-22c4-08d7a67991a1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2020 18:15:36.2603 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SNu+6EkYtovgo4pX91WsBymmRUTM6pD3Rm0y+w5A1tdsmXs3WcZvS8QrUA05UsdVgeGHFwSh2hAY7jSiTcoWs3hKC1Otn58iYwtEOMXrfxc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5029
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.113
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 mreitz@redhat.com, dplotnikov@virtuozzo.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

31.01.2020 20:49, Eric Blake wrote:
> On 1/31/20 11:34 AM, Alberto Garcia wrote:
>> On Fri 31 Jan 2020 03:46:12 PM CET, Eric Blake wrote:
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 If the inco=
mpatible bit "Compression type" is set: the field
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 must be pre=
sent and non-zero (which means non-zlib
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 compression=
 type). Otherwise, this field must not be present
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 or must be =
zero (which means zlib).
>>>
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 If the incompatible bit "Compressi=
on type" is set: the field
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 must be present. Otherwise, this f=
ield must not be present
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 or must be zero (which means zlib)=
.
>>
>> But "not being present" and "being zero" is equivalent (as described in
>> the previous commit).
>>
>> And if the incompatible bit is not present then the field can be safely
>> ignored (i.e. whether it is zero or not is irrelevant).
>>
>> Let's try again:
>>
>> =A0=A0=A0 Defines the compression method used for compressed clusters. A=
ll
>> =A0=A0=A0 compressed clusters in an image use the same type.
>>
>> =A0=A0=A0 The value of this field should only be used when the incompati=
ble bit
>> =A0=A0=A0 "Compression type" is set. If that bit is unset then this fiel=
d is
>> =A0=A0=A0 not used and the compression method is zlib.
>=20
> I like that wording.
>=20

I'm OK with it too, as well as I'm OK with the stricter variant, when we do=
n't allow incompatible images with zlib set. I don't see any serious differ=
ence.

But I need this to land somehow. Max likes stricter variant and he is maint=
ainer of qcow2..

Max, will you merge it as is, or did you change your mind, or should we ask=
 Kevin for his opinion?

--=20
Best regards,
Vladimir

