Return-Path: <SRS0=P1lm=VZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DACFC7618B
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jul 2019 06:14:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6084B2077C
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jul 2019 06:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="cnl4D9fh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6084B2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hrcSQ-00018w-Gv
	for qemu-devel@archiver.kernel.org; Sun, 28 Jul 2019 02:14:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37849)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hrcS0-0000e1-3z
 for qemu-devel@nongnu.org; Sun, 28 Jul 2019 02:14:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hrcRy-0006d9-JA
 for qemu-devel@nongnu.org; Sun, 28 Jul 2019 02:14:32 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:48137 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hrcRx-0006an-AG; Sun, 28 Jul 2019 02:14:30 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45xCFs12nhz9sBF; Sun, 28 Jul 2019 16:14:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1564294465;
 bh=/0eHd3rqryk6xnyZlhUiQEWZdl2/Xis1OXbeWnDTJnc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cnl4D9fhhJbWZWBacjEHtqq5k1wYaz9i+JeruRjklQinT1145CG/EThewiT7dLuBt
 yEuSjqD7EoIyfLCEk2Hn3zrS9rTDxuNMt1BC4ot0yekYWx4oh1Nf67NXZcaSzNHmPy
 VNbz4KAVwNxHzTA3jMY32BMHNJT0BhPzLwGR0BTg=
Date: Sun, 28 Jul 2019 16:09:55 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <20190728060955.GC5110@umbus>
References: <20190720012850.14369-1-aik@ozlabs.ru>
 <20190720012850.14369-5-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="xo44VMWPx7vlQ2+2"
Content-Disposition: inline
In-Reply-To: <20190720012850.14369-5-aik@ozlabs.ru>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH qemu RFC 4/4] spapr: Implement SLOF-less
 client_architecture_support
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
Cc: Paul Mackerras <paulus@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--xo44VMWPx7vlQ2+2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 20, 2019 at 11:28:50AM +1000, Alexey Kardashevskiy wrote:
> QEMU already implements H_CAS called by SLOF. The existing handler
> prepares a diff FDT and SLOF applies it on top of its current tree.
> In SLOF-less setup when the user explicitly selected "bios=3Dno",
> this updates the FDT from the OS, updates it and writes back to the OS.
> The new behavior is advertised to the OS via "/chosen/qemu,h_cas".

I don't love having two different paths here, I'm wondering if we can
unify things at all.

I have wondered at some points if there's anything preventing us just
giving a whole new device tree at CAS, rather than selected updates -
that could simplify several things.

> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  include/hw/ppc/spapr.h |  5 +++++
>  hw/ppc/spapr.c         | 24 ++++++++++++++++-----
>  hw/ppc/spapr_hcall.c   | 49 +++++++++++++++++++++++++++++++++++++++---
>  3 files changed, 70 insertions(+), 8 deletions(-)
>=20
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 7f5d7a70d27e..73cd9cf25b83 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -766,9 +766,14 @@ struct SpaprEventLogEntry {
> =20
>  void spapr_events_init(SpaprMachineState *sm);
>  void spapr_dt_events(SpaprMachineState *sm, void *fdt);
> +int spapr_h_cas_do_compose_response(SpaprMachineState *spapr, void *fdt,
> +                                    SpaprOptionVector *ov5_updates);
>  int spapr_h_cas_compose_response(SpaprMachineState *sm,
>                                   target_ulong addr, target_ulong size,
>                                   SpaprOptionVector *ov5_updates);
> +#define FDT_MAX_SIZE 0x100000
> +void *spapr_build_fdt(SpaprMachineState *spapr);
> +
>  void close_htab_fd(SpaprMachineState *spapr);
>  void spapr_setup_hpt_and_vrma(SpaprMachineState *spapr);
>  void spapr_free_hpt(SpaprMachineState *spapr);
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index b097a99951f1..f84895f4a8b4 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -978,6 +978,19 @@ static bool spapr_hotplugged_dev_before_cas(void)
>      return false;
>  }
> =20
> +int spapr_h_cas_do_compose_response(SpaprMachineState *spapr, void *fdt,
> +                                    SpaprOptionVector *ov5_updates)

