Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E81C76191
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 06:01:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 198002173E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 06:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="PMRsPAZz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 198002173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnzTY-0008HR-B1
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 02:01:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41700)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hnzSt-0006oc-AS
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 02:00:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hnzSr-0004DB-SD
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 02:00:27 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:53819)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hnzSr-0004BM-4Y; Thu, 18 Jul 2019 02:00:25 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45q3QB0hl0z9sDQ; Thu, 18 Jul 2019 16:00:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1563429618;
 bh=OujN5D0Y4qdTDmm+yFd45VAtNtXuGWoNU3UgmNBKaxs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PMRsPAZzyYpS23/yLvMtnH0spKHSgnoNR+rLrsRq3XmPzNRvnlboH1F5UXCLhEoxk
 VgQUbIBmrPl4eG+LCaPzRPVPFAbQX9hUn127QGPSybqTibpy07ZotVIhicMVQYQAYP
 TSSDHM4sYQBRMbefVODockdLyW9F47xKsS+fgLQ4=
Date: Thu, 18 Jul 2019 13:51:32 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: David Hildenbrand <david@redhat.com>
Message-ID: <20190718035132.GD8468@umbus.fritz.box>
References: <20190717103550.24657-1-david@redhat.com>
 <20190717103550.24657-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5gxpn/Q6ypwruk0T"
Content-Disposition: inline
In-Reply-To: <20190717103550.24657-3-david@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH-for-4.1 v2 2/3] virtio-balloon: fix memory
 leak on unrealize()
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


--5gxpn/Q6ypwruk0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2019 at 12:35:49PM +0200, David Hildenbrand wrote:
> We could have tracking data for a pbp (PartiallyBalloonedPage)
> allocated. Let's free it.
>=20
> Fixes: ed48c59875b6 ("virtio-balloon: Safely handle BALLOON_PAGE_SIZE <
>                      host page size")
> Cc: qemu-stable@nongnu.org #v4.0.0
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/virtio/virtio-balloon.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index 669067d661..84d01bceb3 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -40,6 +40,12 @@ struct PartiallyBalloonedPage {
>      unsigned long bitmap[];
>  };
> =20
> +static void virtio_balloon_reset_pbp(VirtIOBalloon *balloon)
> +{
> +    g_free(balloon->pbp);
> +    balloon->pbp =3D NULL;
> +}
> +
>  static void balloon_inflate_page(VirtIOBalloon *balloon,
>                                   MemoryRegion *mr, hwaddr offset)
>  {
> @@ -82,8 +88,7 @@ static void balloon_inflate_page(VirtIOBalloon *balloon,
>          /* We've partially ballooned part of a host page, but now
>           * we're trying to balloon part of a different one.  Too hard,
>           * give up on the old partial page */
> -        g_free(balloon->pbp);
> -        balloon->pbp =3D NULL;
> +        virtio_balloon_reset_pbp(balloon);
>      }
> =20
>      if (!balloon->pbp) {
> @@ -106,8 +111,7 @@ static void balloon_inflate_page(VirtIOBalloon *ballo=
on,
>           * has already reported them, and failing to discard a balloon
>           * page is not fatal */
> =20
> -        g_free(balloon->pbp);
> -        balloon->pbp =3D NULL;
> +        virtio_balloon_reset_pbp(balloon);
>      }
>  }
> =20
> @@ -143,8 +147,7 @@ static void balloon_deflate_page(VirtIOBalloon *ballo=
on,
>                    balloon->pbp->bitmap);
> =20
>          if (bitmap_empty(balloon->pbp->bitmap, subpages)) {
> -            g_free(balloon->pbp);
> -            balloon->pbp =3D NULL;
> +            virtio_balloon_reset_pbp(balloon);
>          }
>      }
> =20
> @@ -831,6 +834,7 @@ static void virtio_balloon_device_unrealize(DeviceSta=
te *dev, Error **errp)
>          virtio_balloon_free_page_stop(s);
>          precopy_remove_notifier(&s->free_page_report_notify);
>      }
> +    virtio_balloon_reset_pbp(s);
>      balloon_stats_destroy_timer(s);
>      qemu_remove_balloon_handler(s);
>      virtio_cleanup(vdev);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--5gxpn/Q6ypwruk0T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0v7MQACgkQbDjKyiDZ
s5JN1BAAt1VfOrHIkdDMPJZa3GU7Db6+no1jFXMHAoyNDxB+lZcX7szOSl+W+1xC
+rqIjiGwnSYAC5tNGCKykTWf2FDvqMriB86Z4dxeuieF/x3tWpgIQWUQJFMvcvny
ZzdQSm//WBy8mkeS1FD3fb3fiQmp8woTdBATUJqVg7lQ04XvxPlvnZXjWFNWDXDQ
U2m3prQgLGkOOn0lHL032AAWk9shULVWRVrfuo7gGPJ7nsyqF5NGAi1Qtp3U/J86
7XOpJApOiWKpm0IpAZHqNXglqUxpXcPe6qiEJ8A+k7C7KD1zyHedkU419ib8cCG3
7aNG+PTXWbdiy6mKiIgOcmPg8qOd3zdbira6KIicSTl1lbjRmJMB8JxrS4PO+Av8
rgErEjkUvrprymQo9TRi8NkP+NgF/hHjTdvED0giTf0YCrvr54pK59WNBW8N6+ID
zzC8iKOlcroSWXwX6F9PacPV5sP7TpQFHusil7VF843nIWPctiTtOAoHYRqr8ev0
rMAD/WmGSCGWW/nmGrPEvF6Vj4fxI/9Oavft9x2aqY/rqzuyDF/ucIIWI5hMa0Qp
P19WXR1evryaFptlgczBlkjI3i1en/3D3REMdXJw1l617sSqf9YvWIagd86Ym5CZ
dJSa2Me2TkwylLZ7mPvpzwGbESVX9edDKMc402RGEVR8yPOrfxI=
=Zdi7
-----END PGP SIGNATURE-----

--5gxpn/Q6ypwruk0T--

