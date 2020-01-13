Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569B6C33CAD
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 10:31:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3BC12084D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 10:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Pwd4c0Nk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3BC12084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iqx0N-0004pI-Pl
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 05:31:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52680)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iqwzG-0003xU-IS
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 05:30:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iqwzE-0002or-Ve
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 05:30:22 -0500
Received: from mail-db8eur05on2131.outbound.protection.outlook.com
 ([40.107.20.131]:31201 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1iqwzE-0002lR-DU; Mon, 13 Jan 2020 05:30:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XFQ/wo8XI3WQq705ZLjHbVi0yvdPFeBhL6149xzpZebhtT33DQWvTJF2AEWWVZiZFZPDj8eTxVHjkZDZjzdVwE014gpX/WCHuvsIkBTNbOq3gsDW1Z7bdkXgqiImmQopbssOmfOQZLIkZwpkRCh7hAo4r8NwC677eqiIEFVD3pdCSXtaqGxWoUNRmltAP6MoMRKgZ/cs1pv3VMICObwuvUXEHqzXGdY1PXa7hsSmOKC01Vwr3ZvtURZSo6RXm/gHsxAQY8hj4osjjr/OqlsJbvt0yFKdf+v5TO2aVF69h4BRjLnvowUbCWmcVl+KA5X3sB169oWwIzybt0yBEzxqMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZrjW1sdEIzuvjf1ofWsmP6xdTZHiT85rO77VfDnDSwI=;
 b=mxIWip8s6RZ3r3X3GGhpx2k9W74iJ1wAsQ/yuY+T4FY0xYoNptOOWb9dy21VFS7zav3K1fxIxzJq3a676qe0p8y65yJx6cbqs24cDCGyWETQb7/jJC/VVtmb2XwEQMUyT1qVzxhj0ODQTB9adWqOyEYQzlT8Ag75ah3WMWOkZqcytkvcHcVc/x0/ao9rgURxF8++j5FToqI5P+rFBX3qiroDQrB1EZnlrMQz1mJbZbPdeVAKQFih9nTQORy6YQDArMN2u6Li2bnaMorK/Lr5Ew+WemkFJUR4Vlp/CQcmjINhjnx1gLaJxEFm4fWqSBgc4Rq70nUV2rH4brXrFIq72Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZrjW1sdEIzuvjf1ofWsmP6xdTZHiT85rO77VfDnDSwI=;
 b=Pwd4c0NkZH6NMf9KO7H4HSt1MZUtfKMQgLEzDfStpjfzxSw0jgpHlUZFps7zPKMpox00cEDLv8O2P098It9lqhqTtmLt5ob39kcC3+rIG0gPCq/V0i/kwB/3K2H4xjm+3GT8ssCGNd6mTfJ05zAglnz87kdO0uh/7M5Tb7pSdTU=
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com (10.255.123.95) by
 AM6PR08MB4884.eurprd08.prod.outlook.com (10.255.99.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Mon, 13 Jan 2020 10:30:17 +0000
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::8805:5633:ca46:c8c8]) by AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::8805:5633:ca46:c8c8%7]) with mapi id 15.20.2623.015; Mon, 13 Jan 2020
 10:30:17 +0000
Received: from [172.16.24.225] (185.231.240.5) by
 HE1PR05CA0263.eurprd05.prod.outlook.com (2603:10a6:3:fc::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9 via Frontend Transport; Mon, 13 Jan 2020 10:30:16 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH 2/2] qcow2: dump QCOW2 metadata
Thread-Topic: [PATCH 2/2] qcow2: dump QCOW2 metadata
Thread-Index: AQHVvKr5leVV3xekykyII1O3QjNCBqff1XKAgAiqGQA=
Date: Mon, 13 Jan 2020 10:30:16 +0000
Message-ID: <be0bf681-5551-c5ec-e7b3-3589fb230176@virtuozzo.com>
References: <1577447039-400109-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1577447039-400109-3-git-send-email-andrey.shinkevich@virtuozzo.com>
 <d87d183d-cd69-1994-11d0-5767ec72589e@redhat.com>
