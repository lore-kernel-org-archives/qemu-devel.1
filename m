Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2947ECE58C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 17:32:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2E2A218AC
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 17:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="hW8WoNCQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2E2A218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIFox-000749-R5
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 13:32:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48809)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iI7mY-0001MY-M9
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 04:57:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iI7mX-00078I-3n
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 04:57:18 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:51865 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iI7mW-000775-0C; Wed, 09 Oct 2019 04:57:17 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46p7Pz3yf3z9sDQ; Wed,  9 Oct 2019 19:57:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1570611431;
 bh=vnvbTSiJwe1v/BjPmkc1YAOvESi4dK9BWMA9+dMRxio=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hW8WoNCQuvg/iXuypMS9Z45xb2NTfKrvxzBBDs0u8hAeioyKk+JpilqHj4/w+ijAx
 teoENlZQtWgZde7eNu2yqWnCbG1BMy7pIGZdFTBlvlFF9ORprnk/JZ72vZjXUNPoe1
 YWtJm+oA8lUNrp7DclojMG10jJQBZiCgDRdU2vRE=
Date: Wed, 9 Oct 2019 19:57:07 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: qemu-devel@nongnu.org, clg@kaod.org, qemu-ppc@nongnu.org
Subject: Re: [PATCH v4 18/19] spapr: Handle irq backend changes with VFIO PCI
 devices
Message-ID: <20191009085707.GB5035@umbus.fritz.box>
References: <20191009060818.29719-1-david@gibson.dropbear.id.au>
 <20191009060818.29719-19-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="bCsyhTFzCvuiizWE"
Content-Disposition: inline
In-Reply-To: <20191009060818.29719-19-david@gibson.dropbear.id.au>
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Jason Wang <jasowang@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, groug@kaod.org,
 Laurent Vivier <laurent@vivier.eu>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--bCsyhTFzCvuiizWE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 09, 2019 at 05:08:17PM +1100, David Gibson wrote:
> pseries machine type can have one of two different interrupt controllers =
in
> use depending on feature negotiation with the guest.  Usually this is
> invisible to devices, because they route to a common set of qemu_irqs whi=
ch
> in turn dispatch to the correct back end.
>=20
> VFIO passthrough devices, however, wire themselves up directly to the KVM
> irqchip for performance, which means they are affected by this change in
> interrupt controller.
>=20
> Luckily, there's a notifier chain that will tell VFIO devices to update
> their mappings - we just need to call it whenever the intc backend might
> change.
>=20
> In addition, we make sure we set an active intc earlier, because otherwise
> vfio can issue a false warning, because it doesn't think a KVM irqchip is
> in use (which is essentially for good INTx performance).
>=20
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

For reference, the reason I described this as RFC only in the cover
letter, is that this doesn't work as it stands.

With this patch, when we switch intc we call the intx_routing
notifiers, and vfio_intx_update() in particular.  However that exits
early without calling vfio_intx_enable_kvm() - the bit we actually
need - because the test on pci_intx_route_changed() thinks there's
nothing to do.  The difficulty is that our use case isn't really the
same as the x86 one this notifier path was designed for: they're
changing routing of INTx to global interrupts.  For us the routing to
global interrupts remains the same, but the interrupt controller
handling those global interrupts has changed.

> ---
>  hw/ppc/spapr_irq.c     | 6 ++++++
>  hw/ppc/spapr_pci.c     | 9 +++++++++
>  include/hw/ppc/spapr.h | 1 +
>  3 files changed, 16 insertions(+)
>=20
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 473fc8780a..7964e4a1b8 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -409,6 +409,12 @@ static void set_active_intc(SpaprMachineState *spapr,
>      }
> =20
>      spapr->active_intc =3D new_intc;
> +
> +    /*
> +     * We've changed the interrupt routing at the KVM level, let VFIO
> +     * devices know they need to readjust.
> +     */
> +    spapr_pci_fire_intx_routing_notifiers(spapr);
>  }
> =20
>  void spapr_irq_update_active_intc(SpaprMachineState *spapr)
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index cc0e7829b6..3bcf6325d4 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -93,6 +93,15 @@ PCIDevice *spapr_pci_find_dev(SpaprMachineState *spapr=
, uint64_t buid,
>      return pci_find_device(phb->bus, bus_num, devfn);
>  }
> =20
> +void spapr_pci_fire_intx_routing_notifiers(SpaprMachineState *spapr)
> +{
> +    SpaprPhbState *sphb;
> +
> +    QLIST_FOREACH(sphb, &spapr->phbs, list) {
> +        pci_bus_fire_intx_routing_notifier(PCI_HOST_BRIDGE(sphb)->bus);
> +    }
> +}
> +
>  static uint32_t rtas_pci_cfgaddr(uint32_t arg)
>  {
>      /* This handles the encoding of extended config space addresses */
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index d3b4dd7de3..66b68fdd5e 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -805,6 +805,7 @@ void spapr_clear_pending_events(SpaprMachineState *sp=
apr);
>  int spapr_max_server_number(SpaprMachineState *spapr);
>  void spapr_store_hpte(PowerPCCPU *cpu, hwaddr ptex,
>                        uint64_t pte0, uint64_t pte1);
> +void spapr_pci_fire_intx_routing_notifiers(SpaprMachineState *spapr);
> =20
>  /* DRC callbacks. */
>  void spapr_core_release(DeviceState *dev);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--bCsyhTFzCvuiizWE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2doOMACgkQbDjKyiDZ
s5KxRxAAkOV3LIupLQPOKnDPjxw8opo77EJBihlfmOWOyD73UZBreQfAVDOUQ84c
TnneUViarIO0B8ZSGuXuHI4JoVy92Kwl6N64A/hGmsS7TsALDp+LrKo6II/L7F9t
QmflMwCLz+RvFy/HyUQKdKPBTpni9K0/zBcpBDpGujtQYI2KVuEiskllZ80YBeIV
DQFYdSr8kMQ9+WgNuNPQdsZ5CHOLS9rhgpA2y97rGBmWIGMRDXkjWi7vpZ0GLhxN
cJs4rtuFCLTtzKA0q0TqoYEGxvnEWaHxiRiH9WIQ+7/uG8nmDTAACbCg9ufJOVfk
QejLj83R7wOECFW55TftNtUTpdtOu1PYma1gesUIL/+edy9+5v3McBgezWihBCVv
u3f3tLS5LxvtyKWCf3Jkp4qcXieoA15NMa5ms/LHW50iwZtA+f4UTQ2fdoQKRF40
Q9NXtYM/aareUROhqqEqL2IA5U9Tx71vrHU3vwzn+nnW7/DtgK4hEEnaQBujmaVx
cBGiYyp2k8A6W1NXUYvw6iaDh8fLSQpunnsUjtxMnmWTrm6BomeUz5/Dv9Oqv6tM
5IDqg2Qc2D+4ER9WmBmc9mVsu8Ofh6QFxbU9PIEMWZcBd9Z9h8wzRffnb5AUNp/y
/fYkZ3PHRlP9wWWTcD8KDtvXH7bLzP+gP6GpvQ0LwrhpIpAPVNg=
=3BCe
-----END PGP SIGNATURE-----

--bCsyhTFzCvuiizWE--

