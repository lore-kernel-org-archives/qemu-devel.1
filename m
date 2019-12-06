Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A2AC43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 00:29:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B976522525
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 00:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="GHkM+bNn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B976522525
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1id1V1-0003XA-Sm
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 19:29:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57471)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1id1TM-0002Te-6r
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 19:27:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1id1TJ-0001Zz-Lt
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 19:27:51 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:44563)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1id1TI-0001AO-3c; Thu, 05 Dec 2019 19:27:49 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47TYMJ0c3yz9sPV; Fri,  6 Dec 2019 11:27:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1575592060;
 bh=hkdQVuvsxFBBR2CVn2hrxb2oqpfdwP5VYVmtEm4PUzw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GHkM+bNnCHBFirpJ5ZjLFxNvkwoonEiUwE8DjtPX8KhuqEBxVEbzAqY84gcHcCCYH
 zXb9Qmq9TxgnLbWDn+ezMG5je1IGLfAeOiDSSpS40PXxW6dksXyQj9bOcWVSBsGwEm
 uldnI2OT1zMCsUyu4xn5W+QZhGDE8RGFyImYUB5g=
Date: Fri, 6 Dec 2019 11:02:17 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v7 07/21] ppc: well form kvmppc_hint_smt_possible error
 hint helper
Message-ID: <20191206000217.GG5031@umbus.fritz.box>
References: <20191205152019.8454-1-vsementsov@virtuozzo.com>
 <20191205152019.8454-8-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="nhYGnrYv1PEJ5gA2"
Content-Disposition: inline
In-Reply-To: <20191205152019.8454-8-vsementsov@virtuozzo.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--nhYGnrYv1PEJ5gA2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 05, 2019 at 06:20:05PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> Make kvmppc_hint_smt_possible hint append helper well formed:
> rename errp to errp_in, as it is IN-parameter here (which is unusual
> for errp), rename function to be kvmppc_error_append_*_hint.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy
> <vsementsov@virtuozzo.com>

Apart from Greg's point about the changelog,

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  target/ppc/kvm_ppc.h | 4 ++--
>  hw/ppc/spapr.c       | 2 +-
>  target/ppc/kvm.c     | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> index 98bd7d5da6..f22daabf51 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -28,7 +28,7 @@ void kvmppc_set_papr(PowerPCCPU *cpu);
>  int kvmppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr);
>  void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mpic_proxy);
>  int kvmppc_smt_threads(void);
> -void kvmppc_hint_smt_possible(Error **errp);
> +void kvmppc_error_append_smt_possible_hint(Error *const *errp);
>  int kvmppc_set_smt_threads(int smt);
>  int kvmppc_clear_tsr_bits(PowerPCCPU *cpu, uint32_t tsr_bits);
>  int kvmppc_or_tsr_bits(PowerPCCPU *cpu, uint32_t tsr_bits);
> @@ -164,7 +164,7 @@ static inline int kvmppc_smt_threads(void)
>      return 1;
>  }
> =20
> -static inline void kvmppc_hint_smt_possible(Error **errp)
> +static inline void kvmppc_error_append_smt_possible_hint(Error *const *e=
rrp)
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
> index c77f9848ec..27ea3ce535 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -2076,7 +2076,7 @@ int kvmppc_set_smt_threads(int smt)
>      return ret;
>  }
> =20
> -void kvmppc_hint_smt_possible(Error **errp)
> +void kvmppc_error_append_smt_possible_hint(Error *const *errp)
>  {
>      int i;
>      GString *g;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--nhYGnrYv1PEJ5gA2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3pmoEACgkQbDjKyiDZ
s5Ig+w/7BzCNFr8N8qqtlrsLTAmKCrDp9Eoru4b7YYFNiiO7hj0w1EhFmgcJOANl
wvFwcRm8x6nIdy33/JzoQkUpP9kHqxvXeS0I1xdPq2yYnBd2350PVY+ZFUq8Byx0
DRjoDxX45LFt1WmBh3JhEm8IMfDdT8mP8poL6tG99jrSRKKgttsMsg18XP7L2ohR
vaNDo/iVhEEL2fWR2izbaECZcn2l2naxR+tUSI/128DOoppn3O4736Sxre+E25f/
3gpNCz+4QvH0YltGTXhR+VtInpq7vRVMlJ/wm9JgzMLTivcQ3vRyPC6ayyMBT99c
C0MwE4xDVYsZb8yBVwW5VbrNWE26+nV0c8aY6JV0gU0V6KKjg0/WPB42Pp3TKFAW
M54SkHBha1pIHRNMIYhU1lrsl4WK3JjVC7TFzxoWq5D3elBtTeC9k5mO30Qkh6DP
eKTuiP93giq0tL/i33T80JofNxyrJOLTwvZSereW3PMhal492WDkTKOdIt79pQhF
5vZ+bIP97c7pZpqEPlkGeMo7QQSUBMmVhjs7D1tr6L2a8CfOQbuts91CmHiefEB0
5VcWvfsCZ0obCTKMFRiEVE1X1kRZ9YuGHBRUW5c6qLBsnaEkQ+VGa0WlyHtupNdZ
e/nKPikMErbU7kkbBVkmz3gW40KOUil+aoR7JjIjunpWq+KdgOQ=
=qCEn
-----END PGP SIGNATURE-----

--nhYGnrYv1PEJ5gA2--