In-Reply-To: <d87d183d-cd69-1994-11d0-5767ec72589e@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0263.eurprd05.prod.outlook.com
 (2603:10a6:3:fc::15) To AM6PR08MB5048.eurprd08.prod.outlook.com
 (2603:10a6:20b:ee::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0eaec9de-138c-4383-0b8b-08d79813950d
x-ms-traffictypediagnostic: AM6PR08MB4884:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB48843663813109EBBF88E227F4350@AM6PR08MB4884.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 028166BF91
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39840400004)(396003)(376002)(366004)(346002)(136003)(189003)(199004)(66556008)(66476007)(64756008)(66946007)(110136005)(16576012)(54906003)(71200400001)(66446008)(316002)(478600001)(31696002)(2906002)(31686004)(86362001)(26005)(36756003)(44832011)(16526019)(186003)(107886003)(53546011)(8936002)(52116002)(8676002)(4326008)(2616005)(956004)(6486002)(5660300002)(81156014)(81166006);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4884;
 H:AM6PR08MB5048.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kI6XR0LTOMOTeaD7pKIIJdz3rPsG/+XG+dzi8V+9k9noXSmOC15OMqhIVCcAsPfhGuJhfnIKR+WsVu7RYBOI7E70Yg5/4/rWIQIvN4VSgZvlbdWTt8nqG8elCVDYYZWKJEjfW70NlQmv6o1LUB5Tr9pt+/eloD4dw4aonl5WzO5L8y8Ae40a9anSp/l2KO9+1PAF2clE8iNPKFXYltte1X+pvWkReJZqjFKHJJSBRBiKAOhBHcomZ06UTTCTg2VBZ2YAxSkeCs/lpNX45GXMzy0Ixt3sfkQcAt9qYX/JIilVTW7X+u3u6Qa/stNhOnt6+VTfdIx8WjZDvTvhPSIeWzOBExH/R5Bi1R5sLW4cLPER4xEw8pBMV5aMNHFA2TpuTp7bSPJO0ZG7Wnvi0bVdsV0M5+duPcxkEbCXV3+K44sx/6LlgsK+Q/mB0sm7Lwqp
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <4AE3B5B71867C44FBAA224BD0866A1EF@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eaec9de-138c-4383-0b8b-08d79813950d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2020 10:30:17.0504 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MPSiypltQDe0DvoiTlTXIeztXsilWFktLVWaix/56S6XInmi7iioywVoArgqqb6iaIp0G2ihLPgekLIy/IXeLgOIgFCSwc1a68KBSU5rfSo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4884
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.20.131
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


