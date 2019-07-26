Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24398C7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 08:31:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8908E216C8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 08:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="izfCChRf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8908E216C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqvdA-0003to-Iz
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 04:31:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34167)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hqvcV-0002HN-JZ
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 04:30:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hqvcN-0001Ea-Ir
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 04:30:30 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:47781)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hqvcJ-0000vi-D9; Fri, 26 Jul 2019 04:30:20 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45w2MT6kNcz9sBZ; Fri, 26 Jul 2019 18:30:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1564129813;
 bh=DUnxc7BiR7/s7pdTPwISkY1Q6vBcJBXC8bI7TPnBby4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=izfCChRfLJv6FcIJqpwdkkyfrxfYz+5yQhH6nvIWagN1Y3Rnz6Gh2+i0C0huxe+ka
 W3TcTOfIYsdppcAX6Zgi7NIILhckMzuprrYwRtav1NJ9nt0/xAzOIiLEZrmcAtF64k
 lCr3bG99yRRLmGmDaDFNZgFxJah8PSuuVltc6JI0=
Date: Fri, 26 Jul 2019 18:10:01 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: David Hildenbrand <david@redhat.com>
Message-ID: <20190726081001.GB3147@umbus>
References: <20190725113638.4702-1-david@redhat.com>
 <20190725113638.4702-8-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="FkmkrVfFsRoUs1wW"
Content-Disposition: inline
In-Reply-To: <20190725113638.4702-8-david@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH-for-4.1 v4 7/7] virtio-balloon: No need to
 track subpages for the PBP anymore
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


--FkmkrVfFsRoUs1wW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2019 at 01:36:38PM +0200, David Hildenbrand wrote:
> As ramblocks cannot get removed/readded while we are processing a bulk
> of inflation requests, there is no more need to track the page size
> in form of the number of subpages.
>=20
> Suggested-by: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/virtio/virtio-balloon.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index a6282d58d4..fe9664e42c 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -36,7 +36,6 @@
> =20
>  typedef struct PartiallyBalloonedPage {
>      ram_addr_t base_gpa;
> -    long subpages;
>      unsigned long *bitmap;
>  } PartiallyBalloonedPage;
> =20
> @@ -55,16 +54,15 @@ static PartiallyBalloonedPage *virtio_balloon_pbp_all=
oc(ram_addr_t base_gpa,
>      PartiallyBalloonedPage *pbp =3D g_new0(PartiallyBalloonedPage, 1);
> =20
>      pbp->base_gpa =3D base_gpa;
> -    pbp->subpages =3D subpages;
>      pbp->bitmap =3D bitmap_new(subpages);
> =20
>      return pbp;
>  }
> =20
>  static bool virtio_balloon_pbp_matches(PartiallyBalloonedPage *pbp,
> -                                       ram_addr_t base_gpa, long subpage=
s)
> +                                       ram_addr_t base_gpa)
>  {
> -    return pbp->subpages =3D=3D subpages && pbp->base_gpa =3D=3D base_gp=
a;
> +    return pbp->base_gpa =3D=3D base_gpa;
>  }
> =20
>  static void balloon_inflate_page(VirtIOBalloon *balloon,
> @@ -106,7 +104,7 @@ static void balloon_inflate_page(VirtIOBalloon *ballo=
on,
>      base_gpa =3D memory_region_get_ram_addr(mr) + mr_offset -
>                 (rb_offset - rb_aligned_offset);
> =20
> -    if (*pbp && !virtio_balloon_pbp_matches(*pbp, base_gpa, subpages)) {
> +    if (*pbp && !virtio_balloon_pbp_matches(*pbp, base_gpa)) {
>          /* We've partially ballooned part of a host page, but now
>           * we're trying to balloon part of a different one.  Too hard,
>           * give up on the old partial page */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--FkmkrVfFsRoUs1wW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl06tVkACgkQbDjKyiDZ
s5IwOA/6AwaeQs5ciiJdF0bukVwsPzl4yMwzwGXMpMsGlECOD8BG4KdcCPNWG73h
J96e5ny/mLc3YDrNur8ur8FrKENyroG3ooGUzxfvaeLMDWfkcSTjEqH59trSHdeW
yYHFG0s530jZjsrs4ABIfxlU3Cqb1LJ6sVhLgyuuG+VVFiFX6QmiUz93QebTIpFX
ptasde7x6NeKiocT1pBc2pQsG5Zm5AMOgjzaCAbqD5fcT2//HY892HXw5MKJO7K3
JM5vaAr148z+MF+aAqrU16p7SxU2G6AFXSfe+WkL3tramfV2Nl0d//Q5+mLedRBd
rMLluFGSayEvXzQfrg6SgFhxqHaTVpHgt+B/TAZk8VLufVvMaU7avkuTNYRJbrb1
gEy7/vVUUoJFHgRRL27Hu9WBjBsJJIpBl1VxLi6+N3x9q+xhISwlnSnc55kb9/7G
mEjJnUeS4pjzVWpj6qihAR0mSnLLBCU9uF4b41OtMJ2qAOH/N78B5Gep5akP4FrX
31ESnn+Ly3gPQYPt+PrArKjAQRaepcnf3l3pF9pbyagi5N6HU9zT62DKwyyXM7+m
+AHncrGvn2NBZvHyFouk5VqbzaBSgQzeA7mDSx/H7GY1rsep5hGpQi4/JiQanEoN
oErfpKDk1zoicXQnIcOo2Q5tVmH6575WSXUJE9H9AS3zD3UWg7s=
=KIa2
-----END PGP SIGNATURE-----

--FkmkrVfFsRoUs1wW--

