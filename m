Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 356C3C38A2A
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 01:46:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E933720746
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 01:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="H3zZQTNP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E933720746
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXxWA-0002w4-UB
	for qemu-devel@archiver.kernel.org; Sun, 10 May 2020 21:46:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jXxUt-0000vO-2z
 for qemu-devel@nongnu.org; Sun, 10 May 2020 21:44:47 -0400
Received: from ozlabs.org ([203.11.71.1]:51899)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jXxUq-0000eo-TM
 for qemu-devel@nongnu.org; Sun, 10 May 2020 21:44:46 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49L3dg2n2Fz9sSF; Mon, 11 May 2020 11:44:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1589161479;
 bh=cAGiy8/hXyyn3IAZEN0TygQcrroduLy/h7Tuch4hsjU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=H3zZQTNPlgb8r812iUO4M6qING7Bd07xNQw84ybHqJIqc/k1QRuR4IvljvOda0qPC
 /6cNGjP0NkB/4X2wDOoOcSgmqixWMAGFgL3Kj/OANmupKDhNtPs5TlnEMyTXQQoml3
 4N5VgRcels6GbBVKso7huLfmcEpNRX7aqLQYOz4U=
Date: Mon, 11 May 2020 11:18:36 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v3 08/10] target/ppc: Use tcg_gen_gvec_rotlv
Message-ID: <20200511011836.GE2183@umbus.fritz.box>
References: <20200508151055.5832-1-richard.henderson@linaro.org>
 <20200508151055.5832-9-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="fWddYNRDgTk9wQGZ"
