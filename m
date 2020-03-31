Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95789C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 03:24:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 548C620714
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 03:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="HSv6ChjF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 548C620714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJ7VZ-0005E7-HF
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 23:24:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58368)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jJ7Uo-0004CQ-RK
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 23:23:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jJ7Un-000778-8t
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 23:23:22 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:37051)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jJ7Um-00075z-1J; Mon, 30 Mar 2020 23:23:21 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48rvmM3ZCgz9sSJ; Tue, 31 Mar 2020 14:23:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1585624995;
 bh=0Dt+YnzPFdr0nYNaPNoPWKjudrcj02UBU8gQKmGvdXM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HSv6ChjFXqrAYU66mDSZ+UzyzeWum+sdMQB3lHDjmmi6uzOUidtgdAHnh3zTzXUzA
 KdAHLXsjnw1wN8a8ufjQvzPDVLO2m/liP5CuhTsvPMTvh2jTtsytvlFPsDoFBmbbh2
 +2jO1YSw7cO6iBaQNeqx6IIXnsM6nb8typAm0lEU=
Date: Tue, 31 Mar 2020 14:14:07 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH 2/5] ppc/pnv: Add support for NMI interface
Message-ID: <20200331031407.GH47772@umbus.fritz.box>
References: <20200325144147.221875-1-npiggin@gmail.com>
 <20200325144147.221875-3-npiggin@gmail.com>
 <0c4b70bf-2841-5693-1e1b-e9a0ad168232@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="54u2kuW9sGWg/X+X"
Content-Disposition: inline
In-Reply-To: <0c4b70bf-2841-5693-1e1b-e9a0ad168232@ozlabs.ru>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Greg Kurz <groug@kaod.org>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@fr.ibm.com>,
 Ganesh Goudar <ganeshgr@linux.ibm.com>, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--54u2kuW9sGWg/X+X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2020 at 02:07:42PM +1100, Alexey Kardashevskiy wrote:
