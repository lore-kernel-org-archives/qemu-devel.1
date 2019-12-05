Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF30C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 18:21:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B1CC2464F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 18:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="on5BnArz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B1CC2464F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icvkg-00008Y-5R
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 13:21:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58344)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1icvZG-00074S-38
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 13:09:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1icvZE-0008LB-Jx
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 13:09:33 -0500
Received: from mail-eopbgr40109.outbound.protection.outlook.com
 ([40.107.4.109]:19011 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1icvZA-0007oD-BG; Thu, 05 Dec 2019 13:09:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BMuVnPrmWgm6sWa78T3LdZBDexfwVbprlXynLnXerwE7TNyTFWciUjsqB8jvzng6gZwMxrkMoeioPiERHjXI3WZTrrDipCmq+bN7xovpMyKxd5ew8CDSR4iyB9uDW7nJSRbcwAVRZq3fWgpVbu2+Q2BHekAIRPSTO/M6olgGjT12L0IIkIJ3oDjbzwoTVaW+kY+eyqABChkRf0YHs+XotIawn0Mo3i/MP+PnKwJ08UsVYHAYxRzTapH46eKzfuIBepcwkvmEr+YUw3XOjRr8u0mp8qCi1bsxRPzAKZSkF2niQCXgjedOGm17ak584/l75MG2+qWUsoxwKI4pAXJu8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1kteNdrdyWNqBRQBRd7Ti/yitbuL3HqTdn17SjG5Xg=;
 b=gaPcdsayQH+Gwr0xrrjGre2Vn+iCKo57Wewprz1u6db400vRB02dMTCD0Cxypk01rIefhE30bItN2a3XYCI8qEKiz1A9tku27jJ2VSXQkP4J0X6eqhoW8Essk0bGGbgGoaJJ/kVF4fNdGPbq7P2lVGZXEH4R4lolaBFrwbmutuGn2IX2IprYCmH6wWMIHp7ow5GO4eYBGNY8T8ektir2tHBTAXo+c+2zGbv+nUOkw2AiNr+rElP/6hgt6EozEDeclk2hkuNIm4rm32oWye8RX/Sh4rTMndMXmaelHRSMQPqL7SDV0Kj4fnYEVVrHVh0yOqB/XSvMSklFH5KAzcs/ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1kteNdrdyWNqBRQBRd7Ti/yitbuL3HqTdn17SjG5Xg=;
 b=on5BnArz3rALUXTBwYlGot9SL4DioVNSfVVkVgiOmdvzZJy9WPuZUCLxDtHYuCakDe3fEnmyTosiCqq4lomYVziEigrkAuDiEAz764hWS8vgXF1+ObV8Qv9uOGLSp0XcEvEi2lPeKKqxht4tEVGHTwlNOlnbNplJmNM9BNMrPy4=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3576.eurprd08.prod.outlook.com (20.177.114.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Thu, 5 Dec 2019 18:09:24 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2516.014; Thu, 5 Dec 2019
 18:09:24 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v7 21/21] nbd: assert that Error** is not NULL in
 nbd_iter_channel_error
Thread-Topic: [PATCH v7 21/21] nbd: assert that Error** is not NULL in
 nbd_iter_channel_error
Thread-Index: AQHVq3+LSA8OoYLZZUia0++YbcEGYaerx+kAgAAG74CAAAL1AIAABXEA
Date: Thu, 5 Dec 2019 18:09:24 +0000
Message-ID: <93aec76f-fe86-d8b9-6b7a-228149a6e0d4@virtuozzo.com>
References: <20191205152019.8454-1-vsementsov@virtuozzo.com>
 <20191205152019.8454-22-vsementsov@virtuozzo.com>
 <c4ff448d-e756-9d95-b07e-4ae5f2d5b9b0@redhat.com>
 <93046486-1580-14a1-520d-08abdf74da0e@virtuozzo.com>
 <443bfd26-08df-a421-fe88-71b2c068d8e4@redhat.com>
In-Reply-To: <443bfd26-08df-a421-fe88-71b2c068d8e4@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0102CA0062.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:7d::39) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191205210922043
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e422f93-ec4b-4147-8a3d-08d779ae425e
x-ms-traffictypediagnostic: AM6PR08MB3576:
x-microsoft-antispam-prvs: <AM6PR08MB357633756400508186699022C15C0@AM6PR08MB3576.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:288;
x-forefront-prvs: 02426D11FE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(39850400004)(376002)(136003)(396003)(346002)(189003)(199004)(66476007)(64756008)(66556008)(66946007)(4326008)(316002)(31686004)(66446008)(6486002)(110136005)(186003)(81166006)(81156014)(8676002)(305945005)(11346002)(25786009)(102836004)(2616005)(53546011)(6506007)(26005)(14454004)(14444005)(229853002)(71190400001)(71200400001)(31696002)(8936002)(5660300002)(52116002)(478600001)(54906003)(76176011)(36756003)(86362001)(2906002)(99286004)(6512007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3576;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cEe63ECFzJmnDFygCnDfBBg6FQm1imuDmRDeI6Jkv7Kpf9Wkh/WwEND9NU4xIwBwrDuSnHrsxYvN3CxVAQ+LB+D3Noae9j8+egAYZD6kNbNGEsCQZebWyD1SJ12OrFCVT2HaOZgj706vJRSkGcDith+oU1VSnVpfpTymf7z6vmktYrMpyCvjHhtNPu2qo/YHuZ6oIhYTMCP+grMwrwoF75hAMst9fwqrmOl2V4apsM47c5+pIj8P7Vs7B7Qmw4lzbcDpH5GAPdowuLY2AbNoB9Xp7Tmj1H0cxGX2FpsEqoPMsT+oIOEo0fptcboXU7n0h+08TatiJBFJR53m/mZF068lIG39W/J2y6f+VFw02ZTgCs0LaMrm8yvfB3v/JJ0ovEliUKdQGlcxG03MTMuu+CmAntjW7GWo6gKIO70MzuqrLUBH9dx8KxFDc5Ufu6Wu
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <FF5952717738AE45A34E20275B10A1F2@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e422f93-ec4b-4147-8a3d-08d779ae425e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2019 18:09:24.1866 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BKi2hE+EOpe6pcwGOtUWWsNEH4saNgr4URl+I8tjnz43Xp7OlTmPwMaHX26l8UPzIBfJh0WNde9imnjgqSX8E6UFjxcns7HG6nzFZ2Wb1FA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3576
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.109
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
Cc: Kevin Wolf <kwolf@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

05.12.2019 20:49, Eric Blake wrote:
> On 12/5/19 11:39 AM, Vladimir Sementsov-Ogievskiy wrote:
>> 05.12.2019 20:14, Eric Blake wrote:
>>> On 12/5/19 9:20 AM, Vladimir Sementsov-Ogievskiy wrote:
>>>> The local_err parameter is not here to return information about
>>>> nbd_iter_channel_error failure. Instead it's assumed to be filled when
>>>> passed to the function. This is already stressed by its name
>>>> (local_err, instead of classic errp). Stress it additionally by
>>>> assertion.
>>>>
>=20
>>>
>>> Would it be better to assert(!local_err || *local_err)?=A0 The assertio=
n as written is too strict without ERRP_AUTO_PROPAGATE, but you get away wi=
th it because none of the grandparents pass NULL; but is appropriate as wri=
tten for after after the macro conversion so then we wonder if churn on the=
 macro is worth it.
>>
>> We don't have any grandparents, this function is always called on local_=
err. And it's argument named local_err to stress it.
>=20
> Then the commit message should state that. How about:
>=20
> All callers of nbd_iter_channel_error() pass the address of a local_err v=
ariable, and only call this function if an error has already occurred, usin=
g this function

> to append details to that error.=20

Hmm, not to append details but to report the error to the magical receiving=
 loop, which doesn't yet know about the error

> This is already implied by its name (local_err instead of the classic err=
p), but it is worth additionally stressing this by adding an assertion to m=
ake it part of the function contract.


So, how about simply s/to append details to that error/to report that error=
/ ?

>=20
>> The function is an API to report error, and it wants filled local_err ob=
ject.
>>
>> It will crash anyway if local_err is NULL, as it dereferences it.
>>
>> I just want to place an assertion at start of functions like this,
>> which will be easily recognizable by coccinelle.
>=20
> With an improved commit message, the assertion makes sense, so
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
>>
>> ---
>>
>> We can improve the API, to support local_err=3D=3DNULL, for the case whe=
n original request was called with
>> errp=3D=3DNULL, but for this we'll need more changes, like, pass errp to=
 NBD_FOREACH_REPLY_CHUNK and save
>> it into iter object...
>>
>> But how to detect it in code? Something like
>>
>>
>> --- a/block/nbd.c
>> +++ b/block/nbd.c
>> @@ -1059,8 +1059,10 @@ static int nbd_co_receive_blockstatus_reply(BDRVN=
BDState *s,
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 case NBD_REPLY_TYPE_BLOCK_STATUS:
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (received) {
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 nbd_channel_error=
(s, -EINVAL);
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 error_setg(&local_err, "S=
everal BLOCK_STATUS chunks in reply");
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 nbd_iter_channel_error(&i=
ter, -EINVAL, &local_err);
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (errp) {
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 error_setg(&l=
ocal_err, "Several BLOCK_STATUS chunks in reply");
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 nbd_iter_channel_error(&i=
ter, -EINVAL, errp ? &local_err : NULL);
>=20
> No, that's not worth it.
>=20


--=20
Best regards,
Vladimir

