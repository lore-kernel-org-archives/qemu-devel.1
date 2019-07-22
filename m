Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3322C76191
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 03:05:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8DDB21951
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 03:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="bOrlzQ1b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8DDB21951
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpOdj-0001V6-Kz
	for qemu-devel@archiver.kernel.org; Sun, 21 Jul 2019 23:05:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32927)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hpOdJ-0000Ju-78
 for qemu-devel@nongnu.org; Sun, 21 Jul 2019 23:05:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hpOdH-0004il-Rl
 for qemu-devel@nongnu.org; Sun, 21 Jul 2019 23:05:01 -0400
Received: from ozlabs.org ([203.11.71.1]:43635)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1hpOdG-0004Y9-Th
 for qemu-devel@nongnu.org; Sun, 21 Jul 2019 23:04:59 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45sRKr41V0z9sBF; Mon, 22 Jul 2019 13:04:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1563764688;
 bh=t4lQNWllKeoNNCuKMSwXKwMItHuq4YuCqBDoaMrvhAY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bOrlzQ1brX4C2nKvIqKHx8Aa7YGXCBPoNvGwkqBXxZuXTlBe5p/d0O6wbHBrMSGEA
 OwJfuCpDS6CpXOkUj9wqXlnXgrO889smIWxdqUFzwNx2XBndqADxr7YhD6vTa8Artm
 4h+s+ufvJ48qfKccDu1fmZbiXFY0u8xcPvVbqeIc=
Date: Mon, 22 Jul 2019 12:29:30 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: David Hildenbrand <david@redhat.com>
Message-ID: <20190722022930.GB1426@umbus.fritz.box>
References: <20190719160120.26581-1-david@redhat.com>
 <20190719160120.26581-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="tjCHc7DPkfUGtrlw"
