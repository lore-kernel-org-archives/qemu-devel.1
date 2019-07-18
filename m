Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9EBC76191
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 06:02:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C7C12173E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 06:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="UW3ot8pn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C7C12173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnzUz-0005CK-Eo
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 02:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41713)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hnzSt-0006og-Rm
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 02:00:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hnzSs-0004Du-FA
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 02:00:27 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:40539)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hnzSq-0004CC-RS; Thu, 18 Jul 2019 02:00:26 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45q3Q96GDQz9sNC; Thu, 18 Jul 2019 16:00:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1563429617;
 bh=1X/NmsV4EjPSdjca9icaOm/4RcWjWOcDmnAbmOEMfV4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UW3ot8pnHFbkycl3ZE68pdrDbgL0OnB+/e/klHhGGWvJuEGBxVbJx1f50lvtlROrm
 zwVetDNAIPG5IcLJFfxDz1/jdFjlJL5bvlllgwzXwB2AO0LKPX8frC9F0JoAbN61yj
 Ci4ljqE81AdOeA2Y2z6OAgd4Qu11zqLNDF5uFxUw=
Date: Thu, 18 Jul 2019 13:50:32 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: David Hildenbrand <david@redhat.com>
Message-ID: <20190718035032.GC8468@umbus.fritz.box>
References: <20190717103550.24657-1-david@redhat.com>
 <20190717103550.24657-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="69pVuxX8awAiJ7fD"
Content-Disposition: inline
In-Reply-To: <20190717103550.24657-2-david@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH-for-4.1 v2 1/3] virtio-balloon: fix QEMU
 crashes on pagesize > BALLOON_PAGE_SIZE
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


--69pVuxX8awAiJ7fD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2019 at 12:35:48PM +0200, David Hildenbrand wrote:
> We are using the wrong functions to set/clear bits, effectively touching
> multiple bits, writing out of range of the bitmap, resulting in memory
> corruptions. We have to use set_bit()/clear_bit() instead.
>=20
> Can easily be reproduced by starting a qemu guest on hugetlbfs memory,
> inflating the balloon. QEMU crashes. This never could have worked
> properly - especially, also pages would have been discarded when the
> first sub-page would be inflated (the whole bitmap would be set).
>=20
> While testing I realized, that on hugetlbfs it is pretty much impossible
> to discard a page - the guest just frees the 4k sub-pages in random order
> most of the time. I was only able to discard a hugepage a handful of
> times - so I hope that now works correctly.
>=20
> Fixes: ed48c59875b6 ("virtio-balloon: Safely handle BALLOON_PAGE_SIZE <
>                      host page size")
> Fixes: b27b32391404 ("virtio-balloon: Fix possible guest memory corruption
>                      with inflates & deflates")
> Cc: qemu-stable@nongnu.org #v4.0.0
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Ahem.  You can pass me the brown paper bag now.

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/virtio/virtio-balloon.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index e85d1c0d5c..669067d661 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -94,9 +94,8 @@ static void balloon_inflate_page(VirtIOBalloon *balloon,
>          balloon->pbp->base =3D host_page_base;
>      }
> =20
> -    bitmap_set(balloon->pbp->bitmap,
> -               (ram_offset - balloon->pbp->base) / BALLOON_PAGE_SIZE,
> -               subpages);
> +    set_bit((ram_offset - balloon->pbp->base) / BALLOON_PAGE_SIZE,
> +            balloon->pbp->bitmap);
> =20
>      if (bitmap_full(balloon->pbp->bitmap, subpages)) {
>          /* We've accumulated a full host page, we can actually discard
> @@ -140,9 +139,8 @@ static void balloon_deflate_page(VirtIOBalloon *ballo=
on,
>           * for a guest to do this in practice, but handle it anyway,
>           * since getting it wrong could mean discarding memory the
>           * guest is still using. */
> -        bitmap_clear(balloon->pbp->bitmap,
> -                     (ram_offset - balloon->pbp->base) / BALLOON_PAGE_SI=
ZE,
> -                     subpages);
> +        clear_bit((ram_offset - balloon->pbp->base) / BALLOON_PAGE_SIZE,
> +                  balloon->pbp->bitmap);
> =20
>          if (bitmap_empty(balloon->pbp->bitmap, subpages)) {
>              g_free(balloon->pbp);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--69pVuxX8awAiJ7fD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0v7IYACgkQbDjKyiDZ
s5L5BA/9Has+a2twYqQKy9TdljWuVT9hcMKxiwo7z1Vcpsn1VTROYaGQBzXda6SO
g7wO6pSYv8GVAQBWhDaBqb8q9DeDZ+ot3bsQmr5hdFiJ2ffg8HKntYvw2NYe7ncs
yj9UgC31UtdwySjNTZsfwZinys1+yhDdNBAz+8XW2/hfx4w3+FdPUdpkWp3NrKbp
XsWyogQC3Gg9godhkKzl/ilhJjCqJUyT1BiOEgZfsqWK6lMUT+yIcUUNC6dlCDB/
rv3udphFXqlglF+t237WfOXl7KtXbmeSjZ+IyahcE04pNZmQIihM4BEE5SDfRxwk
CUHSInA/Pzgsp54H5z2JSBvQOow7JvKX/Jk4agF0zFaiAVcWhXI3+lHfzLWUtExC
uPLpUmklemrySDikSpFbsrUvHPUIK5KNkOuCgkTZ7G7rE5cbs7zol1zyWaxCNi1q
6Da/XY6m4D6p9TBCIANtpvPzXnuB5eHZT9u8jwhxjbjv4Ii0E9voKcQHE+9/N1Un
XbVwVXlGHZfsQyeVAy1mwWGpB+IFzqYxz7t93rM0WP2ydVqz9A7TEv4yZ0OJMmXi
Bg8J7I+hGgdspCVf/1yQ0Ob9mn/ZcORbO7swc2L1X4ror75y8/nm2KS89JVbeFLK
/VdGScgcBCLwmZW3p6c4Miv58shkcPq/LQe26ece3OMvZVPLU28=
=EMPo
-----END PGP SIGNATURE-----

--69pVuxX8awAiJ7fD--

