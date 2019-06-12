Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE24CC31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 03:46:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B780A20B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 03:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ED8NmiZz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B780A20B7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36794 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbGh2-0001oh-VY
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 23:46:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57582)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hbGc8-000563-WB
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 23:41:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hbGc4-0006nT-LC
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 23:41:23 -0400
Received: from ozlabs.org ([203.11.71.1]:60861)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hbGc2-0006hS-8v; Wed, 12 Jun 2019 23:41:19 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45PTzp3CXlz9sBb; Thu, 13 Jun 2019 13:41:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1560397270;
 bh=OAHu9oTq4jpW/fVOwjH/nwpwwfltkp5Vob+BN3/jmBc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ED8NmiZzAz1PSvWTBVYqZubcBCUJn95J4P40I7koXn/SN62e7IgFd6EEluOc5mXHi
 2Tgc7nyjfD/ip/GhA2Ruyp7K+9QeiV8fDdbD7KuYLRxrrv3NSn1vcJlgvHRXlqfKqK
 D+lTtneLVnasQzoh/v5hxa9DWI63LNwKCkhu1v3M=
Date: Thu, 13 Jun 2019 09:59:26 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Message-ID: <20190612235926.GF26378@umbus.fritz.box>
References: <20190612160425.27670-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2FkSFaIQeDFoAt0B"
Content-Disposition: inline
In-Reply-To: <20190612160425.27670-1-clg@kaod.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH] docs: updates on the POWER9 XIVE interrupt
 controller documentation
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org,
 Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--2FkSFaIQeDFoAt0B
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2019 at 06:04:25PM +0200, C=E9dric Le Goater wrote:
> This includes various small updates and a better description of the
> chosen interrupt mode resulting from the combination of the 'ic-mode'
> machine option, the 'kernel_irqchip' option, guest support and KVM
> support.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>=20
>  David, please check the tables below. Thanks

LGTM, applied.