On 08/01/2020 01:11, Eric Blake wrote:
> On 12/27/19 5:43 AM, Andrey Shinkevich wrote:
>> Let QEMU-IMG CHECK command show QCOW2 structure to inform a user about
>> metadata allocations on disk. Introduce '-M'('--dump-meta') key option.
>>
>> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>> ---
>=20
>> +++ b/qemu-img.c
>> @@ -173,6 +173,7 @@ static void QEMU_NORETURN help(void)
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "=A0=A0=A0=A0=A0=A0 '-r leaks' repa=
irs only cluster leaks, whereas=20
>> '-r all' fixes all\n"
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "=A0=A0=A0=A0=A0=A0 kinds of errors=
, with a higher risk of choosing=20
>> the wrong fix or\n"
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "=A0=A0=A0=A0=A0=A0 hiding corrupti=
on that has already occurred.\n"
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "=A0 '-M' Dump QCOW2 metadata to stdout =
in JSON format.\n"
>=20
> Should QCOW2 be all caps?
>=20
>=20
>> =A0 }
>> @@ -701,9 +710,10 @@ static int img_check(int argc, char **argv)
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 {"object", required_argument, 0,=
 OPTION_OBJECT},
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 {"image-opts", no_argument, 0, O=
PTION_IMAGE_OPTS},
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 {"force-share", no_argument, 0, =
'U'},
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 {"dump-meta", no_argument, 0, 'M'},
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 {0, 0, 0, 0}
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 };
>> -=A0=A0=A0=A0=A0=A0=A0 c =3D getopt_long(argc, argv, ":hf:r:T:qU",
>> +=A0=A0=A0=A0=A0=A0=A0 c =3D getopt_long(argc, argv, ":hf:r:T:qU:M",
>=20
> We are already inconsistent, but I tend to add options in alphabetical=20
> order, both here...
>=20

If I merely move 'M' forward like ':hf:M:r:T:qU', will it be OK?

>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 long_options, &option_index);
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 if (c =3D=3D -1) {
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;
>> @@ -745,6 +755,9 @@ static int img_check(int argc, char **argv)
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 case 'U':
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 force_share =3D true;
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;
>> +=A0=A0=A0=A0=A0=A0=A0 case 'M':
>=20
> ...and here, as it is then easier to find a given option for later editin=
g.
>=20

...and similar here without changing the existing code. Have I=20
understood you correctly?

>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fix |=3D BDRV_DUMP_META;
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 case OPTION_OBJECT: {
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 QemuOpts *opts;
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 opts =3D qemu_opts_parse_noisily=
(&qemu_object_opts,
>> @@ -772,6 +785,11 @@ static int img_check(int argc, char **argv)
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 return 1;
>> =A0=A0=A0=A0=A0 }
>> +=A0=A0=A0 if ((fix & BDRV_DUMP_META) && output_format !=3D OFORMAT_JSON=
) {
>> +=A0=A0=A0=A0=A0=A0=A0 error_report("Metadata output in JSON format only=
");
>> +=A0=A0=A0=A0=A0=A0=A0 return 1;
>=20
> Why this restriction?
>=20

This is to remind a user that '-M' can be effective with the option=20
'--output=3Djson' only. Do you think that a comment in the qemu-img.texi=20
would be enough and the restriction should be omitted here?

>> +=A0=A0=A0 }
>> +
>> =A0=A0=A0=A0=A0 if (qemu_opts_foreach(&qemu_object_opts,
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 user_creatable_add_opts_foreach,
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 qemu_img_object_print_help, &error_fatal)) {
>> @@ -792,6 +810,15 @@ static int img_check(int argc, char **argv)
>> =A0=A0=A0=A0=A0 bs =3D blk_bs(blk);
>> =A0=A0=A0=A0=A0 check =3D g_new0(ImageCheck, 1);
>> +
>> +=A0=A0=A0 if (fix & BDRV_DUMP_META) {
>> +=A0=A0=A0=A0=A0=A0=A0 if (strcmp(bs->drv->format_name, "qcow2")) {
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 error_report("Metadata output support=
ed for QCOW2 format=20
>> only");
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D -ENOTSUP;
>=20
> This one makes sense, I guess - we may relax it in later versions if=20
> more file formats gain the ability to dump extra metadata.
>=20
>=20
>> +++ b/qemu-img.texi
>> @@ -230,7 +230,7 @@ specified as well.
>> =A0 For write tests, by default a buffer filled with zeros is written.=20
>> This can be
>> =A0 overridden with a pattern byte specified by @var{pattern}.
>> -@item check [--object @var{objectdef}] [--image-opts] [-q] [-f=20
>> @var{fmt}] [--output=3D@var{ofmt}] [-r [leaks | all]] [-T=20
>> @var{src_cache}] [-U] @var{filename}
>> +@item check [--object @var{objectdef}] [--image-opts] [-M] [-q] [-f=20
>> @var{fmt}] [--output=3D@var{ofmt}] [-r [leaks | all]] [-T=20
>> @var{src_cache}] [-U] @var{filename}
>=20
> This mentions that -M is valid, but has no further documentation on what=
=20
> -M means.=A0 Without that, it's anyone's guess.
>=20

Thank you Eric, I really missed to supply a comment for the new option=20
here and am going to put it below. Should I mention that option in=20
qapi/block-core.json file also with this patch of the series?

>> =A0 Perform a consistency check on the disk image @var{filename}. The=20
>> command can
>> =A0 output in the format @var{ofmt} which is either @code{human} or=20
>> @code{json}.
>>
>=20

--=20
With the best regards,
Andrey Shinkevich


