Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5EFC76196
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 06:01:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BD4F2173E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 06:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Tx+7ejb9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BD4F2173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnzTb-0000AJ-3l
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 02:01:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41702)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hnzSt-0006od-B7
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 02:00:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hnzSs-0004DP-0R
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 02:00:27 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:57363 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hnzSq-0004BJ-S2; Thu, 18 Jul 2019 02:00:25 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45q3QB2n9sz9sNT; Thu, 18 Jul 2019 16:00:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1563429618;
 bh=NOPQltffnDZimp3DgpaUwM/EVrhsh7jmiuCE2Q2VZNM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Tx+7ejb9h8x8N2EOia0EnsZ2HjJQ0KLCXKL+Xqz8zadsDfIuOacv32o3ll7TrG8KE
 flO/PlnYitLoFGqEDr/AnzN9gYlHqdrxL5kOOTgfuhpI8jZXwRTkbYS5pwImWNrYr4
 t6FLAKPa2mIuLwTmlweh/3+LG3twv2Zi+008aUoI=
Date: Thu, 18 Jul 2019 13:52:03 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: David Hildenbrand <david@redhat.com>
Message-ID: <20190718035203.GE8468@umbus.fritz.box>
References: <20190717103550.24657-1-david@redhat.com>
 <20190717103550.24657-4-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ILuaRSyQpoVaJ1HG"
Content-Disposition: inline
In-Reply-To: <20190717103550.24657-4-david@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH-for-4.1 v2 3/3] virtio-balloon: reset pbp
 on device resets
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


--ILuaRSyQpoVaJ1HG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2019 at 12:35:50PM +0200, David Hildenbrand wrote:
> When a guest reboots (ordinary reboots, but also via kexec), it will
> happily reuse any system memory, including previously inflated memory.
>=20
> We could have tracking data for a pbp (PartiallyBalloonedPage). It could
> happen that a new inflation request from the guest will result in a
> discard of such a pbp, although the guest is (again) reusing some
> memory.
>=20
> We should reset the pbp on any device resets.
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
>  hw/virtio/virtio-balloon.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index 84d01bceb3..9de3c030bf 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -847,6 +847,7 @@ static void virtio_balloon_device_reset(VirtIODevice =
*vdev)
>      if (virtio_balloon_free_page_support(s)) {
>          virtio_balloon_free_page_stop(s);
>      }
> +    virtio_balloon_reset_pbp(s);
> =20
>      if (s->stats_vq_elem !=3D NULL) {
>          virtqueue_unpop(s->svq, s->stats_vq_elem, 0);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ILuaRSyQpoVaJ1HG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0v7OMACgkQbDjKyiDZ
s5IzRxAAs9ycyBelNJl5MfBRVdtAkcdeNh5MCJuaa82OWP33nZALzVZYJKdymCy4
AOVciYIt8V9bAsU0OTxrH3LbhCDc+wdALrt1XddXlTMkbqxpAKVHWQS5A5MNQHRu
741vczCurxmcdZs9oYWDFes28c6xqJfUcbfY4vAr70/JteZIHBPfeChm8+7cH5mf
OgKJ7elYbKUmVUpsdZqVBkeX90rMg+CsQXJid1fGQjxJ94Hk27THD7rg6tZXnKsJ
zT7NUBlWkDf47G9J6s2flWwEoT86LMeCpnxeB0K63cqp1ZhNyMy2NinkyiKwB/y9
EfZnp58lEvnSNYAL0k68+6QJ8PrcBB/Z09QqRVOXSGMPSekuvbxVQ4Dmzza/zGpZ
6rg1ZGR2b0xieqJW3c3iBCiOGME2XgAIIko28q+99bNV3X76moEhVLO0AWhEiAV3
Fyyilu8Ti1iiqOLeIw7jNZu4p/gU/u3cVk561r/kxNOizNA8wgVVumh8BcmnIeDD
vsU0c5VeVMglDWUu7sAYIQgyeO/t8W0hIjtkdK9RG2CVW8x7rW6ztFcpfLyKoVRJ
yX6C5ih88yWoWrsyOVE0DSuMCZAArxwWyFubqW7FhxXRiwL+Q0tbhG3U6QywTWsK
K4sHppsgZdCQP7ac7dgnUg17OWh3ySn/FQdUEJrpZ4H5w/uV690=
=w+7e
-----END PGP SIGNATURE-----

--ILuaRSyQpoVaJ1HG--