Content-Disposition: inline
In-Reply-To: <20200508151055.5832-9-richard.henderson@linaro.org>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/10 21:17:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: alex.bennee@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--fWddYNRDgTk9wQGZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 08, 2020 at 08:10:53AM -0700, Richard Henderson wrote:
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  target/ppc/helper.h                 |  4 ----
>  target/ppc/int_helper.c             | 17 -----------------
>  target/ppc/translate/vmx-impl.inc.c |  8 ++++----
>  3 files changed, 4 insertions(+), 25 deletions(-)
>=20
> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> index a95c010391..b0114fc915 100644
> --- a/target/ppc/helper.h
> +++ b/target/ppc/helper.h
> @@ -213,10 +213,6 @@ DEF_HELPER_3(vsubuqm, void, avr, avr, avr)
>  DEF_HELPER_4(vsubecuq, void, avr, avr, avr, avr)
>  DEF_HELPER_4(vsubeuqm, void, avr, avr, avr, avr)
>  DEF_HELPER_3(vsubcuq, void, avr, avr, avr)
> -DEF_HELPER_3(vrlb, void, avr, avr, avr)
> -DEF_HELPER_3(vrlh, void, avr, avr, avr)
> -DEF_HELPER_3(vrlw, void, avr, avr, avr)
> -DEF_HELPER_3(vrld, void, avr, avr, avr)
>  DEF_HELPER_4(vsldoi, void, avr, avr, avr, i32)
>  DEF_HELPER_3(vextractub, void, avr, avr, i32)
>  DEF_HELPER_3(vextractuh, void, avr, avr, i32)
> diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
> index 6d238b989d..ee308da2ca 100644
> --- a/target/ppc/int_helper.c
> +++ b/target/ppc/int_helper.c
> @@ -1347,23 +1347,6 @@ VRFI(p, float_round_up)
>  VRFI(z, float_round_to_zero)
>  #undef VRFI
> =20
> -#define VROTATE(suffix, element, mask)                                  \
> -    void helper_vrl##suffix(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)   \
> -    {                                                                   \
> -        int i;                                                          \
> -                                                                        \
> -        for (i =3D 0; i < ARRAY_SIZE(r->element); i++) {                =
  \
> -            unsigned int shift =3D b->element[i] & mask;                =
  \
> -            r->element[i] =3D (a->element[i] << shift) |                =
  \
> -                (a->element[i] >> (sizeof(a->element[0]) * 8 - shift)); \
> -        }                                                               \
> -    }
> -VROTATE(b, u8, 0x7)
> -VROTATE(h, u16, 0xF)
> -VROTATE(w, u32, 0x1F)
> -VROTATE(d, u64, 0x3F)
> -#undef VROTATE
> -
>  void helper_vrsqrtefp(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *b)
>  {
>      int i;
> diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/v=
mx-impl.inc.c
> index 403ed3a01c..de2fd136ff 100644
> --- a/target/ppc/translate/vmx-impl.inc.c
> +++ b/target/ppc/translate/vmx-impl.inc.c
> @@ -900,13 +900,13 @@ GEN_VXFORM3(vsubeuqm, 31, 0);
>  GEN_VXFORM3(vsubecuq, 31, 0);
>  GEN_VXFORM_DUAL(vsubeuqm, PPC_NONE, PPC2_ALTIVEC_207, \
>              vsubecuq, PPC_NONE, PPC2_ALTIVEC_207)
> -GEN_VXFORM(vrlb, 2, 0);
> -GEN_VXFORM(vrlh, 2, 1);
> -GEN_VXFORM(vrlw, 2, 2);
> +GEN_VXFORM_V(vrlb, MO_8, tcg_gen_gvec_rotlv, 2, 0);
> +GEN_VXFORM_V(vrlh, MO_16, tcg_gen_gvec_rotlv, 2, 1);
> +GEN_VXFORM_V(vrlw, MO_32, tcg_gen_gvec_rotlv, 2, 2);
>  GEN_VXFORM(vrlwmi, 2, 2);
>  GEN_VXFORM_DUAL(vrlw, PPC_ALTIVEC, PPC_NONE, \
>                  vrlwmi, PPC_NONE, PPC2_ISA300)
> -GEN_VXFORM(vrld, 2, 3);
> +GEN_VXFORM_V(vrld, MO_64, tcg_gen_gvec_rotlv, 2, 3);
>  GEN_VXFORM(vrldmi, 2, 3);
>  GEN_VXFORM_DUAL(vrld, PPC_NONE, PPC2_ALTIVEC_207, \
>                  vrldmi, PPC_NONE, PPC2_ISA300)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--fWddYNRDgTk9wQGZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl64p+sACgkQbDjKyiDZ
s5Kc8w//RW2zMXTmqXch1xHSDWmAsCAlHeo4cf6Kuedf9dnNgr/J0RAibD7PPZZE
r6viohbgS4xPCdwFAw4qePZaKT8jvar9fT3GVK6C6H1+ONEtxfoPlov8FBRZ5+NC
EjaunMXzznAVPJb0ZyaOGBlcxbrj30wfVxfk42txAa90mrtc0OJR4fms5ZjgiaQJ
UDgR6G3w/iex068wmBvu+IC0ZwHMEqVksRxHiw0euLsj29tv2e41MWgSMuXZhtiu
n2HSqyMzBbRHz522tLFtlJ369mQ9uN9pd9JgfL3AoqOjfTdxyDI6WUNwASabitp1
B7yyABrV8L+v7TqXq4AvKKKPzBU3T98DjszV/QfdY35w4G4dOfoZNrvlV1/dgn9L
LTH+Sy/KoBWiWimF3ZCI6IK29eBZThFkZ4pwxgPLQ30dgq2UE4GySNkIul2G/Lhq
ft+1I6G33k9R6G1FLWLqLkVP06RSmBwq4qDrvG4ZCvEk1nKHoKRpeAmD5FIl42t1
kekrdVzLnA3hLu/uOyW18L+L28dU5czbDKfjbFd9yLfSelFSfD0DpIT0cKeNnQpx
Vj0GImZfgIdkLtKV4dw3PpMql5jxYOQzAjFgD7mX7np7NMnQqewvaNkHVy3dSk69
hRgEsab0ZFAhalP90e0sVAfL2AEk8bYqRKZNt7YCV5Pm5XR/1no=
=rdll
-----END PGP SIGNATURE-----

--fWddYNRDgTk9wQGZ--

