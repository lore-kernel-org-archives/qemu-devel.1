Return-Path: <SRS0=NWXH=WU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86EBC3A59E
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2019 10:16:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FB6E2082E
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2019 10:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Sk21hL8R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FB6E2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1T69-0000Yb-ME
	for qemu-devel@archiver.kernel.org; Sat, 24 Aug 2019 06:16:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52540)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i1T5E-0008TO-LY
 for qemu-devel@nongnu.org; Sat, 24 Aug 2019 06:15:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i1T5D-000560-65
 for qemu-devel@nongnu.org; Sat, 24 Aug 2019 06:15:44 -0400
Received: from mail-eopbgr60114.outbound.protection.outlook.com
 ([40.107.6.114]:28669 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i1T59-00053D-3H; Sat, 24 Aug 2019 06:15:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYqX6zWlEOWLZD9X5/ZJK+csVpuYr7gf8m6qS4l3k7ytln6VAwZ3WDWPTqs9JWUg6V04+QmL7py0CGV+UmzGDbNFsalypm8k1KS8R6s+3pLhvypIZ/dH+3BGTndnKX3d1U44NqPuhzMN0WMNtthdlHL40upyGurWc3dtoP4I8tXM8xvpxnW9X3UiuZ1hn9BHbixqaotsj1RDNiwJaWxM9c1MGBPbWazLQ7b5u57RUZs0hn9a5MyegrrDh+oxBddND/uuly80aX7ENereSaJgyWk5EdSxrJKDXPhC7NHHl2WXXs5CtXnM/l77CCG29fVjFCpPzvwTZBIlv7CT8HJ+Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6aLELgX/8bMiIkMl6RPr9039WHJle5w5Vu520SkUgI8=;
 b=lfMCHheV5pG/Mbxy1l7KFS/l11OTFnk1KakITsHNk4Th/AZrFdmMsNGFqw9NC1AHeHiwWghvJoOWMQVxupDABvPUpr/MtxGB8SxB2MjDeLROhiIF+6NQemw4lBbBtOgSCAycbkskYc4b0DiIZGkbNK/TlwuQhava5D2JvaqyLm3PMyEIiRPNgfSA5HDa5jmaAxYMow0OhCTf3zwwzeY68WTlcK0IIrvYKUJYaX6gXOhgIQzafRoiPGXmytLarWtyblT1qQ+Ksdyg/xnxmutju1oDVzQN8lOscUxEB96HgTYLwQQ9FUhxuCIfP7ZGIVp5vMvmSmSATADZveDqL4mZTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6aLELgX/8bMiIkMl6RPr9039WHJle5w5Vu520SkUgI8=;
 b=Sk21hL8RP90pMRhbjqMwdV8bqbLCFa6jyHhCrIK+3cJB4LeqF3Hlzwubsf/IMRgdNu9lkUkxUE9NNrJYlQjU+QEpjwimXd9lDeyWOeFrrxFvK9SF0YoaxzX3GTx+U/RDFK9A7vnsdy7iPsXp6p9mdo9gZUz+/04tdLPiXur26bQ=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5002.eurprd08.prod.outlook.com (10.255.17.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.20; Sat, 24 Aug 2019 10:15:35 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2178.020; Sat, 24 Aug 2019
 10:15:35 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Thread-Topic: [Qemu-devel] [PATCH v2 00/12] block: qiov_offset parameter for io
Thread-Index: AQHVGvDDN3N+yvQgRE6fCgP4uttDuacHzNcAgAAaSACAAAQKgIAABbOAgAF2y4CAASwvgA==
Date: Sat, 24 Aug 2019 10:15:35 +0000
Message-ID: <378a87ca-8b65-02c3-cb5d-626ebf9860c1@virtuozzo.com>
References: <20190604161514.262241-1-vsementsov@virtuozzo.com>
 <20190822155046.GA20462@stefanha-x1.localdomain>
 <9c1212a8-e9a2-662a-95ca-eab33ea7e367@virtuozzo.com>
 <0f0c8882-ab41-8fcf-85ca-ecff901f4ce8@virtuozzo.com>
 <870d2422-b37a-2ce2-72d6-6cded1598b22@virtuozzo.com>
 <20190823162107.GC27586@stefanha-x1.localdomain>
In-Reply-To: <20190823162107.GC27586@stefanha-x1.localdomain>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR1001CA0008.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::18) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190824131531938
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 81b5b228-6b1b-41b6-57fc-08d7287c0103
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DB8PR08MB5002; 
x-ms-traffictypediagnostic: DB8PR08MB5002:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB5002BBA1C7C133FB1347DCB0C1A70@DB8PR08MB5002.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0139052FDB
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(366004)(346002)(39840400004)(136003)(376002)(53754006)(189003)(199004)(6246003)(6916009)(6306002)(6506007)(386003)(14444005)(53936002)(316002)(76176011)(52116002)(256004)(2906002)(102836004)(81166006)(81156014)(7736002)(64756008)(66446008)(66556008)(6512007)(26005)(25786009)(446003)(66476007)(66946007)(486006)(6486002)(966005)(8936002)(229853002)(86362001)(31696002)(4326008)(11346002)(66066001)(3846002)(6436002)(186003)(71190400001)(71200400001)(5660300002)(36756003)(2616005)(99286004)(476003)(8676002)(305945005)(31686004)(14454004)(54906003)(478600001)(6116002)(21314003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5002;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hWBve2hExMyGzwRO6jiADmWIJC4BhyEBxfYOxNuPgjDYK++tlJRXyYWNKlIltG8obkwl+RPLElsMkVE5dNE80tqtt5Y5WxeTrrgEchIK9TPZCK72KMUWqm2N1M9NyhFg3kq6dt7OUpLacdInBPtk/HjurWhOr0A5YbTC/Q9BRNFtiyBVMO1cYwg8SBMaAKXZt4K5r+GU5+DdOvDu6RTiNQdYFiQeQoWWMpHyIYypEmOtdQouD6WB0z68KIEYvF7bnPF8ZRo2LIFCPrqrlkxAdsZiIaxsO3J18Z1ChVZYR/8EeMnBHNEmSnUq2gnAHIEl+v47NHuz4bVJiDsVzpmoUuS/oVFyzWocZ+JWq4bRYjTEpot5u4klHLWEG9WHBqJc35SOvdahnwhN/cmY9j3LzfynoltckpgHYX1xXS8eLxY=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <665BED997FEED945B225A2C37B882DCA@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81b5b228-6b1b-41b6-57fc-08d7287c0103
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2019 10:15:35.6568 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BdLTzySEZls1Aus76yLzQ5fgrQGr2VqdWSH42+4LeFSLFgPaBK8x2N/pns/SCQ8qTitDdxiZ0HuvIknHHT+1Y/AoW3NxEzo1b8E9i+rg6TM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5002
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.114
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
 Stefan Hajnoczi <stefanha@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

23.08.2019 19:21, Stefan Hajnoczi wrote:
> On Thu, Aug 22, 2019 at 05:59:43PM +0000, Vladimir Sementsov-Ogievskiy wr=
ote:
>> 22.08.2019 20:39, Vladimir Sementsov-Ogievskiy wrote:
>>> 22.08.2019 20:24, Vladimir Sementsov-Ogievskiy wrote:
>>>> 22.08.2019 18:50, Stefan Hajnoczi wrote:
>>>>> On Tue, Jun 04, 2019 at 07:15:02PM +0300, Vladimir Sementsov-Ogievski=
y wrote:
>>>>>> Hi all!
>>>>>>
>>>>>> Here is new parameter qiov_offset for io path, to avoid
>>>>>> a lot of places with same pattern of creating local_qiov or hd_qiov
>>>>>> variables.
>>>>>>
>>>>>> These series also includes my
>>>>>> "[Qemu-devel] [PATCH 0/2] block/io: refactor padding"
>>>>>> with some changes [described in 01 and 03 emails]
>>>>>>
>>>>>> Vladimir Sementsov-Ogievskiy (12):
>>>>>>  =A0=A0 util/iov: introduce qemu_iovec_init_extended
>>>>>>  =A0=A0 util/iov: improve qemu_iovec_is_zero
>>>>>>  =A0=A0 block/io: refactor padding
>>>>>>  =A0=A0 block: define .*_part io handlers in BlockDriver
>>>>>>  =A0=A0 block/io: bdrv_co_do_copy_on_readv: use and support qiov_off=
set
>>>>>>  =A0=A0 block/io: bdrv_co_do_copy_on_readv: lazy allocation
>>>>>>  =A0=A0 block/io: bdrv_aligned_preadv: use and support qiov_offset
>>>>>>  =A0=A0 block/io: bdrv_aligned_pwritev: use and support qiov_offset
>>>>>>  =A0=A0 block/io: introduce bdrv_co_p{read,write}v_part
>>>>>>  =A0=A0 block/qcow2: refactor qcow2_co_preadv to use buffer-based io
>>>>>>  =A0=A0 block/qcow2: implement .bdrv_co_preadv_part
>>>>>>  =A0=A0 block/qcow2: implement .bdrv_co_pwritev(_compressed)_part
>>>>>>
>>>>>>  =A0 block/qcow2.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 1 +
>>>>>>  =A0 include/block/block_int.h |=A0 21 ++
>>>>>>  =A0 include/qemu/iov.h=A0=A0=A0=A0=A0=A0=A0 |=A0 10 +-
>>>>>>  =A0 block/backup.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 2 +-
>>>>>>  =A0 block/io.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 532 +=
+++++++++++++++++++++----------------
>>>>>>  =A0 block/qcow2-cluster.c=A0=A0=A0=A0 |=A0 14 +-
>>>>>>  =A0 block/qcow2.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 131 +++++--=
---
>>>>>>  =A0 qemu-img.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=
 4 +-
>>>>>>  =A0 util/iov.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 153 +=
++++++++--
>>>>>>  =A0 9 files changed, 559 insertions(+), 309 deletions(-)
>>>>>
>>>>> qemu-iotests 077 fails after I apply this series (including your
>>>>> uninitialized variable fix).=A0 I'm afraid I can't include it in the =
block
>>>>> pull request, sorry!
>>>>>
>>>>> Stefan
>>>>>
>>>>
>>>> Hmm, 77 don't work on master for me:
>>>> 077=A0=A0=A0=A0=A0 fail=A0=A0=A0=A0=A0=A0 [20:23:57] [20:23:59]=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 output mismatch (see 07=
7.out.bad)
>>>> --- /work/src/qemu/up-block-drop-hd-qiov/tests/qemu-iotests/077.out=A0=
=A0=A0=A0 2019-04-22 15:06:56.162045432 +0300
>>>> +++ /work/src/qemu/up-block-drop-hd-qiov/tests/qemu-iotests/077.out.ba=
d 2019-08-22 20:23:59.124122307 +0300
>>>> @@ -1,7 +1,15 @@
>>>>  =A0=A0QA output created by 077
>>>> +=3D=3D117186=3D=3DWARNING: ASan doesn't fully support makecontext/swa=
pcontext functions and may produce false positives in some cases!
>>>> +=3D=3D117186=3D=3DWARNING: ASan is ignoring requested __asan_handle_n=
o_return: stack top: 0x7ffefc071000; bottom 0x7fad7277b000; size: 0x0051898=
f6000 (350200225792)
>>>> +False positive error reports may follow
>>>> +For details see http://code.google.com/p/address-sanitizer/issues/det=
ail?id=3D189
>>>>  =A0=A0Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728
>>>>
>>>>  =A0=A0=3D=3D Some concurrent requests involving RMW =3D=3D
>>>> +=3D=3D117197=3D=3DWARNING: ASan doesn't fully support makecontext/swa=
pcontext functions and may produce false positives in some cases!
>>>> +=3D=3D117197=3D=3DWARNING: ASan is ignoring requested __asan_handle_n=
o_return: stack top: 0x7fffa4fcc000; bottom 0x7fa93a2c1000; size: 0x00566ad=
0b000 (371159248896)
>>>> +False positive error reports may follow
>>>> +For details see http://code.google.com/p/address-sanitizer/issues/det=
ail?id=3D189
>>>>  =A0=A0wrote XXX/XXX bytes at offset XXX
>>>>  =A0=A0XXX bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>>>  =A0=A0wrote XXX/XXX bytes at offset XXX
>>>> @@ -66,6 +74,10 @@
>>>>  =A0=A0XXX bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>>>
>>>>  =A0=A0=3D=3D Verify image content =3D=3D
>>>> +=3D=3D117219=3D=3DWARNING: ASan doesn't fully support makecontext/swa=
pcontext functions and may produce false positives in some cases!
>>>> +=3D=3D117219=3D=3DWARNING: ASan is ignoring requested __asan_handle_n=
o_return: stack top: 0x7ffc722de000; bottom 0x7f0848232000; size: 0x00f42a0=
ac000 (1048677367808)
>>>> +False positive error reports may follow
>>>> +For details see http://code.google.com/p/address-sanitizer/issues/det=
ail?id=3D189
>>>>  =A0=A0read 512/512 bytes at offset 0
>>>>  =A0=A0512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>>>  =A0=A0read 512/512 bytes at offset 512
>>>> @@ -156,5 +168,9 @@
>>>>  =A0=A01 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>>>  =A0=A0read 2048/2048 bytes at offset 71680
>>>>  =A0=A02 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>>> +=3D=3D117229=3D=3DWARNING: ASan doesn't fully support makecontext/swa=
pcontext functions and may produce false positives in some cases!
>>>> +=3D=3D117229=3D=3DWARNING: ASan is ignoring requested __asan_handle_n=
o_return: stack top: 0x7fffa3342000; bottom 0x7fd85a275000; size: 0x0027490=
cd000 (168729300992)
>>>> +False positive error reports may follow
>>>> +For details see http://code.google.com/p/address-sanitizer/issues/det=
ail?id=3D189
>>>>  =A0=A0No errors were found on the image.
>>>>  =A0=A0*** done
>>>> Failures: 077
>>>> Failed 1 of 1 tests
>>>>
>>>>
>>>>
>>>
>>> But after "block/io: refactor padding" it hangs instead of this fail.. =
This is not good
>>>
>>>
>>
>> Aha seems it's because 77 has "break pwritev_rmw_after_tail" which may n=
ot fire if we have merge_reads =3D true.
>>
>> So, for me the following fix for 03 helps (77 fails, but not hangs, so s=
ame behavior as on master):
>>
>> diff --git a/block/io.c b/block/io.c
>> index 6448f1c503..04e69400d8 100644
>> --- a/block/io.c
>> +++ b/block/io.c
>> @@ -1493,13 +1493,23 @@ static int bdrv_padding_rmw_read(BdrvChild *chil=
d,
>>
>>            qemu_iovec_init_buf(&local_qiov, pad->buf, bytes);
>>
>> -        bdrv_debug_event(bs, BLKDBG_PWRITEV_RMW_HEAD);
>> +        if (pad->head) {
>> +            bdrv_debug_event(bs, BLKDBG_PWRITEV_RMW_HEAD);
>> +        }
>> +        if (pad->merge_reads && pad->tail) {
>> +            bdrv_debug_event(bs, BLKDBG_PWRITEV_RMW_TAIL);
>> +        }
>>            ret =3D bdrv_aligned_preadv(child, req, req->overlap_offset, =
bytes,
>>                                      align, &local_qiov, 0);
>>            if (ret < 0) {
>>                return ret;
>>            }
>> -        bdrv_debug_event(bs, BLKDBG_PWRITEV_RMW_AFTER_HEAD);
>> +        if (pad->head) {
>> +            bdrv_debug_event(bs, BLKDBG_PWRITEV_RMW_AFTER_HEAD);
>> +        }
>> +        if (pad->merge_reads && pad->tail) {
>> +            bdrv_debug_event(bs, BLKDBG_PWRITEV_RMW_AFTER_TAIL);
>> +        }
>>
>>
>> Does it work for you?
>=20
> Yes, it works as expected now, thanks.  I've squashed in your fix and
> will send these patches in the next block pull request.
>=20

Thank you!


--=20
Best regards,
Vladimir

