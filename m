Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F33C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 10:26:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B47FF20678
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 10:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="jxiPBHI8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B47FF20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itqjx-0005tI-SL
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 05:26:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35438)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1itqiz-00057o-Cz
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 05:25:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1itqiu-0005x1-Qk
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 05:25:32 -0500
Received: from mail-eopbgr60136.outbound.protection.outlook.com
 ([40.107.6.136]:42670 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1itqiu-0005w9-4C; Tue, 21 Jan 2020 05:25:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HbtTGR8Sy/t93Qruk3gq2ReKHUWy8GezbGKH7pfQsW4KiOrzyhFI3MeUdMTmCtR+rCa2TIGkjVP5unBfgg0vAb3grWkU2+84hZlBJ+rbWJcF/DdjsQK/UMe1UnSKEyROBG8NE8hn4wzPLYirLAA3HnZ5BDkSqaUaPtP1ck068mVqyMmu1N58GCpF39Q00bCZdMfwG0q9JGxVqlv08tOykN65jVaDJlVrubseTSslIw+Y3vmUxL1SqNWfcSWVHDdiHmS/dCZLPGqu3EamLOLzQXhmfrZgA8Xzdxr2JulIaP1NvJ4VUEjnTmPryNeU8HQX/5E54FkOOCWxlDhMHbpEMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T8yRO3ef2I4OsH42F05XK00/XwbERbVNayfVXxnYuKc=;
 b=j0+lYMf8A3K0mCWr2WjEAocFLX0xqGoEo1pXamywAew1hPE40zih+stgt19We+zqvZGcxuvnqjTrfjiwhkW0Npg3IlqjK9F28C/nN9T4+ySQi5Uu/6KV7cm8aqQKn8Pr/yr6BA6gwZVccP9hLJ1Nm03eFf6iqxBBUQYwMaHTpKO1ti90FR8gDaMOUanf0BCSVU4M7ooK6Piqz4YtSAlnyVW0cbZ/InUAGLHfs5ZgNbc8HIhmk7uFIUJskVqu4PaLfELhRuwUw4dWxZgWURvweV2se0VWrmFopwu7YsYK37fUXvU4+VsHiCu4eysiyhIJuXypClyOJiqQXxVY+mOAzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T8yRO3ef2I4OsH42F05XK00/XwbERbVNayfVXxnYuKc=;
 b=jxiPBHI8f1+qWvLT+q4IBVlh1Jjg1Aq1pNC7VuMBU+uWzkuDtuQknvIm6iRa4qCu/m+O5Ai2WF5gpIjJIqfWRrGUbH5L8pXylh3u4M9EggnEhdxuFiodtypTvY4WB8m0XMNft/sqi1DGjCf0fjn7Jbmgsb/CgCoEb/a5d07SUp4=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4023.eurprd08.prod.outlook.com (20.179.1.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Tue, 21 Jan 2020 10:25:24 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2644.027; Tue, 21 Jan 2020
 10:25:24 +0000
Received: from [172.16.24.200] (185.231.240.5) by
 AM4PR0101CA0053.eurprd01.prod.exchangelabs.com (2603:10a6:200:41::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19 via Frontend
 Transport; Tue, 21 Jan 2020 10:25:24 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v3 08/10] nbd/server: introduce NBDExtentArray
Thread-Topic: [PATCH v3 08/10] nbd/server: introduce NBDExtentArray
Thread-Index: AQHVtlOipndDBZmKU0mcvPPQYvauh6f0MX+AgADsB4A=
Date: Tue, 21 Jan 2020 10:25:24 +0000
Message-ID: <b09cc9d8-dfc9-28fa-cf17-e4a03d5a42ab@virtuozzo.com>
References: <20191219100348.24827-1-vsementsov@virtuozzo.com>
 <20191219100348.24827-9-vsementsov@virtuozzo.com>
 <1f55c9d0-9d53-89d4-18a2-02703aada893@redhat.com>
In-Reply-To: <1f55c9d0-9d53-89d4-18a2-02703aada893@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM4PR0101CA0053.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::21) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20200121132523085
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e4ad6874-615b-424d-b432-08d79e5c3a23
x-ms-traffictypediagnostic: AM6PR08MB4023:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB4023EA76775ECC2424F29D51C10D0@AM6PR08MB4023.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1247;
x-forefront-prvs: 0289B6431E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(376002)(346002)(366004)(136003)(39850400004)(199004)(189003)(66946007)(71200400001)(4326008)(5660300002)(31686004)(81156014)(16576012)(54906003)(110136005)(956004)(2616005)(316002)(52116002)(53546011)(8936002)(107886003)(8676002)(2906002)(26005)(81166006)(31696002)(508600001)(66476007)(66556008)(6486002)(36756003)(64756008)(86362001)(186003)(16526019)(66446008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4023;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o4YT2X1Iay7FTEQ+dCaMSamt4khVOzr5aElKVpGGRM8mHRtI/Hf90acAqVIEDmCEOvVpzNSF0ILubMcBjGxrXPDPvRfKiaMDTe+KsNGndD/1lDUKTpZ8JNJFlU9DGnNHeokeXspXUjcvR+wEI3+0/YiqxFrW8v3yK05NQ/vFrQYfCJE9R0pJ+ZldQ7pgaPt4H08rXtV12kbtDajvK8ROwB32BeXSwO3Rx0Mi20iFrhWanT0RPC89mbJSrQtV12vt0dsJSJzzoigxh7lS/JhPp+5ukFDsE1f3w82cdf+mOx8fEaX/lgO/SrCoKE9weDUGRyBDWkGJm+ZgT/k2DnvDlc0Iyz+MsaMeK/QkWhippQST1pTp36mUgZTT9sDRz4dCwmzXR6pWup13LsqjjuC23nZSJwdD1fgp4SyWrmrijxDPFTQzWE8i7NwkqKoVignw
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <70C8BA2042277A4FAAC0B5DFCDBEE60D@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4ad6874-615b-424d-b432-08d79e5c3a23
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2020 10:25:24.7142 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aPv7UOHEg5PYuSee/ctGWPXogxFgqfI47RoffjgFOkKHKVyKevk22C2m2KNLfavCxEhDvC/iRUvCTLI0aCxJtRcWvjImaQe0DMXr6/yXuag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4023
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.136
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
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

20.01.2020 23:20, Eric Blake wrote:
> On 12/19/19 4:03 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Introduce NBDExtentArray class, to handle extents list creation in more
>> controlled way and with less OUT parameters in functions.
>=20
> s/less/fewer/
>=20
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>> =A0 nbd/server.c | 201 ++++++++++++++++++++++++++++---------------------=
--
>> =A0 1 file changed, 109 insertions(+), 92 deletions(-)
>>
>> diff --git a/nbd/server.c b/nbd/server.c
>> index a4b348eb32..cc722adc31 100644
>> --- a/nbd/server.c
>> +++ b/nbd/server.c
>> @@ -1909,27 +1909,89 @@ static int coroutine_fn nbd_co_send_sparse_read(=
NBDClient *client,
>> =A0=A0=A0=A0=A0 return ret;
>> =A0 }
>> +typedef struct NBDExtentArray {
>> +=A0=A0=A0 NBDExtent *extents;
>> +=A0=A0=A0 unsigned int nb_alloc;
>> +=A0=A0=A0 unsigned int count;
>> +=A0=A0=A0 uint64_t total_length;
>> +=A0=A0=A0 bool converted; /* extents are converted to BE, no more chang=
es allowed */
>> +} NBDExtentArray;
>> +
>=20
> Looks good.
>=20
>> +static NBDExtentArray *nbd_extent_array_new(unsigned int nb_alloc)
>> +{
>> +=A0=A0=A0 NBDExtentArray *ea =3D g_new0(NBDExtentArray, 1);
>> +
>> +=A0=A0=A0 ea->nb_alloc =3D nb_alloc;
>> +=A0=A0=A0 ea->extents =3D g_new(NBDExtent, nb_alloc);
>=20
> I guess g_new() is okay rather tahn g_new0, as long as we are careful not=
 to read that uninitialized memory.
>=20
>> +
>> +=A0=A0=A0 return ea;
>> +}
>> +
>> +static void nbd_extent_array_free(NBDExtentArray *ea)
>> +{
>> +=A0=A0=A0 g_free(ea->extents);
>> +=A0=A0=A0 g_free(ea);
>> +}
>> +G_DEFINE_AUTOPTR_CLEANUP_FUNC(NBDExtentArray, nbd_extent_array_free);
>> +
>> +/* Further modifications of the array after conversion are abandoned */
>> +static void nbd_extent_array_convert_to_be(NBDExtentArray *ea)
>> +{
>> +=A0=A0=A0 int i;
>> +
>> +=A0=A0=A0 if (ea->converted) {
>> +=A0=A0=A0=A0=A0=A0=A0 return;
>> +=A0=A0=A0 }
>=20
> Would this be better as assert(!ea->converted), to ensure we aren't buggy=
 in our usage? ...

No, as array may be already automatically converted by nbd_extent_array_add=
, or may be not.

But your question stress that my design is weird. Now I think it's better t=
o add separate
boolean ea field for nbd_extent_array_add() safety, instead of reusing .con=
verted.

>=20
>> +=A0=A0=A0 ea->converted =3D true;
>> +
>> +=A0=A0=A0 for (i =3D 0; i < ea->count; i++) {
>> +=A0=A0=A0=A0=A0=A0=A0 ea->extents[i].flags =3D cpu_to_be32(ea->extents[=
i].flags);
>> +=A0=A0=A0=A0=A0=A0=A0 ea->extents[i].length =3D cpu_to_be32(ea->extents=
[i].length);
>> +=A0=A0=A0 }
>> +}
>> +
>> =A0 /*
>> - * Populate @extents from block status. Update @bytes to be the actual
>> - * length encoded (which may be smaller than the original), and update
>> - * @nb_extents to the number of extents used.
>> - *
>> - * Returns zero on success and -errno on bdrv_block_status_above failur=
e.
>> + * Add extent to NBDExtentArray. If extent can't be added (no available=
 space),
>> + * return -1.
>> + * For safety, when returning -1 for the first time, the array is conve=
rted
>> + * to BE and further modifications are abandoned.
>> =A0=A0 */
>> -static int blockstatus_to_extents(BlockDriverState *bs, uint64_t offset=
,
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 uint64_t *bytes, NBDExtent *extents,
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 unsigned int *nb_extents)
>> +static int nbd_extent_array_add(NBDExtentArray *ea,
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 uint32_t length, uint32_t flags)
>> =A0 {
>> -=A0=A0=A0 uint64_t remaining_bytes =3D *bytes;
>> -=A0=A0=A0 NBDExtent *extent =3D extents, *extents_end =3D extents + *nb=
_extents;
>> -=A0=A0=A0 bool first_extent =3D true;
>> +=A0=A0=A0 assert(!ea->converted);
>=20
> ...especially since you assert here.
>=20
>> +
>> +=A0=A0=A0 if (!length) {
>> +=A0=A0=A0=A0=A0=A0=A0 return 0;
>> +=A0=A0=A0 }
>> +
>> +=A0=A0=A0 /* Extend previous extent if flags are the same */
>> +=A0=A0=A0 if (ea->count > 0 && flags =3D=3D ea->extents[ea->count - 1].=
flags) {
>> +=A0=A0=A0=A0=A0=A0=A0 ea->extents[ea->count - 1].length +=3D length;
>> +=A0=A0=A0=A0=A0=A0=A0 ea->total_length +=3D length;
>> +=A0=A0=A0=A0=A0=A0=A0 return 0;
>> +=A0=A0=A0 }
>=20
> The NBD spec states that NBD_CMD_BLOCK_STATUS with flag NBD_CMD_FLAG_REQ_=
ONE must not exceed the original length of the client's request, but that w=
hen the flag is not present, the final extent may indeed go beyond the clie=
nt's request.=A0 I see two potential problems here:
>=20
> 1) I don't see any check that extending .length does not exceed the clien=
t's request if NBD_CMD_FLAG_REQ_ONE was set (we can sort of tell if that is=
 the case based on whether nb_alloc is 1 or greater than 1, but not directl=
y here, and it seems like this is a better place to do a common check than =
to make each caller repeat it).

we have two callers. blockstatus_to_extents can't exceed the requested rang=
e, and bitmaps_to_extents has own check. If we want to move the check into =
nbd_extent_array_add, we need to enhance its interface to allow it to add o=
nly "part" of extent.. And how to handle it?
Mark the array "closed" after first partly applied extent, but return succe=
ss? Then we'll have to change assertion at start of _add s/assert(ea->can_a=
dd)/if (!ea->can_add) {return -1}/..  Or return count of really applied byt=
es to the caller?