>=20
>=20
> On 26/03/2020 01:41, Nicholas Piggin wrote:
> > This implements the NMI interface for the PNV machine, similarly to
> > commit 3431648272d ("spapr: Add support for new NMI interface") for
> > SPAPR.
> >=20
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >  hw/ppc/pnv.c | 30 +++++++++++++++++++++++++++++-
> >  1 file changed, 29 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> > index b75ad06390..671535ebe6 100644
> > --- a/hw/ppc/pnv.c
> > +++ b/hw/ppc/pnv.c
> > @@ -27,6 +27,7 @@
> >  #include "sysemu/runstate.h"
> >  #include "sysemu/cpus.h"
> >  #include "sysemu/device_tree.h"
> > +#include "sysemu/hw_accel.h"
> >  #include "target/ppc/cpu.h"
> >  #include "qemu/log.h"
> >  #include "hw/ppc/fdt.h"
> > @@ -34,6 +35,7 @@
> >  #include "hw/ppc/pnv.h"
> >  #include "hw/ppc/pnv_core.h"
> >  #include "hw/loader.h"
> > +#include "hw/nmi.h"
> >  #include "exec/address-spaces.h"
> >  #include "qapi/visitor.h"
> >  #include "monitor/monitor.h"
> > @@ -1955,10 +1957,35 @@ static void pnv_machine_set_hb(Object *obj, boo=
l value, Error **errp)
> >      }
> >  }
> > =20
> > +static void pnv_cpu_do_nmi_on_cpu(CPUState *cs, run_on_cpu_data arg)
> > +{
> > +    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> > +    CPUPPCState *env =3D &cpu->env;
> > +
> > +    cpu_synchronize_state(cs);
> > +    ppc_cpu_do_system_reset(cs);
> > +    /*
> > +     * SRR1[42:45] is set to 0100 which the ISA defines as implementat=
ion
> > +     * dependent. POWER processors use this for xscom triggered interr=
upts,
> > +     * which come from the BMC or NMI IPIs.
> > +     */
> > +    env->spr[SPR_SRR1] |=3D PPC_BIT(43);
> > +}
> > +
> > +static void pnv_nmi(NMIState *n, int cpu_index, Error **errp)
> > +{
> > +    CPUState *cs;
> > +
> > +    CPU_FOREACH(cs) {
> > +        async_run_on_cpu(cs, pnv_cpu_do_nmi_on_cpu, RUN_ON_CPU_NULL);
> > +    }
> > +}
> > +
> >  static void pnv_machine_class_init(ObjectClass *oc, void *data)
> >  {
> >      MachineClass *mc =3D MACHINE_CLASS(oc);
> >      InterruptStatsProviderClass *ispc =3D INTERRUPT_STATS_PROVIDER_CLA=
SS(oc);
> > +    NMIClass *nc =3D NMI_CLASS(oc);
> > =20
> >      mc->desc =3D "IBM PowerNV (Non-Virtualized)";
> >      mc->init =3D pnv_init;
> > @@ -1975,6 +2002,7 @@ static void pnv_machine_class_init(ObjectClass *o=
c, void *data)
> >      mc->default_ram_size =3D INITRD_LOAD_ADDR + INITRD_MAX_SIZE;
> >      mc->default_ram_id =3D "pnv.ram";
> >      ispc->print_info =3D pnv_pic_print_info;
> > +    nc->nmi_monitor_handler =3D pnv_nmi;
> > =20
> >      object_class_property_add_bool(oc, "hb-mode",
> >                                     pnv_machine_get_hb, pnv_machine_set=
_hb,
> > @@ -2038,7 +2066,7 @@ static const TypeInfo types[] =3D {
> >          .class_size    =3D sizeof(PnvMachineClass),
> >          .interfaces =3D (InterfaceInfo[]) {
> >              { TYPE_INTERRUPT_STATS_PROVIDER },
> > -            { },
> > +            { TYPE_NMI },
>=20
>=20
> The interface list must end with {}, otherwise QEMU crashes very early.
> Thanks,

I've fixed that inline now.

>=20
>=20
> >          },
> >      },
> >      {
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--54u2kuW9sGWg/X+X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl6CtXwACgkQbDjKyiDZ
s5I11A//ayqHN/X4cbDmEo1ttsJtYghuKSv1+4m9N9AaUK/7asTd1BGblD8KKgjG
Gus8JiSqhLYr9PcxUHcUDmnxi+yVCSjyFJVdlGPR+fZDVOQ+zm/9v7Loo4Tg8PIA
uADcEWDJLxQDDkYjWl9SDA454UKhFZrd92eX4g3R2MCesCa/wErm/BOa8aA6olDP
bn7BIeQLZoe2w9hDXwS+U2jSDKsaA9pb6hFYQqsb7KrkwHq//fmO2+StpMf12/uI
EdgEROlsVHvTHGXHtVJ8wWu/6cigaeqBOH3QA9+/mJwOVyMSFAjNIE8pT2Xkm+BT
0rf77rAgE6RCikDUdfG21g4yMsMlBO+a8/XSy/be8M8oWlu2CF7WB6xZsDrclwfU
c+fj574X5ayp29zYTwpao85GkCLclLNPTimtK4WHwdAxzNwaTp6g6/h/JkXDMRYx
G9RYn/v6wiMD1Mvcwklhf7Iv3vI/xLesM01INusOucBTKy1+RBa+2nuHWSUjILEj
6mIPuQTs5eVZ6GziNagYaOOHf2wjpK7mzNEwFW2HncmZmccjoxZWU8HTQyErmocm
jWh+v2T5ec4YqEgnNskcfKQ3kxgAXH/Cin22X8BcLaDoNfjq6sYqEYbWLJuCksgz
f849vD4uQA26mbr8vyRN9MbzoBno7ZekH89PjpKj9c4PhLrXklo=
=EcPT
-----END PGP SIGNATURE-----

--54u2kuW9sGWg/X+X--

