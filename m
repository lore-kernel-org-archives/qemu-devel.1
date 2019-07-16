Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA0FC76192
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 08:53:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62810206C2
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 08:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="cpMki/jH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62810206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnJDW-0001Ua-A3
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 04:53:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45099)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hnJD1-00006d-CC
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:53:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hnJD0-0007TE-2i
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:53:15 -0400
Received: from ozlabs.org ([203.11.71.1]:45775)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hnJCz-0007SI-8t; Tue, 16 Jul 2019 04:53:13 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45nvLY1rsXz9sN4; Tue, 16 Jul 2019 18:53:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1563267189;
 bh=3CZuikxAi84d/JnDOphY/C6UJVItEFSkAsyy0Ahrd5Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cpMki/jHX1BHsxPIpCAi5eri5YgXhf16o4GT3WIp11aa6aWnqUmVJTFD8YcvdbxdU
 Wz22OajAlTQofuwSjTeYfDMRxqK6lApW3CjTbbc3T7eoi9csk0rj7psukwqqwKVNij
 lnvOqp4aEpcvpx8CQobMo6B5O6z2uBuX3me6ZW0s=
Date: Tue, 16 Jul 2019 18:26:25 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Message-ID: <20190716082625.GF7525@umbus.fritz.box>
References: <20190716024726.17864-1-npiggin@gmail.com>
 <20190716024726.17864-5-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NQTVMVnDVuULnIzU"
Content-Disposition: inline
In-Reply-To: <20190716024726.17864-5-npiggin@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH v4 4/5] spapr: Implement H_JOIN
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
Cc: Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--NQTVMVnDVuULnIzU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2019 at 12:47:25PM +1000, Nicholas Piggin wrote:
> This has been useful to modify and test the Linux pseries suspend
> code but it requires modification to the guest to call it (due to
> being gated by other unimplemented features). It is not otherwise
> used by Linux yet, but work is slowly progressing there.
>=20
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

LGTM apart from style issues as noted by the bot.

> ---
>  hw/ppc/spapr.c       |  1 +
>  hw/ppc/spapr_hcall.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 87b11e2484..5c54e1cb9a 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1066,6 +1066,7 @@ static void spapr_dt_rtas(SpaprMachineState *spapr,=
 void *fdt)
>      add_str(hypertas, "hcall-tce");
>      add_str(hypertas, "hcall-vio");
>      add_str(hypertas, "hcall-splpar");
> +    add_str(hypertas, "hcall-join");
>      add_str(hypertas, "hcall-bulk");
>      add_str(hypertas, "hcall-set-mode");
>      add_str(hypertas, "hcall-sprg0");
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 28d58113be..52847a7047 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1069,6 +1069,47 @@ static target_ulong h_cede(PowerPCCPU *cpu, SpaprM=
achineState *spapr,
>      return H_SUCCESS;
>  }
> =20
> +static target_ulong h_join(PowerPCCPU *cpu, SpaprMachineState *spapr,
> +                           target_ulong opcode, target_ulong *args)
> +{
> +    CPUPPCState *env =3D &cpu->env;
> +    CPUState *cs;
> +    SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
> +    bool last_unjoined =3D true;
> +
> +    if (env->msr & (1ULL << MSR_EE)) {
> +        return H_BAD_MODE;
> +    }
> +
> +    if (spapr_cpu->prod) {
> +        spapr_cpu->prod =3D false;
> +        return H_SUCCESS;
> +    }
> +
> +    CPU_FOREACH(cs) {
> +        PowerPCCPU *c =3D POWERPC_CPU(cs);
> +        CPUPPCState *e =3D &c->env;
> +        if (c =3D=3D cpu)
> +            continue;
> +
> +	/* Don't have a way to indicate joined, so use halted && MSR[EE]=3D0 */
> +        if (!cs->halted || (e->msr & (1ULL << MSR_EE))) {
> +            last_unjoined =3D false;
> +            break;
> +        }
> +    }
> +    if (last_unjoined) {
> +        return H_CONTINUE;
> +    }
> +
> +    cs =3D CPU(cpu);
> +    cs->halted =3D 1;
> +    cs->exception_index =3D EXCP_HALTED;
> +    cs->exit_request =3D 1;
> +
> +    return H_SUCCESS;
> +}
> +
>  static target_ulong h_confer(PowerPCCPU *cpu, SpaprMachineState *spapr,
>                             target_ulong opcode, target_ulong *args)
>  {
> @@ -1959,6 +2000,9 @@ static void hypercall_register_types(void)
>      spapr_register_hypercall(H_CONFER, h_confer);
>      spapr_register_hypercall(H_PROD, h_prod);
> =20
> +    /* hcall-join */
> +    spapr_register_hypercall(H_JOIN, h_join);
> +
>      spapr_register_hypercall(H_SIGNAL_SYS_RESET, h_signal_sys_reset);
> =20
>      /* processor register resource access h-calls */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--NQTVMVnDVuULnIzU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0tijAACgkQbDjKyiDZ
s5Lt6w/7BVKLxiKSFXmjPv2941wGlng9BQoDCL/EkkvNp2R1ovj5+GjomlFWWTuV
lGrH/aHGA6XWGs0oeylywSEdTpVIWsxVjENVjqcIurLCS0EfORXmbLd6KlNTO07v
rLJk1kMSY+cV6eBytfPkFRYftlG6faS551t7Ds32RskaybrBQdqXdjLzc4erm+P/
WgxRZyN1O7/v9WMjoAVVvv8lKVrIF07v6NNsQ+lZl0eWT1uyjwPmGXGhZ/Ia2kvh
OyHCItJEWXPI0Yy7uFJ4SMOmlIZq+ZvHSN4/Qn/sTRZGpqN/B1orLVF5M9mPcoCj
qJiSvF4znV2qmUbrW8oQXxtLFDR9+TC1HOBCnX1wyjUAo1QxTZalI/bKyBFH0tw9
HHbScxpk7HueNPeaGLsk/i4Qbl6rmAIGCxclD0yR+44pA3v/O9x0bQgH97em/1nB
dYbCp8YxMvyvW/P9ejj+ATLGVHzP7T2qxhtFCH4a1R9tNJB4uVKXkCNdII49PAeB
DyDCdHXqtJiLW1VfFpW8K5vId1j4MUMCuvt74XbRHnxCma3yR9JRP3kUr1HKSDEL
kLVrisuNYf0yZ0RCrRA+W+v9+4UZ26BWBFjCV3PQYKeZ6YxM6UUdSWCLPzUnBXOB
RcqjyIxBX6gTPNTeMixVDlhMmtZSYLQoC65ORM7NW5kJAsfMcRk=
=sWqr
-----END PGP SIGNATURE-----

--NQTVMVnDVuULnIzU--

