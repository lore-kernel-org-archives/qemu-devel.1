Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F354C3A59E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 07:46:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C2BA2080C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 07:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ZvwHMSv0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C2BA2080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i29i1-0005AD-7S
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 03:46:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40747)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i29gN-0003o3-LL
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 03:44:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i29gL-0008Be-Rg
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 03:44:55 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:56819)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i29gK-00086l-AN; Mon, 26 Aug 2019 03:44:53 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46H3tc1h47z9sNF; Mon, 26 Aug 2019 17:44:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1566805480;
 bh=WSYDZxz/PBeaUmDk3GI44jzchs3i+5JR4OLeWs9biXA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZvwHMSv0w+6kZWytKuwQsrtUhXOd6SqMO8077e3CwDo1YODB8VD6oKogCJzfDTUdb
 9h/igpshg1A1tc2Vyh3ZhQM0ZIrFeAPV8gUiawUl00kAMvDfbYhmebSqOSdHYWw6cS
 dRrAy5N4rlw7uiRhyw+JgPf16kGCxWiJmOovy5YY=
Date: Mon, 26 Aug 2019 17:44:31 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <20190826074431.GA28081@umbus.fritz.box>
References: <20190826043126.11589-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
In-Reply-To: <20190826043126.11589-1-aik@ozlabs.ru>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH qemu] spapr: Render full FDT on ibm,
 client-architecture-support
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


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2019 at 02:31:26PM +1000, Alexey Kardashevskiy wrote:
> The ibm,client-architecture-support call is a way for the guest to
> negotiate capabilities with a hypervisor. It is implemented as:
> - the guest calls SLOF via client interface;
> - SLOF calls QEMU (H_CAS hypercall) with an options vector from the guest;
> - QEMU returns a device tree diff (which uses FDT format with
> an additional header before it);
> - SLOF walks through the partial diff tree and updates its internal tree
> with the values from the diff.
>=20
> This changes QEMU to simply re-render the entire tree and send it as
> an update. SLOF can handle this already mostly, [1] is needed before this
> can be applied.
>=20
> The benefit is reduced code size as there is no need for another set of
> DT rendering helpers such as spapr_fixup_cpu_dt().
>=20
> The downside is that the updates are bigger now (as they include all
> nodes and properties) but the difference on a '-smp 256,threads=3D1' syst=
em
> before/after is 2.35s vs. 2.5s.
>=20
> While at this, add a missing g_free(fdt) if the resulting tree is bigger
> than the space allocated by SLOF. Also, store the resulting tree in
> the spapr machine to have the latest valid FDT copy possible (this should
> not matter much as H_UPDATE_DT happens right after that but nevertheless).
>=20
> [1] https://patchwork.ozlabs.org/patch/1152915/
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Can you wrap that up with the SLOF update in a pull request for me?


