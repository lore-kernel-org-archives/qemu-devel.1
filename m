Return-Path: <SRS0=5Zkg=SY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854A7C10F11
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 13:37:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 484E92064A
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 13:37:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 484E92064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37581 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIZ8q-0004Mp-0a
	for qemu-devel@archiver.kernel.org; Mon, 22 Apr 2019 09:37:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hIZ7w-00041H-Vw
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 09:36:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hIZ7v-0005Mu-UZ
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 09:36:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43656)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>)
	id 1hIZ7r-0005Hm-CH; Mon, 22 Apr 2019 09:36:53 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C67033091753;
	Mon, 22 Apr 2019 13:36:46 +0000 (UTC)
Received: from [10.3.116.149] (ovpn-116-149.phx2.redhat.com [10.3.116.149])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8979A5D723;
	Mon, 22 Apr 2019 13:36:38 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20190419140557.102725-1-vsementsov@virtuozzo.com>
	<20190419140557.102725-2-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=eblake@redhat.com; keydata=
	xsBNBEvHyWwBCACw7DwsQIh0kAbUXyqhfiKAKOTVu6OiMGffw2w90Ggrp4bdVKmCaEXlrVLU
	xphBM8mb+wsFkU+pq9YR621WXo9REYVIl0FxKeQo9dyQBZ/XvmUMka4NOmHtFg74nvkpJFCD
	TUNzmqfcjdKhfFV0d7P/ixKQeZr2WP1xMcjmAQY5YvQ2lUoHP43m8TtpB1LkjyYBCodd+LkV
	GmCx2Bop1LSblbvbrOm2bKpZdBPjncRNob73eTpIXEutvEaHH72LzpzksfcKM+M18cyRH+nP
	sAd98xIbVjm3Jm4k4d5oQyE2HwOur+trk2EcxTgdp17QapuWPwMfhaNq3runaX7x34zhABEB
	AAHNHkVyaWMgQmxha2UgPGVibGFrZUByZWRoYXQuY29tPsLAegQTAQgAJAIbAwULCQgHAwUV
	CgkICwUWAgMBAAIeAQIXgAUCS8fL9QIZAQAKCRCnoWtKJSdDahBHCACbl/5FGkUqJ89GAjeX
	RjpAeJtdKhujir0iS4CMSIng7fCiGZ0fNJCpL5RpViSo03Q7l37ss+No+dJI8KtAp6ID+PMz
	wTJe5Egtv/KGUKSDvOLYJ9WIIbftEObekP+GBpWP2+KbpADsc7EsNd70sYxExD3liwVJYqLc
	Rw7so1PEIFp+Ni9A1DrBR5NaJBnno2PHzHPTS9nmZVYm/4I32qkLXOcdX0XElO8VPDoVobG6
	gELf4v/vIImdmxLh/w5WctUpBhWWIfQDvSOW2VZDOihm7pzhQodr3QP/GDLfpK6wI7exeu3P
	pfPtqwa06s1pae3ad13mZGzkBdNKs1HEm8x6zsBNBEvHyWwBCADGkMFzFjmmyqAEn5D+Mt4P
	zPdO8NatsDw8Qit3Rmzu+kUygxyYbz52ZO40WUu7EgQ5kDTOeRPnTOd7awWDQcl1gGBXgrkR
	pAlQ0l0ReO57Q0eglFydLMi5bkwYhfY+TwDPMh3aOP5qBXkm4qIYSsxb8A+i00P72AqFb9Q7
	3weG/flxSPApLYQE5qWGSXjOkXJv42NGS6o6gd4RmD6Ap5e8ACo1lSMPfTpGzXlt4aRkBfvb
	NCfNsQikLZzFYDLbQgKBA33BDeV6vNJ9Cj0SgEGOkYyed4I6AbU0kIy1hHAm1r6+sAnEdIKj
	cHi3xWH/UPrZW5flM8Kqo14OTDkI9EtlABEBAAHCwF8EGAEIAAkFAkvHyWwCGwwACgkQp6Fr
	SiUnQ2q03wgAmRFGDeXzc58NX0NrDijUu0zx3Lns/qZ9VrkSWbNZBFjpWKaeL1fdVeE4TDGm
	I5mRRIsStjQzc2R9b+2VBUhlAqY1nAiBDv0Qnt+9cLiuEICeUwlyl42YdwpmY0ELcy5+u6wz
	mK/jxrYOpzXKDwLq5k4X+hmGuSNWWAN3gHiJqmJZPkhFPUIozZUCeEc76pS/IUN72NfprZmF
	Dp6/QDjDFtfS39bHSWXKVZUbqaMPqlj/z6Ugk027/3GUjHHr8WkeL1ezWepYDY7WSoXwfoAL
	2UXYsMAr/uUncSKlfjvArhsej0S4zbqim2ZY6S8aRWw94J3bSvJR+Nwbs34GPTD4Pg==
