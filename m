Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D654C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 16:39:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 089DE2073D
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 16:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="bi8WwMpa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 089DE2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ita5O-00050c-45
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 11:39:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60611)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ita4f-0004F7-Hb
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 11:38:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ita4e-0002VN-6h
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 11:38:49 -0500
Received: from mail-eopbgr30113.outbound.protection.outlook.com
 ([40.107.3.113]:27115 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1ita4W-0002QY-9X; Mon, 20 Jan 2020 11:38:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SXbsaJOe7vJsMrtcE2RGvkTCpuCwyBX3dzqlbSUN6h6pcWwfn2jfZj1sM+aYJcP8KPs+/ozUEzp3aX8JSiPoWTQgSURFDk11HQHQG/raAhppy96TQZ9tqZrKb/MDxKkv4vemTsepdUpV9aCY23pS+Yo/8OIOTrOOJqi/GE5qwaHv9vJLJZ+UMMCo1Lha+xZE09aP/+heR8G7q1dsJ0tsBmHUbeTZagyRY71d5k0Gfzg442q6TK0FIRAbY9EBbpbO/oLXkyORlczowqJ8ssx+qKsDymP6sxpZSkly7JnM4eEori/T1ObOdEMK29UzaWbEclz42Q+vHMACl3N11MnLmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9+HJlT6LrVfKf6zIdebvD2uE8R/ZN3aL7vNIj3L9iM=;
 b=kX2wzVmWt/byXEVZyuLfAHy23XzSAixZE0yYWdes+y8i8p0BXW4T23WoR/g43REl1TbrpeM+/7VxHnKW+KOHfUwqqRYbYGo3kQpkWmtVaxqOg+2qR6oBAGOyLSerRWVxVKf4BSuOzEMGjz6XzED3JxKGm63sgGjQ2shQHvSkVBTwHXQZuq++SfaGwKx+NDU3OEuOLoEWUCBsBofcs66oRL45N3y6iIrmQXSlR7v8b0WN22cvPz5Coa6oBwNeRx1WhUkkayqaqGAPxT1IljyaYIQZR27Nxwz+Cez4xHGgmFADzA4SN7dbywPBReZ2sC4b0SLIEscKFPo1Ne8B1DWzaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9+HJlT6LrVfKf6zIdebvD2uE8R/ZN3aL7vNIj3L9iM=;
 b=bi8WwMpaLFbLMEEVBex1GMm8AO9TQLTQyxryiTQqMgB5ZHEfHDCyR6ALTeHfu0dDYxPWLi4pyMtltDolnMXJDwjuxcVa6Z4T0F7fmzaTx11v2MlbCf2N9W6xMjJDBIZTPp9lA1Kal5fKbTOhsT8A8er353pAZN/2RO/ULuMnWOg=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3256.eurprd08.prod.outlook.com (52.135.164.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Mon, 20 Jan 2020 16:38:37 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2644.026; Mon, 20 Jan 2020
 16:38:37 +0000
Received: from [172.16.24.200] (185.231.240.5) by
 AM4PR0701CA0026.eurprd07.prod.outlook.com (2603:10a6:200:42::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.14 via Frontend
 Transport; Mon, 20 Jan 2020 16:38:36 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v9 2/2] docs: qcow2: introduce compression type feature
Thread-Topic: [PATCH v9 2/2] docs: qcow2: introduce compression type feature
Thread-Index: AQHVtArTAyB6+DXpyUK3B9xWdseKMafz8V+AgAAGqYA=
Date: Mon, 20 Jan 2020 16:38:37 +0000
Message-ID: <a5851deb-5571-f044-de4f-851fa676ee5e@virtuozzo.com>
References: <20191216121733.63562-1-vsementsov@virtuozzo.com>
 <20191216121733.63562-3-vsementsov@virtuozzo.com>
 <d1856518-c246-75bf-abaf-2711b332437f@redhat.com>
In-Reply-To: <d1856518-c246-75bf-abaf-2711b332437f@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM4PR0701CA0026.eurprd07.prod.outlook.com
 (2603:10a6:200:42::36) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20200120193835785
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 10b91e06-50b5-4439-a0f2-08d79dc732f0
x-ms-traffictypediagnostic: AM6PR08MB3256:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB325678794312E2408FCDDF65C1320@AM6PR08MB3256.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:208;
x-forefront-prvs: 0288CD37D9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(366004)(376002)(136003)(346002)(39840400004)(189003)(199004)(66476007)(66946007)(64756008)(6486002)(31686004)(66556008)(66446008)(36756003)(107886003)(110136005)(2906002)(316002)(54906003)(16576012)(478600001)(86362001)(16526019)(8936002)(71200400001)(52116002)(53546011)(186003)(4326008)(26005)(81156014)(81166006)(5660300002)(31696002)(2616005)(956004)(8676002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3256;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0f9ePw9uiCnK70UscexUG/YgLB8I22NW9Rq/Vh0OE4ndkLSO2DWl4J05/sWvf1+c34H9pGaU1e1nLa6fgEUh73uG0ii8aY+pUWpOguK9BRfghjLwcLDe+q0Sq7bmLxtGHtpI6gHi0+NhybBUY/i8P1E+HNHyjF3TAqBymSfrNMylDAERJrUpAqS1Lr3zlV/P0PYLC6sPBfoc2wW+G27eJDV0cFAx98CCyt6jOL4lPysnR1TMPOH+6U3hAgWlMPGfaRAMFg/ZEg/TBbgd+W3c55HGm3BginCoZncaU4nXDYeE0/F83teqwo+Zc9cr7Km2ojkbiOhRA2Up7CIcBK4eQ1alnYm7HvWyd2U+ayPSw7oFDg5q5/DClEAEsfK0eBO1t5cPl9xwD3KPVCFzZ+lVUuG4vIyiTi4UtHGfNRiSfklhOOfb9wlNV5u7jbe9Pu0sERvDnSZ9gt62vRGBCIPljaVmjp1x3fAdLqo59e06TrWjA/HkzH4+O5ZqVHj6uNPL2kMAvIqyCu5zAME6FfFBCA==
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <1A155830872B3B4B9414AEE9CFEFC417@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10b91e06-50b5-4439-a0f2-08d79dc732f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2020 16:38:37.6556 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TWiud/GeSO1FzGVsFgsDtxyYRIMt5EqsrpsqX8vEacmayLIYYGe/GySbV2Hwz6ba7KgUf5ouAKWCyoEcBbU8zx51y6oe+V7pFc0MfGSBiHE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3256
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.113
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

20.01.2020 19:14, Max Reitz wrote:
> On 16.12.19 13:17, Vladimir Sementsov-Ogievskiy wrote:
>> The patch add new additional field to qcow2 header: compression_type,
>> which specifies compression type. If field is absent or zero, default
>> compression type is set: ZLIB, which corresponds to current behavior.
>>
>> New compression type (ZSTD) is to be added in further commit.
>>
>> Suggested-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   docs/interop/qcow2.txt | 16 +++++++++++++++-
>>   1 file changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
>> index d92c827763..77146b5169 100644
>> --- a/docs/interop/qcow2.txt
>> +++ b/docs/interop/qcow2.txt
>> @@ -109,6 +109,11 @@ the next fields through header_length.
>>                                   An External Data File Name header exte=
nsion may
>>                                   be present if this bit is set.
>>  =20
>> +                    Bit 3:      Compression type bit.  If this bit is s=
et,
>> +                                non-default compression is used for com=
pressed
>=20
> s/non-default/a non-default/
>=20
>> +                                clusters. compression_type field must b=
e
>> +                                present and not zero.
>=20
> s/compression_type field/The compression_type field/
>=20
>> +
>>                       Bits 3-63:  Reserved (set to 0)
>>  =20
>>            80 -  87:  compatible_features
>> @@ -188,7 +193,16 @@ present*, if not altered by specific incompatible b=
it.
>>   *. Field is not present when header_length is less or equal to field's=
 offset.
>>   Also, all additional fields are not present for version 2.
>>  =20
>> -        < ... No additional fields in the header currently ... >
>> +              104:  compression_type
>> +                    Defines the compression method used for compressed =
clusters.
>> +                    A single compression type is applied to all compres=
sed image
>> +                    clusters.
>=20
> Sounds a bit too complicated.  Maybe =84All compressed clusters in an
> image use the same compression type.=94 instead?  (Or s/an/the same/)

Sounds better, yes.

>=20
>> +                    If incompatible compression type bit is set: the fi=
eld must
>=20
> Hmm, this sounds like there was an =93incompatible compression type=94 bi=
t,
> instead of an incompatible bit called =93compression type=94.  So maybe =
=93If
> the incompatible bit "compression type" is set, this field must...=94?

OK)

>=20
>> +                    be present and non-zero (which means non-zlib compr=
ession type)
>=20
> s/$/./
>=20
>> +                    If incompatible compression type bit is unset: the =
field
>=20
> I=92d just make this =93Otherwise, this field...=94
>=20
>> +                    may not exist or it must be zero (which means zlib)=
.
>=20
> =93must not be present or must be zero=94?
>=20
> (=93exist=94 sounds a bit weird; the spec only defined =93not present=94 =
so far.
>   As for the =93may not=94, that isn=92t in RFC 2119. :-))

Agreed, thanks.

>=20
> Max
>=20
>> +                    Available compression type values:
>> +                        0: zlib <https://www.zlib.net/>
>>  =20
>>   Header padding
>>  =20
>>
>=20
>=20


--=20
Best regards,
Vladimir

