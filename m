Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC517C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 08:51:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7768721774
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 08:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="kl0Cjf5p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7768721774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibhQW-0000Ku-Jt
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 03:51:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48999)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ibhPB-0007Ia-TP
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 03:50:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ibhP6-00008p-8k
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 03:50:05 -0500
Received: from ozlabs.org ([203.11.71.1]:40539)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ibhP5-000070-9R; Mon, 02 Dec 2019 03:50:00 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47RJhf1Rs4z9sPJ; Mon,  2 Dec 2019 19:49:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1575276594;
 bh=+BxqYyPKrJzPOeYJ40TpuMyQmzM71R2L8yeX5gZNzmA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kl0Cjf5pK/Ocks2SKHQDlWZ5PjOSUJoYoC51jRLiORTZEkeG7T+sb0/I7CsCubgeh
 LzmLlCbOio1gE6kiXlsKUbIXuV63IpaH3PCLQ4WLtWvcErgI7VxjpRJp594mT4Pb6m
 2cVOf6DCsaltE4u3AdUpQ+DIp1yteOxVKHaqS9O8=
Date: Mon, 2 Dec 2019 19:40:13 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [for-5.0 3/4] spapr: Fold h_cas_compose_response() into
 h_client_architecture_support()
Message-ID: <20191202084013.GC37909@umbus.fritz.box>
References: <20191129053356.232413-1-david@gibson.dropbear.id.au>
 <20191129053356.232413-4-david@gibson.dropbear.id.au>
 <20191202092335.5f474f06@bahia.w3ibm.bluemix.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ZwgA9U+XZDXt4+m+"
Content-Disposition: inline
In-Reply-To: <20191202092335.5f474f06@bahia.w3ibm.bluemix.net>
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
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 clg@kaod.org, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--ZwgA9U+XZDXt4+m+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 02, 2019 at 09:23:35AM +0100, Greg Kurz wrote:
> On Fri, 29 Nov 2019 16:33:55 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > spapr_h_cas_compose_response() handles the last piece of the PAPR featu=
re
> > negotiation process invoked via the ibm,client-architecture-support OF
> > call.  Its only caller is h_client_architecture_support() which handles
> > most of the rest of that process.
> >=20
> > I believe it was place in a separate file originally to handle some fid=
dly
>=20
> it was placed

fixed, thanks.

