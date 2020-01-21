Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A29C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 09:07:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DCBD20882
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 09:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="fd3QlRQD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DCBD20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itpV4-00042Y-DG
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 04:07:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55931)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1itpUI-0003Ut-2O
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 04:06:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1itpUG-0007r8-5j
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 04:06:17 -0500
Received: from mail-eopbgr140122.outbound.protection.outlook.com
 ([40.107.14.122]:33603 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1itpUF-0007qK-DX; Tue, 21 Jan 2020 04:06:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=II0g9J7OOovUHM0kgc8vfAjivYEtInewCQTlR38tk6CrZ2+Fs/PStkTCHhx1EHTtnna/gLJJG98deAoTBM2ZQ7aAlOtXQW/m4OJUkbc+GJ/9hXnPof+mDPQJYn2aVngYq/gzearpnfU2T2j+iDoogVNgT3Cn+OaKOG2RonAb81auiZeXrm+R9Hm8WAP5Gbh1ZsWhoYwA/n8vhMKalVb/wZmV+SrGY9bCXFEj+NXgCuLzJny+DEgnt2RS+I3coUlnZmzOQL6f8LYP/Y55i0YXb6Fm3amIzyUr8iBMQErkMQEiND3Ioo7qi1EysmDPaY7aI7E+7Nw2HQU23N/G0B8ahQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Y3+tcxyuK09+PPEeqhhNDLvmSRswZU7pBGJ3pk/UFQ=;
 b=UdJrkuxlXCVPrxzdwWu4wTKTVcse/DjI5DLAv9jDa0N2iFbLoZAq32q17zrmBscB0jd+jS99cFijKJRpJW8cSrKpyz11RlTMq/+u4hnnsEWGIp6rZUZ1zlOjs3dmORhTV64mtqRmJPsTFFGjmN8CpFS9Wohi3qeynvmHNzteYaf5ZD3P2MHN6prmIQZtqG4WPfTthDHydKzvw6Uo3Yos6y8OyyMnW07VDRZ6vcBXLYC1OwJGiOUHoQTSmxk4VAVFkCTtRINvOQPljzh6xTDNjt/+Y8uE/O4XdEBamPHFrkD3s5igO+KmS47xj8mCxlLitkEX6r3HknSO4pmGftomDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Y3+tcxyuK09+PPEeqhhNDLvmSRswZU7pBGJ3pk/UFQ=;
 b=fd3QlRQDPsWnY0/Lhfl89YBNQNaNgDru6K0ZhhHItUNPBQV/zMF/GIwnfpPIdouPGHFUV4tgzYKyYSOTT59fyiey7QrytNNX6v+4Sh0BK8MiM1xA8cJDMsSpw6fr9/0qaaPMdL0rI0GU2IUH3WVUDpFN5Gn7wiOZT/DlmoeUsvc=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB5285.eurprd08.prod.outlook.com (20.179.0.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19; Tue, 21 Jan 2020 09:06:12 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2644.027; Tue, 21 Jan 2020
 09:06:12 +0000
Received: from [172.16.24.200] (185.231.240.5) by
 AM0PR04CA0033.eurprd04.prod.outlook.com (2603:10a6:208:122::46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend
 Transport; Tue, 21 Jan 2020 09:06:11 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v10 2/2] docs: qcow2: introduce compression type feature
Thread-Topic: [PATCH v10 2/2] docs: qcow2: introduce compression type feature
Thread-Index: AQHVz7UL5hfQaRKsXEyWI5N7oc9Wr6fz9TOAgADfbgA=
Date: Tue, 21 Jan 2020 09:06:12 +0000
Message-ID: <562a676a-094f-d144-4000-b9bbc1038be9@virtuozzo.com>
References: <20200120171345.24345-1-vsementsov@virtuozzo.com>
 <20200120171345.24345-3-vsementsov@virtuozzo.com>
 <679ba957-0b47-27ab-0684-e066ca8a6196@redhat.com>
In-Reply-To: <679ba957-0b47-27ab-0684-e066ca8a6196@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR04CA0033.eurprd04.prod.outlook.com
 (2603:10a6:208:122::46) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20200121120610364
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aa285d0e-5a3e-48cd-b20e-08d79e512947
x-ms-traffictypediagnostic: AM6PR08MB5285:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB5285EB71E8A212D9C16DACB9C10D0@AM6PR08MB5285.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 0289B6431E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(396003)(39850400004)(366004)(376002)(346002)(189003)(199004)(54906003)(110136005)(5660300002)(66446008)(4326008)(2906002)(52116002)(64756008)(66946007)(71200400001)(66476007)(66556008)(107886003)(26005)(16526019)(186003)(316002)(81156014)(8936002)(8676002)(81166006)(31686004)(508600001)(6486002)(16576012)(36756003)(956004)(2616005)(53546011)(86362001)(31696002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB5285;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CTtVd7Uoqxj82IKj+U8XgHQS2FLCQrTJ1RLNcpxrXAtRT0jzYGbODLUt52ckm3XI+/Yzrgr4+1Yw8fJY963V2cdn5+IoTyKNu7qr3Sv/DH1kDKwqEfu6b3ZD1nA8fYLrL0msD/441HMKlgRNT7usxN6pBuXXIo0giiHXiKcP2LlO2CF9Qur0zeii+c/JzGhHHoO9DaLEZl1TwKT0fw1nkkVn5Up3b0yhcX6miVUB+O1bkZcUdN1+XTRm1UiaY2HQ7ODrJgyglnSxSVbrViJMds5vWpTQZshTVZoc8FalhsBIhrvp92n7aDeNqzoU/KqHwbLUVfmp2EcTvZBKqMRRAZIrDtILfMGRr6L4t1IPVSudZj2UWXtd1tos+BfhTJd8NLDdvdDG5deZe8PinHWtAlIGBUPW/+R+g1I58U2xTK1B3mpy6iB1qH3OV7n4UYP36ztX8zzlmCvFAyVTyBLo34AHirT8X82WUELIIc1TcxxPPzuaZkiF4qGWBXMBOvTXvqZwXgJ6dwu5beFtrLnjLQ==
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <6CDA38BD5BE57545BFE8AB87A90D6AD5@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa285d0e-5a3e-48cd-b20e-08d79e512947
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2020 09:06:12.0897 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 210T8NybI1z9wvQ3V5Dv8Qdlwoj2CZxTNxYXVdXGQ2DTIBF9/QR/C9v9zqhyejkbAmXAnNL47AGXVDbXYD+nS6pgAQg7YUk6o0GMPloYsrE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5285
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.122
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
 "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

20.01.2020 22:46, Eric Blake wrote:
> On 1/20/20 11:13 AM, Vladimir Sementsov-Ogievskiy wrote:
>> The patch add new additional field to qcow2 header: compression_type,
>=20
> s/add/adds a/
> s/to/to the/
>=20
>> which specifies compression type. If field is absent or zero, default
>> compression type is set: ZLIB, which corresponds to current behavior.
>>
>> New compression type (ZSTD) is to be added in further commit.
>=20
> It would be nice to have that patch as part of the same series, but it ha=
s already been posted to the list separately, so I'm okay with this series =
as just doc word-smithing while we get that patch series in soon.
>=20
>>
>> Suggested-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>> =A0 docs/interop/qcow2.txt | 16 +++++++++++++++-
>> =A0 1 file changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
>> index 355925c35e..4569f0dba3 100644
>> --- a/docs/interop/qcow2.txt
>> +++ b/docs/interop/qcow2.txt
>> @@ -109,6 +109,11 @@ the next fields through header_length.
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 An External Data File Name header extension may
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 be present if this bit is set.
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Bit 3:=A0=A0=
=A0=A0=A0 Compression type bit.=A0 If this bit is set,
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 a non-default compression is used for compressed
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 clusters. The compression_type field must be
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 present and not zero.
>=20
> Why must the compression_type field be non-zero?=A0 If this bit is set, a=
n older qemu cannot use the image, regardless of the contents of the compre=
ssion_type field, so for maximum back-compat, a sane app will never set thi=
s bit when compression_type is zero.=A0 But there is nothing technically wr=
ong with setting this bit even when compression_type is 0, and newer qemu w=
ould still manage to use the image correctly with zlib compression if it we=
re not for this arbitrary restriction.

OK, I just made it stricter, no actual reason for it. Then:

If this bit is set, the compression type of the image is defined by compres=
sion_type additional field (which must present in this case).

>=20
>> +
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Bits 3-6=
3:=A0 Reserved (set to 0)
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 80 -=A0 87:=A0 compatible_features
>> @@ -189,7 +194,16 @@ present*, if not altered by a specific incompatible=
 bit.
>> =A0 *. A field is considered not present when header_length is less or e=
qual to the
>> =A0 field's offset. Also, all additional fields are not present for vers=
ion 2.
>> -=A0=A0=A0=A0=A0=A0=A0 < ... No additional fields in the header currentl=
y ... >
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 104:=A0 compression_type
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Defines the c=
ompression method used for compressed clusters.
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 All compresse=
d clusters in an image use the same compression
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 type.
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 If the incomp=
atible bit "Compression type" is set: the field
>=20
> Ragged edge formatting looks awkward.=A0 Either this is one paragraph ("t=
ype.=A0 If") or there should be a blank line to make it obvious there are t=
wo paragraphs.

OK, let it be additional empty line. Then we need one before "Defines" too?

>=20
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 must be prese=
nt and non-zero (which means non-zlib
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 compression t=
ype). Otherwise, this field must not be present
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 or must be ze=
ro (which means zlib).
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Available com=
pression type values:
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=
: zlib <https://www.zlib.net/>
>=20
> I'm still not sure I agree with the mandate that the field must be non-ze=
ro when the incompatible feature bit is set.
>=20

I don't care, so let's make it less strict.

--=20
Best regards,
Vladimir

