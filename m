Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDBCC76188
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 05:20:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDA782238E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 05:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="HKNh3lk2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDA782238E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpnDg-00056p-5L
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 01:20:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39683)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hpnCd-0000s3-Mv
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 01:19:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hpnCc-0003mh-8a
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 01:19:07 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:53983 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hpnCb-0003gO-Dv; Tue, 23 Jul 2019 01:19:06 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45t6G80qYSz9sDB; Tue, 23 Jul 2019 15:18:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1563859136;
 bh=kAm+4MYG6VWkj52D/DjrfIg4F5Dv271zrXHZGQuPVc4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HKNh3lk2k5AaYXGe2G237ayDScOzeJLy5EzttgmArCf3+qXSozuTMsEYn5QV4reyg
 3Lqec/QcAL66iyOfFDobLqdM2ItDfnhHmJH96WTN1kUsAAslTEzvyU54FX7Uj/KcLH
 KBMxnGxNpveGL0wpUtql0M55yvR8PYxose9wsZE0=
Date: Tue, 23 Jul 2019 12:54:22 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: David Hildenbrand <david@redhat.com>
Message-ID: <20190723025422.GL25073@umbus.fritz.box>
References: <20190722134108.22151-1-david@redhat.com>
 <20190722134108.22151-6-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="RNGrj7vazCqBHNw7"
Content-Disposition: inline
In-Reply-To: <20190722134108.22151-6-david@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH-for-4.1 v3 5/6] virtio-balloon: Rework pbp
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


--RNGrj7vazCqBHNw7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2019 at 03:41:07PM +0200, David Hildenbrand wrote:
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

I think the test on subpages is pointless here.  You've (reasonably)
rejected handling the edge case of a ramblock being removed and
replugged - but the only thing this handles is an edge case of that
edge case.


Otherwise, LGTM.

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

--RNGrj7vazCqBHNw7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl02dtwACgkQbDjKyiDZ
s5JF/xAAv+p74PbggYVJkvSrZDVJZwkmEWHfHnhRYXa8eETlgU8BubLNWg3NsMuR
5JZn7NL9sBckmpFLmBWnH02z7Q+rTSoyE0R6QFfKBk5S7k+I1WBflEpaKAm4iz4c
npz8bbafCOHvdqFYLYTGHTWnJH/ogNvkb6ZxWuGz0ySqnw9oWtfxHnTlpQOOluQU
bbSzuNw2iOVuPM8VnLpIE4Px7h2bSEVqakpX6TWWEoTuNizU5nrxIu0aI9NfQbLR
fZoZ3Cy3zdRP6M2rZ7FUgHHixtvNg8ThSSqD5cxtbBDNJXxWurT9vAhu2+lexwcP
L+TkMR2Y7YEv5owhC6qoqyc757k3H+h4aISfXdvMNWMVtT2fbXirv/V6lObFGuxb
kzZmwbaGxCitM9md32tFnYC72Pw+03r2KUwkgb0k1T1fF5xX3KOaDXM5phxkJEIC
IkPBT4yanMycLuC+o/CzGT9snqlqGJ9bUFS4HTvDlzGqyh0bS2dmZDG5qYi+iFo/
ZQTBzkxMz+DoB+PP8zG4jLFS8+WMjrgjruaRVrHgyQ2IqoZFV+3PYtpqHfjFeMpU
Lq7VADI+Sy6Bc24y+5c2K+AkfzHMaPgzJerYb9RStUibD6j+d3ShjSb7jCXN3Ed2
GGHsVsxvsWJXPOi4GgF7fPDBxyIce3EFuNKcV3S0lCnGtm4dHmU=
=kv/N
-----END PGP SIGNATURE-----

--RNGrj7vazCqBHNw7--