Organization: Red Hat, Inc.
Message-ID: <0eaf7740-a524-1ef4-27f7-7a0bf0be3222@redhat.com>
Date: Mon, 22 Apr 2019 08:36:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190419140557.102725-2-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MJaTfULaTlGZFCQw2jQCLiBJdAl5qvxqv"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Mon, 22 Apr 2019 13:36:47 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v3 1/3] block/qcow2-refcount: add
 trace-point to qcow2_process_discards
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, fam@euphon.net, den@virtuozzo.com, stefanha@redhat.com,
	mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190422133637.zT7yxU3yHdHuuq0Ak_dII1sdb346XMn5l2L_Svjv9Yg@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MJaTfULaTlGZFCQw2jQCLiBJdAl5qvxqv
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, fam@euphon.net, stefanha@redhat.com,
 den@virtuozzo.com
Message-ID: <0eaf7740-a524-1ef4-27f7-7a0bf0be3222@redhat.com>
Subject: Re: [PATCH v3 1/3] block/qcow2-refcount: add trace-point to
 qcow2_process_discards
References: <20190419140557.102725-1-vsementsov@virtuozzo.com>
 <20190419140557.102725-2-vsementsov@virtuozzo.com>
In-Reply-To: <20190419140557.102725-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/19/19 9:05 AM, Vladimir Sementsov-Ogievskiy wrote:
> Let's at least trace ignored failure.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/qcow2-refcount.c | 7 ++++++-
>  block/trace-events     | 3 +++
>  2 files changed, 9 insertions(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
> index e0fe322500..60284bcaac 100644
> --- a/block/qcow2-refcount.c
> +++ b/block/qcow2-refcount.c
> @@ -30,6 +30,7 @@
>  #include "qemu/range.h"
>  #include "qemu/bswap.h"
>  #include "qemu/cutils.h"
> +#include "trace.h"
> =20
>  static int64_t alloc_clusters_noref(BlockDriverState *bs, uint64_t siz=
e,
>                                      uint64_t max);
> @@ -738,7 +739,11 @@ void qcow2_process_discards(BlockDriverState *bs, =
int ret)
> =20
>          /* Discard is optional, ignore the return value */
>          if (ret >=3D 0) {
> -            bdrv_pdiscard(bs->file, d->offset, d->bytes);
> +            int r2 =3D bdrv_pdiscard(bs->file, d->offset, d->bytes);
> +            if (r2 < 0) {
> +                trace_qcow2_process_discards_failed_region(d->offset, =
d->bytes,
> +                                                           r2);
> +            }
>          }
> =20
>          g_free(d);
> diff --git a/block/trace-events b/block/trace-events
> index 7335a42540..ea508f637e 100644
> --- a/block/trace-events
> +++ b/block/trace-events
> @@ -91,6 +91,9 @@ qcow2_cache_get_done(void *co, int c, int i) "co %p i=
s_l2_cache %d index %d"
>  qcow2_cache_flush(void *co, int c) "co %p is_l2_cache %d"
>  qcow2_cache_entry_flush(void *co, int c, int i) "co %p is_l2_cache %d =
index %d"
> =20
> +# qcow2-refcount.c
> +qcow2_process_discards_failed_region(uint64_t offset, uint64_t bytes, =
int ret) "offset 0x%" PRIx64 " bytes 0x%" PRIx64 " ret %d"
> +
>  # qed-l2-cache.c
>  qed_alloc_l2_cache_entry(void *l2_cache, void *entry) "l2_cache %p ent=
ry %p"
>  qed_unref_l2_cache_entry(void *entry, int ref) "entry %p ref %d"
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--MJaTfULaTlGZFCQw2jQCLiBJdAl5qvxqv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAly9w2UACgkQp6FrSiUn
Q2q7Iwf/fWLturOvOTdkP+eLJV/SyPQbpiXUfVtBltkOIyZDadNpwCue4RNO838i
OlCsvNjXpZhaMaJjBdVdnleQ+c1n+NVQnUEPfnOyd0+VW8paxaKkmjoXsZ4j1DAe
vTo6vsVmSB9Xiw9ZdzIra/BH1HWsD1C1fb6r8NP/iLzkgZYX9Xs2LJeR8acP+Una
nx/SuvOhyWV8baOiYsPyet88E7xTVu+8YTqXxCwCBPRXdBr/L3Y54usCgwZ5tdzR
jVAGblbPGbtVXH4R7b5btJBsBwm475eZlwtZ32ONwNJPUwB3SI2Qf5atOEfV12xy
+os7K3aKkVspuMVyt10Fi0XmMLk80w==
=FUdT
-----END PGP SIGNATURE-----

--MJaTfULaTlGZFCQw2jQCLiBJdAl5qvxqv--

