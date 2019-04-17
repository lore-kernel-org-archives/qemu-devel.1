Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD1BC282DA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 15:05:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99175205F4
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 15:05:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99175205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55128 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGm86-00027x-O2
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 11:05:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hGm6u-0001Ub-At
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 11:04:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hGm6s-0004kj-2W
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 11:04:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>)
	id 1hGm6i-0004cG-Fm; Wed, 17 Apr 2019 11:04:16 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BAB17306C9F9;
	Wed, 17 Apr 2019 15:04:11 +0000 (UTC)
Received: from [10.3.116.103] (ovpn-116-103.phx2.redhat.com [10.3.116.103])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D35DF19C67;
	Wed, 17 Apr 2019 15:04:06 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20190417100929.39943-1-vsementsov@virtuozzo.com>
	<20190417100929.39943-3-vsementsov@virtuozzo.com>
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
Message-ID: <4552f220-7180-2d19-edf5-465bebe74011@redhat.com>
Date: Wed, 17 Apr 2019 10:04:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190417100929.39943-3-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="b7IjwEYe6rlrgZ9whkczUR3SGKmYgVLAI"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Wed, 17 Apr 2019 15:04:11 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 2/2] iotests: test big qcow2 shrink
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
Message-ID: <20190417150405.Gygz_EIXhqB_IKJiQxGXinVA9ciReRzf_Uxob8k-8io@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--b7IjwEYe6rlrgZ9whkczUR3SGKmYgVLAI
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, fam@euphon.net, den@virtuozzo.com, mreitz@redhat.com,
 stefanha@redhat.com
Message-ID: <4552f220-7180-2d19-edf5-465bebe74011@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] iotests: test big qcow2 shrink
References: <20190417100929.39943-1-vsementsov@virtuozzo.com>
 <20190417100929.39943-3-vsementsov@virtuozzo.com>
In-Reply-To: <20190417100929.39943-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/17/19 5:09 AM, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  tests/qemu-iotests/249     | 69 ++++++++++++++++++++++++++++++++++++++=

>  tests/qemu-iotests/249.out | 30 +++++++++++++++++
>  tests/qemu-iotests/group   |  1 +
>  3 files changed, 100 insertions(+)
>  create mode 100755 tests/qemu-iotests/249
>  create mode 100644 tests/qemu-iotests/249.out

> +
> +# This test checks bug in qcow2_process_discards, fixed by previous co=
mmit.

This sentence makes sense in a commit message, but is a bit stale in the
test itself. Simpler to just state:

This test checks that qcow2_process_discards does not truncate a discard
request > 2G.

> +# The problem was that bdrv_pdiscard was called with uint64_t bytes pa=
rameter
> +# which was cropped to int.

then drop this sentence.

> +# To reproduce bug we need to overflow int by one sequential discard, =
so we
> +# need size > 2G, bigger cluster size (as with default 64k we may have=
 maximum
> +# of 512M sequential data, corresponding to one L1 entry, and we need =
to write

s/entry,/entry),/

> +# at offset 0 at last, to prevent bdrv_co_truncate(bs->file) in
> +# qcow2_co_truncate to stole the whole effect of failed discard.

and we need a second write at offset 0 to prevent
bdrv_co_truncate(bs->file) from short-circuiting the entire discard.

> +
> +size=3D2300M
> +IMGOPTS=3D"cluster_size=3D1M"
> +
> +_make_test_img $size
> +$QEMU_IO -c 'write 100M 2000M' -c 'write 2100M 200M' \
> +    -c 'write 0 100M' "$TEST_IMG" | _filter_qemu_io

This takes a LONG time to produce; and when I tried it on a 32-bit
machine, I got an ENOMEM failure for being unable to allocate a 2000M
buffer. Is there any faster way to produce a similar setup, perhaps by
manually messing with the qcow2 file rather than directly writing that
much consecutive data?  Even if there isn't, you'll want to at least
make the test gracefully skip rather than fail if it hits ENOMEM.

> +Image resized.
> +image: TEST_DIR/t.qcow2
> +file format: qcow2
> +virtual size: 50M (52428800 bytes)
> +disk size: 54M

I confirmed that when patch 1/2 is not present, this reports 2.2G
instead of 54M.

The output here will need tweaking if my patch to rework qemu-img
human-readable sizing lands first (it's currently queued on Kevin's
block-next tree, but needs a rework to fix a few more iotests and to
resolve a 32-bit compilation issue).

> +++ b/tests/qemu-iotests/group
> @@ -248,3 +248,4 @@
>  246 rw auto quick
>  247 rw auto quick
>  248 rw auto quick
> +249 rw auto
>=20

I agree that this isn't quick. I will also point out that at least three
earlier messages have also claimed 249:

Berto: [PATCH for-4.1 v2 2/2] iotests: Check that images are in
read-only mode after block-commit

Max: [PATCH v3 6/7] iotests: Test qemu-img convert --salvage

and yourself :) [PATCH v6 7/7] iotests: test nbd reconnect

so someone gets to rename.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--b7IjwEYe6rlrgZ9whkczUR3SGKmYgVLAI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAly3QGUACgkQp6FrSiUn
Q2ofMQf/TNW2ExLgqJAwqfL3kJun0YPWhLj/aCzwPQF4L4DMtg+tB4FAI1MRC/Dj
aY9fX+1wpVr1YFyzxcz98aXpAFrxrSsWGWWIIYfUzXTCJAT706pPVqKtHvunw6DQ
O7I/9V+eiSZuBr/5M1rWBU0v2QLqAwqcZrEgTxmDz6kO03OcZWkdn78RICrKVtBc
Y1K+Va5k9U/tuAagIF0YAAH+70QIekQPSLJ3+DEvkbxQVqeMFmcF3IH8jhYTsMLl
hZ9D/KuTopLeD5x8ygxVXovxwwF6rSPv2loBSvraHiiRUhX9sATFJoYmnfYGDToE
tyOhOrUA3n3+q8pMmfEwHkcacGcJpg==
=KvL8
-----END PGP SIGNATURE-----

--b7IjwEYe6rlrgZ9whkczUR3SGKmYgVLAI--

