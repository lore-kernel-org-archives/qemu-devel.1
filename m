Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADC0C7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 14:56:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 302842070B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 14:56:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 302842070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr1e1-0001QH-Dk
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 10:56:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41177)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hr1dq-0000oq-Un
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 10:56:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hr1dn-0006ig-6f
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 10:56:16 -0400
Received: from 3.mo69.mail-out.ovh.net ([188.165.52.203]:51324)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hr1dl-0006ds-02
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 10:56:13 -0400
Received: from player734.ha.ovh.net (unknown [10.109.159.35])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id AA18E634DB
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 16:56:08 +0200 (CEST)
Received: from kaod.org (bad36-1-78-202-132-1.fbx.proxad.net [78.202.132.1])
 (Authenticated sender: clg@kaod.org)
 by player734.ha.ovh.net (Postfix) with ESMTPSA id B39E784B28F5;
 Fri, 26 Jul 2019 14:56:02 +0000 (UTC)
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <156415227297.1064338.9181963275184520284.stgit@bahia.lan>
 <156415227855.1064338.5657793835271464648.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <35067e66-bb9e-3730-df0d-9b45ac5098da@kaod.org>
Date: Fri, 26 Jul 2019 16:56:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <156415227855.1064338.5657793835271464648.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 1479432481403341651
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrkeeggdekfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 188.165.52.203
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/07/2019 16:44, Greg Kurz wrote:
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

This looks good.



Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.


> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/ppc/spapr_pci.c |   24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 2d5697d119f4..bc22568bfa71 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -336,10 +336,6 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, S=
paprMachineState *spapr,
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
> @@ -409,10 +405,6 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, S=
paprMachineState *spapr,
> =20
>      /* Release previous MSIs */
>      if (msi) {
> -        if (!smc->legacy_irq_allocation) {
> -            spapr_irq_msi_free(spapr, msi->first_irq, msi->num);
> -        }
> -        spapr_irq_free(spapr, msi->first_irq, msi->num);
>          g_hash_table_remove(phb->msi, &config_addr);
>      }
>
> @@ -1806,6 +1798,19 @@ static void spapr_phb_unrealize(DeviceState *dev=
, Error **errp)
>      memory_region_del_subregion(get_system_memory(), &sphb->mem32windo=
w);
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
>      /* We don't use SPAPR_MACHINE() in order to exit gracefully if the=
 user
> @@ -2017,7 +2022,8 @@ static void spapr_phb_realize(DeviceState *dev, E=
rror **errp)
>                                      spapr_tce_get_iommu(tcet));
>      }
> =20
> -    sphb->msi =3D g_hash_table_new_full(g_int_hash, g_int_equal, g_fre=
e, g_free);
> +    sphb->msi =3D g_hash_table_new_full(g_int_hash, g_int_equal, g_fre=
e,
> +                                      spapr_phb_destroy_msi);
>      return;
> =20
>  unrealize:
>=20


