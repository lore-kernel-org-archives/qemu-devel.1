Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B71C3A5A3
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 02:51:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CD262173E
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 02:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="I4nZqY06"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CD262173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2o3L-0006s7-9E
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 22:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43696)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i2o1i-0005D1-GU
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 22:49:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i2o1g-00073k-TO
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 22:49:38 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:49047 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i2o1f-0006zu-Qv; Tue, 27 Aug 2019 22:49:36 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46J9F46CqGz9sN1; Wed, 28 Aug 2019 12:49:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1566960568;
 bh=Emtooiixdw1t7rbxZ4x7gCqG29c6USuiuN7z6/rlvUo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=I4nZqY06Apr3fsXUoJlxt4iQ/GqbT8/u2z+VTTZu8bWF7RQIqWrCzyUvaGuWRHR8l
 yNqWeDq1RMvobgZB2Xy6w3QJ5tU41PpYr67PBkWpqavox70Ndop0fTWtNbEOlSeXWe
 0az/zyvyqx1gXpQeXT5QqfFZsN47wqCxEyzs7LQ4=
Date: Wed, 28 Aug 2019 12:47:04 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <20190828024704.GE16825@umbus.fritz.box>
References: <20190719043734.108462-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="bi5JUZtvcfApsciF"
Content-Disposition: inline
In-Reply-To: <20190719043734.108462-1-aik@ozlabs.ru>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH qemu v3] spapr_pci: Advertise BAR
 reallocation capability
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--bi5JUZtvcfApsciF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2019 at 02:37:34PM +1000, Alexey Kardashevskiy wrote:
> The pseries guests do not normally allocate PCI resources and rely on
> the system firmware doing so. Furthermore at least at some point in
> the past the pseries guests won't even allowed to change BARs, probably
> it is still the case for phyp. So since the initial commit we have [1]
> which prevents resource reallocation.
>=20
> This is not a problem until we want specific BAR alignments, for example,
> PAGE_SIZE=3D=3D64k to make sure we can still map MMIO BARs directly. For
> the boot time devices we handle this in SLOF [2] but since QEMU's RTAS
> does not allocate BARs, the guest does this instead and does not align
> BARs even if Linux is given pci=3Dresource_alignment=3D16@pci:0:0 as
> PCI_PROBE_ONLY makes Linux ignore alignment requests.
>=20
> ARM folks added a dial to control PCI_PROBE_ONLY via the device tree [3].
> This makes use of the dial to advertise to the guest that we can handle
> BAR reassignments. This limits the change to the latest pseries machine
> to avoid old guests explosion.
>=20
> We do not remove the flag from [1] as pseries guests are still supported
> under phyp so having that removed may cause problems.
>=20
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/arch/powerpc/platforms/pseries/setup.c?h=3Dv5.1#n773
> [2] https://git.qemu.org/?p=3DSLOF.git;a=3Dblob;f=3Dboard-qemu/slof/pci-p=
hb.fs;h=3D06729bcf77a0d4e900c527adcd9befe2a269f65d;hb=3DHEAD#l338
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3Df81c11af
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Applied to ppc-for-4.2, thanks.

