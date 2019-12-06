Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143E8C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:25:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D684521835
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="erhySrxQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D684521835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idFTk-0001rm-Hg
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 10:25:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33252)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1idEcG-00080r-BU
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:29:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1idEcE-0003k0-Jh
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:29:55 -0500
Received: from mail-eopbgr00132.outbound.protection.outlook.com
 ([40.107.0.132]:15169 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1idEcD-0003cT-SD; Fri, 06 Dec 2019 09:29:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPYzUJfO/smKKdT4n5APBJ5Ds8QbDr+jypydhag7EvwAIBNS+wS1EL2wrb1Q0vOF9ytm7yNF/6qQAO7tyIyq2UlRSNwJQVjAdFxOROuJbLF7+K2KVYTMrBGxT6Jj76kp+HeY3RtxqHVNyDf3kzyXZsDS2bwOCZldPJU7Bffe9wnfIQdQk3W8kF2IKwKCaVNtyb4OtGi0iXIYDsg6TeKs90Q+OMYngXbrHcWjBgmYahIebwZOH2e1KJTIKQ+5eZ/BpX7l4vvJ32fc8If3cRCf9nmIkW3VGKjpeK7DQmCkyeGtzm+89C74925hM5Nn3hkF1+jQVALY820WwPVQyCOO9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7kHM9dm1jeZCwspMwI6tARcUm2Ftnr+PkrUCncFOSg=;
 b=h4tsxgCl58gq/t2ONyl1o3urc7uprtJX28AYAMVhBaEry42LErilwwAqpBr8Td5hUYlRot5vXP5+eZiuxY8uO2rM3zmiisIr3w3VnXMrabGzZYle2EERwdWMny77l7lCVU0zp7++kwtGY8O+kaxTEPbt+Xn5Xv3wGqu/sKaRX9+Wj0Ny9hZj+Gpj5ZHUvB27jWFobZlOza5XF1sKsOIlMcLEDkBNfsGShH+ZF/Mxx3+dzTlzPGeW22lLHVREIkrqjAkEC4DyX9oJnfM2DsniEEkL8w2lt5CECoEUGD4jINZxZemarPRJfwjQkXAIc6seJ7Hv2d3VRL6OyzdkL0rWHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7kHM9dm1jeZCwspMwI6tARcUm2Ftnr+PkrUCncFOSg=;
 b=erhySrxQIbeGTd1orTBFGIe/yiU0359C54gXXRCLxzg4H8l9Z6Fw2eBsjjgb+/AJIwDTMMQEaJOUm1+/2l3/o904BnHlPH6nbTGV/H7vxhDkcgQTawykpMvR04kDck0/eJgWj43UxvQCugvbYg4HDI2E16Uy4C3sNaB+w2xM++g=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3703.eurprd08.prod.outlook.com (20.178.88.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Fri, 6 Dec 2019 14:29:51 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2516.014; Fri, 6 Dec 2019
 14:29:51 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH for-4.2?] block/qcow2-bitmap: fix crash bug in
 qcow2_co_remove_persistent_dirty_bitmap
Thread-Topic: [PATCH for-4.2?] block/qcow2-bitmap: fix crash bug in
 qcow2_co_remove_persistent_dirty_bitmap
Thread-Index: AQHVq6KIduIxknDAaEC7Mfgo+tVtwKer+IsAgAEzaoA=
Date: Fri, 6 Dec 2019 14:29:50 +0000
Message-ID: <ec3c0262-2c21-3973-702a-35f3a097e8c2@virtuozzo.com>
References: <20191205193049.30666-1-vsementsov@virtuozzo.com>
 <22af83d1-91e2-ab71-2dc4-349b5b24d1d8@redhat.com>
In-Reply-To: <22af83d1-91e2-ab71-2dc4-349b5b24d1d8@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0306.eurprd05.prod.outlook.com
 (2603:10a6:7:93::37) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191206172949126
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cb0dabb8-294c-44e6-26a3-08d77a58c0e7
x-ms-traffictypediagnostic: AM6PR08MB3703:
x-microsoft-antispam-prvs: <AM6PR08MB3703A0C2FFE924CCDBFED09BC15F0@AM6PR08MB3703.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-forefront-prvs: 0243E5FD68
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(376002)(346002)(396003)(136003)(366004)(189003)(199004)(51444003)(53754006)(4326008)(6506007)(478600001)(86362001)(102836004)(6512007)(2616005)(26005)(53546011)(99286004)(186003)(31686004)(66476007)(52116002)(66446008)(316002)(66556008)(76176011)(229853002)(64756008)(66946007)(6486002)(110136005)(81156014)(71190400001)(2906002)(5660300002)(54906003)(36756003)(305945005)(8936002)(81166006)(31696002)(8676002)(71200400001)(14143004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3703;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zKorY0x3NoQh2GrVGoBj71Q7xwRaSLqpxee28ZScVB7l2My9BwXDUmUr3hwMwAuQVnxvkNPv+w6bA1IlLjqBpfcwMJnDx4MctIC6aPtt3TehHDKs1RVcebNb0pKDtwHeLHzf0sOKPvYEKEXbrsOwJf3TnjoA/B04J+xigMO+GlPdc3c6uvDOxR/yB6rIuB/+QzB26V0Sqogc76W4pNvtaCB/Fd1yTePXSCsnh1BrSwHn0BqV9KUhDfHogFJSSfK7PlDB6SLyhdJ9aSxvDh2N3xp+A5vUPLyF51Xocc1oim8SAdCymL6bYzdF6qcicFuDds7h8UY1nq3q4h7A7AX9xZf2tpvRmJeREGlIvIwWLbGOV+XRIayaBWnjp1GOKVRLZNwjwhKwOErs7HyzqzSXQgD56tulZxoZka9LuWqhbuq3gk/yYJ1lrJXzuC7oumFNghZrcGSYHhnpJhTz+dDnXlPOoZ9Q9r65ktEL1+3wMgDjlf7yZP7ItXwmJyY2RS9X2hUTpVURgNqXnTEwVSWnaRehtmr5Fa2rAlNPJBW0O44=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <17FE4332EF6D0D4891ACF0A74C78186B@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb0dabb8-294c-44e6-26a3-08d77a58c0e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2019 14:29:50.9648 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OlKf5X2EtECjrD9DbZrSwJR4CxvpwgybQ2sp7aL1CYXnonpQyl8D0MbCFh1T3A89IdHXF/gy1Lqogv0NWoH+cdPMCyIsdbNZqtU1jUtdv58=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3703
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.132
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 "libvirt-list@redhat.com" <libvirt-list@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

05.12.2019 23:09, Eric Blake wrote:
> On 12/5/19 1:30 PM, Vladimir Sementsov-Ogievskiy wrote:
>> Here is double bug:
>>
>> First, return error but not set errp. This may lead to:
>> qmp block-dirty-bitmap-remove may report success when actually failed
>>
>> block-dirty-bitmap-remove used in a transaction will crash, as
>> qmp_transaction will think that it returned success and will cal
>=20
> call
>=20
>> block_dirty_bitmap_remove_commit which will crash, as state->bitmap is
>> NULL
>>
>> Second (like in anecdote), this case is not an error at all. As it is
>> documented in the comment above bdrv_co_remove_persistent_dirty_bitmap
>> definition, absence of bitmap is not an error, and similar case handled
>> at start of qcow2_co_remove_persistent_dirty_bitmap, it returns 0 when
>> there is no bitmaps at all..
>=20
> double .
>=20
>>
>> But when there are some bitmaps, but not the requested one, it return
>> error with errp unset.
>>
>> Fix that.
>>
>> Fixes: b56a1e31759b750
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>
>> Hi all!
>>
>> Ohm, suddenly we faced this bug. It's a regression in 4.2. I'm very
>> sorry for introducing it, and it sad that it's found so late..
>>
>> Personally, I think that this one worth rc5, as it makes new bitmap
>> interfaces unusable. But the decision is yours.
>>
>> Last minute edit: hmm, actually, transaction action introduced in
>> 4.2, so crash is not a regression, only broken block-dirty-bitmap-remove
>> command is a regression... Maybe it's OK for stable.
>=20
> Libvirt REALLY wants to use transaction bitmap management (and require qe=
mu 4.2) for its incremental backup patches that Peter is almost ready to me=
rge in.=A0 I'm trying to ascertain:

Side question:

Is libvirt prepared to inconsistent bitmaps?

For example, migration with enabled dirty-bitmaps capability will fail if t=
here are inconsistent bitmaps.
Also, incremental backup may be affected (you see, that you have your bitma=
p, try to do something with it,
aiming to start next incremental backup, but bitmap is inconsistent, and op=
eration fails)..

In fact, we in Virtuozzo now faced with these broken migration and backup b=
ecause of inconsistent bitmaps
(which were ignored in past), and we have to apply a temporary fix like

--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -986,8 +986,8 @@ bool qcow2_load_dirty_bitmaps(BlockDriverState *bs, Err=
or **errp)
      QSIMPLEQ_FOREACH(bm, bm_list, entry) {
          BdrvDirtyBitmap *bitmap;

-        if ((bm->flags & BME_FLAG_IN_USE) &&
-            bdrv_find_dirty_bitmap(bs, bm->name))
+        if ((bm->flags & BME_FLAG_IN_USE) /* &&
+            bdrv_find_dirty_bitmap(bs, bm->name) */)
          {
              /*
               * We already have corresponding BdrvDirtyBitmap, and bitmap =
in the
@@ -1000,6 +1000,13 @@ bool qcow2_load_dirty_bitmaps(BlockDriverState *bs, =
Error **errp)
               * should not load it on migration target, as we already have=
 this
               * bitmap, being migrated.
               */
+
+            /*
+             * VZ7.12:
+             *
+             * We don't load inconsistent bitmaps at all, as they block
+             * migration. So the second condition is commented out.
+             */
              continue;
          }

And correct way is to handle inconsistent bitmaps in libvirt somehow.


Note, that the source of inconsistent bitmaps are crashes, hard resets, etc=
, when Qemu is unable to store bitmaps correctly.


>=20
> When exactly can this bug hit?=A0 Can you give a sequence of QMP commands=
 that will trigger it for easy reproduction?=A0 Are there workarounds (such=
 as checking that a bitmap exists prior to attempting to remove it)?=A0 If =
it does NOT get fixed in rc5, how will libvirt be able to probe whether the=
 fix is in place?
>=20
>>
>> =A0 block/qcow2-bitmap.c | 9 ++++++---
>> =A0 1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
>> index 8abaf632fc..c6c8ebbe89 100644
>> --- a/block/qcow2-bitmap.c
>> +++ b/block/qcow2-bitmap.c
>> @@ -1469,8 +1469,10 @@ int coroutine_fn qcow2_co_remove_persistent_dirty=
_bitmap(BlockDriverState *bs,
>> =A0=A0=A0=A0=A0 Qcow2BitmapList *bm_list;
>> =A0=A0=A0=A0=A0 if (s->nb_bitmaps =3D=3D 0) {
>> -=A0=A0=A0=A0=A0=A0=A0 /* Absence of the bitmap is not an error: see exp=
lanation above
>> -=A0=A0=A0=A0=A0=A0=A0=A0 * bdrv_remove_persistent_dirty_bitmap() defini=
tion. */
>> +=A0=A0=A0=A0=A0=A0=A0 /*
>> +=A0=A0=A0=A0=A0=A0=A0=A0 * Absence of the bitmap is not an error: see e=
xplanation above
>> +=A0=A0=A0=A0=A0=A0=A0=A0 * bdrv_co_remove_persistent_dirty_bitmap() def=
inition.
>> +=A0=A0=A0=A0=A0=A0=A0=A0 */
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 return 0;
>> =A0=A0=A0=A0=A0 }
>> @@ -1485,7 +1487,8 @@ int coroutine_fn qcow2_co_remove_persistent_dirty_=
bitmap(BlockDriverState *bs,
>> =A0=A0=A0=A0=A0 bm =3D find_bitmap_by_name(bm_list, name);
>> =A0=A0=A0=A0=A0 if (bm =3D=3D NULL) {
>> -=A0=A0=A0=A0=A0=A0=A0 ret =3D -EINVAL;
>> +=A0=A0=A0=A0=A0=A0=A0 /* Absence of the bitmap is not an error, see abo=
ve. */
>> +=A0=A0=A0=A0=A0=A0=A0 ret =3D 0;
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out;
>> =A0=A0=A0=A0=A0 }
>>
>=20


--=20
Best regards,
Vladimir