>=20
>  docs/specs/ppc-spapr-xive.rst | 112 ++++++++++++++++++++++++++++++++--
>  docs/specs/ppc-xive.rst       |   9 +--
>  2 files changed, 111 insertions(+), 10 deletions(-)
>=20
> diff --git a/docs/specs/ppc-spapr-xive.rst b/docs/specs/ppc-spapr-xive.rst
> index 539ce7ca4e90..7a64c9d04951 100644
> --- a/docs/specs/ppc-spapr-xive.rst
> +++ b/docs/specs/ppc-spapr-xive.rst
> @@ -34,19 +34,118 @@ CAS Negotiation
>  ---------------
> =20
>  QEMU advertises the supported interrupt modes in the device tree
> -property "ibm,arch-vec-5-platform-support" in byte 23 and the OS
> -Selection for XIVE is indicated in the "ibm,architecture-vec-5"
> +property ``ibm,arch-vec-5-platform-support`` in byte 23 and the OS
> +Selection for XIVE is indicated in the ``ibm,architecture-vec-5``
>  property byte 23.
> =20
>  The interrupt modes supported by the machine depend on the CPU type
>  (POWER9 is required for XIVE) but also on the machine property
>  ``ic-mode`` which can be set on the command line. It can take the
> -following values: ``xics``, ``xive``, ``dual`` and currently ``xics``
> -is the default but it may change in the future.
> +following values: ``xics``, ``xive``, and ``dual`` which is the
> +default mode. ``dual`` means that both modes XICS **and** XIVE are
> +supported and if the guest OS supports XIVE, this mode will be
> +selected.
> =20
>  The choosen interrupt mode is activated after a reconfiguration done
>  in a machine reset.
> =20
> +KVM negotiation
> +---------------
> +
> +When the guest starts under KVM, the capabilities of the host kernel
> +and QEMU are also negotiated. Depending on the version of the host
> +kernel, KVM will advertise the XIVE capability to QEMU or not.
> +
> +Nevertheless, the available interrupt modes in the machine should not
> +depend on the XIVE KVM capability of the host. On older kernels
> +without XIVE KVM support, QEMU will use the emulated XIVE device as a
> +fallback and on newer kernels (>=3D5.2), the KVM XIVE device.
> +
> +As a final refinement, the user can also switch the use of the KVM
> +device with the machine option ``kernel_irqchip``.
> +
> +
> +XIVE support in KVM
> +~~~~~~~~~~~~~~~~~~~
> +
> +For guest OSes supporting XIVE, the resulting interrupt modes on host
> +kernels with XIVE KVM support are the following:
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +ic-mode                            kernel_irqchip
> +--------------  ----------------------------------------------
> +/               allowed        off            on
> +                (default)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +dual (default)  XIVE KVM       XIVE emul.     XIVE KVM
> +xive            XIVE KVM       XIVE emul.     XIVE KVM
> +xics            XICS KVM       XICS emul.     XICS KVM
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +For legacy guest OSes without XIVE support, the resulting interrupt
> +modes are the following:
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +ic-mode                            kernel_irqchip
> +--------------  ----------------------------------------------
> +/               allowed        off            on
> +                (default)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +dual (default)  XICS KVM       XICS emul.     XICS KVM
> +xive            QEMU error(3)  QEMU error(3)  QEMU error(3)
> +xics            XICS KVM       XICS emul.     XICS KVM
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +(3) QEMU fails at CAS with ``Guest requested unavailable interrupt
> +    mode (XICS), either don't set the ic-mode machine property or try
> +    ic-mode=3Dxics or ic-mode=3Ddual``
> +
> +
> +No XIVE support in KVM
> +~~~~~~~~~~~~~~~~~~~~~~
> +
> +For guest OSes supporting XIVE, the resulting interrupt modes on host
> +kernels without XIVE KVM support are the following:
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +ic-mode                            kernel_irqchip
> +--------------  ----------------------------------------------
> +/               allowed        off            on
> +                (default)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +dual (default)  XIVE emul.(1)  XIVE emul.     QEMU error (2)
> +xive            XIVE emul.(1)  XIVE emul.     QEMU error (2)
> +xics            XICS KVM       XICS emul.     XICS KVM
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +
> +(1) QEMU warns with ``warning: kernel_irqchip requested but unavailable:
> +    IRQ_XIVE capability must be present for KVM``
> +(2) QEMU fails with ``kernel_irqchip requested but unavailable:
> +    IRQ_XIVE capability must be present for KVM``
> +
> +
> +For legacy guest OSes without XIVE support, the resulting interrupt
> +modes are the following:
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +ic-mode                            kernel_irqchip
> +--------------  ----------------------------------------------
> +/               allowed        off            on
> +                (default)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +dual (default)  QEMU error(4)  XICS emul.     QEMU error(4)
> +xive            QEMU error(3)  QEMU error(3)  QEMU error(3)
> +xics            XICS KVM       XICS emul.     XICS KVM
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +(3) QEMU fails at CAS with ``Guest requested unavailable interrupt
> +    mode (XICS), either don't set the ic-mode machine property or try
> +    ic-mode=3Dxics or ic-mode=3Ddual``
> +(4) QEMU/KVM incompatibility due to device destruction in reset. This
> +    needs to be addressed more cleanly with an error.
> +
> +
>  XIVE Device tree properties
>  ---------------------------
> =20
> @@ -92,10 +191,11 @@ for both interrupt mode. The different ranges are de=
fined as follow :
>  - ``0x0000 .. 0x0FFF`` 4K CPU IPIs (only used under XIVE)
>  - ``0x1000 .. 0x1000`` 1 EPOW
>  - ``0x1001 .. 0x1001`` 1 HOTPLUG
> +- ``0x1002 .. 0x10FF`` unused
>  - ``0x1100 .. 0x11FF`` 256 VIO devices
> -- ``0x1200 .. 0x127F`` 32 PHBs devices
> +- ``0x1200 .. 0x127F`` 32x4 LSIs for PHB devices
>  - ``0x1280 .. 0x12FF`` unused
> -- ``0x1300 .. 0x1FFF`` PHB MSIs
> +- ``0x1300 .. 0x1FFF`` PHB MSIs (dynamically allocated)
> =20
>  Monitoring XIVE
>  ---------------
> diff --git a/docs/specs/ppc-xive.rst b/docs/specs/ppc-xive.rst
> index b997dc062910..148d57eb6ab2 100644
> --- a/docs/specs/ppc-xive.rst
> +++ b/docs/specs/ppc-xive.rst
> @@ -20,10 +20,11 @@ The XIVE IC is composed of three sub-engines, each ta=
king care of a
>  processing layer of external interrupts:
> =20
>  - Interrupt Virtualization Source Engine (IVSE), or Source Controller
> -  (SC). These are found in PCI PHBs, in the PSI host bridge
> -  controller, but also inside the main controller for the core IPIs
> -  and other sub-chips (NX, CAP, NPU) of the chip/processor. They are
> -  configured to feed the IVRE with events.
> +  (SC). These are found in PCI PHBs, in the Processor Service
> +  Interface (PSI) host bridge Controller, but also inside the main
> +  controller for the core IPIs and other sub-chips (NX, CAP, NPU) of
> +  the chip/processor. They are configured to feed the IVRE with
> +  events.
>  - Interrupt Virtualization Routing Engine (IVRE) or Virtualization
>    Controller (VC). It handles event coalescing and perform interrupt
>    routing by matching an event source number with an Event

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--2FkSFaIQeDFoAt0B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0Bkd4ACgkQbDjKyiDZ
s5LeLBAAhaRhicDxsxSnr1YEQOlDKRECvqsEvtJhNN1SvcvUVl0hNb5fvK5/nIdw
Ta8o6l201tBJJWhglmmfVPMwHpcdDN8gMjg9AJvdM9S1CK8BNZmixM/hMJThNLjq
waNHDM4X/TGqTi7Ok0CW1wLCVNp4MnADXj+PgaL2O20guuBV+66BKFc1VPEzgM37
Qw9xPdkvIfRzyW1I1tOOEMcSLA3kfFssRSad1X4Jw50Av1sTEpdvchNdb0ee4EBN
41fL6cxEcPWLeAaUj/wdJvhl8HwKOBQw4MLWRgT1rECMpJiTSytCwVSLUk2oedmw
16wOQtz7URQWrpP6qj1igXj7wmn/zFd533xIjx7LZ2AuWQnOBfs4dn8YfUFSrvie
NCqxiq6JGRRPGqbqHlZUS8dMeD/P3arumZcccKjiD0zCXDbHjrr+zW2+cUxkFOjG
98+MEELptnPa/irETjcRR1+TKddOjdebelcMEjTSHtgS0O/tu7ILNmLG4+KB9Ppm
D80+gTcHQ3qmGTP00JtsW6d4Z4Aw+A54Eaam0zleIq4NIi5Ju5ydJzUHIEJvIrOG
5cnoVy7OnVUnAD6DAGc6oibCT+Qgu8xdgPoR6ZDJGiqKt6LKxiMMnbhINA5oXFko
MMRrCrxXqhYs+rGA82kiDoCdgBeKEwMY2oUmgmQ40N99A5RjSSk=
=4aIL
-----END PGP SIGNATURE-----

--2FkSFaIQeDFoAt0B--

