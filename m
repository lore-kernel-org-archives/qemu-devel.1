Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B67C35DEE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 14:31:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3DB024656
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 14:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="BxUQlgp+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3DB024656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7KCe-00023y-Ml
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 09:31:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47246)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j7KBh-0001Xt-5v
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:30:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j7KBf-0002vA-Uk
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:30:53 -0500
Received: from mail-eopbgr00100.outbound.protection.outlook.com
 ([40.107.0.100]:9089 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j7KBb-0002ty-Vw; Thu, 27 Feb 2020 09:30:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VfhSXUEJaMveNV05EirN9OTRCgklIx2hCGw5cl/BPpPIba/6dQTvfz2EnGr7bXFgipBCAoW9aP+/lTaqy7+olf/fj6aCESHi9Wi0cd8UzSBAUFjCIL9hs+9Ig0KwGeS6DkqQyEagAZnSlmsxnyLkkvJa1H0r8UbJlDfUJOsIp+0EF84c/Alpt+nyW+7ABmNlEIf90/cp5EYR/QsBZAw8YIAOuvFAbRUZZRrTTs31/FuJti2gg8GCB9lYf6blW4tRw93utAAISSgLPdhV6dcpRoYBg/OUssu116I4ED/n8u5SjxVQmo5wQLOzI3tl7x7CUtKXmNkrAIx0arEa/Wjvnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDL8qxV/B+Zr3Teo1xuBlyatfgYxtuXKwe00FlRw4Bo=;
 b=fIXqdkDqr8YJMzbf4XU2t9KEjIMB2z570asYpOI9mynvpskeWufxz8CK9k3KGQ746rCEpy8X2LnroecObRv1NKFpLBONCgI3/iBIzP1qrMrrh4BOcpGeGUcFFaGYvKv+UEVjB7LpD1u167ZAPdUF5koySVn/jYCejsI+MflgDD37GHi9h+ighLpeWPwrNyx8pai3/9n8Xpdd49nNqZdydls7Eqlln8GcqO0t2j0xLCVXxq1FHYd7IncLe5trUxckpM6fZ59RXAlIyrbQY6uWgdwYAi9bGKGL6DHQQv/YCskb0xgO2Vswzo6BNl5lXNfDaczXQYNvSr8Hpc+b8Grlfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDL8qxV/B+Zr3Teo1xuBlyatfgYxtuXKwe00FlRw4Bo=;
 b=BxUQlgp+2yo/EYkfVfxNc2VyZkLyg02pcJo2OIb5XgxLAUTFoOyaWZJV/x8BiqEsXwOhQV6ig+oE+DheIcUnFECKYjyM0zpg6zvlZ87NnpmknY9STFTTEg/DWxDp9CJPIbUP6iKgck7LrmIUXoISw+mi/0f2vz8XMpDo2yQoT0w=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from VI1PR08MB4432.eurprd08.prod.outlook.com (20.179.28.138) by
 VI1PR08MB3984.eurprd08.prod.outlook.com (20.178.204.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Thu, 27 Feb 2020 14:30:45 +0000
Received: from VI1PR08MB4432.eurprd08.prod.outlook.com
 ([fe80::91aa:2540:62c:aeda]) by VI1PR08MB4432.eurprd08.prod.outlook.com
 ([fe80::91aa:2540:62c:aeda%5]) with mapi id 15.20.2750.024; Thu, 27 Feb 2020
 14:30:45 +0000
Subject: Re: [PATCH v1 1/8] qcow2: introduce compression type feature
To: Eric Blake <eblake@redhat.com>, Denis Plotnikov
 <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200227072953.25445-1-dplotnikov@virtuozzo.com>
 <20200227072953.25445-2-dplotnikov@virtuozzo.com>
 <501fde69-f116-a3b9-0356-05708f0b78b7@redhat.com>
 <78aa28c9-49a4-ac0a-51c5-e3587f46603d@virtuozzo.com>
 <e93ca287-07c0-c6f9-c490-31954bcde274@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200227173041972
Message-ID: <e166d252-37ae-7b56-8ff4-d8524e055eed@virtuozzo.com>
Date: Thu, 27 Feb 2020 17:30:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <e93ca287-07c0-c6f9-c490-31954bcde274@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1P190CA0057.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::46)
 To VI1PR08MB4432.eurprd08.prod.outlook.com
 (2603:10a6:803:102::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1P190CA0057.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::46) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Thu, 27 Feb 2020 14:30:44 +0000
X-Tagtoolbar-Keys: D20200227173041972
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d235ff5-2990-4117-3023-08d7bb91a177
X-MS-TrafficTypeDiagnostic: VI1PR08MB3984:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB39849B2EAA3C4C379BC43B3FC1EB0@VI1PR08MB3984.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 03264AEA72
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(136003)(376002)(346002)(39850400004)(396003)(366004)(189003)(199004)(2906002)(36756003)(66556008)(6486002)(52116002)(956004)(2616005)(66476007)(66946007)(478600001)(8676002)(5660300002)(81156014)(16576012)(110136005)(8936002)(53546011)(81166006)(186003)(6666004)(26005)(316002)(31686004)(31696002)(4326008)(86362001)(16526019);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB3984;
 H:VI1PR08MB4432.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JE6DFvQzURE9SoMxx8hKgonyUIy/sUo40Xn8bHZS0J92tBp11M9Fe6Ds2a5aqGQzXfZbfQpWmJ87sXb+RjgmeoKkxSZEWV9lGCNBRV17+D0oHvjU5CldcWVn9XZS1aaS84igpYifWNoL6tgR0oZMUUP4QcZ5rdJfcV0uM2PxRUqLZVqfgTq+/L9vP5cHykQu3B4760ryD693PeZkwuv3LxPoNpc01ud6t4uCfboIoCF2nLD1RWAJVSD4odjZj4Cr5lAQemGyOmYq8qicbnyLMlzbprRR48osyFbJTBG9cQChV6/+Q3s3GQ32YaLsXlgGcwazmkHRImAQuujM3h2UDTUTK1j1XRKfzyAh8e7epfsyCuasQmamUfoGaQOdZbCjV+tFpIrMO+lS4GYyJ5WefQk0A1ubYDxUOygYxcrO6NjyBx/Ph7ulVBIfShhabvac
X-MS-Exchange-AntiSpam-MessageData: n/4znOswovwCz7yVYnBgkW9G7DNdkXEoin+LioY2Tt7Znd/oTOKAN4XO90NiRlT+J0UaqASBKujpGJ/YPrI9UQtL7qo9KXKbTZP31mE7Hn6mk1ZZbOgNVnslv01E7po6uYC9NJ1tZeAyR0t3cbZg2Q==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d235ff5-2990-4117-3023-08d7bb91a177
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 14:30:45.1298 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OvYK9nLW8c3pPTQlMLcCkUmk50PBQdxrgPFIah2lQ2rOg9JV6N//nCtmEdoyM3uqYp1ifxGFSJ2PaSCipSUjSnPJS9BpZDWUw8flkvLYo3w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3984
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.100
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
Cc: kwolf@redhat.com, armbru@redhat.com, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

27.02.2020 17:13, Eric Blake wrote:
> On 2/27/20 7:59 AM, Vladimir Sementsov-Ogievskiy wrote:
>=20
>>> Hmm - I think it may be worth a tweak to qcow2.txt to call out:
>>>
>>> 104: compression_type
>>> 105 - 111: padding, must be 0
>>>
>>> or else call out:
>>>
>>> 104-111: compression type
>>>
>>> and just blindly use all 8 bytes for the value even though really only =
1 or two values will ever be defined.=A0 Of course, that moves the byte in =
question from 104 to 111, thanks to our big endian encoding, but as this se=
ries is the first one installing a non-zero value in those 8 bytes, and as =
we just finished documenting that the header length must be a multiple of 8=
, there is no real impact - we can make such tweaks up until the 5.0 releas=
e.
>>
>> But what is the benefit? We have already documented padding in the spec,=
 and discussed it so much time... What is the problem with padding? And why=
 to add 8 bytes for every new feature which needs only one byte?
>=20
> Okay, so requiring an 8-byte field is not necessary.=A0 But still, at lea=
st mentioning padding bytes (that may be assigned meanings later) is consis=
tent with the rest of the document (for example, we have padding bits docum=
ented for the compatible/incompatible/autoclear feature bits), and reminds =
implementers to keep size rounded to a multiple of 8.
>=20

Yes, we can add something about it.. But I'm not sure we need, and I can't =
imaging correct short wording.


We have section about padding:

"
=3D=3D=3D Header padding =3D=3D=3D

@header_length must be a multiple of 8, which means that if the end of the =
last
additional field is not aligned, some padding is needed. This padding must =
be
zeroed, so that if some existing (or future) additional field will fall int=
o
the padding, it will be interpreted accordingly to point [3.] of the previo=
us
paragraph, i.e.  in the same manner as when this field is not present.
"


So, if we want to add something about 104-111, it should be added to this s=
ection, not to previous "=3D=3D=3D Additional fields (version 3 and higher)=
 =3D=3D=3D".

And, if we want, to add something, we should consider both cases when compr=
ession type field exists and when not... What to write?

"105 - 111: These bytes are padding, if header length > 104. May be turned =
into new additional fields in future."

Sounds a bit strange... Keeping in mind that different versions of qemu may=
 consider the same bytes as additional field or as padding, and it is corre=
ct.


--=20
Best regards,
Vladimir