Not a great function name.

> +{
> +    /* Fixup cpu nodes */
> +    _FDT((spapr_fixup_cpu_dt(fdt, spapr)));
> +
> +    if (spapr_dt_cas_updates(spapr, fdt, ov5_updates)) {
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
>  int spapr_h_cas_compose_response(SpaprMachineState *spapr,
>                                   target_ulong addr, target_ulong size,
>                                   SpaprOptionVector *ov5_updates)
> @@ -1009,10 +1022,7 @@ int spapr_h_cas_compose_response(SpaprMachineState=
 *spapr,
>      _FDT((fdt_open_into(fdt_skel, fdt, size)));
>      g_free(fdt_skel);
> =20
> -    /* Fixup cpu nodes */
> -    _FDT((spapr_fixup_cpu_dt(fdt, spapr)));
> -
> -    if (spapr_dt_cas_updates(spapr, fdt, ov5_updates)) {
> +    if (spapr_h_cas_do_compose_response(spapr, fdt, ov5_updates)) {
>          return -1;
>      }
> =20
> @@ -1232,6 +1242,10 @@ static void spapr_dt_chosen(SpaprMachineState *spa=
pr, void *fdt)
> =20
>      /* We always implemented RTAS as hcall, tell guests to call it direc=
tly */
>      _FDT(fdt_setprop_cell(fdt, chosen, "qemu,h_rtas", 1));
> +    /* Tell the guest that H_CAS will return the entire FDT now, not the=
 diff */
> +    if (!spapr->bios_enabled) {
> +        _FDT(fdt_setprop_cell(fdt, chosen, "qemu,h_cas", 1));

As with H_RTAS< using qemu,hypertas-functions would be more
appropriate for this.

> +    }
> =20
>      spapr_dt_ov5_platform_support(spapr, fdt, chosen);
> =20
> @@ -1262,7 +1276,7 @@ static void spapr_dt_hypervisor(SpaprMachineState *=
spapr, void *fdt)
>      }
>  }
> =20
> -static void *spapr_build_fdt(SpaprMachineState *spapr)
> +void *spapr_build_fdt(SpaprMachineState *spapr)
>  {
>      MachineState *machine =3D MACHINE(spapr);
>      MachineClass *mc =3D MACHINE_GET_CLASS(machine);
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index b964d94f330b..c5cb06c9d507 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -17,6 +17,7 @@
>  #include "hw/ppc/spapr_ovec.h"
>  #include "mmu-book3s-v3.h"
>  #include "hw/mem/memory-device.h"
> +#include "sysemu/device_tree.h"
> =20
>  static bool has_spr(PowerPCCPU *cpu, int spr)
>  {
> @@ -1774,9 +1775,51 @@ static target_ulong h_client_architecture_support(=
PowerPCCPU *cpu,
>              /* legacy hash or new hash: */
>              spapr_setup_hpt_and_vrma(spapr);
>          }
> -        spapr->cas_reboot =3D
> -            (spapr_h_cas_compose_response(spapr, args[1], args[2],
> -                                          ov5_updates) !=3D 0);
> +
> +        if (spapr->bios_enabled) {
> +            spapr->cas_reboot =3D
> +                (spapr_h_cas_compose_response(spapr, args[1], args[2],
> +                                              ov5_updates) !=3D 0);
> +        } else {
> +            int size;
> +            void *fdt, *fdt_skel;
> +            struct fdt_header hdr =3D { 0 };
> +
> +            cpu_physical_memory_read(args[1], &hdr, sizeof(hdr));
> +            size =3D fdt32_to_cpu(hdr.totalsize);
> +            if (size > FDT_MAX_SIZE) {
> +                return H_NOT_AVAILABLE;
> +            }
> +
> +            fdt_skel =3D g_malloc0(size);
> +            cpu_physical_memory_read(args[1], fdt_skel, size);
> +
> +            fdt =3D g_malloc0(FDT_MAX_SIZE);
> +            fdt_open_into(fdt_skel, fdt, FDT_MAX_SIZE);
> +            g_free(fdt_skel);

fdt_open_into() explicitly permits using the same buffer for both
arguments, so you don't need two allocations here - you can just
allocate FDT_MAX_SIZE, read it in, then fdt_open_into() in place.

You probably should check for errors from fdt_open_into(), though.

> +
> +            if (spapr_h_cas_do_compose_response(spapr, fdt, ov5_updates)=
) {
> +                g_free(fdt);
> +                return H_NOT_AVAILABLE;
> +            }
> +            fdt_pack(fdt);
> +            if (fdt_totalsize(fdt) > FDT_MAX_SIZE) {

This can't actually happen - you only ever allocated a buffer of size
FDT_MAX_SIZE, so if the DT was going to exceed that you would have hit
FDT_ERR_NOSPACE in an earlier step.

> +                error_report("FDT too big ! 0x%x bytes (max is 0x%x)",
> +                             fdt_totalsize(fdt), FDT_MAX_SIZE);
> +                g_free(fdt);
> +                return H_NOT_AVAILABLE;
> +            }
> +
> +            /* Load the fdt */
> +            cpu_physical_memory_write(args[1], fdt, fdt_totalsize(fdt));
> +
> +            g_free(spapr->fdt_blob);
> +            spapr->fdt_size =3D fdt_totalsize(fdt);
> +            spapr->fdt_initial_size =3D spapr->fdt_size;
> +            spapr->fdt_blob =3D fdt;
> +
> +            qemu_fdt_dumpdtb(fdt, fdt_totalsize(fdt));
> +        }
>      }
> =20
>      /*

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--xo44VMWPx7vlQ2+2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl09PDEACgkQbDjKyiDZ
s5KIWA//RO7Xq2RfSLo+lAXgs4MxcV4gyryUCdmuI5DjekpSTCuGxsbE214/Zb/a
C9kkdst8H/NFWHJ6HDGR/3bpKUIFePH65RCYJGjR3YdoPFe7OvSzl7WhdeIFPEiT
HfSxmibAknVPm3MGaPGItX3GTmUgdQnfKytosqdE7AMhGGklinJTuodgyY4TxFBh
mfImo9DA34lnDZfWuPR+FA9k0FG9w8H8dYNA8f4Lc0VWDvxBabmTl3VqXjWWyD+4
/niMFTpqUfYqeU48O4BXaEqyByEmOPlbRQuqY0b5f8P9VeLmRSGhn1QHzqsTqPJU
MkgJ7f0vO4lL1MpUKeg38XOOmMFulANR/T+cfW3EM7jDfoxyCOh/B2T+l73FDcHr
Akf1FYkhwPBc1K069aJDYnFfhAaAknA5fB0GAybY6e4uPSsuDSdqIzOnqN0MQSB4
DcUEezuCmnNQ0muQQSYkwoGMlKHvbaK2EvnljsyP8ul+LU9fbKWFo7/osjc0VtbX
rY/Tp+Vyg8745BhbUV2Ua5Doscl7yzuxPQ78YJ+QFKdiNoQwOhkycUspcBWLcket
YumlUyNdZao6qzqpvDj8hW0Jb2dEyeZw2hpCK5ale7Tr3YCz4m7Nm/skF+5ma+Q1
rrLlxV08ovb9MZKf9NFhlJpxuFznGTI1Rk9VzyGKxifFCH/wJbg=
=KyKp
-----END PGP SIGNATURE-----

--xo44VMWPx7vlQ2+2--

