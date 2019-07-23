Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43107C76188
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 05:19:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1165D2238E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 05:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="PaH4imCw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1165D2238E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpnD7-0002LY-Qe
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 01:19:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39679)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hpnCd-0000s2-Dl
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 01:19:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hpnCc-0003md-8k
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 01:19:07 -0400
Received: from ozlabs.org ([203.11.71.1]:45271)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hpnCb-0003gF-3y; Tue, 23 Jul 2019 01:19:06 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45t6G803H0z9s4Y; Tue, 23 Jul 2019 15:18:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1563859136;
 bh=1GTfoq2Oz2gqu5zFMFVZlz46m1QTfYuJE8w+fyDYVo4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PaH4imCwK9QuuHCyJpRIllLYaay34GHBUNhgkCcj5v2zrAJ7cj34JgJ6eT9EBmkc6
 OqpJIWhcFL6cgKD0eHUH+lOWuY1eEOcyRXSnAso7Ocr0kt+sGNWbkpOZp4wOv/kgVP
 AKK/ITqYGxW312BnLnSBRcne1mn9znm+TEzpRDp8=
Date: Tue, 23 Jul 2019 12:27:40 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: David Hildenbrand <david@redhat.com>
Message-ID: <20190723022740.GK25073@umbus.fritz.box>
References: <20190722134108.22151-1-david@redhat.com>
 <20190722134108.22151-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="kswDJesP0akhmDn8"
Content-Disposition: inline
In-Reply-To: <20190722134108.22151-2-david@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH-for-4.1 v3 1/6] virtio-balloon: Fix wrong
 sign extension of PFNs
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


--kswDJesP0akhmDn8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2019 at 03:41:03PM +0200, David Hildenbrand wrote:
> If we directly cast from int to uint64_t, we will first sign-extend to
> an int64_t, which is wrong. We actually want to treat the PFNs like
> unsigned values.
>=20
> As far as I can see, this dates back to the initial virtio-balloon
> commit, but wasn't triggered as fairly big guests would be required.
>=20
> Cc: qemu-stable@nongnu.org
> Reported-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/virtio/virtio-balloon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index e85d1c0d5c..515abf6553 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -343,8 +343,8 @@ static void virtio_balloon_handle_output(VirtIODevice=
 *vdev, VirtQueue *vq)
>          }
> =20
>          while (iov_to_buf(elem->out_sg, elem->out_num, offset, &pfn, 4) =
=3D=3D 4) {
> +            unsigned int p =3D virtio_ldl_p(vdev, &pfn);
>              hwaddr pa;
> -            int p =3D virtio_ldl_p(vdev, &pfn);
> =20
>              pa =3D (hwaddr) p << VIRTIO_BALLOON_PFN_SHIFT;
>              offset +=3D 4;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--kswDJesP0akhmDn8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl02cJsACgkQbDjKyiDZ
s5IbyhAAjLgtLSQIQByIPApKQegvhBkuC2ZVJCCQGVsC4sntRSfKwuxXjV6feecX
uHymLrloPQldSLCWe/K9byiWouLbo2YzBny26RZl6X+he8CM89MpkyluNGC7nzoQ
2ItE4nbXF6DSy88h0zryEcULDmvCX9NdLrFojaGr5s7uHkvoiVSeJZv+F76x71wg
g94mzOKXcezvxzIVPS8nzIMO1LBnGfMwcqLdN+aoJHzrovANbQX1h/8+ES9E0Fl+
uzEYHnz0XdscBk5csmv+kh+A2GSq1fZ+mSrzs7e31627xyrFALeloelOnrJpkWvo
q3pnyAt7r/Y/8AQOHzbq6a1fCj7I0+3U/oy5cGcV/zOabztnsDX5hwAxCLlKdKGg
+Xw0hWh9dvi546+rEEVlVu5/UrpsSgyPpPtHP8NvnZAu3AnYbuaN1MeVDezmmPwe
AmgUZ4sDldKdbQKHGOfLuZbp+gaq/aXCahebpsfcJ3z42HrquhP9b2kBmwGFsm9p
wxfmiKi0EaSRamqpeSoTz00H8M5IY4WefO0X1M1zU4i7MlLRSIbSOKSfqJY1OFRg
G5LOkTNDCHDe+C9XqpnAKMFPoB3Ek/tQhD7kRMTvZctP4s3HQg01hFEoIWUitSHa
9AnWpZ39ThmxSubDUyCWGR4EJoRz4izq5RY5qtR1Hp9yMQm2sls=
=APJ1
-----END PGP SIGNATURE-----

--kswDJesP0akhmDn8--

