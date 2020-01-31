Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050D8C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 13:56:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE4542063A
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 13:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Anl8KsmI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE4542063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixWmC-0006Q2-16
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 08:56:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38100)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ixWlU-0005pU-AC
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 08:55:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ixWlS-0008J6-G1
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 08:55:19 -0500
Received: from mail-eopbgr60095.outbound.protection.outlook.com
 ([40.107.6.95]:3547 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1ixWlR-0008Ec-V4; Fri, 31 Jan 2020 08:55:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gVq29ik1Q+CWxpb9BLBU9nQyhWWWp91g5pIKcXy5XNdH/GNiT0Io02b4F2jNDmW/wwkaivlgzm+Km//FL+LFLIV/49B1A0HbK377p/WpUPQE7iyZJKK3fsN4kVZdeNsEYoirlGsHLrxfc9HMi1Z+NJYR01BHoLqxI17MRAcpMlAj04LtsdtQyB26PQ4/yGdHwagWjoVIxrO4eQEFDrdQSMd4Ag9yXeVgZEmpIqyK9Rrw16kWx8FSp+i4QOH2xWt4pS4C8w4LDoQDtyfYRPPY6qxAyCUC7C4AozRoFoNnJllNw9vyu2LFV1cnIfDL5Wxf7kCPrt5fGpZN00pZfEQPYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/pgxJD3a/SukGHwo9/PgGTW6DwFGAL9NW4aiKtgZE4=;
 b=WeZkZoI0YuvNScXJfQvu4BwrAcVfeuaCSTREL3Q2vxssCLE5CAtlQmQRDuk0y4egnVl2dUJMqVaJvH9K2N/HjsM9/RUfYO9kDfv+GnY6MdIvTE9HqZC64XdrNTCARj0b0NUQ6fpYcCybgZVPyJ41NyyR9RyoerC8jTqyb7DEBjeGLBJmPpFMArCulTGxGU4aBLFZv03zwa7DlwUu4Y+FCO/aP4ZEyjZ+Rw1jcic3EoZj5LHmFIFeLerN95U3fP97A7vaStssStzIcSj620BodVB1mWcHatqNcWirpl0N+ZVdjGNz21LVD0b0XYhCQATxX9vl3MxHP34PEJU/KDAtMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/pgxJD3a/SukGHwo9/PgGTW6DwFGAL9NW4aiKtgZE4=;
 b=Anl8KsmIBv5Q5Fm5P8p2gJjq3UUYmbw0JLpz5UezsoPSdWC0ynmBZS0Wd/MgULIX8vh/SCNcKoPbaAzVCh2/dyLURd5iayznW7w1XJQuachhvsjJO1l/xDfrCaGLc+bZq8GDRlmQdC2j7JYALGub7wW8AII5axzDh4T6mTF5kqE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3557.eurprd08.prod.outlook.com (20.177.115.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Fri, 31 Jan 2020 13:55:14 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2686.028; Fri, 31 Jan 2020
 13:55:14 +0000
Subject: Re: [PATCH v10 1/2] docs: improve qcow2 spec about extending image
 header
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20200120171345.24345-1-vsementsov@virtuozzo.com>
 <20200120171345.24345-2-vsementsov@virtuozzo.com>
 <e457c8c4-ae37-9b30-5580-40b34bbf458c@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200131165511773
Message-ID: <7e8e7077-0c95-5ccb-5f97-a4a93710e57d@virtuozzo.com>
Date: Fri, 31 Jan 2020 16:55:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <e457c8c4-ae37-9b30-5580-40b34bbf458c@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR0301CA0022.eurprd03.prod.outlook.com
 (2603:10a6:3:76::32) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR0301CA0022.eurprd03.prod.outlook.com (2603:10a6:3:76::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27 via Frontend Transport; Fri, 31 Jan 2020 13:55:13 +0000
X-Tagtoolbar-Keys: D20200131165511773
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7251a5a-c4fc-4eb8-3a59-08d7a655325e
X-MS-TrafficTypeDiagnostic: AM6PR08MB3557:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3557E943A371177B98A65EA9C1070@AM6PR08MB3557.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-Forefront-PRVS: 029976C540
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(396003)(136003)(346002)(376002)(366004)(39850400004)(189003)(199004)(6486002)(8936002)(81166006)(81156014)(956004)(2616005)(4326008)(107886003)(66556008)(66946007)(478600001)(66476007)(36756003)(31686004)(53546011)(8676002)(16526019)(31696002)(5660300002)(86362001)(2906002)(316002)(52116002)(26005)(186003)(16576012);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3557;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /YBErQ46Sze62mAehZKhd23xjbNZWqX6ZCxaUkJ0QmLoK8gut524+5F0kUF5G0P8XMyOv2ut7hVAbiGJqk1uacNFtj3vbXPQJB4kGPwDP7ruHCWB2Qj9FHkfOQ1BnZWzOnxRPtZVz5dlrKlY2l0KKa3XXyAAEPCIXtwslELRIlSB4WOVQ+BL1xXlJkAGhCHqQOmInc3YBjcjv+gn11vXlprwUMQkgUuqs1cwfrEg5LhNCxPFRT3EAfmMaexSAkBWJ3VXZYxIogQ84gg3oMnvWFrnjfybIzEvBrfRP/7K8p2y8DG7RF6v7g1p95lfYfWWNxZA5V60ugmgQgKWSNOEBUX7P8Vxp0KlhVOo4MlNIx1P8GxUid+2SURYwcsZzj0U5m7B43aau2ZjngBXFsh+B90jICAWyMEdmfj5EFtDmz5HInDkcwAzXYnte5qzZRle
X-MS-Exchange-AntiSpam-MessageData: SmJMk3/y9hDHsCAN8LF7kV2Tt6BBn+Bz30J21lODp2ANZnFGo20q3izqdewToVcyMt687sc1Jn4mL3v2tQb6/DGH2gLOXzKzQv7VZKuzJ+LEHIPYXCIGb9RgNCET50exgmAgriGcw5FxtzPx/9m4rQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7251a5a-c4fc-4eb8-3a59-08d7a655325e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2020 13:55:14.4721 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YWsUOSQF6TgX5bru8jjnY9SGSKbvjCQ8/+qr9NxTGiFLHi92WMHWoOdulZMnp52SknEQgwOtyTznid1K8W0+r9ixAtx+SIUMtDpQZZgproY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3557
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.95
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
Cc: kwolf@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
 dplotnikov@virtuozzo.com, den@openvz.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

20.01.2020 22:42, Eric Blake wrote:
> On 1/20/20 11:13 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Make it more obvious how to add new fields to the version 3 header and
>> how to interpret them.
>>
>> The specification is adjusted so for new defined optional fields:
>=20
> s/so for/so that for/
>=20
>>
>> 1. Software may support some of these optional fields and ignore the
>> =A0=A0=A0 others, which means that features may be backported to downstr=
eam
>> =A0=A0=A0 Qemu independently.
>> 2. If we want to add incompatible field (or a field, for which some its
>> =A0=A0=A0 values would be incompatible), it must be accompanied by
>> =A0=A0=A0 incompatible feature bit.
>>
>> Also the concept of "default is zero" is clarified, as it's strange to
>> say that the value of the field is assumed to be zero for the software
>> version which don't know about the field at all and don't know how to
>> treat it be it zero or not.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>> =A0 docs/interop/qcow2.txt | 44 +++++++++++++++++++++++++++++++++++++++-=
--
>> =A0 1 file changed, 41 insertions(+), 3 deletions(-)
>>
>> diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
>> index af5711e533..355925c35e 100644
>> --- a/docs/interop/qcow2.txt
>> +++ b/docs/interop/qcow2.txt
>> @@ -79,9 +79,9 @@ The first cluster of a qcow2 image contains the file h=
eader:
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Offset i=
nto the image file at which the snapshot table
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 starts. =
Must be aligned to a cluster boundary.
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
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 72 -=A0 79:=A0 incompatible_features
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Bitmask =
of incompatible features. An implementation must
>> @@ -164,6 +164,44 @@ in the description of a field.
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 100 - 103:=A0 header_length
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Length o=
f the header structure in bytes. For version 2
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 images, =
the length is always assumed to be 72 bytes.
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 For version 3=
 it's at least 104 bytes and must be a multiple
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 of 8.
>> +
>> +
>> +=3D=3D=3D Additional fields (version 3 and higher) =3D=3D=3D
>> +
>> +In general, these fields are optional and may be safely ignored by the =
software,
>> +as well as filled by zeros (which is equal to field absence), if softwa=
re needs
>=20
> We're inconsistent on 'zeros' (git grep has 201 hits) vs. 'zeroes' (688 h=
its); I prefer the latter, but won't object if you don't tweak it since thi=
s is the first use of either spelling in qcow2.txt.

No, qcow2.txt already contains 4 invocations of 'zeros' (and no one 'zeroes=
'), so, I'll keep 'zeros' for consitency.

>=20
>> +to set field B, but does not care about field A, which precedes B. More
>=20
> s/A, which/A which/
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
>> +present*, if not altered by a specific incompatible bit.
>> +
>> +*. A field is considered not present when header_length is less or equa=
l to the
>=20
> s/less/less than/
>=20
>> +field's offset. Also, all additional fields are not present for version=
 2.
>> +jkjkkjjkjkj
>> +=A0=A0=A0=A0=A0=A0=A0 < ... No additional fields in the header currentl=
y ... >
>> +
>> +
>> +=3D=3D=3D Header padding =3D=3D=3D
>> +
>> +@header_length must be a multiple of 8, which means that if the end of =
the last
>> +additional field is not aligned, some padding is needed. This padding m=
ust be
>> +zeroed, so that, if some existing (or future) additional field will fal=
l into
>=20
> s/that, if/that if/
>=20
>> +the padding, it will be interpreted accordingly to point [3.] of the pr=
evious
>> +paragraph, i.e.=A0 in the same manner as when this field is not present=
.
>> +
>> +
>> +=3D=3D=3D Header extensions =3D=3D=3D
>> =A0 Directly after the image header, optional sections called header ext=
ensions can
>> =A0 be stored. Each extension has a structure like the following:
>>
>=20
> We're down to few enough grammar nits that I'm happy with:
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20


--=20
Best regards,
Vladimir

