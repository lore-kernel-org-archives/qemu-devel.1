Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A43EC3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 18:01:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB9EB2173E
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 18:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="jF2whSxM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB9EB2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0rOo-0007GH-TN
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 14:01:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48119)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i0rNM-0006Ak-0m
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 13:59:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i0rNK-0004qv-A1
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 13:59:55 -0400
Received: from mail-eopbgr10129.outbound.protection.outlook.com
 ([40.107.1.129]:47632 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i0rNE-0004mc-FA; Thu, 22 Aug 2019 13:59:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PMfMoFUh4voTmFlMvMKAlL6VtApu6abtj6V0Rqtf9g8K3XnDoGQPlinsg7bRIpVY+P0kgrdC/4QOIpAzjQDmWVl45f2Jw5+Cs3f2RXtvlLlN/p3DDCGTkyL0E3lqholAmAbj680hMtelZyXULDjzZzk77qrLtf3Ziv7VeLB6VHJrYQYayVcstft0b1DlIKGY2lHEzDqjYvspjnJ1IoWvhvjeRsWuVhU1jHu62bZgskq9HQrwLPi8z7jYjP8OIGMFNQgJwd9t2iSbl9jA2daxJUC/bd99GD5UCyVhaQWUa7DLIeRlwtElejwvtDCixztpNjVfLv+MHoXTnD8vlDr2mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8kKqjCzajHKd+eNj5nSCDr+oT6K3IX0CzU9KjvCHmM0=;
 b=KnPyDJLvPVaRretMSXUPqxFFl1aOQPBDgR7DjYfFrGh4pJ4TXQldwj9gM247vE1lMMTIXU026lmshGoroqn42GN8pTDyW6aiyXcd/7A0ytOe9qcvjqtX41ma9BlpWefNP1Sg/S6ilSujk30BK6RIWyPm7fttKQ21xvfFJ6Ra0bTVqdgZjJ9UmkY9eqQ0tFpOVUnFZckmWeLKWZc4s/kOrgtOn7Nnc3YH0lnJaZWv4sqawlHShH2RG2dqPZ0XNhKNpmV5R9bGVl9wMiEPQUMotOltR6KhXPtsLh33e1sI6pqoFSY4ozdhzCDqPc38c66o76WTVKJ/XLCxdO+i4C5wrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8kKqjCzajHKd+eNj5nSCDr+oT6K3IX0CzU9KjvCHmM0=;
 b=jF2whSxMaWG4La6bdLZos4UAL24TBxviTlElhfXVU8YRLBXa9n5q07uSkdK5QMasrbSI7kOpWAQt+EVbmnkxpI8pnJ2Xk6CXO5s6y+avtHpOauPvIW0AV6/Mhs/0iYtyjkGFU4fnWqwtEUFZzHfeJuWIDUp78OROHHvpFezabRY=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5386.eurprd08.prod.outlook.com (52.133.241.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Thu, 22 Aug 2019 17:59:43 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2178.020; Thu, 22 Aug 2019
 17:59:43 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Thread-Topic: [Qemu-devel] [PATCH v2 00/12] block: qiov_offset parameter for io
Thread-Index: AQHVGvDDN3N+yvQgRE6fCgP4uttDuacHzNcAgAAaSACAAAQKgIAABbOA
Date: Thu, 22 Aug 2019 17:59:43 +0000
Message-ID: <870d2422-b37a-2ce2-72d6-6cded1598b22@virtuozzo.com>
References: <20190604161514.262241-1-vsementsov@virtuozzo.com>
 <20190822155046.GA20462@stefanha-x1.localdomain>
 <9c1212a8-e9a2-662a-95ca-eab33ea7e367@virtuozzo.com>
 <0f0c8882-ab41-8fcf-85ca-ecff901f4ce8@virtuozzo.com>
In-Reply-To: <0f0c8882-ab41-8fcf-85ca-ecff901f4ce8@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR02CA0115.eurprd02.prod.outlook.com
 (2603:10a6:7:29::44) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190822205941262
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f1b55d28-8dcf-4391-d443-08d7272a82ee
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DB8PR08MB5386; 
x-ms-traffictypediagnostic: DB8PR08MB5386:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB53869C1BA3691BFC4FF4A2B9C1A50@DB8PR08MB5386.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01371B902F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(396003)(136003)(39850400004)(366004)(376002)(189003)(199004)(53754006)(8936002)(31696002)(81156014)(81166006)(36756003)(8676002)(2906002)(6506007)(186003)(386003)(229853002)(1411001)(6306002)(99286004)(66446008)(64756008)(86362001)(6916009)(66946007)(26005)(66556008)(6436002)(66476007)(102836004)(476003)(53936002)(316002)(14444005)(478600001)(31686004)(2616005)(6116002)(966005)(6512007)(446003)(3846002)(11346002)(54906003)(76176011)(4326008)(14454004)(71200400001)(52116002)(66066001)(305945005)(25786009)(71190400001)(486006)(6486002)(7736002)(6246003)(256004)(5660300002)(21314003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5386;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6S9BiPKCEF9wpjcHsY++UMhg621i7+cD0rPN5WUeetE+kSLqvtFv+LmRj8my+m/5jqQLSgeNUlzTYZKKBKGZEzIxDN94h3vctKVQ1SSwOzRMLTATbYUsRnuEilGMGfx8I9kdfjajG/n6PZzfkf30NCcGu5vNrXDkvb643gOED0O+lvpLvJruBva12MAwSXtPJHqoovdhlMbFz6MSZKF8Mw6GekCcvP6inWvGxxQJv+YIQ5oe0o/lHhxqLBN08oq/1OK4CizMJUYTDb/tVEmhiVuNCysH0QCLT++PoDlJQ7g55yLtEAxEhm8akVaL4xdzn1PevJTlL6UzvX4oln8WC2gEPD8xx8QV6tyhUME4HNrGWwypG9d9DurCVLVixB8ArbKD+hB52Wzy4B43xrAZpF5eD87K4qFnFmAj0XJuMg4=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <7A62F3C887E8E445899A685F248B2DAA@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1b55d28-8dcf-4391-d443-08d7272a82ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2019 17:59:43.6465 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c3+UtSFnSPO30JwZNiy8fTMYX5ke81IOTpsBELgwBMC4zA630hmwlupDMpB3axp90SrnRiE7rmFo/zbkOxq3NjcKtuO4cy/Y1qqxqFrtkpA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5386
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.129
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

22.08.2019 20:39, Vladimir Sementsov-Ogievskiy wrote:
> 22.08.2019 20:24, Vladimir Sementsov-Ogievskiy wrote:
>> 22.08.2019 18:50, Stefan Hajnoczi wrote:
>>> On Tue, Jun 04, 2019 at 07:15:02PM +0300, Vladimir Sementsov-Ogievskiy =
wrote:
>>>> Hi all!
>>>>
>>>> Here is new parameter qiov_offset for io path, to avoid
>>>> a lot of places with same pattern of creating local_qiov or hd_qiov
>>>> variables.
>>>>
>>>> These series also includes my
>>>> "[Qemu-devel] [PATCH 0/2] block/io: refactor padding"
>>>> with some changes [described in 01 and 03 emails]
>>>>
>>>> Vladimir Sementsov-Ogievskiy (12):
>>>> =A0=A0 util/iov: introduce qemu_iovec_init_extended
>>>> =A0=A0 util/iov: improve qemu_iovec_is_zero
>>>> =A0=A0 block/io: refactor padding
>>>> =A0=A0 block: define .*_part io handlers in BlockDriver
>>>> =A0=A0 block/io: bdrv_co_do_copy_on_readv: use and support qiov_offset
>>>> =A0=A0 block/io: bdrv_co_do_copy_on_readv: lazy allocation
>>>> =A0=A0 block/io: bdrv_aligned_preadv: use and support qiov_offset
>>>> =A0=A0 block/io: bdrv_aligned_pwritev: use and support qiov_offset
>>>> =A0=A0 block/io: introduce bdrv_co_p{read,write}v_part
>>>> =A0=A0 block/qcow2: refactor qcow2_co_preadv to use buffer-based io
>>>> =A0=A0 block/qcow2: implement .bdrv_co_preadv_part
>>>> =A0=A0 block/qcow2: implement .bdrv_co_pwritev(_compressed)_part
>>>>
>>>> =A0 block/qcow2.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 1 +
>>>> =A0 include/block/block_int.h |=A0 21 ++
>>>> =A0 include/qemu/iov.h=A0=A0=A0=A0=A0=A0=A0 |=A0 10 +-
>>>> =A0 block/backup.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 2 +-
>>>> =A0 block/io.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 532 ++++=
++++++++++++++++++----------------
>>>> =A0 block/qcow2-cluster.c=A0=A0=A0=A0 |=A0 14 +-
>>>> =A0 block/qcow2.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 131 +++++-----
>>>> =A0 qemu-img.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 4 =
+-
>>>> =A0 util/iov.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 153 ++++=
+++++--
>>>> =A0 9 files changed, 559 insertions(+), 309 deletions(-)
>>>
>>> qemu-iotests 077 fails after I apply this series (including your
>>> uninitialized variable fix).=A0 I'm afraid I can't include it in the bl=
ock
>>> pull request, sorry!
>>>
>>> Stefan
>>>
>>
>> Hmm, 77 don't work on master for me:
>> 077=A0=A0=A0=A0=A0 fail=A0=A0=A0=A0=A0=A0 [20:23:57] [20:23:59]=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 output mismatch (see 077.o=
ut.bad)
>> --- /work/src/qemu/up-block-drop-hd-qiov/tests/qemu-iotests/077.out=A0=
=A0=A0=A0 2019-04-22 15:06:56.162045432 +0300
>> +++ /work/src/qemu/up-block-drop-hd-qiov/tests/qemu-iotests/077.out.bad =
2019-08-22 20:23:59.124122307 +0300
>> @@ -1,7 +1,15 @@
>> =A0=A0QA output created by 077
>> +=3D=3D117186=3D=3DWARNING: ASan doesn't fully support makecontext/swapc=
ontext functions and may produce false positives in some cases!
>> +=3D=3D117186=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_=
return: stack top: 0x7ffefc071000; bottom 0x7fad7277b000; size: 0x0051898f6=
000 (350200225792)
>> +False positive error reports may follow
>> +For details see http://code.google.com/p/address-sanitizer/issues/detai=
l?id=3D189
>> =A0=A0Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728
>>
>> =A0=A0=3D=3D Some concurrent requests involving RMW =3D=3D
>> +=3D=3D117197=3D=3DWARNING: ASan doesn't fully support makecontext/swapc=
ontext functions and may produce false positives in some cases!
>> +=3D=3D117197=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_=
return: stack top: 0x7fffa4fcc000; bottom 0x7fa93a2c1000; size: 0x00566ad0b=
000 (371159248896)
>> +False positive error reports may follow
>> +For details see http://code.google.com/p/address-sanitizer/issues/detai=
l?id=3D189
>> =A0=A0wrote XXX/XXX bytes at offset XXX
>> =A0=A0XXX bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> =A0=A0wrote XXX/XXX bytes at offset XXX
>> @@ -66,6 +74,10 @@
>> =A0=A0XXX bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>
>> =A0=A0=3D=3D Verify image content =3D=3D
>> +=3D=3D117219=3D=3DWARNING: ASan doesn't fully support makecontext/swapc=
ontext functions and may produce false positives in some cases!
>> +=3D=3D117219=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_=
return: stack top: 0x7ffc722de000; bottom 0x7f0848232000; size: 0x00f42a0ac=
000 (1048677367808)
>> +False positive error reports may follow
>> +For details see http://code.google.com/p/address-sanitizer/issues/detai=
l?id=3D189
>> =A0=A0read 512/512 bytes at offset 0
>> =A0=A0512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> =A0=A0read 512/512 bytes at offset 512
>> @@ -156,5 +168,9 @@
>> =A0=A01 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> =A0=A0read 2048/2048 bytes at offset 71680
>> =A0=A02 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> +=3D=3D117229=3D=3DWARNING: ASan doesn't fully support makecontext/swapc=
ontext functions and may produce false positives in some cases!
>> +=3D=3D117229=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_=
return: stack top: 0x7fffa3342000; bottom 0x7fd85a275000; size: 0x0027490cd=
000 (168729300992)
>> +False positive error reports may follow
>> +For details see http://code.google.com/p/address-sanitizer/issues/detai=
l?id=3D189
>> =A0=A0No errors were found on the image.
>> =A0=A0*** done
>> Failures: 077
>> Failed 1 of 1 tests
>>
>>
>>
>=20
> But after "block/io: refactor padding" it hangs instead of this fail.. Th=
is is not good
>=20
>=20

Aha seems it's because 77 has "break pwritev_rmw_after_tail" which may not =
fire if we have merge_reads =3D true.

So, for me the following fix for 03 helps (77 fails, but not hangs, so same=
 behavior as on master):

diff --git a/block/io.c b/block/io.c
index 6448f1c503..04e69400d8 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1493,13 +1493,23 @@ static int bdrv_padding_rmw_read(BdrvChild *child,

          qemu_iovec_init_buf(&local_qiov, pad->buf, bytes);

-        bdrv_debug_event(bs, BLKDBG_PWRITEV_RMW_HEAD);
+        if (pad->head) {
+            bdrv_debug_event(bs, BLKDBG_PWRITEV_RMW_HEAD);
+        }
+        if (pad->merge_reads && pad->tail) {
+            bdrv_debug_event(bs, BLKDBG_PWRITEV_RMW_TAIL);
+        }
          ret =3D bdrv_aligned_preadv(child, req, req->overlap_offset, byte=
s,
                                    align, &local_qiov, 0);
          if (ret < 0) {
              return ret;
          }
-        bdrv_debug_event(bs, BLKDBG_PWRITEV_RMW_AFTER_HEAD);
+        if (pad->head) {
+            bdrv_debug_event(bs, BLKDBG_PWRITEV_RMW_AFTER_HEAD);
+        }
+        if (pad->merge_reads && pad->tail) {
+            bdrv_debug_event(bs, BLKDBG_PWRITEV_RMW_AFTER_TAIL);
+        }


Does it work for you?

--=20
Best regards,
Vladimir