>=20
> > dependencies between functions, but mostly it's just confusing to have
> > the CAS process split into two pieces like this.  Now that compose resp=
onse
> > is simplified (by just generating the whole device tree anew), it's cle=
aner
> > to just fold it into h_client_architecture_support().
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
>=20
> Reviewed-by: Greg Kurz <groug@kaod.org>
>=20
> >  hw/ppc/spapr.c         | 61 +-----------------------------------------
> >  hw/ppc/spapr_hcall.c   | 55 ++++++++++++++++++++++++++++++++++---
> >  include/hw/ppc/spapr.h |  4 +--
> >  3 files changed, 54 insertions(+), 66 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index d34e317f48..5187f5b0a5 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -76,7 +76,6 @@
> >  #include "hw/nmi.h"
> >  #include "hw/intc/intc.h"
> > =20
> > -#include "qemu/cutils.h"
> >  #include "hw/ppc/spapr_cpu_core.h"
> >  #include "hw/mem/memory-device.h"
> >  #include "hw/ppc/spapr_tpm_proxy.h"
> > @@ -897,63 +896,6 @@ out:
> >      return ret;
> >  }
> > =20
> > -static bool spapr_hotplugged_dev_before_cas(void)
> > -{
> > -    Object *drc_container, *obj;
> > -    ObjectProperty *prop;
> > -    ObjectPropertyIterator iter;
> > -
> > -    drc_container =3D container_get(object_get_root(), "/dr-connector"=
);
> > -    object_property_iter_init(&iter, drc_container);
> > -    while ((prop =3D object_property_iter_next(&iter))) {
> > -        if (!strstart(prop->type, "link<", NULL)) {
> > -            continue;
> > -        }
> > -        obj =3D object_property_get_link(drc_container, prop->name, NU=
LL);
> > -        if (spapr_drc_needed(obj)) {
> > -            return true;
> > -        }
> > -    }
> > -    return false;
> > -}
> > -
> > -static void *spapr_build_fdt(SpaprMachineState *spapr, bool reset,
> > -                             size_t space);
> > -
> > -int spapr_h_cas_compose_response(SpaprMachineState *spapr,
> > -                                 target_ulong addr, target_ulong size,
> > -                                 SpaprOptionVector *ov5_updates)
> > -{
> > -    void *fdt;
> > -    SpaprDeviceTreeUpdateHeader hdr =3D { .version_id =3D 1 };
> > -
> > -    if (spapr_hotplugged_dev_before_cas()) {
> > -        return 1;
> > -    }
> > -
> > -    if (size < sizeof(hdr)) {
> > -        error_report("SLOF provided insufficient CAS buffer "
> > -                     TARGET_FMT_lu " (min: %zu)", size, sizeof(hdr));
> > -        exit(EXIT_FAILURE);
> > -    }
> > -
> > -    size -=3D sizeof(hdr);
> > -
> > -    fdt =3D spapr_build_fdt(spapr, false, size);
> > -    _FDT((fdt_pack(fdt)));
> > -
> > -    cpu_physical_memory_write(addr, &hdr, sizeof(hdr));
> > -    cpu_physical_memory_write(addr + sizeof(hdr), fdt, fdt_totalsize(f=
dt));
> > -    trace_spapr_cas_continue(fdt_totalsize(fdt) + sizeof(hdr));
> > -
> > -    g_free(spapr->fdt_blob);
> > -    spapr->fdt_size =3D fdt_totalsize(fdt);
> > -    spapr->fdt_initial_size =3D spapr->fdt_size;
> > -    spapr->fdt_blob =3D fdt;
> > -
> > -    return 0;
> > -}
> > -
> >  static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
> >  {
> >      MachineState *ms =3D MACHINE(spapr);
> > @@ -1191,8 +1133,7 @@ static void spapr_dt_hypervisor(SpaprMachineState=
 *spapr, void *fdt)
> >      }
> >  }
> > =20
> > -static void *spapr_build_fdt(SpaprMachineState *spapr, bool reset,
> > -                             size_t space)
> > +void *spapr_build_fdt(SpaprMachineState *spapr, bool reset, size_t spa=
ce)
> >  {
> >      MachineState *machine =3D MACHINE(spapr);
> >      MachineClass *mc =3D MACHINE_GET_CLASS(machine);
> > diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> > index 05a7ca275b..0f19be794c 100644
> > --- a/hw/ppc/spapr_hcall.c
> > +++ b/hw/ppc/spapr_hcall.c
> > @@ -1,4 +1,5 @@
> >  #include "qemu/osdep.h"
> > +#include "qemu/cutils.h"
> >  #include "qapi/error.h"
> >  #include "sysemu/hw_accel.h"
> >  #include "sysemu/runstate.h"
> > @@ -15,6 +16,7 @@
> >  #include "cpu-models.h"
> >  #include "trace.h"
> >  #include "kvm_ppc.h"
> > +#include "hw/ppc/fdt.h"
> >  #include "hw/ppc/spapr_ovec.h"
> >  #include "mmu-book3s-v3.h"
> >  #include "hw/mem/memory-device.h"
> > @@ -1638,6 +1640,26 @@ static uint32_t cas_check_pvr(SpaprMachineState =
*spapr, PowerPCCPU *cpu,
> >      return best_compat;
> >  }
> > =20
> > +static bool spapr_hotplugged_dev_before_cas(void)
> > +{
> > +    Object *drc_container, *obj;
> > +    ObjectProperty *prop;
> > +    ObjectPropertyIterator iter;
> > +
> > +    drc_container =3D container_get(object_get_root(), "/dr-connector"=
);
> > +    object_property_iter_init(&iter, drc_container);
> > +    while ((prop =3D object_property_iter_next(&iter))) {
> > +        if (!strstart(prop->type, "link<", NULL)) {
> > +            continue;
> > +        }
> > +        obj =3D object_property_get_link(drc_container, prop->name, NU=
LL);
> > +        if (spapr_drc_needed(obj)) {
> > +            return true;
> > +        }
> > +    }
> > +    return false;
> > +}
> > +
> >  static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
> >                                                    SpaprMachineState *s=
papr,
> >                                                    target_ulong opcode,
> > @@ -1645,6 +1667,8 @@ static target_ulong h_client_architecture_support=
(PowerPCCPU *cpu,
> >  {
> >      /* Working address in data buffer */
> >      target_ulong addr =3D ppc64_phys_to_real(args[0]);
> > +    target_ulong fdt_buf =3D args[1];
> > +    target_ulong fdt_bufsize =3D args[2];
> >      target_ulong ov_table;
> >      uint32_t cas_pvr;
> >      SpaprOptionVector *ov1_guest, *ov5_guest, *ov5_cas_old, *ov5_updat=
es;
> > @@ -1788,16 +1812,41 @@ static target_ulong h_client_architecture_suppo=
rt(PowerPCCPU *cpu,
> > =20
> >      spapr_irq_update_active_intc(spapr);
> > =20
> > +    if (spapr_hotplugged_dev_before_cas()) {
> > +        spapr->cas_reboot =3D true;
> > +    }
> > +
> >      if (!spapr->cas_reboot) {
> > +        void *fdt;
> > +        SpaprDeviceTreeUpdateHeader hdr =3D { .version_id =3D 1 };
> > +
> >          /* If spapr_machine_reset() did not set up a HPT but one is ne=
cessary
> >           * (because the guest isn't going to use radix) then set it up=
 here. */
> >          if ((spapr->patb_entry & PATE1_GR) && !guest_radix) {
> >              /* legacy hash or new hash: */
> >              spapr_setup_hpt_and_vrma(spapr);
> >          }
> > -        spapr->cas_reboot =3D
> > -            (spapr_h_cas_compose_response(spapr, args[1], args[2],
> > -                                          ov5_updates) !=3D 0);
> > +
> > +        if (fdt_bufsize < sizeof(hdr)) {
> > +            error_report("SLOF provided insufficient CAS buffer "
> > +                         TARGET_FMT_lu " (min: %zu)", fdt_bufsize, siz=
eof(hdr));
> > +            exit(EXIT_FAILURE);
> > +        }
> > +
> > +        fdt_bufsize -=3D sizeof(hdr);
> > +
> > +        fdt =3D spapr_build_fdt(spapr, false, fdt_bufsize);
> > +        _FDT((fdt_pack(fdt)));
> > +
> > +        cpu_physical_memory_write(fdt_buf, &hdr, sizeof(hdr));
> > +        cpu_physical_memory_write(fdt_buf + sizeof(hdr), fdt,
> > +                                  fdt_totalsize(fdt));
> > +        trace_spapr_cas_continue(fdt_totalsize(fdt) + sizeof(hdr));
> > +
> > +        g_free(spapr->fdt_blob);
> > +        spapr->fdt_size =3D fdt_totalsize(fdt);
> > +        spapr->fdt_initial_size =3D spapr->fdt_size;
> > +        spapr->fdt_blob =3D fdt;
> >      }
> > =20
> >      spapr_ovec_cleanup(ov5_updates);
> > diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> > index d5ab5ea7b2..61f005c6f6 100644
> > --- a/include/hw/ppc/spapr.h
> > +++ b/include/hw/ppc/spapr.h
> > @@ -766,11 +766,9 @@ struct SpaprEventLogEntry {
> >      QTAILQ_ENTRY(SpaprEventLogEntry) next;
> >  };
> > =20
> > +void *spapr_build_fdt(SpaprMachineState *spapr, bool reset, size_t spa=
ce);
> >  void spapr_events_init(SpaprMachineState *sm);
> >  void spapr_dt_events(SpaprMachineState *sm, void *fdt);
> > -int spapr_h_cas_compose_response(SpaprMachineState *sm,
> > -                                 target_ulong addr, target_ulong size,
> > -                                 SpaprOptionVector *ov5_updates);
> >  void close_htab_fd(SpaprMachineState *spapr);
> >  void spapr_setup_hpt_and_vrma(SpaprMachineState *spapr);
> >  void spapr_free_hpt(SpaprMachineState *spapr);
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ZwgA9U+XZDXt4+m+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3kzesACgkQbDjKyiDZ
s5LIIxAAvRAOrKKFOOcpFXXkrmaeGkzbluLbXr/POqLgREIR9HCx0FZAjZj3NEHR
88TnErjcSUQy6IWSPoM5VKgbbCw9Iv1pkuTGifOY6XEXFPJCx4pmvjSgHxBbir7S
6r05ewui5J90W6XRODEgUAHuczKDOii+wMxfX/XvQ+49IWwKKpH4+yIAGwS7tHUS
8caGE2acvWVMub2ycFZRhZDBKVFv9jBGpzi3bnhyzspMufPsmc0gjRNFd/UJL2dj
mLAiinYRXNXUpyeWYhFF4EDvhM+PKODt7t+G7Hc8qzAAGwP0ktfzmzokg6/+qatN
9tvWUThGPICZQRfuarb+Tr/svxd26uEMkiZH8H6+XtteiM2TvRsuCcI6R3glAn/w
Hk5g7RuyJ+6HssG55crGHey17hjOPvpMPFqvDhDeA4J1F+uxRQ9xH/+M5W8vzDEZ
Yw2vPVcAQfjXrl9GEDe6SNCFojVs/yL9sLa9WP2iPT543BIDSp5PMICfDcRZfsGy
bgc+ZkGhAUa5424YrRN0O03n9YzJhzM7VOfwZfl0cE7n3VFtxZfb9DRgj6zJU5aH
yFQZ4xMhjsqfp2/Qcvy3izr/BbKUT5WnM2Edzjcu1BHw8nHkn1gL6uEA8B/hMBMn
NK0NMvMs9wqv8TV0cjqddX/gpt0Dm9TR0peTrnBepQrD3vRn+us=
=h5De
-----END PGP SIGNATURE-----

--ZwgA9U+XZDXt4+m+--

