Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B790DC76191
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 03:05:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87FE021953
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 03:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="mu2GSOrE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87FE021953
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpOdn-0001os-Ix
	for qemu-devel@archiver.kernel.org; Sun, 21 Jul 2019 23:05:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32930)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hpOdJ-0000Jv-H5
 for qemu-devel@nongnu.org; Sun, 21 Jul 2019 23:05:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hpOdH-0004iz-Tk
 for qemu-devel@nongnu.org; Sun, 21 Jul 2019 23:05:01 -0400
Received: from ozlabs.org ([203.11.71.1]:58129)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1hpOdG-0004YE-TD
 for qemu-devel@nongnu.org; Sun, 21 Jul 2019 23:04:59 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45sRKs0xMWz9sDQ; Mon, 22 Jul 2019 13:04:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1563764689;
 bh=N4HxOWpUDAJts1ov+HCoJ416aJN7+Nnz2trj+4N/gAU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mu2GSOrELplK8iX+iny2hZsYmhJ5M136nUP03Rz9l7mE/leU6ZeOrqBUaH+vWV4x5
 U4CvUjuDEOZ04YJxsnlBLygwegSraQBNzy682k/atx/UPZ7sUoD4Vj4uSnytit+mmw
 X+qNk5g431aZW6vdKjnZTLTiugfXezvI8q6YTyK4=
Date: Mon, 22 Jul 2019 13:04:36 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: David Hildenbrand <david@redhat.com>
Message-ID: <20190722030436.GC1426@umbus.fritz.box>
References: <20190719160120.26581-1-david@redhat.com>
 <20190719160120.26581-4-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="lCAWRPmW1mITcIfM"
Content-Disposition: inline
In-Reply-To: <20190719160120.26581-4-david@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH v1 3/3] virtio-balloon: Rework pbp tracking
 data
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


--lCAWRPmW1mITcIfM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2019 at 06:01:20PM +0200, David Hildenbrand wrote:
> Using the address of a RAMBlock to test for a matching pbp is not really
> safe. Instead, let's use the guest physical address of the base page
> along with the page size (via the number of subpages).
>=20
> While at it, move "struct PartiallyBalloonedPage" to virtio-balloon.h
> now (previously most probably avoided to te the ramblock), renaming it.
>=20
> Also, let's only dynamically allocating the bitmap. This makes the code
> easier to read and maintain - we can reuse bitmap_new().
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>

This mostly looks good, but one thing bothers me..

