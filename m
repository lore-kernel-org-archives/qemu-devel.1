Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF37CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 10:49:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8A2320679
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 10:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="vv8VkcjK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8A2320679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNagK-0005Yb-8o
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 06:49:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57070)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iNadI-0002hv-Df
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:46:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iNadH-0007AY-5B
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:46:20 -0400
Received: from mail-he1eur02on0703.outbound.protection.outlook.com
 ([2a01:111:f400:fe05::703]:9190
 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iNadC-00078D-Rd; Thu, 24 Oct 2019 06:46:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+jrMlkAxZ04Lqtlmy6ZNubomRtjucsdwKr2g5QRuOsjEKnf9JJR1aZCrk2l+XPC2Q0elTP0n0d25xw92e6KHuul+0LebRZDKTV95NoYzHXF5p+U7gVL/8+bkHJb4OKdK5eFxDUZ7XCpzumgbO2dZ3pMJgubKlZstZySBhLz/Li5kFP/srGXmExKXs/uJHQN5gw/isSptBH8+ELuRaiTxTgNquTO5USjZmz+qyUn/bwoA+7REqZEPYifVicmjJtECqkYSzj6yH8Fg09zrlp3JE9jId+iZzmWhErRSQccYrUp86vnaXXk2sg5+0F34VByJ3J0XUMvG9tYDK5zhLRJYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pbo5365KXbgSlej2izc6pKjLVNGUv3PjWpPEjpRCC8w=;
 b=e36bNcIUYuON/nXwYOON4s5OrNf9IwoSIditP23Z7I8oXkAfYP9epVDxk+S9kJMMawgU2VN6v0+jSHzCe8uQ5Ka3tVjIliZmr1s9N8lWHyffdxuKE7IAiK66CBzkW1rSThjK/MhGoozROArAImIwNs31B4lwrwhvSnNUDNiRIM0Y0dpejy4IR50TTFyq9gN+tkZegNtvuOlUoJ+/QfsYPEKhaS/2NjjCRk9gOVcsYFY3qF+cezslajIk8188zuKZ9U9jCDgboXEDcX6HiIqRvW5wbz43Tax6ZtfMxqDtVSA+PdZFjJm9IvXqFdmuAD4mU4X09uDqeq6rE1vpeaiXLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pbo5365KXbgSlej2izc6pKjLVNGUv3PjWpPEjpRCC8w=;
 b=vv8VkcjKbS9p55tFeJRkvJi0YnsxCfLT/zGzxNonPnZ417O6VBypSmw/u8RtzXIzmnZ+g+PVc7UBVpnGXqoB4zBme4yJVA6DvQOBK/RrEamNeBiRRqxCVvO7Fli2hJP0slG+Bj+MZPstJx1nEZWQaalFVE9vLXKfhduu+o8tSos=
Received: from AM0PR08MB4435.eurprd08.prod.outlook.com (20.179.35.83) by
 AM0PR08MB4161.eurprd08.prod.outlook.com (20.178.203.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.24; Thu, 24 Oct 2019 10:46:11 +0000
Received: from AM0PR08MB4435.eurprd08.prod.outlook.com
 ([fe80::4461:dd32:b358:110c]) by AM0PR08MB4435.eurprd08.prod.outlook.com
 ([fe80::4461:dd32:b358:110c%7]) with mapi id 15.20.2367.027; Thu, 24 Oct 2019
 10:46:11 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH 3/3] qcow2: Fix corruption bug in
 qcow2_detect_metadata_preallocation()
Thread-Topic: [PATCH 3/3] qcow2: Fix corruption bug in
 qcow2_detect_metadata_preallocation()
Thread-Index: AQHVibZRVvKZmtdwLUmUBJHEqcF3fadpnRCA
Date: Thu, 24 Oct 2019 10:46:11 +0000
Message-ID: <3cfee2ed-cebb-44ef-82ce-77a77c1a9e6a@virtuozzo.com>
References: <20191023152620.13166-1-kwolf@redhat.com>
 <20191023152620.13166-4-kwolf@redhat.com>
In-Reply-To: <20191023152620.13166-4-kwolf@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR02CA0097.eurprd02.prod.outlook.com
 (2603:10a6:7:29::26) To AM0PR08MB4435.eurprd08.prod.outlook.com
 (2603:10a6:208:144::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191024134609162
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 28c91069-5967-4170-e8b0-08d7586f6276
x-ms-traffictypediagnostic: AM0PR08MB4161:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB41618DAF7C8E47A5F7FC8D8EC16A0@AM0PR08MB4161.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 0200DDA8BE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(39840400004)(346002)(136003)(396003)(376002)(189003)(199004)(11346002)(305945005)(54906003)(446003)(64756008)(14454004)(86362001)(476003)(81156014)(8676002)(8936002)(478600001)(186003)(31696002)(66556008)(486006)(66476007)(66946007)(66446008)(2501003)(66066001)(31686004)(386003)(25786009)(2616005)(102836004)(5660300002)(14444005)(256004)(6506007)(26005)(52116002)(71190400001)(99286004)(2906002)(7736002)(110136005)(4326008)(6116002)(6246003)(3846002)(6486002)(81166006)(6436002)(229853002)(36756003)(6512007)(71200400001)(316002)(76176011);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4161;
 H:AM0PR08MB4435.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kqnlVQGNLsrA+dFZkZvOCThMX4Pqn7gO/ukvjKJj59HXZErgBNdl7jdBMvtKqF2GSA2vdgI7CTLHxLYbOVYodIuOjGJlQLdtvjAZiMiPLAbBB8C1R38KIZ1aaarpG7uKHp/b7p8XJjPX++gAaLwTjix7/PCNed5iXdCRnYhorVniccKZwdmYfk9SXaOTG69XZ1SYwPOuvaXN5Nl9HmPLlbwMpeX/qqcmJK93Lj5Vi//o984O3qoRYGRIZWozuDLxvDt61/PSZ9SW2dl0jKZQJQuCqm/OtOebKgaKcWT9PBPN45A0tqL6MenqL4yaivRsKRpsEtlg5luS89IhWhRrs4239zdUqfAi6ppMYfJKZLqZ/Hv164p+YAvvpnci24cYFgcrPVpO3OIBaOaNByGd9o066UTMyTCcR9Z5+CLpniTvPC3/iXYA8k00E4rnIL2M
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <74C5A4897E03AB4B81344148B673ABD1@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28c91069-5967-4170-e8b0-08d7586f6276
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2019 10:46:11.4507 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vwGVBcgcD8LbSnzv+/GnRGdZGxY/hf9RTsQLKdO2wzIKr1mszxnUKWiKD8fMmBq8LZq8RF1b/qXR42OBZHlZ3sriwwb9mGR+qSLomVotLdg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4161
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe05::703
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
Cc: "psyhomb@gmail.com" <psyhomb@gmail.com>,
 "michael@weiser.dinsnail.net" <michael@weiser.dinsnail.net>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "lersek@redhat.com" <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

23.10.2019 18:26, Kevin Wolf wrote:
> qcow2_detect_metadata_preallocation() calls qcow2_get_refcount() which
> requires s->lock to be taken to protect its accesses to the refcount
> table and refcount blocks. However, nothing in this code path actually
> took the lock. This could cause the same cache entry to be used by two
> requests at the same time, for different tables at different offsets,
> resulting in image corruption.
>=20
> As it would be preferable to base the detection on consistent data (even
> though it's just heuristics), let's take the lock not only around the
> qcow2_get_refcount() calls, but around the whole function.
>=20
> This patch takes the lock in qcow2_co_block_status() earlier and asserts
> in qcow2_detect_metadata_preallocation() that we hold the lock.
>=20
> Fixes: 69f47505ee66afaa513305de0c1895a224e52c45
> Cc: qemu-stable@nongnu.org
> Reported-by: Michael Weiser <michael@weiser.dinsnail.net>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Oh, I'm very sorry. I was going to backport this patch, and found that it's
fixed in our downstream long ago, even before last upstream version patch s=
ent :(

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

> ---
>   block/qcow2-refcount.c | 2 ++
>   block/qcow2.c          | 3 ++-
>   2 files changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
> index ef965d7895..0d64bf5a5e 100644
> --- a/block/qcow2-refcount.c
> +++ b/block/qcow2-refcount.c
> @@ -3455,6 +3455,8 @@ int qcow2_detect_metadata_preallocation(BlockDriver=
State *bs)
>       int64_t i, end_cluster, cluster_count =3D 0, threshold;
>       int64_t file_length, real_allocation, real_clusters;
>  =20
> +    qemu_co_mutex_assert_locked(&s->lock);
> +
>       file_length =3D bdrv_getlength(bs->file->bs);
>       if (file_length < 0) {
>           return file_length;
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 8b05933565..0bc69e6996 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -1916,6 +1916,8 @@ static int coroutine_fn qcow2_co_block_status(Block=
DriverState *bs,
>       unsigned int bytes;
>       int status =3D 0;
>  =20
> +    qemu_co_mutex_lock(&s->lock);
> +
>       if (!s->metadata_preallocation_checked) {
>           ret =3D qcow2_detect_metadata_preallocation(bs);
>           s->metadata_preallocation =3D (ret =3D=3D 1);
> @@ -1923,7 +1925,6 @@ static int coroutine_fn qcow2_co_block_status(Block=
DriverState *bs,
>       }
>  =20
>       bytes =3D MIN(INT_MAX, count);
> -    qemu_co_mutex_lock(&s->lock);
>       ret =3D qcow2_get_cluster_offset(bs, offset, &bytes, &cluster_offse=
t);
>       qemu_co_mutex_unlock(&s->lock);
>       if (ret < 0) {
>=20


--=20
Best regards,
Vladimir