I doubt that this is a good idea, it seems simpler to keep nbd extent array=
 not knowing about length limitation, keeping in mind that the following pa=
tch will drop any exceeding of the requested range.

>=20
> 2) I don't see any check that extending .length does not exceed 32 bits. =
=A0If the client requested status of 3.5G, but the caller divides that into=
 two extent additions of 3G each and with the same flags, we could end up o=
verflowing the 32-bit reply field (not necessarily fatal except when the ov=
erflow is exactly at 4G, because as long as the server is making progress, =
the client will eventually get all data; it is only when the overflow wraps=
 to exactly 0 that we quit making progress). 32-bit overflow is one case wh=
ere the server HAS to return back-to-back extents with the same flags (if i=
t is going to return information on that many bytes, rather than truncating=
 its reply to just the first extent < 4G).

good catch. I'll write it like

      /* Extend previous extent if flags are the same */
      if (ea->count > 0 && flags =3D=3D ea->extents[ea->count - 1].flags) {
          uint64_t sum =3D (uint64_t)length + ea->extents[ea->count - 1].le=
ngth;

          if (sum <=3D UINT32_MAX) {
              ea->extents[ea->count - 1].length =3D sum;
              ea->total_length +=3D length;
              return 0;
          }
      }

>=20
>> +
>> +=A0=A0=A0 if (ea->count >=3D ea->nb_alloc) {
>> +=A0=A0=A0=A0=A0=A0=A0 nbd_extent_array_convert_to_be(ea);
>> +=A0=A0=A0=A0=A0=A0=A0 return -1;
>> +=A0=A0=A0 }
>> +
>> +=A0=A0=A0 ea->total_length +=3D length;
>> +=A0=A0=A0 ea->extents[ea->count] =3D (NBDExtent) {.length =3D length, .=
flags =3D flags};
>> +=A0=A0=A0 ea->count++;
>> -=A0=A0=A0 assert(*nb_extents);
>> -=A0=A0=A0 while (remaining_bytes) {
>> +=A0=A0=A0 return 0;
>> +}
>> +
>> +static int blockstatus_to_extents(BlockDriverState *bs, uint64_t offset=
,
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 uint64_t bytes, NBDExtentArray *ea)
>> +{
>> +=A0=A0=A0 while (bytes) {
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 uint32_t flags;
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 int64_t num;
>> -=A0=A0=A0=A0=A0=A0=A0 int ret =3D bdrv_block_status_above(bs, NULL, off=
set, remaining_bytes,
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &num, NULL, NULL);
>> +=A0=A0=A0=A0=A0=A0=A0 int ret =3D bdrv_block_status_above(bs, NULL, off=
set, bytes, &num,
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 NULL, NULL);
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret < 0) {
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
>> @@ -1938,60 +2000,37 @@ static int blockstatus_to_extents(BlockDriverSta=
te *bs, uint64_t offset,
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 flags =3D (ret & BDRV_BLOCK_ALLOCATED ? 0 : =
NBD_STATE_HOLE) |
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (ret & BDRV_BLOCK_ZE=
RO=A0=A0=A0=A0=A0 ? NBD_STATE_ZERO : 0);
>> -=A0=A0=A0=A0=A0=A0=A0 if (first_extent) {
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 extent->flags =3D flags;
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 extent->length =3D num;
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 first_extent =3D false;
>> -=A0=A0=A0=A0=A0=A0=A0 } else if (flags =3D=3D extent->flags) {
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* extend current extent */
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 extent->length +=3D num;
>> -=A0=A0=A0=A0=A0=A0=A0 } else {
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (extent + 1 =3D=3D extents_end) {
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>> -
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* start new extent */
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 extent++;
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 extent->flags =3D flags;
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 extent->length =3D num;
>> +=A0=A0=A0=A0=A0=A0=A0 if (nbd_extent_array_add(ea, num, flags) < 0) {
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 0;
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>> -=A0=A0=A0=A0=A0=A0=A0 offset +=3D num;
>> -=A0=A0=A0=A0=A0=A0=A0 remaining_bytes -=3D num;
>> -=A0=A0=A0 }
>=20
> However, I _do_ like the refactoring on making the rest of the code easie=
r to read.
>=20
>> -
>> -=A0=A0=A0 extents_end =3D extent + 1;
>> -=A0=A0=A0 for (extent =3D extents; extent < extents_end; extent++) {
>> -=A0=A0=A0=A0=A0=A0=A0 extent->flags =3D cpu_to_be32(extent->flags);
>> -=A0=A0=A0=A0=A0=A0=A0 extent->length =3D cpu_to_be32(extent->length);
>> +=A0=A0=A0=A0=A0=A0=A0 offset +=3D num;
>> +=A0=A0=A0=A0=A0=A0=A0 bytes -=3D num;
>> =A0=A0=A0=A0=A0 }
>> -=A0=A0=A0 *bytes -=3D remaining_bytes;
>> -=A0=A0=A0 *nb_extents =3D extents_end - extents;
>> -
>> =A0=A0=A0=A0=A0 return 0;
>> =A0 }
>=20
> I think this needs v4 to fix the boundary cases, but I like where it is h=
eaded.
>=20


--=20
Best regards,
Vladimir