> ---
> Changes:
> v3:
> * moved the default setting to spapr_machine_class_init()
>=20
> v2:
> * limited the change by a machine version
> ---
>  include/hw/ppc/spapr.h | 1 +
>  hw/ppc/spapr.c         | 9 +++++++++
>  2 files changed, 10 insertions(+)
>=20
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index c79bc6a1232b..ebbd92673b34 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -121,6 +121,7 @@ struct SpaprMachineClass {
>      bool legacy_irq_allocation;
>      bool broken_host_serial_model; /* present real host info to the gues=
t */
>      bool pre_4_1_migration; /* don't migrate hpt-max-page-size */
> +    bool linux_pci_probe;
> =20
>      void (*phb_placement)(SpaprMachineState *spapr, uint32_t index,
>                            uint64_t *buid, hwaddr *pio,=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 2ee671e55e0c..4bff0cf90d4b 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1164,6 +1164,7 @@ static void spapr_dt_ov5_platform_support(SpaprMach=
ineState *spapr, void *fdt,
>  static void spapr_dt_chosen(SpaprMachineState *spapr, void *fdt)
>  {
>      MachineState *machine =3D MACHINE(spapr);
> +    SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(machine);
>      int chosen;
>      const char *boot_device =3D machine->boot_order;
>      char *stdout_path =3D spapr_vio_stdout_path(spapr->vio_bus);
> @@ -1221,6 +1222,11 @@ static void spapr_dt_chosen(SpaprMachineState *spa=
pr, void *fdt)
>          _FDT(fdt_setprop_string(fdt, chosen, "stdout-path", stdout_path)=
);
>      }
> =20
> +    /* We can deal with BAR reallocation just fine, advertise it to the =
guest */
> +    if (smc->linux_pci_probe) {
> +        _FDT(fdt_setprop_cell(fdt, chosen, "linux,pci-probe-only", 0));
> +    }
> +
>      spapr_dt_ov5_platform_support(spapr, fdt, chosen);
> =20
>      g_free(stdout_path);
> @@ -4467,6 +4473,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
>      spapr_caps_add_properties(smc, &error_abort);
>      smc->irq =3D &spapr_irq_dual;
>      smc->dr_phb_enabled =3D true;
> +    smc->linux_pci_probe =3D true;
>  }
> =20
>  static const TypeInfo spapr_machine_info =3D {
> @@ -4526,12 +4533,14 @@ DEFINE_SPAPR_MACHINE(4_2, "4.2", true);
>   */
>  static void spapr_machine_4_1_class_options(MachineClass *mc)
>  {
> +    SpaprMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
>      static GlobalProperty compat[] =3D {
>          /* Only allow 4kiB and 64kiB IOMMU pagesizes */
>          { TYPE_SPAPR_PCI_HOST_BRIDGE, "pgsz", "0x11000" },
>      };
> =20
>      spapr_machine_4_2_class_options(mc);
> +    smc->linux_pci_probe =3D false;
>      compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--bi5JUZtvcfApsciF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1l6yUACgkQbDjKyiDZ
s5IIlxAA250uUySnywnGvuauV8T11aYL0EpgvMtTclu/v4MC8QaOV2e8y6Qo/D/l
zBjzTTjLDFDZ0nL3KgJE+s0t/NYbKBHk2T8x/gcD86+B+HBW2uA/R0HVsnP7LEB6
CJY2TswdqGIK8CsoL0lIVR+M7/zk845sS8sAm0+M220p5FiIumBifMc7uy2n9Vgu
GKdFw6mAZD1fnwJQKCD7xAbPZEYpgHjNYdkMdKdrpE5FgLvTyFSRrWD3E9BPnZUL
xQNCO+8HdQbfFK+CGkRD338fUKztG4RU4cujTnncxeyn05L3HQMHFGZbxRxTstF/
5ocB/uEU3z2++9tgrKrFLCFyPhGS/8PhhkEmYb2yI/mB2eQ5bVfFf0Tvb7nfss+X
pcJuyZ9EONhhHnSKXk+NG/eEaAwyPY3AbFCMfI9FAhIeHFQcmt8HRLys5saan8cK
QorCpd6tAlIW5MDHAawVqA+UXmZWGAcAMtPpCGFVYVvSItn3VENAKLhxY1J6OpU/
ZizckFXsVc7yc68R/4BY3jG0V5p8hkSz1wu7kNWqceyNTyVmL47/T37oAwlzNvld
UwWRbIk6lUjEuSAWNJz6r7XJpk2WKdOBMIwaIlKyo8GoyDPQ061TX20tFuZuCFws
thDUstu2Rbu/ENThU59XkNRFq9U8fzosoDnd0ZCx8Ma1OLPv4lI=
=IVOE
-----END PGP SIGNATURE-----

--bi5JUZtvcfApsciF--

