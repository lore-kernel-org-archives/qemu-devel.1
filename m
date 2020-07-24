Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F2AC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 05:10:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4881206F6
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 05:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="mGwSKQMv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4881206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jypyo-0006jN-WB
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 01:10:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jypy8-0006De-R6; Fri, 24 Jul 2020 01:10:05 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:39915)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jypy6-0005xL-58; Fri, 24 Jul 2020 01:10:04 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BCchM0pTPz9sSn; Fri, 24 Jul 2020 15:09:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1595567395;
 bh=krR4IXYLuHabOUY3BMiLq7i+ulR4X0AT75KotwhH2HQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mGwSKQMvrQYofLmspNmi480TSJ1kCHG0TOcPgAmkLHjmT3aEegk7i5SklBC0CLQaF
 Fle8vEmaeAydo1ItdklSSqfiQOWpOIUxJmTm+Ky66gc5c2Mbuj0VDOLTVyfjl5bA/J
 6Y3HT2oocEpUjkz0mRk+8Hwp9cFA/cE8h0QrHlhc=
Date: Fri, 24 Jul 2020 14:56:13 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: [PATCH 2/2] ppc: Enable 2nd DAWR support on p10
Message-ID: <20200724045613.GA8983@umbus.fritz.box>
References: <20200723104220.314671-1-ravi.bangoria@linux.ibm.com>
 <20200723104220.314671-3-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
In-Reply-To: <20200723104220.314671-3-ravi.bangoria@linux.ibm.com>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: christophe.leroy@c-s.fr, qemu-ppc@nongnu.org, mikey@neuling.org,
 rogealve@br.ibm.com, kvm@vger.kernel.org, mst@redhat.com, mpe@ellerman.id.au,
 cohuck@redhat.com, qemu-devel@nongnu.org, npiggin@gmail.com, paulus@samba.org,
 clg@kaod.org, jniethe5@gmail.com, pedromfc@br.ibm.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2020 at 04:12:20PM +0530, Ravi Bangoria wrote:
