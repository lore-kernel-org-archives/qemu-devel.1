Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290ADC7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 08:31:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E41F3216C8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 08:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="MWv4zNGe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E41F3216C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqvcx-00037s-Ph
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 04:30:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34081)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hqvcT-0002H0-EL
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 04:30:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hqvcQ-0001G8-5e
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 04:30:28 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:47449)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hqvcK-0000vs-IT; Fri, 26 Jul 2019 04:30:22 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45w2MV0CY3z9sML; Fri, 26 Jul 2019 18:30:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1564129814;
 bh=BM2shhbOtIhLYqjd0ti6l6KAOnZyII2HMsg7wGVVoEw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MWv4zNGeiUyn35HUCRGL6hoqkuXZnJumWAcjzNvlU4bvjAFfQ2QVHlcCM0uxmlppY
 Okv4f0r2YxxUUFAsdaAcUAOhZTvPsh0fSjrRT4XShBzmSHlHhEohptkIhlSjwZ5vpD
 Xc7XTOpJ5sr9FwpWrEuOQDmYitqM8eMl5eJ5u3Ys=
Date: Fri, 26 Jul 2019 18:08:57 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: David Hildenbrand <david@redhat.com>
Message-ID: <20190726080857.GA3147@umbus>
References: <20190725113638.4702-1-david@redhat.com>
 <20190725113638.4702-6-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
