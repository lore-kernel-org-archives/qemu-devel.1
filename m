Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F46DC3A5A2
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 17:27:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 193D22064A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 17:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="iDXypKKb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 193D22064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0qs0-00013Q-KF
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 13:27:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35942)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i0qpg-0006tg-0W
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 13:25:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i0qpe-0003gG-20
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 13:25:07 -0400
Received: from mail-he1eur02on071d.outbound.protection.outlook.com
 ([2a01:111:f400:fe05::71d]:60132
 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i0qpW-0003aE-1B; Thu, 22 Aug 2019 13:24:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mIp80Y3KnZEHLjjUvaMAquYhxJAliiH6OtJKWiyckrohEqIQDavzsW5FjWLI5tU8mo/2r3lZnCXa2Opgyj6AW6JDT7JZucKWe7bS2trSvg2cxgOhoSLk6XFE0aR++SWg1lUuZEseg0NzGCy3KYDlOHiRoYuPO6VIuW7UZ1wJRqAu6j50NrbnoMy281/tBIDk7qYlh1vyw51DFXIR+zfUD6i8q9L7MxK3aVrYcP2JNARYLrfWqJBYu7AVekkM9Zn4onx5g+RsTxIi47xA6xph10o4F7NA+qgR5H/vWp6qJdJodg7FveFJmSQp1bFuyeUOIG3IKseSNl6yFneshCVubw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WOT3H7EH//lw/bzXsUDPXIxFlH9PV+h43Sl1HSJnNuI=;
 b=MvGBfxsyVPw78SmOQUug0avXNBqEwGO+Hp5VZ+Pic1B9m82TSIz6bzFXHLNrSesKcJ2wlwlRcKenCoH79LK+ZpkO6r31PHKihbtBhvsdujgxRTzApgGDM5x++EtniVs4PeXZlSOMUHBgvPHyizsNx2eFomRGpVsfNRFdAhT7zMAQrY+aK+t7g65y/96N5KVFh14NppoYAWIvM9YPxRVLo5U4Fwanklcey5vRN8/sBN1wFZuqlvQSh6yq/S4/gUdf3sFMRH9kZwB+no3tg1qHklchAQedEt33Db83d/F9XbXncPQDI1dO3WoA3RltvvT3Gwk7ZOeCgoKec13TuvWgXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WOT3H7EH//lw/bzXsUDPXIxFlH9PV+h43Sl1HSJnNuI=;
 b=iDXypKKbDgTqXYbBv5/4CNE5gdOyToalMDFqrb0uSLKQBzV4mG63gA9j7XcNXAq/vuAMLPeg9dp44QLILMSQHrs9m21Ro/spdJKfILBpN+rDiQz871Dt2tuxhPAIg46ufXj0E8E8gmwAZKVYOhkqN32PxRzO6NFtehwg2f+oXHg=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5097.eurprd08.prod.outlook.com (10.255.4.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.20; Thu, 22 Aug 2019 17:24:53 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2178.020; Thu, 22 Aug 2019
 17:24:53 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Thread-Topic: [Qemu-devel] [PATCH v2 00/12] block: qiov_offset parameter for io
Thread-Index: AQHVGvDDN3N+yvQgRE6fCgP4uttDuacHzNcAgAAaSAA=
Date: Thu, 22 Aug 2019 17:24:53 +0000
Message-ID: <9c1212a8-e9a2-662a-95ca-eab33ea7e367@virtuozzo.com>
References: <20190604161514.262241-1-vsementsov@virtuozzo.com>
 <20190822155046.GA20462@stefanha-x1.localdomain>
In-Reply-To: <20190822155046.GA20462@stefanha-x1.localdomain>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0802CA0007.eurprd08.prod.outlook.com
 (2603:10a6:3:bd::17) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190822202450750
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 783f8c0c-deb8-44e6-d309-08d72725a4e0
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DB8PR08MB5097; 
x-ms-traffictypediagnostic: DB8PR08MB5097:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB5097674E941A12A7F3F83971C1A50@DB8PR08MB5097.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01371B902F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(366004)(346002)(376002)(39850400004)(136003)(189003)(199004)(53754006)(2906002)(81156014)(1411001)(3846002)(446003)(2616005)(476003)(52116002)(8676002)(256004)(8936002)(6916009)(102836004)(66446008)(14454004)(6506007)(386003)(76176011)(81166006)(66946007)(229853002)(11346002)(14444005)(186003)(99286004)(54906003)(36756003)(966005)(26005)(86362001)(6436002)(31696002)(6306002)(6512007)(6246003)(66066001)(66476007)(66556008)(305945005)(53936002)(64756008)(31686004)(25786009)(6486002)(71200400001)(71190400001)(486006)(7736002)(5660300002)(4326008)(316002)(6116002)(478600001)(21314003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5097;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: prXGoMoYkTxc9RmR8CZrl9/ZPBfCWY4asr1XlJu9JufyvSqhZI6cIZ5d+uxHIR6QBKx+tePU3EvHPLtul8wqsTI+kTXibX3K1hnTDUJMljfVYKee4WJS6iOJPP58X4QaHVHYXcTPM41e+Oyv9OIH3i2QWagXpVSXT0i8ffqNzWe2crbQTHorSkxcVNuqwOTAb/5oFUx6aHk6XwNzy7/NGnV9fFT3haMBsdn8ufa3M/5HdNuZKXEtETdHHDIo73LyXpDnBclxWS2O2NAIRsflHjLVZZnXrO2m1SBUN4GDVUNRlpBs5iTrdXw4+nZdppMa/U6aG673RUDdYGNScqZBjYiSg8pVLgnZZdVdxrugx/3Za2DKJy6mIt1UZOFZuTL/U4mEeAdfks8CCUolKrfdDtklS26EiEsjD4kbFRp4CZQ=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <3CD6B27596D5464D8D3409C5CE276F98@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 783f8c0c-deb8-44e6-d309-08d72725a4e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2019 17:24:53.2387 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3sqmZYlVJoFXlO0NRGvfwLQOzPurja7rf05ekwDb/G40/R3f11Yt5syr1MkyQvQjvLyVIQ1el9zcM2NqlIkREMekdj1HWvh2x11TPyO1o6M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5097
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe05::71d
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

22.08.2019 18:50, Stefan Hajnoczi wrote:
> On Tue, Jun 04, 2019 at 07:15:02PM +0300, Vladimir Sementsov-Ogievskiy wr=
ote:
>> Hi all!
>>
>> Here is new parameter qiov_offset for io path, to avoid
>> a lot of places with same pattern of creating local_qiov or hd_qiov
>> variables.
>>
>> These series also includes my
>> "[Qemu-devel] [PATCH 0/2] block/io: refactor padding"
>> with some changes [described in 01 and 03 emails]
>>
>> Vladimir Sementsov-Ogievskiy (12):
>>    util/iov: introduce qemu_iovec_init_extended
>>    util/iov: improve qemu_iovec_is_zero
>>    block/io: refactor padding
>>    block: define .*_part io handlers in BlockDriver
>>    block/io: bdrv_co_do_copy_on_readv: use and support qiov_offset
>>    block/io: bdrv_co_do_copy_on_readv: lazy allocation
>>    block/io: bdrv_aligned_preadv: use and support qiov_offset
>>    block/io: bdrv_aligned_pwritev: use and support qiov_offset
>>    block/io: introduce bdrv_co_p{read,write}v_part
>>    block/qcow2: refactor qcow2_co_preadv to use buffer-based io
>>    block/qcow2: implement .bdrv_co_preadv_part
>>    block/qcow2: implement .bdrv_co_pwritev(_compressed)_part
>>
>>   block/qcow2.h             |   1 +
>>   include/block/block_int.h |  21 ++
>>   include/qemu/iov.h        |  10 +-
>>   block/backup.c            |   2 +-
>>   block/io.c                | 532 ++++++++++++++++++++++----------------
>>   block/qcow2-cluster.c     |  14 +-
>>   block/qcow2.c             | 131 +++++-----
>>   qemu-img.c                |   4 +-
>>   util/iov.c                | 153 +++++++++--
>>   9 files changed, 559 insertions(+), 309 deletions(-)
>=20
> qemu-iotests 077 fails after I apply this series (including your
> uninitialized variable fix).  I'm afraid I can't include it in the block
> pull request, sorry!
>=20
> Stefan
>=20

Hmm, 77 don't work on master for me:
077      fail       [20:23:57] [20:23:59]                    output mismatc=
h (see 077.out.bad)
--- /work/src/qemu/up-block-drop-hd-qiov/tests/qemu-iotests/077.out     201=
9-04-22 15:06:56.162045432 +0300
+++ /work/src/qemu/up-block-drop-hd-qiov/tests/qemu-iotests/077.out.bad 201=
9-08-22 20:23:59.124122307 +0300
@@ -1,7 +1,15 @@
  QA output created by 077
+=3D=3D117186=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
+=3D=3D117186=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_ret=
urn: stack top: 0x7ffefc071000; bottom 0x7fad7277b000; size: 0x0051898f6000=
 (350200225792)
+False positive error reports may follow
+For details see http://code.google.com/p/address-sanitizer/issues/detail?i=
d=3D189
  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728

  =3D=3D Some concurrent requests involving RMW =3D=3D
+=3D=3D117197=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
+=3D=3D117197=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_ret=
urn: stack top: 0x7fffa4fcc000; bottom 0x7fa93a2c1000; size: 0x00566ad0b000=
 (371159248896)
+False positive error reports may follow
+For details see http://code.google.com/p/address-sanitizer/issues/detail?i=
d=3D189
  wrote XXX/XXX bytes at offset XXX
  XXX bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
  wrote XXX/XXX bytes at offset XXX
@@ -66,6 +74,10 @@
  XXX bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)

  =3D=3D Verify image content =3D=3D
+=3D=3D117219=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
+=3D=3D117219=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_ret=
urn: stack top: 0x7ffc722de000; bottom 0x7f0848232000; size: 0x00f42a0ac000=
 (1048677367808)
+False positive error reports may follow
+For details see http://code.google.com/p/address-sanitizer/issues/detail?i=
d=3D189
  read 512/512 bytes at offset 0
  512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
  read 512/512 bytes at offset 512
@@ -156,5 +168,9 @@
  1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
  read 2048/2048 bytes at offset 71680
  2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+=3D=3D117229=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
+=3D=3D117229=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_ret=
urn: stack top: 0x7fffa3342000; bottom 0x7fd85a275000; size: 0x0027490cd000=
 (168729300992)
+False positive error reports may follow
+For details see http://code.google.com/p/address-sanitizer/issues/detail?i=
d=3D189
  No errors were found on the image.
  *** done
Failures: 077
Failed 1 of 1 tests



--=20
Best regards,
Vladimir

