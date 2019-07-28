Return-Path: <SRS0=P1lm=VZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2967EC433FF
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jul 2019 02:00:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE11D2070B
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jul 2019 02:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="huaXclX5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE11D2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hrYTg-0000aq-Vr
	for qemu-devel@archiver.kernel.org; Sat, 27 Jul 2019 22:00:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48661)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hrYT5-00087V-5Z
 for qemu-devel@nongnu.org; Sat, 27 Jul 2019 21:59:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hrYT4-0001wR-16
 for qemu-devel@nongnu.org; Sat, 27 Jul 2019 21:59:23 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:36699 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hrYT2-0001q7-Mq; Sat, 27 Jul 2019 21:59:21 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45x5bJ0pk9z9s8m; Sun, 28 Jul 2019 11:59:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1564279148;
 bh=dtBVm1x13rjPpLMTyoFm4QpOQYS1qzPjo57Pr1awLL8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=huaXclX5pl/hnj5L0sup+cBeCo/D58ia03BcmnExCWFF8hM5SFzZDyMRlY4/zpKqB
 fDLv7CLMUQi+XHMLbBxhy3taoJvw7pB27FPbx4o7bm3ebebqtM5uAwH09azFUj4tc9
 7ofEyPUXC2/5GlLk9px6AEt1E/FRbYMsinUj7ID8=
Date: Sun, 28 Jul 2019 11:54:44 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Message-ID: <20190728015444.GB5110@umbus>
References: <156415227297.1064338.9181963275184520284.stgit@bahia.lan>
 <156415227855.1064338.5657793835271464648.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ZoaI/ZTpAVc4A5k6"
Content-Disposition: inline
In-Reply-To: <156415227855.1064338.5657793835271464648.stgit@bahia.lan>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH 1/3] spapr/pci: Consolidate de-allocation
 of MSIs
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


--ZoaI/ZTpAVc4A5k6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2019 at 04:44:38PM +0200, Greg Kurz wrote:
> When freeing MSIs, we need to:
> - remove them from the machine's MSI bitmap
> - remove them from the IC backend
> - remove them from the PHB's MSI cache
>=20
> This is currently open coded in two places in rtas_ibm_change_msi(),
> and we're about to need this in spapr_phb_reset() as well. Instead of
> duplicating this code again, make it a destroy function for the PHB's
> MSI cache. Removing an MSI device from the cache will call the destroy
> function internally.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-4.2.

> ---
>  hw/ppc/spapr_pci.c |   24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 2d5697d119f4..bc22568bfa71 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -336,10 +336,6 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, Spa=
prMachineState *spapr,
>              return;
>          }
> =20
> -        if (!smc->legacy_irq_allocation) {
> -            spapr_irq_msi_free(spapr, msi->first_irq, msi->num);
> -        }
> -        spapr_irq_free(spapr, msi->first_irq, msi->num);
>          if (msi_present(pdev)) {
>              spapr_msi_setmsg(pdev, 0, false, 0, 0);
>          }
> @@ -409,10 +405,6 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, Spa=
prMachineState *spapr,
> =20
>      /* Release previous MSIs */
>      if (msi) {
> -        if (!smc->legacy_irq_allocation) {
> -            spapr_irq_msi_free(spapr, msi->first_irq, msi->num);
> -        }
> -        spapr_irq_free(spapr, msi->first_irq, msi->num);
>          g_hash_table_remove(phb->msi, &config_addr);
>      }
> =20
> @@ -1806,6 +1798,19 @@ static void spapr_phb_unrealize(DeviceState *dev, =
Error **errp)
>      memory_region_del_subregion(get_system_memory(), &sphb->mem32window);
>  }
> =20
> +static void spapr_phb_destroy_msi(gpointer opaque)
> +{
> +    SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> +    SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
> +    spapr_pci_msi *msi =3D opaque;
> +
> +    if (!smc->legacy_irq_allocation) {
> +        spapr_irq_msi_free(spapr, msi->first_irq, msi->num);
> +    }
> +    spapr_irq_free(spapr, msi->first_irq, msi->num);
> +    g_free(msi);
> +}
> +
>  static void spapr_phb_realize(DeviceState *dev, Error **errp)
>  {
>      /* We don't use SPAPR_MACHINE() in order to exit gracefully if the u=
ser
> @@ -2017,7 +2022,8 @@ static void spapr_phb_realize(DeviceState *dev, Err=
or **errp)
>                                      spapr_tce_get_iommu(tcet));
>      }
> =20
> -    sphb->msi =3D g_hash_table_new_full(g_int_hash, g_int_equal, g_free,=
 g_free);
> +    sphb->msi =3D g_hash_table_new_full(g_int_hash, g_int_equal, g_free,
> +                                      spapr_phb_destroy_msi);
>      return;
> =20
>  unrealize:
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ZoaI/ZTpAVc4A5k6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl09AGQACgkQbDjKyiDZ
s5KAdQ/9FXZCSM+TCaRnMJOL0F+QufBnqqzWuAQQgj94L9yaD2K1V/iUZlBNHSZ3
yuABjuIE1LjMKwe9lRvnTIqPdlDQoKpDiEvFT1gK7mz1hLdSAGaX2XAVLHb0MoCm
BtD/hZY0dqrZrWujZwcS/GLK3unlbfG+tEDVwCIGgiDexXInQLO1o1o5GcvfvXJG
1yrIQWmjOHHl9eeiN1JU3hgDEEL/qrYmlrGVU5Y3wVWG1acxwyzABSWgDfjdEBgo
dv3cXM/lFnA08boCo9QXGC1XqI/ERLoNm343OKjsk7VMqP8V/T8suV+fW02JRXii
MWfIe5klNBxUBkQcojnxSq9eH24MCqdQYCWcSso5VIDxYoQ4UZLDdNAG73ZKVYWa
29sAxYLmjmX/Tr3SR0oc96iA9c3Rcpv/ZK9SGlf609NdKvk2UeKOpXiPpPpe7nLl
cRstpPjbSA+jaDXEwMM1qhAfwZhxy89LRjxWtZqunETKzp6Y5qaWE6FOpjpBysQX
6lGNL7hgjEj1kkilW7X9fS8t4M9+r/Dsl2ofVrRakYkT++fiOIABsrS2mgS71bwt
FqQ1RG85q1G927zMB5QqncBEj+WPAyueld7V4q/6oLJtmcGdas9p5iUB1RoW2+gt
c5rLScHSwrdep054x7a8Zuk8ZOs4c8PmVJdgyTk2G3QEq77rlis=
=9PFT
-----END PGP SIGNATURE-----

--ZoaI/ZTpAVc4A5k6--

