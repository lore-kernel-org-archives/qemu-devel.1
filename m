Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C491BC33CAF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 17:08:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ECE321739
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 17:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="pyeIemxM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ECE321739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir3Co-0001Gb-LZ
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 12:08:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60125)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1ir36i-00011z-06
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 12:02:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1ir36g-0000EM-GJ
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 12:02:27 -0500
Received: from mail-eopbgr150092.outbound.protection.outlook.com
 ([40.107.15.92]:60762 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1ir36f-0000BV-Th; Mon, 13 Jan 2020 12:02:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rhfz3rW2ZtT9MSY5xev+BjwElpqSx7uuhWUAjMChxcxaNWoFEA6aBA5IwrprT1KPMNTKA/f91KUCj4ASgbAODLF3FAiNnxV3jw2Ga/1sK0jWTUBLTc6wAfMxi2yUqqzTU69xUB2fqedd31xh75dE/xvqmy4qoJoiznUM8c3ElvCxTBMX1AfVcoA0gA6H6wgS2luFCjwvgJf6xUdUDw+f75l/qOLlQactgBGd1DJu/ZA9FGd38Vy7AycjkTR9LQUY7YnVjPODlYVw3K6cZGcwqaLivEV0OK23bWyES5eqOPnSOwBEhTjrUMMuEioq+mSlq75CJLjv8elA9QSZlMv0pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=80dlTYfaxoITFOHUQmSiJYyQiv+1bnR1eDO66eDaEfM=;
 b=XFZKba7iqIxcJhlHmhpNUAhR6iCBpYo5U2zImEI0q7d82LnBN7uLvsnumLXrwAONmwGty/45Ib8PB7b8ZbzeLEWFLMA1fhTqxL9pDA8f6RJq4x4NGVLbFOxW6pGwytHwUj/r2sczhFRziMhRkpbz1kHCrw3a54x3JTSI+NhoFxLoZnKlU0o+BjdHexsvnM8EUSm+yeo9bJgTrgYOZGY3yXEwAymIs/TL8KQTWqeGPyiRIsa19tIKLDdWJKQi61nnN3cLgQN/vevE9oW1IN9GLfvmwxJBzlBPpLYhq79ORPDXjrAWgZ1ncYWvXYG4eG1Tk0tMt/FUHZ3qq5+R3DkwVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=80dlTYfaxoITFOHUQmSiJYyQiv+1bnR1eDO66eDaEfM=;
 b=pyeIemxMZxdR7iUpI1eHmbxVVZP+I24s4VXO2AFeFEdWq4Q91X7u1VCuDD2bMbBp1tHUDGvIHF4HN/CF0WLBaJdmHTUIcIs6EpAZennUSdbX2GK8n54YMWn5hisHRhk5nro3N79+TaekVLEUiTnnyB+Wm8n0lj2bYlcxAQcqFv4=
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com (10.255.123.95) by
 AM6PR08MB3223.eurprd08.prod.outlook.com (52.135.167.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.8; Mon, 13 Jan 2020 17:02:23 +0000
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::8805:5633:ca46:c8c8]) by AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::8805:5633:ca46:c8c8%7]) with mapi id 15.20.2623.015; Mon, 13 Jan 2020
 17:02:23 +0000
Received: from [172.16.24.225] (185.231.240.5) by
 HE1PR1001CA0014.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:3:f7::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9 via Frontend Transport; Mon, 13 Jan 2020 17:02:23 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH 2/2] qcow2: dump QCOW2 metadata
Thread-Topic: [PATCH 2/2] qcow2: dump QCOW2 metadata
Thread-Index: AQHVvKr5leVV3xekykyII1O3QjNCBqff1XKAgAjcZACAAC5hAIAADOOA
Date: Mon, 13 Jan 2020 17:02:23 +0000
Message-ID: <da049f97-9eac-9c07-cf4b-a390d8c24000@virtuozzo.com>
References: <1577447039-400109-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1577447039-400109-3-git-send-email-andrey.shinkevich@virtuozzo.com>
 <d87d183d-cd69-1994-11d0-5767ec72589e@redhat.com>
 <be0bf681-5551-c5ec-e7b3-3589fb230176@virtuozzo.com>
 <cedf0e08-8994-a892-85dc-bf0dea221163@redhat.com>
