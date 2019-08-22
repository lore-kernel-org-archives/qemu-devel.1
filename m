Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B6AC3A5A2
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 17:40:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AB4023402
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 17:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="m+qcKvmV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AB4023402
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0r4O-0002SL-Sp
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 13:40:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41475)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i0r3Z-0001ur-34
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 13:39:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i0r3X-0002tx-KU
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 13:39:29 -0400
Received: from mail-eopbgr40094.outbound.protection.outlook.com
 ([40.107.4.94]:31079 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i0r3T-0002qb-5Z; Thu, 22 Aug 2019 13:39:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WHR1tqjjC0kxWGhcGvBgu/CNAGlPgRFiOAw/3C0AGfq8oFgZwD8/TLcQZsmol02ThfhijjqKHPlmDNsrWCelNUSkro8duWKDqrBJtN/HTM60ge7bVSrBpusnkUPggincXHeZX20n9AH0OAsadM8PwN0z19c1l9nR3vFotszsJ7uJG+7qMkNaZtYccxEheXXlMi/0akXVNJBGkA9uhfeo17uHKni06kgp4ifPzhbLk9Kg3ZEv/+Cmt3gkkiM1oxDrfWPVKul3KEZW8oQte5H5PQgx9Zi+hl9TumOUaIN+RrGaKUnSsuJuoySND4VgcnUZJ319znMZmEUKi0dYWbv5HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5J6169OXsewPB0SI+H4u0Ic87JCzlzZh5EI6SBHDjw=;
 b=HMKq7jPEFT+jmKNjTIJk+UwHjLfYJyVAbgCgXZ0WDkTbCZ4wSrtE8v+r82mgtyCNEZTQsPgjVhLgrvEsysYGMPwKOxnCHR+Rcj6rQP+rFbq62mr//CL1FL9plPOYZHrG/T/4JCv8dUlIabuZL3vLT4uU1CVrKO4DYxCq262a+yzLoSV5gLxp6nFaaZDBA0SoxW4O+hnXT++mpFDLf6WCciUnDtvbwayNTf+FTNfsIwUA7049zNBTxMcfLrnBHDAPh5qocQbXbg7lRzDrxgxZG3zolzyzedyO6Ndml8D+Vkl0G/VNbDoQ3TGZ2mvMWoO1J+vmLYi0iIbjaP82y9wRTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5J6169OXsewPB0SI+H4u0Ic87JCzlzZh5EI6SBHDjw=;
 b=m+qcKvmVGbUZ8CZLdR+kGGlo3VMb2FALhsvCwQbxuGwzV4J9sSKuQPwGg8egJvK+Mrd5eva3rnWyg6a4iVvrae2lVy/t9czPP+jQo/MDghHluQ0br05DeJdQNJ81Rv7yTHFjQlo0jqSOvzCemLfC2Jiav+ZoMG7f0HgPj+oqbXQ=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5402.eurprd08.prod.outlook.com (52.133.241.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Thu, 22 Aug 2019 17:39:20 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2178.020; Thu, 22 Aug 2019
 17:39:20 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Thread-Topic: [Qemu-devel] [PATCH v2 00/12] block: qiov_offset parameter for io
Thread-Index: AQHVGvDDN3N+yvQgRE6fCgP4uttDuacHzNcAgAAaSACAAAQKgA==
Date: Thu, 22 Aug 2019 17:39:20 +0000
Message-ID: <0f0c8882-ab41-8fcf-85ca-ecff901f4ce8@virtuozzo.com>
References: <20190604161514.262241-1-vsementsov@virtuozzo.com>
 <20190822155046.GA20462@stefanha-x1.localdomain>
 <9c1212a8-e9a2-662a-95ca-eab33ea7e367@virtuozzo.com>
In-Reply-To: <9c1212a8-e9a2-662a-95ca-eab33ea7e367@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0901CA0056.eurprd09.prod.outlook.com
 (2603:10a6:3:45::24) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190822203917587
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9597ed6b-e4e4-48c9-4705-08d72727a998
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DB8PR08MB5402; 
x-ms-traffictypediagnostic: DB8PR08MB5402:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB5402D4E75BA743BC3BAF3C22C1A50@DB8PR08MB5402.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01371B902F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(396003)(39840400004)(376002)(346002)(136003)(199004)(189003)(53754006)(446003)(6512007)(81166006)(8676002)(66946007)(11346002)(2616005)(476003)(31696002)(6306002)(26005)(7736002)(305945005)(76176011)(229853002)(966005)(6916009)(14454004)(5660300002)(486006)(6486002)(25786009)(386003)(31686004)(186003)(6506007)(102836004)(6436002)(478600001)(86362001)(6116002)(71190400001)(1411001)(2906002)(54906003)(256004)(71200400001)(6246003)(14444005)(52116002)(53936002)(4326008)(3846002)(316002)(99286004)(66476007)(66446008)(64756008)(66556008)(66066001)(36756003)(8936002)(81156014)(21314003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5402;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: u6k8xmuU6TdSAJuW3uBroGevqCbXyKSN1RLUAtuJk/gIOl3mEIzxEZrldc9I9zghG3IgyGNfYZ+k1FGJ4EPuEaks5yNJ4qfuXrn7ivSvunvSGOMl/uBcMZ6txGSS1rPUtDsR/C5RzQ+Gp/89uJ5c7Jt6HiJhDqVQ5aOLv8ldovMdAeDsVPv1zeTdJugdTCR22Hw61B+OaZz60aENRuxzZwYXvA2fSoVt7DXgpfVy2Crk2YGA9iRS9zhWOanjkJGZKMr9PYLSLhp5Uk1Z6OCpohbcKwg5rxpAWbKdR5kfPzErMJXrtcFLE3zQsPQ+hnqYIX47eq6NmYaBcPHVxRcO3GW+t8if1Fiv+AjqY0SQzzKGJl+K3FW3b+zLNVrxKZvTpdsdMpZRTzT3aXPCyyvq5zdz04tl9PLBMuPsbrnaNPY=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <3E6EC7B740B9B3448BAE08F5FD5C9632@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9597ed6b-e4e4-48c9-4705-08d72727a998
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2019 17:39:20.0212 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HtkPEk/DEROQXnWIc2QAfKziKpP0oh6YfSuDCrKRS5WiaddidJaQMvm7xqAvSQU6lJA7pxADdHJsY2WZR/qwbAjG/OMapv8/aVOz0qIpleA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5402
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.94
Subject: Re: [Qemu-devel] [PATCH v2 00/12] block: qiov_offset parameter for
 io
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
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

22.08.2019 20:24, Vladimir Sementsov-Ogievskiy wrote:
> 22.08.2019 18:50, Stefan Hajnoczi wrote:
>> On Tue, Jun 04, 2019 at 07:15:02PM +0300, Vladimir Sementsov-Ogievskiy w=
rote:
>>> Hi all!
>>>
>>> Here is new parameter qiov_offset for io path, to avoid
>>> a lot of places with same pattern of creating local_qiov or hd_qiov
>>> variables.
>>>
>>> These series also includes my
>>> "[Qemu-devel] [PATCH 0/2] block/io: refactor padding"
>>> with some changes [described in 01 and 03 emails]
>>>
>>> Vladimir Sementsov-Ogievskiy (12):
>>> =A0=A0 util/iov: introduce qemu_iovec_init_extended
>>> =A0=A0 util/iov: improve qemu_iovec_is_zero
>>> =A0=A0 block/io: refactor padding
>>> =A0=A0 block: define .*_part io handlers in BlockDriver
>>> =A0=A0 block/io: bdrv_co_do_copy_on_readv: use and support qiov_offset
>>> =A0=A0 block/io: bdrv_co_do_copy_on_readv: lazy allocation
>>> =A0=A0 block/io: bdrv_aligned_preadv: use and support qiov_offset
>>> =A0=A0 block/io: bdrv_aligned_pwritev: use and support qiov_offset
>>> =A0=A0 block/io: introduce bdrv_co_p{read,write}v_part
>>> =A0=A0 block/qcow2: refactor qcow2_co_preadv to use buffer-based io
>>> =A0=A0 block/qcow2: implement .bdrv_co_preadv_part
>>> =A0=A0 block/qcow2: implement .bdrv_co_pwritev(_compressed)_part
>>>
>>> =A0 block/qcow2.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 1 +
>>> =A0 include/block/block_int.h |=A0 21 ++
>>> =A0 include/qemu/iov.h=A0=A0=A0=A0=A0=A0=A0 |=A0 10 +-
>>> =A0 block/backup.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 2 +-
>>> =A0 block/io.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 532 +++++=
+++++++++++++++++----------------
>>> =A0 block/qcow2-cluster.c=A0=A0=A0=A0 |=A0 14 +-
>>> =A0 block/qcow2.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 131 +++++-----
>>> =A0 qemu-img.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 4 +=
-
>>> =A0 util/iov.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 153 +++++=
++++--
>>> =A0 9 files changed, 559 insertions(+), 309 deletions(-)
>>
>> qemu-iotests 077 fails after I apply this series (including your
>> uninitialized variable fix).=A0 I'm afraid I can't include it in the blo=
ck
>> pull request, sorry!
>>
>> Stefan
>>
>=20
> Hmm, 77 don't work on master for me:
> 077=A0=A0=A0=A0=A0 fail=A0=A0=A0=A0=A0=A0 [20:23:57] [20:23:59]=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 output mismatch (see 077.o=
ut.bad)
> --- /work/src/qemu/up-block-drop-hd-qiov/tests/qemu-iotests/077.out=A0=A0=
=A0=A0 2019-04-22 15:06:56.162045432 +0300
> +++ /work/src/qemu/up-block-drop-hd-qiov/tests/qemu-iotests/077.out.bad 2=
019-08-22 20:23:59.124122307 +0300
> @@ -1,7 +1,15 @@
>  =A0QA output created by 077
> +=3D=3D117186=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> +=3D=3D117186=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_r=
eturn: stack top: 0x7ffefc071000; bottom 0x7fad7277b000; size: 0x0051898f60=
00 (350200225792)
> +False positive error reports may follow
> +For details see http://code.google.com/p/address-sanitizer/issues/detail=
?id=3D189
>  =A0Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728
>=20
>  =A0=3D=3D Some concurrent requests involving RMW =3D=3D
> +=3D=3D117197=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> +=3D=3D117197=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_r=
eturn: stack top: 0x7fffa4fcc000; bottom 0x7fa93a2c1000; size: 0x00566ad0b0=
00 (371159248896)
> +False positive error reports may follow
> +For details see http://code.google.com/p/address-sanitizer/issues/detail=
?id=3D189
>  =A0wrote XXX/XXX bytes at offset XXX
>  =A0XXX bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  =A0wrote XXX/XXX bytes at offset XXX
> @@ -66,6 +74,10 @@
>  =A0XXX bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>=20
>  =A0=3D=3D Verify image content =3D=3D
> +=3D=3D117219=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> +=3D=3D117219=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_r=
eturn: stack top: 0x7ffc722de000; bottom 0x7f0848232000; size: 0x00f42a0ac0=
00 (1048677367808)
> +False positive error reports may follow
> +For details see http://code.google.com/p/address-sanitizer/issues/detail=
?id=3D189
>  =A0read 512/512 bytes at offset 0
>  =A0512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  =A0read 512/512 bytes at offset 512
> @@ -156,5 +168,9 @@
>  =A01 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  =A0read 2048/2048 bytes at offset 71680
>  =A02 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +=3D=3D117229=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> +=3D=3D117229=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_r=
eturn: stack top: 0x7fffa3342000; bottom 0x7fd85a275000; size: 0x0027490cd0=
00 (168729300992)
> +False positive error reports may follow
> +For details see http://code.google.com/p/address-sanitizer/issues/detail=
?id=3D189
>  =A0No errors were found on the image.
>  =A0*** done
> Failures: 077
> Failed 1 of 1 tests
>=20
>=20
>=20

But after "block/io: refactor padding" it hangs instead of this fail.. This=
 is not good


--=20
Best regards,
Vladimir

