Return-Path: <SRS0=P1lm=VZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D87C433FF
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jul 2019 07:09:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50BE22085A
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jul 2019 07:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="RMZ4qDlz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50BE22085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hrdJb-0002WR-MP
	for qemu-devel@archiver.kernel.org; Sun, 28 Jul 2019 03:09:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46783)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hrdHw-0000qb-0V
 for qemu-devel@nongnu.org; Sun, 28 Jul 2019 03:08:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hrdHu-0007x0-PD
 for qemu-devel@nongnu.org; Sun, 28 Jul 2019 03:08:11 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:54251 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hrdHt-0007tC-Ie; Sun, 28 Jul 2019 03:08:10 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45xDRn0dr5z9s7T; Sun, 28 Jul 2019 17:08:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1564297685;
 bh=TQWdnO1cHDzhMcj49hgNjV88dpL6A3CoLGIBVPMEsDE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RMZ4qDlzHwYn3E9Kf3eTr5lLUCwoho7oeJRMWTN44e92PxlTfGL3KvltuiFcrpldp
 KfVMzGV0iB0HYiLkvxMGQQfE2BddaEoROC71Pq451uHCtVDqrm80+zqZnVUgGbRrnx
 GZnM6FHYM1Z4LVcYcH8NKbCCnaPzJbRzrcv1j3hA=
Date: Sun, 28 Jul 2019 17:07:56 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Message-ID: <20190728070756.GE5110@umbus>
References: <156415227297.1064338.9181963275184520284.stgit@bahia.lan>
 <156415228966.1064338.190189424190233355.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/2994txjAzEdQwm5"
Content-Disposition: inline
In-Reply-To: <156415228966.1064338.190189424190233355.stgit@bahia.lan>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH 3/3] spapr/irq: Drop spapr_irq_msi_reset()
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--/2994txjAzEdQwm5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2019 at 04:44:49PM +0200, Greg Kurz wrote:
> PHBs already take care of clearing the MSIs from the bitmap during reset
> or unplug. No need to do this globally from the machine code. Rather add
> an assert to ensure that PHBs have acted as expected.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-4.2, thanks.

> ---
>  hw/ppc/spapr.c             |    4 ----
>  hw/ppc/spapr_irq.c         |    7 ++-----
>  include/hw/ppc/spapr_irq.h |    1 -
>  3 files changed, 2 insertions(+), 10 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 5894329f29a9..855e9fbd9805 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1739,10 +1739,6 @@ static void spapr_machine_reset(MachineState *mach=
ine)
>          ppc_set_compat(first_ppc_cpu, spapr->max_compat_pvr, &error_fata=
l);
>      }
> =20
> -    if (!SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
> -        spapr_irq_msi_reset(spapr);
> -    }
> -
>      /*
>       * NVLink2-connected GPU RAM needs to be placed on a separate NUMA n=
ode.
>       * We assign a new numa ID per GPU in spapr_pci_collect_nvgpu() whic=
h is
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index d07aed8ca9f9..c72d8433681d 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -57,11 +57,6 @@ void spapr_irq_msi_free(SpaprMachineState *spapr, int =
irq, uint32_t num)
>      bitmap_clear(spapr->irq_map, irq - SPAPR_IRQ_MSI, num);
>  }
> =20
> -void spapr_irq_msi_reset(SpaprMachineState *spapr)
> -{
> -    bitmap_clear(spapr->irq_map, 0, spapr->irq_map_nr);
> -}
> -
>  static void spapr_irq_init_kvm(SpaprMachineState *spapr,
>                                    SpaprIrq *irq, Error **errp)
>  {
> @@ -729,6 +724,8 @@ int spapr_irq_post_load(SpaprMachineState *spapr, int=
 version_id)
> =20
>  void spapr_irq_reset(SpaprMachineState *spapr, Error **errp)
>  {
> +    assert(bitmap_empty(spapr->irq_map, spapr->irq_map_nr));
> +
>      if (spapr->irq->reset) {
>          spapr->irq->reset(spapr, errp);
>      }
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index f965a58f8954..44fe4f9e0e2e 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -28,7 +28,6 @@ void spapr_irq_msi_init(SpaprMachineState *spapr, uint3=
2_t nr_msis);
>  int spapr_irq_msi_alloc(SpaprMachineState *spapr, uint32_t num, bool ali=
gn,
>                          Error **errp);
>  void spapr_irq_msi_free(SpaprMachineState *spapr, int irq, uint32_t num);
> -void spapr_irq_msi_reset(SpaprMachineState *spapr);
> =20
>  typedef struct SpaprIrq {
>      uint32_t    nr_irqs;
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/2994txjAzEdQwm5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl09ScwACgkQbDjKyiDZ
s5IwyhAAojE6bxNpbvJryvJ1JvLdxlFHwigUWsSzIMoxs/scWDOP66MF0b4BkbyI
IVe6S5NsXsMMTpeqFYn4lOoQoO1tfOk5e2vWOsyZ9G4ek3RFxrA8nfozi1RwHoJp
6yLzjJ2KG2FLtlrEKU/3BrlZ4zgz/Rj7J6p5/NjTNLI5Abwuh4SuJvpzO/d8bNYN
97YKor8X6OKrET4H4rSDfFi36MArxDcNMGK+W/oxNaKHB1sr9UD8KJVDCV50dG35
GGSByDRgeaWKfbcxaXw5eU9xE3j/TqncbWDy2bL/s9FgKppi1ptlVVVqNzuBOL7C
hhgjOyhL2k5E0Y3HthqBjGEltDfdH6KMB0J9lC3jkRccVW523gBPwusjKL0u6drr
MlqMk3FreAEvWt64IyXIwY6W8t8VfSMmLOubOgXmti40GryPIHx1KZSbFKEFZE7i
1BwAQMBIMmMpoOeS5HsnTzo5YxeHb683ctrnTDFDxNbhKzWP4VE0O2yQjceBSupu
0CduTtagfDkHZ3cRF1U0CxXHzFmXJAOy0+pfa4SCqoqQjQULm/ESIdz1mTFzzMbz
n+urAnenKDnT2Jpd2b/53B0+DplVfXpX3w4n2kglBb97fdm+NQp01aOXarve8JAI
BWd9ZbBaa1eFkJYetWVybj2d6O46SApFHgcuxj4vxZ0D/+oyqYc=
=KX/C
-----END PGP SIGNATURE-----

--/2994txjAzEdQwm5--