In-Reply-To: <cedf0e08-8994-a892-85dc-bf0dea221163@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR1001CA0014.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::24) To AM6PR08MB5048.eurprd08.prod.outlook.com
 (2603:10a6:20b:ee::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 34811d1a-745d-4e4f-d8f6-08d7984a5c06
x-ms-traffictypediagnostic: AM6PR08MB3223:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB3223EB09E235C255877A4691F4350@AM6PR08MB3223.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 028166BF91
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(396003)(346002)(39840400004)(366004)(376002)(55674003)(199004)(189003)(86362001)(52116002)(6486002)(8936002)(16576012)(316002)(2906002)(2616005)(956004)(31696002)(26005)(16526019)(110136005)(186003)(53546011)(71200400001)(36756003)(54906003)(8676002)(81156014)(81166006)(107886003)(478600001)(44832011)(5660300002)(4326008)(66556008)(64756008)(66446008)(66476007)(31686004)(66946007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3223;
 H:AM6PR08MB5048.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: otcf3In87HTVAuoRKa+gx9Stlhy/UOvJ4ByD17FdfqqHatlKhXjhMyeNAhAd3YXB8YFC5TaPLYWLooVvLCWPO6BMjs6TJnk61r5p2qSp9s9AUgWBDhCo7GAfQw3nBznHXEmKG/yPeMe8pKoeQqcvDXxl1bMU9qeZD9Ghjy3TCrhvfAxkSvx8XbMckNU+1zENTTWRDsZFWnJZTnnBSLtUs17u6olbFuzV6Vnt/HT3Ge8KygjbsMxHtJoNQhSMjxqjrjA6GB0pUH6+V3867SuC1Wrqw7BQzQXZ+KheYCcpFw+Bm8l8gANYIK0pn9qNqCcLfVTASYIHqeWvz0+Dj31eiojS6vNsSnlX7SgPI5EhsZSGGKQNxx2BaxkPN+WrtpyX3rEI04rgjtrt2Ot6gJ4DHYeu9tdADo/ZrD5Rbkwpm7GWDaHN2nFHxvIasdHCNuMfXzw9mIyKiWahdnqxIiaKwbHqqXaqRNjErhMinmNR8YpU1zrO0G7KY3znqXRj2O/x
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <25CC7E11BE856149B13EB838FEB0754E@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34811d1a-745d-4e4f-d8f6-08d7984a5c06
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2020 17:02:23.6198 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K9t4qlCx3eGavPtf0xxmR6gQb9LUDj6I+wdPRd9IUA6YrqIxIpJEUOUMEq6dm8n0Xn9L0Mq7inRzBJkO6UpCOpsViDol+7wrCxkAtVCUWGQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3223
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.92
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Denis Lunev <den@virtuozzo.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 13/01/2020 19:16, Eric Blake wrote:
> On 1/13/20 4:30 AM, Andrey Shinkevich wrote:
>=20
>>>> -=A0=A0=A0=A0=A0=A0=A0 c =3D getopt_long(argc, argv, ":hf:r:T:qU",
>>>> +=A0=A0=A0=A0=A0=A0=A0 c =3D getopt_long(argc, argv, ":hf:r:T:qU:M",
>>>
>>> We are already inconsistent, but I tend to add options in alphabetical
>>> order, both here...
>>>
>>
>> If I merely move 'M' forward like ':hf:M:r:T:qU', will it be OK?
>>
>=20
> If you don't mind writing a pre-requisite patch that sorts the existing=20
> options, then the patch adding your option in sorted order is easy. But=20
> that's asking you to do extra work, which I'm not going to insist on, so=
=20
> I can also live with your patch being in any order as it is no worse=20
> than existing code and anyone that wants to do a cleanup patch to sort=20
> things has roughly the same level of effort whether or not your patch=20
> without sorting lands in the meantime.
>=20
>=20

Yes, I don't mind. It is easy.


>>>> +=A0=A0=A0 if ((fix & BDRV_DUMP_META) && output_format !=3D OFORMAT_JS=
ON) {
>>>> +=A0=A0=A0=A0=A0=A0=A0 error_report("Metadata output in JSON format on=
ly");
>>>> +=A0=A0=A0=A0=A0=A0=A0 return 1;
>>>
>>> Why this restriction?
>>>
>>
>> This is to remind a user that '-M' can be effective with the option
>> '--output=3Djson' only. Do you think that a comment in the qemu-img.texi
>> would be enough and the restriction should be omitted here?
>=20
> Rather, why can't we come up with some sort of sane human output, so=20
> that we don't have to limit the flag to just --output=3Djson?
>=20

It is not as easy and will incur much more coding. The json output is=20
priority-driven format and can be converted to a human readable one with=20
some other tools if needed. This option is for developers only.

>>>> +++ b/qemu-img.texi
>>>> @@ -230,7 +230,7 @@ specified as well.
>>>> =A0=A0 For write tests, by default a buffer filled with zeros is writt=
en.
>>>> This can be
>>>> =A0=A0 overridden with a pattern byte specified by @var{pattern}.
>>>> -@item check [--object @var{objectdef}] [--image-opts] [-q] [-f
>>>> @var{fmt}] [--output=3D@var{ofmt}] [-r [leaks | all]] [-T
>>>> @var{src_cache}] [-U] @var{filename}
>>>> +@item check [--object @var{objectdef}] [--image-opts] [-M] [-q] [-f
>>>> @var{fmt}] [--output=3D@var{ofmt}] [-r [leaks | all]] [-T
>>>> @var{src_cache}] [-U] @var{filename}
>>>
>>> This mentions that -M is valid, but has no further documentation on wha=
t
>>> -M means.=A0 Without that, it's anyone's guess.
>>>
>>
>> Thank you Eric, I really missed to supply a comment for the new option
>> here and am going to put it below. Should I mention that option in
>> qapi/block-core.json file also with this patch of the series?
>=20
> Mentioning that the qapi type exists to facilitate a qemu-img option=20
> might not hurt. But more important is that the qemu-img documentation=20
> mentions what -M does; that documentation can point to the qapi docs for=
=20
> how the output will be structured when --output=3Djson is in effect.
>=20

Would you please specify the qemu-img and qapi documentation files to=20
modify? Thank you.

Andrey
--=20
With the best regards,
Andrey Shinkevich


