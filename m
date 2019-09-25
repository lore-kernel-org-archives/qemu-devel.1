Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1D3C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 07:13:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9488021D7C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 07:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="qDsfJo6x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9488021D7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD1UQ-0007RZ-5C
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 03:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39262)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iD16g-0001my-Nq
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 02:48:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iD16f-000584-Eb
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 02:48:58 -0400
Received: from ozlabs.org ([203.11.71.1]:60443)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iD16e-00056X-Qx; Wed, 25 Sep 2019 02:48:57 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46dTDQ3rCSz9sPL; Wed, 25 Sep 2019 16:48:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1569394134;
 bh=yi5gqsyLQSdlFU6Ss2n/OfG6FsIyjJVz6yBGaMlRDhw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qDsfJo6xobHdOuvnKlRYPGjF6+9fmeH1jRQ4YkZZBn4SpGxA7XMQ+xqtU5SeoV68O
 ii2THUz3G1b4PkkLTxHyHI++GNWPY0fX+9eKbxKfhoBrSVrK8z+3QVWAsWaaaIL3XY
 pWSxv2Mb8UB+euih6fbAGjOkQu8aeZOQ7g6UlwHg=
Date: Wed, 25 Sep 2019 16:48:37 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Subject: Re: [PATCH v14 4/7] target/ppc: Build rtas error log upon an MCE
Message-ID: <20190925064837.GM17405@umbus>
References: <156879398718.18368.17640174821710157715.stgit@aravinda>
 <156879435456.18368.1144480383769624512.stgit@aravinda>
 <20190925013052.GG17405@umbus>
 <3282d800-46d5-d270-542c-bcf8bd937944@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5fECsWged6836Ycf"
Content-Disposition: inline
In-Reply-To: <3282d800-46d5-d270-542c-bcf8bd937944@linux.vnet.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org, paulus@ozlabs.org,
 qemu-ppc@nongnu.org, ganeshgr@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--5fECsWged6836Ycf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2019 at 11:31:30AM +0530, Aravinda Prasad wrote:
>=20
>=20
> On Wednesday 25 September 2019 07:00 AM, David Gibson wrote:
> > On Wed, Sep 18, 2019 at 01:42:34PM +0530, Aravinda Prasad wrote:
> >> Upon a machine check exception (MCE) in a guest address space,
> >> KVM causes a guest exit to enable QEMU to build and pass the
> >> error to the guest in the PAPR defined rtas error log format.
> >>
> >> This patch builds the rtas error log, copies it to the rtas_addr
> >> and then invokes the guest registered machine check handler. The
> >> handler in the guest takes suitable action(s) depending on the type
> >> and criticality of the error. For example, if an error is
> >> unrecoverable memory corruption in an application inside the
> >> guest, then the guest kernel sends a SIGBUS to the application.
> >> For recoverable errors, the guest performs recovery actions and
> >> logs the error.
> >>
> >> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> >> ---
> >>  hw/ppc/spapr.c         |   13 +++
> >>  hw/ppc/spapr_events.c  |  222 +++++++++++++++++++++++++++++++++++++++=
+++++++++
> >>  hw/ppc/spapr_rtas.c    |   26 ++++++
> >>  include/hw/ppc/spapr.h |    6 +
> >>  target/ppc/kvm.c       |    4 +
> >>  5 files changed, 268 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >> index 76ed988..9f2e5d2 100644
> >> --- a/hw/ppc/spapr.c
> >> +++ b/hw/ppc/spapr.c
> >> @@ -2930,6 +2930,19 @@ static void spapr_machine_init(MachineState *ma=
chine)
> >>          error_report("Could not get size of LPAR rtas '%s'", filename=
);
> >>          exit(1);
> >>      }
> >> +
> >> +    if (spapr_get_cap(spapr, SPAPR_CAP_FWNMI_MCE) =3D=3D SPAPR_CAP_ON=
) {
> >> +        /*
> >> +         * Ensure that the rtas image size is less than RTAS_ERROR_LO=
G_OFFSET
> >> +         * or else the rtas image will be overwritten with the rtas e=
rror log
> >> +         * when a machine check exception is encountered.
> >> +         */
> >> +        g_assert(spapr->rtas_size < RTAS_ERROR_LOG_OFFSET);
> >> +
> >> +        /* Resize rtas blob to accommodate error log */
> >> +        spapr->rtas_size =3D RTAS_ERROR_LOG_MAX;
> >> +    }
> >> +
> >=20
> > I've recently merged into ppc-for-4.2 the change to have SLOF supply
> > the RTAS blob, rather than qemu.  So this code will need to be updated
> > accordingly.
>=20
> Sure. Will modify it to check if rtas_size is set to RTAS_ERROR_LOG_MAX
> instead of the assignment.

There is no rtas_size variable now.  You'll need to just trust that
SLOF has allocated enough room.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--5fECsWged6836Ycf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2LDcMACgkQbDjKyiDZ
s5KjNBAAr1oUpkqVDcIyVKICnvV8WVgTtR5hahWxTRl4PgXYZtDRd+REo2JW2GKC
i/w8QK7Gq7/bu2UsHDrVYDFZmERwmy3VpdcY1FvOjamJAmUb/Z3Po2AoHuZeAYb3
4C223DC6mZfPfyq0P+Gl/ktgrW/ErWRXh+l/xNsrrXgZOCet2gGSqIrg3ze7QFOw
GlYb3nI4qOFk8h7E0QMGXmmvMmYvk+WG4M5i/l5IMJGuvByw+EplfNyRAcyw3Hjb
ga0x0aRpJYDIwbpfxp/XU1Dmm7krZnvamQ9bSS4iDmhW9oLZmwW2YFBhAxko5V2B
lnD14e/T4ljBli46Qm0YRkVu1BU8YJiICcG4bV4GkMgxfy1v1MtjVMGtKccXMXTd
y4WiyjIHKIIVXgFUzX6H1jUJU+o2O4NTKORJiG5+l1TFJX4ER0oPT/GrbAMMxouf
nvXk3AeAHleQDf0qR2cfgmr7irKKmCK6WwIDwBmC2H2Fp1kCwWtv/AUae+WVgy8b
cuHXruJCm+KPNQTgmRQzAZUKcQevsCZl/wXwyvZW5cObZX3w5JzobsndO3cyirSg
Q5m3O7XFgMY8r/+gVNbyN6c21BvQ+/4pQI58YEPqKu1HGTjjUcCitcELID+F1+YJ
gsxMCkowTkvK3CJwmdcyKJJGaRrJujXb4hqB5UYk1OxWz77FC/4=
=fYMo
-----END PGP SIGNATURE-----

--5fECsWged6836Ycf--