> ---
>  hw/virtio/virtio-balloon.c         | 52 +++++++++++++++++-------------
>  include/hw/virtio/virtio-balloon.h | 15 +++++++--
>  2 files changed, 42 insertions(+), 25 deletions(-)
>=20
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index 29cee344b2..8e5f9459c2 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -34,23 +34,31 @@
> =20
>  #define BALLOON_PAGE_SIZE  (1 << VIRTIO_BALLOON_PFN_SHIFT)
> =20
> -struct PartiallyBalloonedPage {
> -    RAMBlock *rb;
> -    ram_addr_t base;
> -    unsigned long bitmap[];
> -};
> -
>  static void virtio_balloon_reset_pbp(VirtIOBalloon *balloon)
>  {
> -    g_free(balloon->pbp);
> -    balloon->pbp =3D NULL;
> +    balloon->pbp.base_gpa =3D 0;
> +    balloon->pbp.subpages =3D 0;
> +    g_free(balloon->pbp.bitmap);
> +    balloon->pbp.bitmap =3D NULL;
> +}
> +
> +static bool virtio_balloon_pbp_valid(VirtIOBalloon *balloon)
> +{
> +    return balloon->pbp.bitmap;
> +}
> +
> +static bool virtio_balloon_pbp_matches(VirtIOBalloon *balloon,
> +                                       ram_addr_t base_gpa, long subpage=
s)
> +{
> +    return balloon->pbp.subpages =3D=3D subpages &&
> +           balloon->pbp.base_gpa =3D=3D base_gpa;

=2E. so, I'm trying to think what base_gpa matching, but subpages not
matching means.  I think that can only happen if a pbp is created,
then the ramblock it was in is unplugged, then another ramblock is
plugged in covering the same address and with a different (host) page
size.  Which is unlikely but possible, IIUC.  However, also possible
and marginally less unlikely is to plug a new block of the same page
size, in which case this *will* match, but presumably the pbp should
still be discarded.

>  }
> =20
>  static void balloon_inflate_page(VirtIOBalloon *balloon,
>                                   MemoryRegion *mr, hwaddr mr_offset)
>  {
>      void *addr =3D memory_region_get_ram_ptr(mr) + mr_offset;
> -    ram_addr_t rb_offset, rb_aligned_offset;
> +    ram_addr_t rb_offset, rb_aligned_offset, base_gpa;
>      RAMBlock *rb;
>      size_t rb_page_size;
>      int subpages;
> @@ -81,32 +89,32 @@ static void balloon_inflate_page(VirtIOBalloon *ballo=
on,
> =20
>      rb_aligned_offset =3D QEMU_ALIGN_DOWN(rb_offset, rb_page_size);
>      subpages =3D rb_page_size / BALLOON_PAGE_SIZE;
> +    base_gpa =3D memory_region_get_ram_addr(mr) + mr_offset -
> +               (rb_offset - rb_aligned_offset);
> =20
> -    if (balloon->pbp
> -        && (rb !=3D balloon->pbp->rb
> -            || rb_aligned_offset !=3D balloon->pbp->base)) {
> +    if (virtio_balloon_pbp_valid(balloon) &&
> +        !virtio_balloon_pbp_matches(balloon, base_gpa, subpages)) {
>          /* We've partially ballooned part of a host page, but now
>           * we're trying to balloon part of a different one.  Too hard,
>           * give up on the old partial page */
>          virtio_balloon_reset_pbp(balloon);
>      }
> =20
> -    if (!balloon->pbp) {
> +    if (!virtio_balloon_pbp_valid(balloon)) {
>          /* Starting on a new host page */
> -        size_t bitlen =3D BITS_TO_LONGS(subpages) * sizeof(unsigned long=
);
> -        balloon->pbp =3D g_malloc0(sizeof(PartiallyBalloonedPage) + bitl=
en);
> -        balloon->pbp->rb =3D rb;
> -        balloon->pbp->base =3D rb_aligned_offset;
> +        balloon->pbp.base_gpa =3D base_gpa;
> +        balloon->pbp.subpages =3D subpages;
> +        balloon->pbp.bitmap =3D bitmap_new(subpages);
>      }
> =20
> -    set_bit((rb_offset - balloon->pbp->base) / BALLOON_PAGE_SIZE,
> -            balloon->pbp->bitmap);
> +    set_bit((rb_offset - rb_aligned_offset) / BALLOON_PAGE_SIZE,
> +            balloon->pbp.bitmap);
> =20
> -    if (bitmap_full(balloon->pbp->bitmap, subpages)) {
> +    if (bitmap_full(balloon->pbp.bitmap, subpages)) {
>          /* We've accumulated a full host page, we can actually discard
>           * it now */
> =20
> -        ram_block_discard_range(rb, balloon->pbp->base, rb_page_size);
> +        ram_block_discard_range(rb, rb_aligned_offset, rb_page_size);
>          /* We ignore errors from ram_block_discard_range(), because it
>           * has already reported them, and failing to discard a balloon
>           * page is not fatal */
> @@ -130,7 +138,7 @@ static void balloon_deflate_page(VirtIOBalloon *ballo=
on,
>      rb =3D qemu_ram_block_from_host(addr, false, &rb_offset);
>      rb_page_size =3D qemu_ram_pagesize(rb);
> =20
> -    if (balloon->pbp) {
> +    if (virtio_balloon_pbp_valid(balloon)) {
>          /* Let's play safe and always reset the pbp on deflation request=
s. */
>          virtio_balloon_reset_pbp(balloon);
>      }
> diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virti=
o-balloon.h
> index 5a99293a45..0190d78d71 100644
> --- a/include/hw/virtio/virtio-balloon.h
> +++ b/include/hw/virtio/virtio-balloon.h
> @@ -33,8 +33,6 @@ typedef struct virtio_balloon_stat_modern {
>         uint64_t val;
>  } VirtIOBalloonStatModern;
> =20
> -typedef struct PartiallyBalloonedPage PartiallyBalloonedPage;
> -
>  enum virtio_balloon_free_page_report_status {
>      FREE_PAGE_REPORT_S_STOP =3D 0,
>      FREE_PAGE_REPORT_S_REQUESTED =3D 1,
> @@ -42,6 +40,12 @@ enum virtio_balloon_free_page_report_status {
>      FREE_PAGE_REPORT_S_DONE =3D 3,
>  };
> =20
> +typedef struct VirtIOPartiallyBalloonedPage {
> +    ram_addr_t base_gpa;
> +    long subpages;
> +    unsigned long *bitmap;
> +} VirtIOPartiallyBalloonedPage;
> +
>  typedef struct VirtIOBalloon {
>      VirtIODevice parent_obj;
>      VirtQueue *ivq, *dvq, *svq, *free_page_vq;
> @@ -70,7 +74,12 @@ typedef struct VirtIOBalloon {
>      int64_t stats_last_update;
>      int64_t stats_poll_interval;
>      uint32_t host_features;
> -    PartiallyBalloonedPage *pbp;
> +
> +    /*
> +     * Information about a partially ballooned page - does not have to be
> +     * migrated and has to be reset on every device reset.
> +     */
> +    VirtIOPartiallyBalloonedPage pbp;
> =20
>      bool qemu_4_0_config_size;
>  } VirtIOBalloon;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--lCAWRPmW1mITcIfM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl01J8IACgkQbDjKyiDZ
s5Jt4RAAob8nbn7gCcOE+CUid+TMtRFeThSfX6gdnLz7WsfLcTgZwO7/SL4Lh2yH
it6XI7kE7deVrZimc6/zJHfQ25T/bRSr889tZjSJdD7u9tnpHovSH4uxC8N0fqzD
8dlDKS8THR/ckKmyglWtd4TYadVxMmAJn841nlsXEm6DgtmX+rRhVJiqnAfLZQaU
xORKJq6hV+cObVcF+I02gWss+fuyxK49/+439dlcAz91ws00sN3g17n/iPQJ7lkM
5fGOJv/aE2FapeGOy4DT7lpiO7Iqvfo7f/VbfEW3HnEKFYR1WbT99J+LJCpaVRQZ
q/1JvsuX218C3Ox5jKUTtECcYbxmnyHhxTbjvQ3WVue0ThtBMK/2fdcygwjZ99S2
KP7XUyf3WtZ7+u5+pX1izr6TogBBp8H7iKkskdW/dNzdbOPJspemh5oDDaw6h2L6
5G03Xm0TFo2kTdvsOMormx5p47srZG+vweQb8+z8QpE/wE5qtboQuCV/O0IMLVV7
X7sI+so0hUyKEholA9ystp3N2/xxh8GDvu9shh2anUFpzhFzL7vc9TLLPaDKmU2W
mE/s6Tm948Q6G/csBVl2LL/WIucYSmSLgH5rvlz4MXDnV2HO0cWE+JB+IbwB+/x7
J2eif/bGoL894QEwNWLW7kFch9ytVdGyfIGRMqITHnZ8cmISEog=
=Wy10
-----END PGP SIGNATURE-----

--lCAWRPmW1mITcIfM--

