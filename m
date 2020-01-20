Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6773C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 16:41:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3AAD2073D
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 16:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="vPj9LDY5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3AAD2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ita73-0006GA-NE
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 11:41:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60898)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ita6M-0005f2-JE
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 11:40:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ita6L-0003aF-7L
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 11:40:34 -0500
Received: from mail-vi1eur04on0706.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::706]:36333
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1ita6H-0003Xx-OG; Mon, 20 Jan 2020 11:40:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aWvxJxRrOHDnnDepu+lVZOU34ZgleQjKl31ZXro+X9NZtq0lYyTg+FrMo0+gauZFMr90EI6pxSMnko1z3HuNRCynF2t3y08mAovRQUOzdJBBxN6g3OPkU4hY4/4pMy7Az72IAFB1m2tc1h4dlaTGQJbWakI1hmNcRedecl5I4Dyxn3e60+yWDlG1KZN4YcNiiID74q7IqsJThQYm4wu6d1IQN5PkJg4WIAqF+zYcBjca1tZ0p/n2UpZdski9te0YgGzNdZb2P3dJ/Vsb/LliWN5JMJziS/VhdpKKaRTHgLc5bSQlJgv4IQq+8AJzwlISZEMS0v+lBCC8y3hlQtJbvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZgg5Tr2/0Cc9XgG2tHkQ+h6FOdBBXzy1l3jRrflmFc=;
 b=ihsOWT5x985vYqKubpn8xYhAmv6Q8ZXSLjoP8SPHB9WpkHvbpXQOybw29BJOttzR644pleyUsu/qJUNgVWRJQuasrj+7imeYryqKMbP69/LPHqfWrbb1WCn67W31btKBIZLrE3dMgv9rd/9dfruuiLpCsKF1Pu52Sr5/JTl12jXnnAzN2G1kg5bnbuooQbtjP68+9wRXGNavMDLx3hwIQn029Ofvybgdvk+hjAk/OgyrtxmEBqsbggEhDF3KLUaBP5hSn2CyU1QWxKw5c5qTDrv4xNMBlE5dHcNnHYIQ9HSstv2W/T5lDkBHyUo2XNDp7X5DrJVvFvKJoL9vBMYhng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZgg5Tr2/0Cc9XgG2tHkQ+h6FOdBBXzy1l3jRrflmFc=;
 b=vPj9LDY5DX+1Vs9J1nbdVFvn4uXBRFvSYGcm8IsEOrtdjMCil2Jy2T3yTkNPEsARoJbaKxL2GNKzllTA0Uczjm8RTere1I4DmemciT6rWFG8gy2i3tgXmMmAQb07LkfLGn/Zpmj8IudoV/y56K08GiIpdKFAk1F/VPxKORl/kKg=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3381.eurprd08.prod.outlook.com (20.177.112.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.25; Mon, 20 Jan 2020 16:40:27 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2644.026; Mon, 20 Jan 2020
 16:40:27 +0000
Received: from [172.16.24.200] (185.231.240.5) by
 FR2P281CA0002.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19 via Frontend Transport; Mon, 20 Jan 2020 16:40:26 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v9 1/2] docs: improve qcow2 spec about extending image
 header
Thread-Topic: [PATCH v9 1/2] docs: improve qcow2 spec about extending image
 header
Thread-Index: AQHVtArSHFWfTfRx3UmcBd6H6yeWvqfz7jMAgAAKWIA=
Date: Mon, 20 Jan 2020 16:40:27 +0000
Message-ID: <c729a426-94be-8a54-e134-d030dfa70d4c@virtuozzo.com>
References: <20191216121733.63562-1-vsementsov@virtuozzo.com>
 <20191216121733.63562-2-vsementsov@virtuozzo.com>
 <5ec4a89e-ea37-d46c-f006-2f47d6f9b736@redhat.com>