Content-Disposition: inline
In-Reply-To: <20190719160120.26581-3-david@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH v1 2/3] virtio-balloon: Better names for
 offset variables in inflate/deflate code
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
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--tjCHc7DPkfUGtrlw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2019 at 06:01:19PM +0200, David Hildenbrand wrote:
> "host_page_base" is really confusing, let's make this clearer, also
> rename the other offsets to indicate to which base they apply.
>=20
> offset -> mr_offset
> ram_offset -> rb_offset
> host_page_base -> rb_aligned_offset
>=20
> While at it, use QEMU_ALIGN_DOWN() instead of a handcrafted computation
> and move the computation to the place where it is needed.
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/virtio/virtio-balloon.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>=20
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index 287d5d4c97..29cee344b2 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -47,24 +47,23 @@ static void virtio_balloon_reset_pbp(VirtIOBalloon *b=
alloon)
>  }
> =20
>  static void balloon_inflate_page(VirtIOBalloon *balloon,
> -                                 MemoryRegion *mr, hwaddr offset)
> +                                 MemoryRegion *mr, hwaddr mr_offset)
>  {
> -    void *addr =3D memory_region_get_ram_ptr(mr) + offset;
> +    void *addr =3D memory_region_get_ram_ptr(mr) + mr_offset;
> +    ram_addr_t rb_offset, rb_aligned_offset;
>      RAMBlock *rb;
>      size_t rb_page_size;
>      int subpages;
> -    ram_addr_t ram_offset, host_page_base;
> =20
>      /* XXX is there a better way to get to the RAMBlock than via a
>       * host address? */
> -    rb =3D qemu_ram_block_from_host(addr, false, &ram_offset);
> +    rb =3D qemu_ram_block_from_host(addr, false, &rb_offset);
>      rb_page_size =3D qemu_ram_pagesize(rb);
> -    host_page_base =3D ram_offset & ~(rb_page_size - 1);
> =20
>      if (rb_page_size =3D=3D BALLOON_PAGE_SIZE) {
>          /* Easy case */
> =20
> -        ram_block_discard_range(rb, ram_offset, rb_page_size);
> +        ram_block_discard_range(rb, rb_offset, rb_page_size);
>          /* We ignore errors from ram_block_discard_range(), because it
>           * has already reported them, and failing to discard a balloon
>           * page is not fatal */
> @@ -80,11 +79,12 @@ static void balloon_inflate_page(VirtIOBalloon *ballo=
on,
>      warn_report_once(
>  "Balloon used with backing page size > 4kiB, this may not be reliable");
> =20
> +    rb_aligned_offset =3D QEMU_ALIGN_DOWN(rb_offset, rb_page_size);
>      subpages =3D rb_page_size / BALLOON_PAGE_SIZE;
> =20
>      if (balloon->pbp
>          && (rb !=3D balloon->pbp->rb
> -            || host_page_base !=3D balloon->pbp->base)) {
> +            || rb_aligned_offset !=3D balloon->pbp->base)) {
>          /* We've partially ballooned part of a host page, but now
>           * we're trying to balloon part of a different one.  Too hard,
>           * give up on the old partial page */
> @@ -96,10 +96,10 @@ static void balloon_inflate_page(VirtIOBalloon *ballo=
on,
>          size_t bitlen =3D BITS_TO_LONGS(subpages) * sizeof(unsigned long=
);
>          balloon->pbp =3D g_malloc0(sizeof(PartiallyBalloonedPage) + bitl=
en);
>          balloon->pbp->rb =3D rb;
> -        balloon->pbp->base =3D host_page_base;
> +        balloon->pbp->base =3D rb_aligned_offset;
>      }
> =20
> -    set_bit((ram_offset - balloon->pbp->base) / BALLOON_PAGE_SIZE,
> +    set_bit((rb_offset - balloon->pbp->base) / BALLOON_PAGE_SIZE,
>              balloon->pbp->bitmap);
> =20
>      if (bitmap_full(balloon->pbp->bitmap, subpages)) {
> @@ -116,18 +116,18 @@ static void balloon_inflate_page(VirtIOBalloon *bal=
loon,
>  }
> =20
>  static void balloon_deflate_page(VirtIOBalloon *balloon,
> -                                 MemoryRegion *mr, hwaddr offset)
> +                                 MemoryRegion *mr, hwaddr mr_offset)
>  {
> -    void *addr =3D memory_region_get_ram_ptr(mr) + offset;
> +    void *addr =3D memory_region_get_ram_ptr(mr) + mr_offset;
> +    ram_addr_t rb_offset;
>      RAMBlock *rb;
>      size_t rb_page_size;
> -    ram_addr_t ram_offset;
>      void *host_addr;
>      int ret;
> =20
>      /* XXX is there a better way to get to the RAMBlock than via a
>       * host address? */
> -    rb =3D qemu_ram_block_from_host(addr, false, &ram_offset);
> +    rb =3D qemu_ram_block_from_host(addr, false, &rb_offset);
>      rb_page_size =3D qemu_ram_pagesize(rb);
> =20
>      if (balloon->pbp) {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--tjCHc7DPkfUGtrlw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl01H4oACgkQbDjKyiDZ
s5IV1w//dRDyG3WPVrnI8ujyWItnnFBRjhbFtyTz9sDesy8Idmh3qIag2/e7i16D
QxmirgOgGJFC1YeAhFJL4HeOr6Wr+W4ytQlXv9O8LbrlYGQPx7pgv730ws4q0Phe
IuPOay1gVcMUDmtPKe4/h3f6zM2kCeiy4ZA6Lrsy4aurbx6ZtIG5iWyoPQ3K8hdt
DxDD7KyLA+IkBOZYm9pYalXhZ5Yyb0D3M+dSlUNf56UxLvqvbgWi4eUJ4xLr6TGN
DNhg2vu7npLpOdguXMejEW+G4O1tffmZ60lP2hRjFyuxyi0UcTGshWSEph10zNzq
li63a7zsv7ILljQp8NVNzXm2akcYu7/0m/K9dhCWAeDUVI6qbJjYyrirq+tO5R58
sA5Za7b0CJMO8Ojc6mh+8tcK6djQNKNUJz8Jvnr/pG0KEFMUvwxZVQPtKNf09q/U
3tHl6Z3PaWU5WSy1jdoRFVcSEWcXtoO6Ez2F/u93vpbKyL7Cp+9wdAM/qlH3H2ba
R/WaezKQsnRPqRCL+wFV3RUbDlJN6yGEPdbeM59oGxUez2LYGYMsEQRcDNdUQfKh
fRuJazrORX0/u60ejKsGF8hUi0cNriVhWahOttjo62KBI+/2WuVwNrhXZcQQXOEO
JkqzFaecqsW4gzo3XH3djxFnv0MFZGNxmInS9EiL5PSdtKS8r+8=
=HJBT
-----END PGP SIGNATURE-----

--tjCHc7DPkfUGtrlw--