> ---
>  hw/ppc/spapr.c | 90 ++++++--------------------------------------------
>  1 file changed, 10 insertions(+), 80 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index baedadf20b8c..6dea5947afbc 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -295,65 +295,6 @@ static void spapr_populate_pa_features(SpaprMachineS=
tate *spapr,
>      _FDT((fdt_setprop(fdt, offset, "ibm,pa-features", pa_features, pa_si=
ze)));
>  }
> =20
> -static int spapr_fixup_cpu_dt(void *fdt, SpaprMachineState *spapr)
> -{
> -    MachineState *ms =3D MACHINE(spapr);
> -    int ret =3D 0, offset, cpus_offset;
> -    CPUState *cs;
> -    char cpu_model[32];
> -    uint32_t pft_size_prop[] =3D {0, cpu_to_be32(spapr->htab_shift)};
> -
> -    CPU_FOREACH(cs) {
> -        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> -        DeviceClass *dc =3D DEVICE_GET_CLASS(cs);
> -        int index =3D spapr_get_vcpu_id(cpu);
> -        int compat_smt =3D MIN(ms->smp.threads, ppc_compat_max_vthreads(=
cpu));
> -
> -        if (!spapr_is_thread0_in_vcore(spapr, cpu)) {
> -            continue;
> -        }
> -
> -        snprintf(cpu_model, 32, "%s@%x", dc->fw_name, index);
> -
> -        cpus_offset =3D fdt_path_offset(fdt, "/cpus");
> -        if (cpus_offset < 0) {
> -            cpus_offset =3D fdt_add_subnode(fdt, 0, "cpus");
> -            if (cpus_offset < 0) {
> -                return cpus_offset;
> -            }
> -        }
> -        offset =3D fdt_subnode_offset(fdt, cpus_offset, cpu_model);
> -        if (offset < 0) {
> -            offset =3D fdt_add_subnode(fdt, cpus_offset, cpu_model);
> -            if (offset < 0) {
> -                return offset;
> -            }
> -        }
> -
> -        ret =3D fdt_setprop(fdt, offset, "ibm,pft-size",
> -                          pft_size_prop, sizeof(pft_size_prop));
> -        if (ret < 0) {
> -            return ret;
> -        }
> -
> -        if (nb_numa_nodes > 1) {
> -            ret =3D spapr_fixup_cpu_numa_dt(fdt, offset, cpu);
> -            if (ret < 0) {
> -                return ret;
> -            }
> -        }
> -
> -        ret =3D spapr_fixup_cpu_smt_dt(fdt, offset, cpu, compat_smt);
> -        if (ret < 0) {
> -            return ret;
> -        }
> -
> -        spapr_populate_pa_features(spapr, cpu, fdt, offset,
> -                                   spapr->cas_legacy_guest_workaround);
> -    }
> -    return ret;
> -}
> -
>  static hwaddr spapr_node0_size(MachineState *machine)
>  {
>      if (nb_numa_nodes) {
> @@ -983,11 +924,13 @@ static bool spapr_hotplugged_dev_before_cas(void)
>      return false;
>  }
> =20
> +static void *spapr_build_fdt(SpaprMachineState *spapr);
> +
>  int spapr_h_cas_compose_response(SpaprMachineState *spapr,
>                                   target_ulong addr, target_ulong size,
>                                   SpaprOptionVector *ov5_updates)
>  {
> -    void *fdt, *fdt_skel;
> +    void *fdt;
>      SpaprDeviceTreeUpdateHeader hdr =3D { .version_id =3D 1 };
> =20
>      if (spapr_hotplugged_dev_before_cas()) {
> @@ -1003,28 +946,11 @@ int spapr_h_cas_compose_response(SpaprMachineState=
 *spapr,
> =20
>      size -=3D sizeof(hdr);
> =20
> -    /* Create skeleton */
> -    fdt_skel =3D g_malloc0(size);
> -    _FDT((fdt_create(fdt_skel, size)));
> -    _FDT((fdt_finish_reservemap(fdt_skel)));
> -    _FDT((fdt_begin_node(fdt_skel, "")));
> -    _FDT((fdt_end_node(fdt_skel)));
> -    _FDT((fdt_finish(fdt_skel)));
> -    fdt =3D g_malloc0(size);
> -    _FDT((fdt_open_into(fdt_skel, fdt, size)));
> -    g_free(fdt_skel);
> -
> -    /* Fixup cpu nodes */
> -    _FDT((spapr_fixup_cpu_dt(fdt, spapr)));
> -
> -    if (spapr_dt_cas_updates(spapr, fdt, ov5_updates)) {
> -        return -1;
> -    }
> -
> -    /* Pack resulting tree */
> +    fdt =3D spapr_build_fdt(spapr);
>      _FDT((fdt_pack(fdt)));
> =20
>      if (fdt_totalsize(fdt) + sizeof(hdr) > size) {
> +        g_free(fdt);
>          trace_spapr_cas_failed(size);
>          return -1;
>      }
> @@ -1032,7 +958,11 @@ int spapr_h_cas_compose_response(SpaprMachineState =
*spapr,
>      cpu_physical_memory_write(addr, &hdr, sizeof(hdr));
>      cpu_physical_memory_write(addr + sizeof(hdr), fdt, fdt_totalsize(fdt=
));
>      trace_spapr_cas_continue(fdt_totalsize(fdt) + sizeof(hdr));
> -    g_free(fdt);
> +
> +    g_free(spapr->fdt_blob);
> +    spapr->fdt_size =3D fdt_totalsize(fdt);
> +    spapr->fdt_initial_size =3D spapr->fdt_size;
> +    spapr->fdt_blob =3D fdt;
> =20
>      return 0;
>  }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1jjd0ACgkQbDjKyiDZ
s5JbzQ/8CWlbnAgVOyXHqVG+YG/1+3JO55sZwJY1f5ctjVoptKes7CcjpbdWsyUR
EvMzBfEJ+DCX1aHRwydDQsm52to463kyAbUbN1OEV4Yxe9F34+SliNL6GoZZmzAY
xsmPcHfi1h07dah34xWONhyFAPRoZMDKuePX4LiVWKkUlis1xf9QY+WPVXqga+vG
V4aHV7oBYzOGL/3JqareZM2LJdIncAbBNcG72pebrjd3eLIaKbIXU0bjlx4C1J3t
Xq2YiYJohY1pwHlSUQSVSORSHKf+EcLJ2VfzOEsAaQBgx9uiLFdFbdybdRJImKhf
HdBsAw3Idh0b7wnfCwMM385V98tG76v6x2dyaY8T9+7BTpOe2BEGYfPclFBJHJ0L
a1V3rzz5RFHi2SddwkJ1yEnPtk/iI33Si6jEiHV19M+cFv/PU7G4M+CVBK5qGDAw
4dDQ5KWZlq55uPmXz5GAoBWA4nYcUVOHqwjSoqjXS34OBYb3y1bDbHJ2OSrPzz8m
iCdSfQItPtTPd1tUixHYz0wTRwylPVPTiklNFG8uSV9wVk2waOP9hPcZU7F4G+1l
+6/pd13F24HYfjhXxeZhm54VLXZP+uGBQ0hXul1OL6qOQbePG45R1fygUMqxk/Sx
3204PqREdS9Qe3ga8niMAFvH7SP4Q9UbMkHPpnKbSTui/VP4ucg=
=Q9RY
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--