In-Reply-To: <20190725113638.4702-6-david@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH-for-4.1 v4 5/7] virtio-balloon: Rework pbp
 tracking data
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
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2019 at 01:36:36PM +0200, David Hildenbrand wrote:
> Using the address of a RAMBlock to test for a matching pbp is not really
> safe. Instead, let's use the guest physical address of the base page
> along with the page size (via the number of subpages).
>=20
> Also, let's allocate the bitmap separately. This makes the code
> easier to read and maintain - we can reuse bitmap_new().
>=20
> Prepare the code to move the PBP out of the device.
>=20
> Fixes: ed48c59875b6 ("virtio-balloon: Safely handle BALLOON_PAGE_SIZE <
>                      host page size")
> Fixes: b27b32391404 ("virtio-balloon: Fix possible guest memory corruption
>                      with inflates & deflates")
> Cc: qemu-stable@nongnu.org #v4.0.0
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/virtio/virtio-balloon.c | 69 +++++++++++++++++++++++++-------------
>  1 file changed, 46 insertions(+), 23 deletions(-)
>=20
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index f206cc8bf7..40d493a31a 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -35,16 +35,44 @@
>  #define BALLOON_PAGE_SIZE  (1 << VIRTIO_BALLOON_PFN_SHIFT)
> =20
>  struct PartiallyBalloonedPage {
> -    RAMBlock *rb;
> -    ram_addr_t base;
> -    unsigned long bitmap[];
> +    ram_addr_t base_gpa;
> +    long subpages;
> +    unsigned long *bitmap;
>  };
> =20
> +static void virtio_balloon_pbp_free(PartiallyBalloonedPage *pbp)
> +{
> +    if (!pbp) {
> +        return;
> +    }
> +    g_free(pbp->bitmap);
> +    g_free(pbp);
> +}
> +
> +static PartiallyBalloonedPage *virtio_balloon_pbp_alloc(ram_addr_t base_=
gpa,
> +                                                        long subpages)
> +{
> +    PartiallyBalloonedPage *pbp =3D g_new0(PartiallyBalloonedPage, 1);
> +
> +    pbp->base_gpa =3D base_gpa;
> +    pbp->subpages =3D subpages;
> +    pbp->bitmap =3D bitmap_new(subpages);
> +
> +    return pbp;
> +}
> +
> +static bool virtio_balloon_pbp_matches(PartiallyBalloonedPage *pbp,
> +                                       ram_addr_t base_gpa, long subpage=
s)
> +{
> +    return pbp->subpages =3D=3D subpages && pbp->base_gpa =3D=3D base_gp=
a;
> +}
> +
>  static void balloon_inflate_page(VirtIOBalloon *balloon,
>                                   MemoryRegion *mr, hwaddr mr_offset)
>  {
>      void *addr =3D memory_region_get_ram_ptr(mr) + mr_offset;
> -    ram_addr_t rb_offset, rb_aligned_offset;
> +    ram_addr_t rb_offset, rb_aligned_offset, base_gpa;
> +    PartiallyBalloonedPage **pbp =3D &balloon->pbp;
>      RAMBlock *rb;
>      size_t rb_page_size;
>      int subpages;
> @@ -75,39 +103,34 @@ static void balloon_inflate_page(VirtIOBalloon *ball=
oon,
> =20
>      rb_aligned_offset =3D QEMU_ALIGN_DOWN(rb_offset, rb_page_size);
>      subpages =3D rb_page_size / BALLOON_PAGE_SIZE;
> +    base_gpa =3D memory_region_get_ram_addr(mr) + mr_offset -
> +               (rb_offset - rb_aligned_offset);
> =20
> -    if (balloon->pbp
> -        && (rb !=3D balloon->pbp->rb
> -            || rb_aligned_offset !=3D balloon->pbp->base)) {
> +    if (*pbp && !virtio_balloon_pbp_matches(*pbp, base_gpa, subpages)) {
>          /* We've partially ballooned part of a host page, but now
>           * we're trying to balloon part of a different one.  Too hard,
>           * give up on the old partial page */
> -        g_free(balloon->pbp);
> -        balloon->pbp =3D NULL;
> +        virtio_balloon_pbp_free(*pbp);
> +        *pbp =3D NULL;
>      }
> =20
> -    if (!balloon->pbp) {
> -        /* Starting on a new host page */
> -        size_t bitlen =3D BITS_TO_LONGS(subpages) * sizeof(unsigned long=
);
> -        balloon->pbp =3D g_malloc0(sizeof(PartiallyBalloonedPage) + bitl=
en);
> -        balloon->pbp->rb =3D rb;
> -        balloon->pbp->base =3D rb_aligned_offset;
> +    if (!*pbp) {
> +        *pbp =3D virtio_balloon_pbp_alloc(base_gpa, subpages);
>      }
> =20
> -    set_bit((rb_offset - balloon->pbp->base) / BALLOON_PAGE_SIZE,
> -            balloon->pbp->bitmap);
> +    set_bit((rb_offset - rb_aligned_offset) / BALLOON_PAGE_SIZE,
> +            (*pbp)->bitmap);
> =20
> -    if (bitmap_full(balloon->pbp->bitmap, subpages)) {
> +    if (bitmap_full((*pbp)->bitmap, subpages)) {
>          /* We've accumulated a full host page, we can actually discard
>           * it now */
> =20
> -        ram_block_discard_range(rb, balloon->pbp->base, rb_page_size);
> +        ram_block_discard_range(rb, rb_aligned_offset, rb_page_size);
>          /* We ignore errors from ram_block_discard_range(), because it
>           * has already reported them, and failing to discard a balloon
>           * page is not fatal */
> -
> -        g_free(balloon->pbp);
> -        balloon->pbp =3D NULL;
> +        virtio_balloon_pbp_free(*pbp);
> +        *pbp =3D NULL;
>      }
>  }
> =20
> @@ -128,7 +151,7 @@ static void balloon_deflate_page(VirtIOBalloon *ballo=
on,
> =20
>      if (balloon->pbp) {
>          /* Let's play safe and always reset the pbp on deflation request=
s. */
> -        g_free(balloon->pbp);
> +        virtio_balloon_pbp_free(balloon->pbp);
>          balloon->pbp =3D NULL;
>      }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl06tRkACgkQbDjKyiDZ
s5JGSxAAu0Y0S6SrMEHlQbpaccb9WpWzzgZ9NqyLBh8iJ5/+QmPKRGvWs/sBwfEM
IXLf3KcCw+X0+YhVnoITiigLLzzWkHEL0vA1wWoqOiFrkdtsN9htqKZuo/6kSya+
lVsLqY5KdLCDSrEo+YjlNUeYMD43fUjc4A/QWseF/b6GhzG1GgcJ1GtjYFW3qpcm
l8YNRB52rUrXnRy14Yh337Roy4YO9xyt3J0SqbtVninW59ZtVJnOzPe2hKE/SLkG
y6d6q05yufCsWGX70WC94et3JhUUcbR8W4MMD3dKOZYMkals7P56rkUeykTOcqHR
1DgkDZHc1OdR8C8ZWiQbowgjN9GFgBQqTt6WvAPjNbmuKy0KlO9yEkFS+QzXfMgU
R8b3XCO+g51pkUjny9b2xWShFBWE1kALJ/Qm+ngyvPzHy3NPzERyLPSj2bpb4V8s
z6gJgbfyCVschS2luZBgt3o2mMHm8lV8d2iG5SfgdaeG6nFdWUbWMw6vCxznTdqr
TiWl3dKlhCvchLl0JBhX5RYxdd/Z67ZKHQJp29+w9VwDRjpnOl6SeCXBuKKKXJak
ZMxz3lx5FZkBHElgHOQTjc/Itrv0KCLcCNTTPcdjPJyL/epjUBFLeCSVJbzqnd2E
3k4ESkbI7pBUYFx7aBwEcEcDPxEUqx98ZwshEeqAi/hre8WH+Hk=
=Ip2S
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--

