Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACD1C28EBB
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 00:22:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D173206DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 00:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="UTaTPaMW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D173206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45232 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZ2ek-0000fa-Jh
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 20:22:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53596)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hZ2bK-0006cb-DZ
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 20:19:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hZ2bI-0003NE-HU
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 20:19:22 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:55763 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hZ2bF-0003Jy-OO; Thu, 06 Jun 2019 20:19:18 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45KjnX4jXbz9sCJ; Fri,  7 Jun 2019 10:19:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1559866752;
 bh=3LDuNTLdZLYCfiKX8XxuRKNgDXi64qDWvMKcZ466MD0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UTaTPaMW//ru9filsAzEeKovpT6rFQdZ++ADzEwtyVBYZBnMj8JxplIAusqPOeoke
 zkLmOX8RfnE2Ni9DGB398KHXfoyYwgzBgAhlbKAhX7XMvHBbnctxIdHE22Rvecxr4l
 lD9WOWE/3owVSQpB7I+AyRZFc6HjetDkVCVX+VtY=
Date: Fri, 7 Jun 2019 10:19:01 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Message-ID: <20190607001901.GC3760@umbus.fritz.box>
References: <155984093894.2803172.8618224129384655510.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="raC6veAxrt5nqIoY"
Content-Disposition: inline
In-Reply-To: <155984093894.2803172.8618224129384655510.stgit@bahia.lan>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH] spapr: Don't use the "dual" interrupt
 controller mode with an old hypervisor
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
Cc: qemu-ppc@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--raC6veAxrt5nqIoY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 06, 2019 at 07:08:59PM +0200, Greg Kurz wrote:
> If KVM is too old to support XIVE native exploitation mode, we might end
> up using the emulated XIVE after CAS. This is sub-optimal if KVM in-kernel
> XICS is available, which is the case most of the time.

This is intentional.  A predictable guest environment trumps performance.

> Also, an old KVM may not allow to destroy and re-create the KVM XICS, whi=
ch
> is precisely what "dual" does during machine reset. This causes QEMU to t=
ry
> to switch to emulated XICS and to crash because RTAS call de-registration
> isn't handled correctly. We could possibly fix that, but again we would
> still end up with an emulated XICS or XIVE.

Ugh, that's a problem.

> "dual" is definitely not a good choice with older KVMs. Internally force
> XICS when we detect this.

But this is not an acceptable solution.  Silently changing the guest
visible environment based on host capabilities is never ok.  We must
either give the guest environment that the user has requested, or fail
outright.

>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/ppc/spapr_irq.c |   10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 3156daf09381..d788bd662a7a 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -18,6 +18,7 @@
>  #include "hw/ppc/xics_spapr.h"
>  #include "cpu-models.h"
>  #include "sysemu/kvm.h"
> +#include "kvm_ppc.h"
> =20
>  #include "trace.h"
> =20
> @@ -668,6 +669,15 @@ static void spapr_irq_check(SpaprMachineState *spapr=
, Error **errp)
>              return;
>          }
>      }
> +
> +    /*
> +     * KVM may be too old to support XIVE, in which case we'd rather try
> +     * to use the in-kernel XICS instead of the emulated XIVE.
> +     */
> +    if (kvm_enabled() && !kvmppc_has_cap_xive() &&
> +        spapr->irq =3D=3D &spapr_irq_dual) {
> +        spapr->irq =3D &spapr_irq_xics;
> +    }
>  }
> =20
>  /*
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--raC6veAxrt5nqIoY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlz5rXUACgkQbDjKyiDZ
s5J4PA/+N17Q0yxjBz8F6EAzWU+QsPYUnGrwzgVYMi3D734nBHjosmJ1bUtT4NGs
6mFMIhNHOGknd059AoVqWo4ezQz+lfAYMbKC63R7/fGxfxwiV/VQiaKRi0YMujFv
ikrpuBhywLSdVttPG0hNG2HGOE60NxEDSQQ5W8QMGgCeDGeiTiaI0LQNzeiIHnxf
3ocuAggJQCaLJvaJk0qAez51GJhbJNnHVIKPippOck5OdfmJnvbDajjJz9F+//dF
rFnoWZYPAP2f7M6u/w6gEFQotkX0f2B1T0DVrTR8Q9dHEkyYKGEdcpQrHbRdzPPM
lAsutt3eYXhjz9NryeK4p94IZJDNVtF26BFWny2NAzg69zCYSpoCLHEdxi8hBMBu
gHRDQhTSbi0ebDKeLA9z6hZvSPw8BKGOXzPv3PUfdsfM97/qVN4gKfTUMfycmL75
DtMev96/grFFDAkN5A5svT83L1lxZtH4bnHLnvfe+Zgu+gnhLa2Ej7y0hrKsChsJ
5Lr8YDYc6DwRV9cPe5vHHPeU4LPw5Gj3Ifg/QtPrNGyS8vYE1q7oYEdwk1cf89ha
DqKLfQpj1p8FqxgcJpuFqNRgzvdib3ulDisGlBtSEB1wH20ZpRKkEtaFO4rRh55R
fZN0y/V0/W+53OTD+RMpvRAVvSryAuM/OwT/y6ZqUpyuYEO66P0=
=Xx9s
-----END PGP SIGNATURE-----

--raC6veAxrt5nqIoY--

