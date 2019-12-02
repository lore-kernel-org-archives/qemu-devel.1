Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B97AC432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 02:42:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2142720881
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 02:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="YPjZCd5a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2142720881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibbex-0002hp-U1
	for qemu-devel@archiver.kernel.org; Sun, 01 Dec 2019 21:41:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32974)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ibbdY-00027Z-Jm
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 21:40:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ibbdV-0007uF-M1
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 21:40:32 -0500
Received: from ozlabs.org ([203.11.71.1]:41543)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ibbdR-0007pv-TX; Sun, 01 Dec 2019 21:40:29 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47R8VB5Kp6z9sPL; Mon,  2 Dec 2019 13:40:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1575254418;
 bh=4oAtVOnNfVKzynPYcJABQoI+O5UNEl6quI9RpuYr6zo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YPjZCd5aaXFP3ca0+m1IncxVRu7EoD1TpnuXvE4acAoheIs54wBk5VgrhvHknkZQl
 L7J7FeQhXlwYkKm4pQpoUarmkiGCR0qlc+bYLPZBa6N+fil3aM8t00HzDm7IL5aaAW
 lAGPMuv5a3vcpdJPSJfRMMt38WCIbfSvGOS5SryM=
Date: Mon, 2 Dec 2019 13:39:47 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v6] ppc: well form kvmppc_hint_smt_possible error hint
 helper
Message-ID: <20191202023947.GA37909@umbus.fritz.box>
References: <20191127191434.20945-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
In-Reply-To: <20191127191434.20945-1-vsementsov@virtuozzo.com>
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
Cc: marcandre.lureau@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2019 at 10:14:34PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> Make kvmppc_hint_smt_possible hint append helper well formed:
> rename errp to errp_in, as it is IN-parameter here (which is unusual
> for errp), rename function to be kvmppc_error_append_*_hint.

I'm not entirely convinced by the errp_in name, since it's actually
both an in and out parameter.  Nonetheless, I've applied this to
ppc-for-5.0.


> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> ---
>=20
> v6: keep kvmppc_ function prefix
>     add r-b by Marc-Andr=E9
>=20
>  target/ppc/kvm_ppc.h | 4 ++--
>  hw/ppc/spapr.c       | 2 +-
>  target/ppc/kvm.c     | 6 +++---
>  3 files changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> index 98bd7d5da6..47b08a4030 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -28,7 +28,7 @@ void kvmppc_set_papr(PowerPCCPU *cpu);
>  int kvmppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr);
>  void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mpic_proxy);
>  int kvmppc_smt_threads(void);
> -void kvmppc_hint_smt_possible(Error **errp);
> +void kvmppc_error_append_smt_possible_hint(Error **errp_in);
>  int kvmppc_set_smt_threads(int smt);
>  int kvmppc_clear_tsr_bits(PowerPCCPU *cpu, uint32_t tsr_bits);
>  int kvmppc_or_tsr_bits(PowerPCCPU *cpu, uint32_t tsr_bits);
> @@ -164,7 +164,7 @@ static inline int kvmppc_smt_threads(void)
>      return 1;
>  }
> =20
> -static inline void kvmppc_hint_smt_possible(Error **errp)
> +static inline void kvmppc_error_append_smt_possible_hint(Error **errp_in)
>  {
>      return;
>  }
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index e076f6023c..1b87eb0ffd 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2564,7 +2564,7 @@ static void spapr_set_vsmt_mode(SpaprMachineState *=
spapr, Error **errp)
>                                        " requires the use of VSMT mode %d=
=2E\n",
>                                        smp_threads, kvm_smt, spapr->vsmt);
>                  }
> -                kvmppc_hint_smt_possible(&local_err);
> +                kvmppc_error_append_smt_possible_hint(&local_err);
>                  goto out;
>              }
>          }
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index c77f9848ec..7406d18945 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -2076,7 +2076,7 @@ int kvmppc_set_smt_threads(int smt)
>      return ret;
>  }
> =20
> -void kvmppc_hint_smt_possible(Error **errp)
> +void kvmppc_error_append_smt_possible_hint(Error **errp_in)
>  {
>      int i;
>      GString *g;
> @@ -2091,10 +2091,10 @@ void kvmppc_hint_smt_possible(Error **errp)
>              }
>          }
>          s =3D g_string_free(g, false);
> -        error_append_hint(errp, "%s.\n", s);
> +        error_append_hint(errp_in, "%s.\n", s);
>          g_free(s);
>      } else {
> -        error_append_hint(errp,
> +        error_append_hint(errp_in,
>                            "This KVM seems to be too old to support VSMT.=
\n");
>      }
>  }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3keW4ACgkQbDjKyiDZ
s5Ih5g//XqhftL0BwBdLuELvQhc2+vEi6X9aBIk/C2N3WaVl10M0OHDRE0EHpsAf
o2K1pUXbJ9VMrXnwnQbAQd8/oiP7CUOpoxFdBeisLSjkYBvu5ihDpUKNzO0rUH60
YCCE+GA+rJwfZRgjKU0iWESz6q1s5C5VBB3eGGwNnJvIYXExLrBLAZWjUrXqBcYb
ITkmG5qn5l8++JlDI3P7KqwWWGMp6qNKn4Nxeg4+CTJF52ZXTjO65ROarHejf7v1
MIvi5tQUqh5QRuFU9YEHoCs8TiAvyZR1d0Fhdv0os98xVYZVE016/SnagKvnP27S
mf3W5Zbv44rBvocZuzIsHFUF++X58LlKkHup5plx03YpzCJ1GSlS4vJa5hylEl9E
N474vWaz+xOpVzf4FUOB0tUAbDC0abaggsqMQEcCgjgRLXe1dgghWrfLneoB2XNa
GYp44U0AXzJ7AZxM0etzULA3kFOWL12qAljNFMMovjxUBt+uo04yuMXNueAeOl6s
fFQugE1oT7WSz2W+w9kqJcsQlSFtH6VT53DJv2zE/aQ+Ic86k5b13/P2b4qeeYJg
zscjnCjiLY/L7RnTyzFCi7haS4OqLj8AjEICcVH/TIL+9pewPWca3YQ3Ku04FMv7
j3XZDIb+LENbYvp2DgUSUJaOQt9AmbK3kBupYDAtlPWGJZ6OAfs=
=8UCV
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--

