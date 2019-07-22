Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC2AC76191
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 03:05:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E086021951
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 03:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="GjfwN4FP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E086021951
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpOdf-0001Eg-GP
	for qemu-devel@archiver.kernel.org; Sun, 21 Jul 2019 23:05:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32925)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hpOdJ-0000Jt-50
 for qemu-devel@nongnu.org; Sun, 21 Jul 2019 23:05:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hpOdH-0004ir-Sl
 for qemu-devel@nongnu.org; Sun, 21 Jul 2019 23:05:01 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:40487 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1hpOdG-0004Y6-RU
 for qemu-devel@nongnu.org; Sun, 21 Jul 2019 23:04:59 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45sRKr34hYz9sBZ; Mon, 22 Jul 2019 13:04:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1563764688;
 bh=oCF9R2ImntRrDkERz+fy7zZdZDParXbdqtbTL5wOmqM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GjfwN4FPhv4BfYB5fcg/rXtKtC1MmhLAymlTxNzWa9r1u/Rial/7xrHEWCohWpQU/
 H/TRsHVQxkhosP1qSmM8p7AgXmJnmtNpBjGivcXMx+rKt+m/DXS5BesOp4ezEWlaMF
 gBXSK988z0IdtBt7X95Yt+cjcP+civ9DYrI8k8NQ=
Date: Mon, 22 Jul 2019 12:27:39 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: David Hildenbrand <david@redhat.com>
Message-ID: <20190722022739.GA1426@umbus.fritz.box>
References: <20190719160120.26581-1-david@redhat.com>
 <20190719160120.26581-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
In-Reply-To: <20190719160120.26581-2-david@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH v1 1/3] virtio-balloon: simplify deflate
 with pbp
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


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2019 at 06:01:18PM +0200, David Hildenbrand wrote:
> Let's simplify this - the case we are optimizing for is very hard to
> trigger and not worth the effort. If we're switching from inflation to
> deflation, let's reset the pbp.
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/virtio/virtio-balloon.c | 24 ++++--------------------
>  1 file changed, 4 insertions(+), 20 deletions(-)
>=20
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index 9de3c030bf..287d5d4c97 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -121,7 +121,7 @@ static void balloon_deflate_page(VirtIOBalloon *ballo=
on,
>      void *addr =3D memory_region_get_ram_ptr(mr) + offset;
>      RAMBlock *rb;
>      size_t rb_page_size;
> -    ram_addr_t ram_offset, host_page_base;
> +    ram_addr_t ram_offset;
>      void *host_addr;
>      int ret;
> =20
> @@ -129,26 +129,10 @@ static void balloon_deflate_page(VirtIOBalloon *bal=
loon,
>       * host address? */
>      rb =3D qemu_ram_block_from_host(addr, false, &ram_offset);
>      rb_page_size =3D qemu_ram_pagesize(rb);
> -    host_page_base =3D ram_offset & ~(rb_page_size - 1);
> -
> -    if (balloon->pbp
> -        && rb =3D=3D balloon->pbp->rb
> -        && host_page_base =3D=3D balloon->pbp->base) {
> -        int subpages =3D rb_page_size / BALLOON_PAGE_SIZE;
> =20
> -        /*
> -         * This means the guest has asked to discard some of the 4kiB
> -         * subpages of a host page, but then changed its mind and
> -         * asked to keep them after all.  It's exceedingly unlikely
> -         * for a guest to do this in practice, but handle it anyway,
> -         * since getting it wrong could mean discarding memory the
> -         * guest is still using. */
> -        clear_bit((ram_offset - balloon->pbp->base) / BALLOON_PAGE_SIZE,
> -                  balloon->pbp->bitmap);
> -
> -        if (bitmap_empty(balloon->pbp->bitmap, subpages)) {
> -            virtio_balloon_reset_pbp(balloon);
> -        }
> +    if (balloon->pbp) {
> +        /* Let's play safe and always reset the pbp on deflation request=
s. */
> +        virtio_balloon_reset_pbp(balloon);
>      }
> =20
>      host_addr =3D (void *)((uintptr_t)addr & ~(rb_page_size - 1));

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl01HxsACgkQbDjKyiDZ
s5KEmBAAo1Mv3TUKy5NVizXbTrmFU8zk6drWrakLfP2Or225U9Eu7gypRzBLd1X3
DlGAORFuGxMMoP4PMDBUSigE2owyGAPqfJcnAbDG2qKfkOjMBNSyHpQYYoHdvFH1
7asS3TIlkfswkNCSyWKaEdBHWyq8lXF20ycP/iyA7QB0xF16za5khsaTEirmJZDg
c/S81Byc3jz2MRnpPrkOmchxFAS3p0CChnKwUJ4pAgi8av+7/clQyrJRXTeVTlxq
8nA15EKhNgMD4l/ECLUjwJTt/EdyptpOxZPe539USChugbYxF1hjIV2HHd3Ui6tO
3tth0/ZcVBB2PgkeO/V0s5/h0bI3dFwj7GID7/GyS7A6ttNPQs/qqOxKeM2YrxYN
RJiEr1oPCOJUDPDkNtB03cogmMSPLIrGmvIXMf5d6guav12BjPbXnK+RM+9rYdgh
2uQHefGlz+sSUFfoHGH/zljtFaGor0Y+BaL5Dk/ebIMXBlsndGz53sbLQCSqt+4j
RzrLcFO3nfMmkrnpAWolMsrn3jbG/9GYyLjeEdqrkXTeGb+A8mmlZ+WBIFqU3Fc3
pB5kPOCdyQIUByXqpsCj8r6qiv/HzO4EvlVt5d7aHtjMYT/OUcAY6uOL4d8kyM4F
R4IkqxDB5YMuoh+hI0WLQV9H/vCJ4CCpJc5fKHRH3h0TQlc6gQ4=
=69KI
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--

