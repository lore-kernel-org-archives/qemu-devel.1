Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D490C4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 05:32:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29C572072C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 05:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="X83sloEK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29C572072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEnn6-0000ZZ-Ce
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 01:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34543)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jEnjm-00052v-Lw
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 01:29:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jEnjl-0004MB-5O
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 01:28:58 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:57823 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jEnjk-0004C9-7C; Thu, 19 Mar 2020 01:28:57 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48jb6q6zBbz9sRY; Thu, 19 Mar 2020 16:28:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1584595731;
 bh=BC6Zz/HQT/gpwt3+5lKgvbKs2MqAqZ5GjBIJdKmojOc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=X83sloEKAxv/hDV/oKnGRq+Cf00YzyCzs07oXK2TKLHyV7WyPG6uFRVSsTKkDigOh
 qD6UTiDPAnMo0wQ4fePKxFzZVcoEFvNPUCo/z0cKBkmdV6udIyRk7uGpK/sa4D8mcD
 sWoqqKLjMUoUkk7OAp5Lx7zWlK7l72Ig9bUupfe8=
Date: Thu, 19 Mar 2020 16:19:46 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 1/2] target/ppc: Fix slbia TLB invalidation gap
Message-ID: <20200319051946.GE628315@umbus.fritz.box>
References: <20200318044135.851716-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="a1QUDc0q7S3U7/Jg"
Content-Disposition: inline
In-Reply-To: <20200318044135.851716-1-npiggin@gmail.com>
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
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@fr.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--a1QUDc0q7S3U7/Jg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2020 at 02:41:34PM +1000, Nicholas Piggin wrote:
> slbia must invalidate TLBs even if it does not remove a valid SLB
> entry, because slbmte can overwrite valid entries without removing
> their TLBs.
>=20
> As the architecture says, slbia invalidates all lookaside information,
> not conditionally based on if it removed valid entries.
>=20
> It does not seem possible for POWER8 or earlier Linux kernels to hit
> this bug because it never changes its kernel SLB translations, and it
> should always have valid entries if any accesses are made to usespace
> regions. However other operating systems which may modify SLB entry 0
> or do more fancy things with segments might be affected.
>=20
> When POWER9 slbia support is added in the next patch, this becomes a
> real problem because some new slbia variants don't invalidate all
> non-zero entries.
>=20
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to ppc-for-5.0, thanks.

> ---
>  target/ppc/mmu-hash64.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
>=20
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index 34f6009b1e..373d44de74 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -100,20 +100,29 @@ void helper_slbia(CPUPPCState *env)
>      PowerPCCPU *cpu =3D env_archcpu(env);
>      int n;
> =20
> +    /*
> +     * slbia must always flush all TLB (which is equivalent to ERAT in p=
pc
> +     * architecture). Matching on SLB_ESID_V is not good enough, because=
 slbmte
> +     * can overwrite a valid SLB without flushing its lookaside informat=
ion.
> +     *
> +     * It would be possible to keep the TLB in synch with the SLB by flu=
shing
> +     * when a valid entry is overwritten by slbmte, and therefore slbia =
would
> +     * not have to flush unless it evicts a valid SLB entry. However it =
is
> +     * expected that slbmte is more common than slbia, and slbia is usua=
lly
> +     * going to evict valid SLB entries, so that tradeoff is unlikely to=
 be a
> +     * good one.
> +     */
> +
>      /* XXX: Warning: slbia never invalidates the first segment */
>      for (n =3D 1; n < cpu->hash64_opts->slb_size; n++) {
>          ppc_slb_t *slb =3D &env->slb[n];
> =20
>          if (slb->esid & SLB_ESID_V) {
>              slb->esid &=3D ~SLB_ESID_V;
> -            /*
> -             * XXX: given the fact that segment size is 256 MB or 1TB,
> -             *      and we still don't have a tlb_flush_mask(env, n, mas=
k)
> -             *      in QEMU, we just invalidate all TLBs
> -             */
> -            env->tlb_need_flush |=3D TLB_NEED_LOCAL_FLUSH;
>          }
>      }
> +
> +    env->tlb_need_flush |=3D TLB_NEED_LOCAL_FLUSH;
>  }
> =20
>  static void __helper_slbie(CPUPPCState *env, target_ulong addr,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--a1QUDc0q7S3U7/Jg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5zAPIACgkQbDjKyiDZ
s5J3LBAAsjZjB8g4jcUmq4H19nwEaPOR+wwzrJlRAxyk5DsKnlFD/UmKP1GGmojF
PyvlRL/tmjN3n5e5/06uSVWs5xs0uizAhgZHrptRQOanxODbarCv1lcjxZDuICJM
18ILIeG6K5SivLTR57pJxPimwR3LuPFRzwHKjHatmRHnFd2Yxut/IZmTsM9t4e6k
iHCbq0VdjeyiVKW/c6v5sl4s5bKYRenho2dSY8yELwjzfV0Sdxt93ZkI4t3neOIA
93WcaUfecuzAkkNKkp4fxXpq1zn/iAmBLbLDLAbbWLOsOP+QGmXkLCk2erm8MDCf
Qu3972lBxEA7rIJt9Hgh2FSHpzqnqgUZvQKq5lvomtB5lGOz3aA956vwjXsW6rqf
d3blb0C9E65x5JzQKdhuRyERq7EDaiQatoy4HX6JOM6izWWAjxOKx+lwzT+d+dX1
Ji7P210cKvln/PZEZFU5yvlgsrRI04tpZMo6IdAf3wpgLhvnUKc3S4eHi6hTkDDR
+ICAa1O3pmiK6T4Amc7gvlyLB7jU3nrt2ydJNpqhkFgy/x7qJdXWodY/wCPCFNgN
36dcr8bSdOecDDcdcB2cl7EddqqWrIIuGiD9OICkaePXRM/zMQRlwL8vnEYbFnuV
s4JC2lqyaYT4ESLqgpAuYH9cCehCFYslbG79HiXpsKu9Ff9mxBk=
=XOUF
-----END PGP SIGNATURE-----

--a1QUDc0q7S3U7/Jg--