> As per the PAPR, bit 0 of byte 64 in pa-features property indicates
> availability of 2nd DAWR registers. i.e. If this bit is set, 2nd
> DAWR is present, otherwise not. Use KVM_CAP_PPC_DAWR1 capability to
> find whether kvm supports 2nd DAWR or nor. If it's supported, set
> the pa-feature bit in guest DT so the guest kernel can support 2nd
> DAWR.
>=20
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> ---
>  hw/ppc/spapr.c                  | 33 +++++++++++++++++++++++++++++++++
>  include/hw/ppc/spapr.h          |  1 +
>  linux-headers/asm-powerpc/kvm.h |  4 ++++
>  linux-headers/linux/kvm.h       |  1 +
>  target/ppc/cpu.h                |  2 ++
>  target/ppc/kvm.c                |  7 +++++++
>  target/ppc/kvm_ppc.h            |  6 ++++++
>  target/ppc/translate_init.inc.c | 17 ++++++++++++++++-
>  8 files changed, 70 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 0ae293ec94..4416319363 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -252,6 +252,31 @@ static void spapr_dt_pa_features(SpaprMachineState *=
spapr,
>          /* 60: NM atomic, 62: RNG */
>          0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 60 - 65 */
>      };
> +    uint8_t pa_features_310[] =3D { 66, 0,
> +        /* 0: MMU|FPU|SLB|RUN|DABR|NX, 1: fri[nzpm]|DABRX|SPRG3|SLB0|PP1=
10 */
> +        /* 2: VPM|DS205|PPR|DS202|DS206, 3: LSD|URG, SSO, 5: LE|CFAR|EB|=
LSQ */
> +        0xf6, 0x1f, 0xc7, 0xc0, 0x80, 0xf0, /* 0 - 5 */
> +        /* 6: DS207 */
> +        0x80, 0x00, 0x00, 0x00, 0x00, 0x00, /* 6 - 11 */
> +        /* 16: Vector */
> +        0x00, 0x00, 0x00, 0x00, 0x80, 0x00, /* 12 - 17 */
> +        /* 18: Vec. Scalar, 20: Vec. XOR, 22: HTM */
> +        0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 18 - 23 */
> +        /* 24: Ext. Dec, 26: 64 bit ftrs, 28: PM ftrs */
> +        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 24 - 29 */
> +        /* 30: MMR, 32: LE atomic, 34: EBB + ext EBB */
> +        0x80, 0x00, 0x80, 0x00, 0xC0, 0x00, /* 30 - 35 */
> +        /* 36: SPR SO, 38: Copy/Paste, 40: Radix MMU */
> +        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 36 - 41 */
> +        /* 42: PM, 44: PC RA, 46: SC vec'd */
> +        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 42 - 47 */
> +        /* 48: SIMD, 50: QP BFP, 52: String */
> +        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 48 - 53 */
> +        /* 54: DecFP, 56: DecI, 58: SHA */
> +        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 54 - 59 */
> +        /* 60: NM atomic, 62: RNG, 64: DAWR1 */
> +        0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 60 - 65 */
> +    };
>      uint8_t *pa_features =3D NULL;
>      size_t pa_size;
> =20
> @@ -267,6 +292,10 @@ static void spapr_dt_pa_features(SpaprMachineState *=
spapr,
>          pa_features =3D pa_features_300;
>          pa_size =3D sizeof(pa_features_300);
>      }
> +    if (ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_3_10, 0, cpu->compat_p=
vr)) {
> +        pa_features =3D pa_features_310;
> +        pa_size =3D sizeof(pa_features_310);
> +    }
>      if (!pa_features) {
>          return;
>      }
> @@ -291,6 +320,10 @@ static void spapr_dt_pa_features(SpaprMachineState *=
spapr,
>          pa_features[40 + 2] &=3D ~0x80; /* Radix MMU */
>      }
> =20
> +    if (kvm_enabled() && kvmppc_has_cap_dawr1()) {
> +        pa_features[66] |=3D 0x80;
> +    }

Nack.  The guest visible platform must not depend on host capabilities
because it makes a complete mess of migration.  The machine type and
properties of other devices need to define what the guest environment
will be, then qemu can either provide it, or fail outright if KVM
doesn't have the neccessary support.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8aaesACgkQbDjKyiDZ
s5KFuBAAgA/6qyCnJFK/OeujSjvdernralmgH+KVxxVPiNmFIBPePIDqIulT961C
dO1mb3MmMhiPgJRqW40VH3lAPs3izOKz1gFAPrad3CVEKaKxtvallziOWSRTotAd
wz5Scc5ch6ev5VAws8bfXTYpng12KmdHVxL1SioScgKZoIfzAZ7VhnP+POZix6fw
DwCC/mNKsluW7NWeKrK5DJ9A+azX69A2PYvD1SWUpF4JOYfmxKrIKgLDsFXPRyUX
bxwZV9RZ3qXoviNDwxAwcSPYiVIb2GZtN9CLoAJnfsvFHBlpRVlVNz2F5o/yndqQ
tpOO1ee7OQXXJZvj1WnaD4UOUzrVEo+TzdfsseGqjZGusJQiQ+foSLJ+bcc6XUE3
ASvRIR5grY7ggp6vHE/rkbjoOf3nw+5GW43BaMmWu10ol+QnsB7rtmm9TwfPhiF8
6YPErgnPcS2GI5sr5yhL8SlbBL2d3f5OPluiMQqa8UtHj5RbQEbvynZcYNc1O29o
diisn+kpOWA9sQL631u7rxYYNe5wtij83CmHLV0lQCW0F4OHuJ0nhWdt4sVoDW6D
auELJeVAJFDDlfsQrQwvo3WDOxpOXlMjJbNnQZE0QEUBNTVgYdozMpKJSmZT/OLV
YRWKyeJERYr6L4MWhKRHocWhlMuPlFLm1CUEntHznfA6mTCVrTg=
=nSJ3
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--

