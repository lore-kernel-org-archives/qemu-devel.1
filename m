Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2E6C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 19:22:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2ADE20838
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 19:22:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2ADE20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6JoK-0004F4-3c
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 15:22:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43582)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1i6Jjq-0008RQ-IR
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 15:17:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1i6Jjp-0006TG-4f
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 15:17:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54256)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1i6Jjk-0006Rp-Jn; Fri, 06 Sep 2019 15:17:36 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8A912307D923;
 Fri,  6 Sep 2019 19:17:35 +0000 (UTC)
Received: from [10.3.116.234] (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8124A5D9CA;
 Fri,  6 Sep 2019 19:17:34 +0000 (UTC)
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
References: <20190906173201.7926-1-mlevitsk@redhat.com>
 <20190906173201.7926-3-mlevitsk@redhat.com>
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
Message-ID: <3ac8c65d-4bca-372c-d863-1f794292f5cb@redhat.com>
Date: Fri, 6 Sep 2019 14:17:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190906173201.7926-3-mlevitsk@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="0iqS0fRPWpYyCGWf5fZ6eMQTwoQMS4Apk"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Fri, 06 Sep 2019 19:17:35 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/3] block/qcow2: fix the corruption when
 rebasing luks encrypted files
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, qemu-stable <qemu-stable@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0iqS0fRPWpYyCGWf5fZ6eMQTwoQMS4Apk
Content-Type: multipart/mixed; boundary="T0YQTX68UUMQLbRA5RJx9nFJU4DG36eJB";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, qemu-stable <qemu-stable@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Message-ID: <3ac8c65d-4bca-372c-d863-1f794292f5cb@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] block/qcow2: fix the corruption when
 rebasing luks encrypted files
References: <20190906173201.7926-1-mlevitsk@redhat.com>
 <20190906173201.7926-3-mlevitsk@redhat.com>
In-Reply-To: <20190906173201.7926-3-mlevitsk@redhat.com>

--T0YQTX68UUMQLbRA5RJx9nFJU4DG36eJB
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/6/19 12:32 PM, Maxim Levitsky wrote:
> This fixes subltle corruption introduced by luks threaded encryption

subtle

> in commit 8ac0f15f335
>=20
> Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=3D1745922
>=20
> The corruption happens when we do
>    * write to two or more unallocated clusters at once
>    * write doesn't fully cover nether first nor last cluster

s/nether/neither/

or even:

write doesn't fully cover either the first or the last cluster

>=20
> In this case, when allocating the new clusters we COW both area

areas

> prior to the write and after the write, and we encrypt them.
>=20
> The above mentioned commit accidently made it so, we encrypt the

accidentally

s/made it so, we encrypt/changed the encryption of/

> second COW are using the physical cluster offset of the first area.

s/are using/to use/

>=20
> Fix this by:
>  * remove the offset_in_cluster parameter of do_perform_cow_encrypt
>    since it is misleading. That offset can be larger that cluster size.=

>    instead just add the start and end COW are offsets to both host and =
guest offsets
>    that do_perform_cow_encrypt receives.
>=20
> *  in do_perform_cow_encrypt, remove the cluster offset from the host_o=
ffset
>    And thus pass correctly to the qcow2_co_encrypt, the host cluster of=
fset and full guest offset
>=20
>=20
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  block/qcow2-cluster.c | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)
>=20

> +++ b/block/qcow2-cluster.c
> @@ -463,20 +463,20 @@ static int coroutine_fn do_perform_cow_read(Block=
DriverState *bs,
>  }
> =20
>  static bool coroutine_fn do_perform_cow_encrypt(BlockDriverState *bs,
> -                                                uint64_t guest_cluster=
_offset,
> -                                                uint64_t host_cluster_=
offset,
> -                                                unsigned offset_in_clu=
ster,
> +                                                uint64_t guest_offset,=

> +                                                uint64_t host_offset,
>                                                  uint8_t *buffer,
>                                                  unsigned bytes)
>  {
>      if (bytes && bs->encrypted) {
>          BDRVQcow2State *s =3D bs->opaque;
> -        assert((offset_in_cluster & ~BDRV_SECTOR_MASK) =3D=3D 0);
> +        assert((guest_offset & ~BDRV_SECTOR_MASK) =3D=3D 0);
> +        assert((host_offset & ~BDRV_SECTOR_MASK) =3D=3D 0);
>          assert((bytes & ~BDRV_SECTOR_MASK) =3D=3D 0);

Pre-existing, but we could use QEMU_IS_ALIGNED(x, BDRV_SECTOR_SIZE) for
slightly more legibility than open-coding the bit operation.

Neat trick about power-of-2 alignment checks:

assert(QEMU_IS_ALIGNED(offset_in_cluster | guest_offset |
                       host_offset | bytes, BDRV_SECTOR_SIZE));

gives the same result in one assertion.  (I've used it elsewhere in the
code base, but I'm not opposed to one assert per variable if you think
batching is too dense.)

I'll let Dan review the actual code change, but offhand it makes sense
to me.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--T0YQTX68UUMQLbRA5RJx9nFJU4DG36eJB--

--0iqS0fRPWpYyCGWf5fZ6eMQTwoQMS4Apk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1ysM0ACgkQp6FrSiUn
Q2qYOAgAoCB4JnljInewA6mCc68LXGQ299Xh/CUlakGLFT5FgoJuku1AXHReqzoR
Pvi3ehh3cVsJh5+cg5Jfg+Vy5EvJVNetUPZnu3SnRZnMNntd0ifykYC+IlJffr94
GF8I33khr1T0RIYAfDfXYRuck37VLeIsT0T/Kczn7CarF75bQV4KLC8qKRthyYci
9PEhNIdykvHikFHhmwmuEZ+09ZwdzKLgkxvWake6mWujEUZHK9eAascArsNZv4KV
y06MhtvcYN5mND5trX5QyB6yO8d3VbRy4BBwxjuo8b0I1cFGskfIelIw8LBK3Spy
AMrKutfcweKV69o5Dff5iVZCzseoyQ==
=zRb4
-----END PGP SIGNATURE-----

--0iqS0fRPWpYyCGWf5fZ6eMQTwoQMS4Apk--

