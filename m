Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B7CC04AB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 01:57:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19AF8208CA
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 01:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Yb/vqvMv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19AF8208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37638 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQMgq-0004UR-6Z
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 21:57:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hQMfX-0003bp-Cn
	for qemu-devel@nongnu.org; Mon, 13 May 2019 21:55:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hQMfS-0000Bp-Qn
	for qemu-devel@nongnu.org; Mon, 13 May 2019 21:55:48 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:36491)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hQMfN-0008JD-NC; Mon, 13 May 2019 21:55:43 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 45313p16YLz9sBp; Tue, 14 May 2019 11:55:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1557798934;
	bh=quACPbm4dhlY2E1zLMcd6KUFooODSchUZBAuUGGeVaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yb/vqvMv+9AulmdE9VSrS5i0lBU2yN+IBSWgItzIPoS1HgTjoEgtM+ZzyRHvSKNBS
	JVeMxgEr5OPzFwV7SJbI0RiTNynz1wGoaekAmcimSQSOmYaa461hQlZrlDwzPxM+lc
	F3bPQhootdxWCbjybdN2WfllaOnbtmPgkx7wmQLA=
Date: Tue, 14 May 2019 11:54:26 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Message-ID: <20190514015426.GE6441@umbus.fritz.box>
References: <20190513084245.25755-1-clg@kaod.org>
	<20190513084245.25755-14-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2Z2K0IlrPCVsbNpk"
Content-Disposition: inline
In-Reply-To: <20190513084245.25755-14-clg@kaod.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH v4 13/14] ppc/xics: fix irq priority in
 ics_set_irq_type()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--2Z2K0IlrPCVsbNpk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2019 at 10:42:44AM +0200, C=E9dric Le Goater wrote:
> Recent commits changed the behavior of ics_set_irq_type() to
> initialize correctly LSIs at the KVM level. ics_set_irq_type() is also
> called by the realize routine of the different devices of the machine
> when initial interrupts are claimed, before the ICSState device is
> reseted.
>=20
> In the case, the ICSIRQState priority is 0x0 and the call to
> ics_set_irq_type() results in configuring the target of the
> interrupt. On P9, when using the KVM XICS-on-XIVE device, the target
> is configured to be server 0, priority 0 and the event queue 0 is
> created automatically by KVM.
>=20
> With the dual interrupt mode creating the KVM device at reset, it
> leads to unexpected effects on the guest, mostly blocking IPIs. This
> is wrong, fix it by reseting the ICSIRQState structure when
> ics_set_irq_type() is called.
>=20
> Fixes: commit 6cead90c5c9c ("xics: Write source state to KVM at claim tim=
e")
> Signed-off-by: Greg Kurz <groug@kaod.org>
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/intc/xics.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index af7dc709abab..79f5a8a91665 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -610,6 +610,12 @@ static const TypeInfo ics_simple_info =3D {
>      .class_size =3D sizeof(ICSStateClass),
>  };
> =20
> +static void ics_reset_irq(ICSIRQState *irq)
> +{
> +    irq->priority =3D 0xff;
> +    irq->saved_priority =3D 0xff;
> +}
> +
>  static void ics_base_reset(DeviceState *dev)
>  {
>      ICSState *ics =3D ICS_BASE(dev);
> @@ -623,8 +629,7 @@ static void ics_base_reset(DeviceState *dev)
>      memset(ics->irqs, 0, sizeof(ICSIRQState) * ics->nr_irqs);
> =20
>      for (i =3D 0; i < ics->nr_irqs; i++) {
> -        ics->irqs[i].priority =3D 0xff;
> -        ics->irqs[i].saved_priority =3D 0xff;
> +        ics_reset_irq(ics->irqs + i);
>          ics->irqs[i].flags =3D flags[i];
>      }
>  }
> @@ -760,6 +765,7 @@ void ics_set_irq_type(ICSState *ics, int srcno, bool =
lsi)
>          lsi ? XICS_FLAGS_IRQ_LSI : XICS_FLAGS_IRQ_MSI;
> =20
>      if (kvm_irqchip_in_kernel()) {
> +        ics_reset_irq(ics->irqs + srcno);
>          ics_set_kvm_state_one(ics, srcno);
>      }
>  }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--2Z2K0IlrPCVsbNpk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzaH9IACgkQbDjKyiDZ
s5LGFA//eSaJetc1/NayJS/FA+fwopHXivYBmHdQ3H5QAzGPZMaC00HFJMDju5Yd
/N0aGlsj9w3R31buzwGK/q2VaOQfiG7vWmlisqCWtkEwkABPyVeJF7ls65mNfvDw
ryp4PfWm3E+b5kQ7GcOrhWE2GFOGqIQKy8e1dj8dvCKdtuW3VIWkAsD/SIEEGrc8
g7o3MKxVUx4hylDoonf12dLMfSm3NWSxv3JpqeyM88ALmF5d9k38edb2VgI6xwxW
oC9FzRy8WSlUhNHNkvSj0iWZS4gtgjxEQaXd1r8jug/CkeRUjQ+4wnC6RLnjneOn
RTDEoaV1ZueiIqk68RPz0LRrvKwAHmyfsr+9UtUh+f9s0YQlElJV/daIXq2fbxoK
qFbL/wlGoZKVjaCj5+5bRpW/kl/F3L6On5IduvL5sk5WHeQsD6GbUwCuucn9ORs8
yDgDh6rylsIslPmrSCK+NULvLRdbn4J/JR/TiAcKQc4GaMO3vqYotoy2OxZE0Tpb
MSTrG0QEK/ZQR00CZnM8Sy9nuXr2ellM284zzHFeKcqkiIDpJGNwM5j1swYKrSBR
wKXqNtUj2JIFEeLWd8rUkZMQ7P2kzegofLI6RGCKXrbLnOcxF1BJZ6TaFMj9lywT
d+U7ggaXnQ46FYMeuXKZ4LNX5hcB3VBEp0rjKfaF2PCXDjDVfsQ=
=HRFv
-----END PGP SIGNATURE-----

--2Z2K0IlrPCVsbNpk--

