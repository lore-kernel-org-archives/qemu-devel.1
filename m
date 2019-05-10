Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFA2C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 06:36:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB1E6217D6
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 06:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="eKG6zRQH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB1E6217D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37738 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOz9F-0006eG-UW
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 02:36:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hOz7n-0005AD-TL
	for qemu-devel@nongnu.org; Fri, 10 May 2019 02:35:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hOz7m-0004tp-Gw
	for qemu-devel@nongnu.org; Fri, 10 May 2019 02:35:19 -0400
Received: from ozlabs.org ([203.11.71.1]:42133)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hOz7l-0004pV-Mx; Fri, 10 May 2019 02:35:18 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 450gSD3cPfz9sMM; Fri, 10 May 2019 16:35:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1557470108;
	bh=ou8dCxoAYQnZq5Pk/rZDo0JnMWk5w5pUSbNJc1zpor0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eKG6zRQHJqWaGD7ILgZcHK/YM+jo/Vd9DZ5+xrPPUDT2ThV/9dncDHr2++xJFM8QY
	U6jAiZsebr5qsaSpx+bF29LkVLgx7GfvJYrq7GyZRmuHsG2s7WBCr2DwRak0dskpu5
	xW0KRrYh15cnpNCIHD2O8UinoZ3sOEsBg3n2DOLE=
Date: Fri, 10 May 2019 16:34:59 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Message-ID: <20190510063459.GI20559@umbus.fritz.box>
References: <20190503055316.6441-1-sjitindarsingh@gmail.com>
	<20190503055316.6441-14-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Q59ABw34pTSIagmi"
Content-Disposition: inline
In-Reply-To: <20190503055316.6441-14-sjitindarsingh@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH 13/13] target/ppc: Enable
 SPAPR_CAP_NESTED_KVM_HV under tcg
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Q59ABw34pTSIagmi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 03, 2019 at 03:53:16PM +1000, Suraj Jitindar Singh wrote:
> It is now possible to use nested kvm-hv under tcg, thus allow for it to
> be enabled.
>=20
> Note that nested kvm-hv requires that rc updates to ptes be done by
> software, otherwise the page tables get out of sync. So disable hardware
> rc updates when nested kvm-hv is enabled.
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> ---
>  hw/ppc/spapr_caps.c      | 22 ++++++++++++++++++----
>  target/ppc/cpu.h         |  1 +
>  target/ppc/mmu-radix64.c |  4 ++--
>  3 files changed, 21 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index 3278c09b0f..7fe07d83dd 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -389,10 +389,7 @@ static void cap_nested_kvm_hv_apply(SpaprMachineStat=
e *spapr,
>          return;
>      }
> =20
> -    if (tcg_enabled()) {
> -        error_setg(errp,
> -                   "No Nested KVM-HV support in tcg, try cap-nested-hv=
=3Doff");
> -    } else if (kvm_enabled()) {
> +    if (kvm_enabled()) {
>          if (!kvmppc_has_cap_nested_kvm_hv()) {
>              error_setg(errp,
>  "KVM implementation does not support Nested KVM-HV, try cap-nested-hv=3D=
off");
> @@ -400,6 +397,22 @@ static void cap_nested_kvm_hv_apply(SpaprMachineStat=
e *spapr,
>                  error_setg(errp,
>  "Error enabling cap-nested-hv with KVM, try cap-nested-hv=3Doff");
>          }
> +    } /* else { nothing required for tcg } */
> +}
> +
> +static void cap_nested_kvm_hv_cpu_apply(SpaprMachineState *spapr,
> +                                        PowerPCCPU *cpu,
> +                                        uint8_t val, Error **errp)
> +{
> +    CPUPPCState *env =3D &cpu->env;
> +
> +    if (tcg_enabled() && val) {
> +        if (env->spr[SPR_PVR] !=3D 0x004E1202) {

Hrm.  Something other than an explicit PVR check would be nice (or
we'll have to keep hacking this when DD2.3 arrives).

> +            error_setg(errp, "Nested KVM-HV only supported on POWER9 DD2=
=2E2, "
> +                             "try cap-nested-hv=3Doff or -cpu power9_v2.=
2");
> +            return;
> +        }
> +        env->disable_hw_rc_updates =3D true;
>      }
>  }
> =20
> @@ -544,6 +557,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] =
=3D {
>          .set =3D spapr_cap_set_bool,
>          .type =3D "bool",
>          .apply =3D cap_nested_kvm_hv_apply,
> +        .cpu_apply =3D cap_nested_kvm_hv_cpu_apply,
>      },
>      [SPAPR_CAP_LARGE_DECREMENTER] =3D {
>          .name =3D "large-decr",
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 426015c9cd..6502e0de82 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1237,6 +1237,7 @@ struct CPUPPCState {
>      target_ulong hv_ptr, regs_ptr;
>      struct hv_guest_state l2_hv, l1_saved_hv;
>      struct pt_regs l2_regs, l1_saved_regs;
> +    bool disable_hw_rc_updates;
>  };
> =20
>  #define SET_FIT_PERIOD(a_, b_, c_, d_)          \
> diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
> index 2a8147fc38..cc06967dbe 100644
> --- a/target/ppc/mmu-radix64.c
> +++ b/target/ppc/mmu-radix64.c
> @@ -31,9 +31,9 @@
>  static inline bool ppc_radix64_hw_rc_updates(CPUPPCState *env)
>  {
>  #ifdef CONFIG_ATOMIC64
> -    return true;
> +    return !env->disable_hw_rc_updates;
>  #else
> -    return !qemu_tcg_mttcg_enabled();
> +    return !qemu_tcg_mttcg_enabled() && !env->disable_hw_rc_updates;
>  #endif
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Q59ABw34pTSIagmi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzVG5IACgkQbDjKyiDZ
s5IXXQ//Rv4K5OeGaTQ1RcoIpToqZDYlzWQv4D1z3Jp+mD2JhWaaYo0KWrD3wPzs
8XJHNoE8dd7lx4DOKpdDLPvcq9BjqDPr0mv0WWuUpRKYt47BQ43OnCL6nb0+AkbN
gfcVDZAwNKVePOig7x4s9DKsaCNaVYBqBsrlUVYD7jDrWstiKy/jZ+Y5qpD2exXV
Ai39Zw4jfSHVU+DOmXykGjTRUU2PzdOxgzJotzKotz1T/XG9OHsmzFAUKEbzyRNZ
munSV2uCLQ2tJlhDMkgLoHredV1IHQpmvtbl7HeSF7mzaLJiqTAvL2ke3B/DdTDc
PP8nabSLHUNOjL9xmkmAI9eNKyFygF2rHuzlgnmZW19SKugN/wFNf0XKbJzs6K0z
PG9R2q/Z2mvqtLTzx+kWKPm36MObt+Ad/wv8ZmsoNsosTY0jFo/TBk5qkyig2TrF
Zfm7oRdoNzzAwkskNosLqRI/JjJMNZ9UX5E5opC8MDBam/mdDYzo4gZ/wyEc1/E7
lhrLtfKPojjsHbL9UV8+linZnpEFmWcQ8wSMJBNjW5oLjP/BSgxXVAsu21t1vnlb
mOhDVdyrqYsp+TbmhTRs9UCxENNA6p2LlhmLJ5Vu3ctJrU4Zy8rK28j0ZgxnzEoQ
PdGoRzi9JFRdgUnKZ2dcFgUu4P2Bx+VMckAB4l1IOWMabrD8JzY=
=Tyz6
-----END PGP SIGNATURE-----

--Q59ABw34pTSIagmi--