In-Reply-To: <5ec4a89e-ea37-d46c-f006-2f47d6f9b736@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: FR2P281CA0002.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::12) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20200120194025515
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b235922d-55aa-458d-5af3-08d79dc7744e
x-ms-traffictypediagnostic: AM6PR08MB3381:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB3381D5FBA5D05D4921DF5F48C1320@AM6PR08MB3381.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0288CD37D9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(376002)(396003)(39840400004)(346002)(136003)(189003)(199004)(6486002)(478600001)(4326008)(66446008)(66556008)(64756008)(52116002)(2906002)(107886003)(2616005)(81166006)(81156014)(956004)(8676002)(110136005)(71200400001)(54906003)(16576012)(5660300002)(316002)(8936002)(53546011)(31686004)(66476007)(186003)(26005)(86362001)(66946007)(36756003)(16526019)(31696002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3381;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q+9EmwVOllpDTpcQJbdKPIqT1qbwEtoW8/5YOPqwrsH46SQz6wqa8zKLyT8ezvFAQzfhlBlucsbYXRhpXkUczP4hnBb4jvf1mIgsXzu1NLrx+gUFtSTOuFNRXwXZYr4DwzA8QwFdAz/DRSNC6XWv9VDN/y4EBOGkNFICvPrAFsPb84xd9Fym2WOxkhc6hQ1G7FVHS9wvnmZc9wLKyILRJBBoEiWOZ/tfaXBsEleZQtAl7wSXv7PcQyDxRFhPMroGGSutyE6+2wWB6YaBiYDep32Hno4pRywhVBhZV7qNuiqBnPiH6C8XQ081picTBsakSyRbK1u3XmkYNvHLAXY5h2NTQ7kazqbq0uz40D5RzhmQYBeuDylVACpiiOwZoropdAh8VpPZ37ghkHARuWbqyhjHaCLZdz6z9hMJL2uLaUIFaIEVskolGhBkrm/um8O6
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <5F181E9073252D4586CC7617FB7E4EB8@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b235922d-55aa-458d-5af3-08d79dc7744e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2020 16:40:27.2558 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DDocH0+hghdDiw4GyXUoXT+u63H5qiFWle3Vxxes1FZg/wOQTbujFbsAJEm5tXuFYQ0YzoOGymIta8up8BH8FVPnXYomwiK/260NLBhpatU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3381
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0e::706
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

20.01.2020 19:03, Max Reitz wrote:
> On 16.12.19 13:17, Vladimir Sementsov-Ogievskiy wrote:
>> Make it more obvious how to add new fields to the version 3 header and
>> how to interpret them.
>>
>> The specification is adjusted so for new defined optional fields:
>>
>> 1. Software may support some of these optional fields and ignore the
>>     others, which means that features may be backported to downstream
>>     Qemu independently.
>> 2. If we want to add incompatible field (or a field, for which some its
>>     values would be incompatible), it must be accompanied by
>>     incompatible feature bit.
>>
>> Also the concept of "default is zero" is clarified, as it's strange to
>> say that the value of the field is assumed to be zero for the software
>> version which don't know about the field at all and don't know how to
>> treat it be it zero or not.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   docs/interop/qcow2.txt | 39 ++++++++++++++++++++++++++++++++++++---
>>   1 file changed, 36 insertions(+), 3 deletions(-)
>=20
> I put review of this off for so long because I always waited for Eric to
> give his R-b, but maybe not.
>=20
> I generally think that he=92s stricter on what to write in documentation,
> and accordingly I only have nit picks on spelling and structure:

This is very helpful too, thanks.

I'll resend now with your suggestions, to make it easier to read for others=
.

>=20
>> diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
>> index af5711e533..d92c827763 100644
>> --- a/docs/interop/qcow2.txt
>> +++ b/docs/interop/qcow2.txt
>> @@ -79,9 +79,9 @@ The first cluster of a qcow2 image contains the file h=
eader:
>>                       Offset into the image file at which the snapshot t=
able
>>                       starts. Must be aligned to a cluster boundary.
>>  =20
>> -If the version is 3 or higher, the header has the following additional =
fields.
>> -For version 2, the values are assumed to be zero, unless specified othe=
rwise
>> -in the description of a field.
>> +For version 2, the header is exactly 72 bytes in length, and finishes h=
ere.
>> +For version 3 or higher, the header length is at least 104 bytes, inclu=
ding
>> +the next fields through header_length.
>>  =20
>>            72 -  79:  incompatible_features
>>                       Bitmask of incompatible features. An implementatio=
n must
>> @@ -164,6 +164,39 @@ in the description of a field.
>>           100 - 103:  header_length
>>                       Length of the header structure in bytes. For versi=
on 2
>>                       images, the length is always assumed to be 72 byte=
s.
>> +                    For version 3 it's at least 104 bytes and must be a=
 multiply
>=20
> s/multiply/multiple/
>=20
>> +                    of 8.
>> +
>> +Additional fields (version 3 and higher)
>=20
> If this is supposed to be a heading, maybe it should enclosed by =93=3D=
=3D=3D=94
> on both sides.
>=20
>> +
>> +In general, these fields are optional and may be safely ignored by the =
software,
>> +as well as filled by zeros (which is equal to field absence), if softwa=
re needs
>> +to set field B, but don't want to care about field A, which precedes B.=
 More
>=20
> s/don't/does not/ (or maybe s/don't want/does not/)
>=20
>> +formally, additional fields have the following compatibility rules:
>> +
>> +1. If the value of the additional field must not be ignored for correct
>> +handling of the file, it will be accompanied by a corresponding incompa=
tible
>> +feature bit.
>> +
>> +2. If there are no unrecognized incompatible feature bits set, an unkno=
wn
>> +additional field may be safely ignored other than preserving its value =
when
>> +rewriting the image header.
>> +
>> +3. An explicit value of 0 will have the same behavior as when the field=
 is not
>> +present*, if not altered by specific incompatible bit.
>=20
> s/by specific/by a specific/
>=20
>> +
>> +*. Field is not present when header_length is less or equal to field's =
offset.
>=20
> s/Field/A field/, s/field's/the field's/
>=20
> (maybe also +considered, as in "A field is considered not present...")
>=20
>> +Also, all additional fields are not present for version 2.
>> +
>> +        < ... No additional fields in the header currently ... >
>=20
> This looks a bit weird to me, but the next patch will remove it again,
> so who cares.
>=20
>> +Header padding
>=20
> Same heading note here (I=92d make this =93=3D=3D=3D Header padding =3D=
=3D=3D=94).
>=20
>> +
>> +@header_length must be a multiply of 8, which means that if last additi=
onal field
>=20
> s/multiply/multiple/
>=20
>> +end is not aligned, some padding is needed. This padding must be zeroed=
, so that,
>=20
> I think s/last additional field end/the last additional field=92s end/, o=
r
> maybe s/last additional field end/the end of the last additional field/.
>=20
>> +if some existing (or future) additional field will fall into the paddin=
g, it
>> +will be interpreted accordingly to point [3.] of the previous paragraph=
, i.e.
>> +in same manner as when this field is not present.
>=20
> s/in same/in the same/
>=20
>>  =20
>=20
> I think there should be a new heading here
> (=93=3D=3D=3D Header extensions =3D=3D=3D=94).
>=20
> Max
>=20
>>   Directly after the image header, optional sections called header exten=
sions can
>>   be stored. Each extension has a structure like the following:
>>
>=20


--=20
Best regards,
Vladimir

