Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27821C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 00:29:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7C1F22525
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 00:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="SUoOYG7Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7C1F22525
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1id1V4-0003Yy-64
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 19:29:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57469)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1id1TM-0002Td-5m
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 19:27:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1id1TJ-0001ZK-I0
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 19:27:51 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:49661)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1id1TI-0001A8-4O; Thu, 05 Dec 2019 19:27:49 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47TYMJ1XLJz9sPL; Fri,  6 Dec 2019 11:27:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1575592060;
 bh=5YnCg5ji1cOdyo/P6jq97Dfnd/Wo3RNc5OXBWkjVHrY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SUoOYG7YqQazDxCI9qhFf6IHDu9ySAjawd+H6KLpxFWNy9x7X5oZcQb+ppwdnJM4/
 qJSQrpAjFLDTh6YMcvtWkt8Qq2164Pmo1rQl2IuRhxZR0fk7qgee415Xl1YdZAOMGc
 x9a/pZ9+geQM5BJirx5XyaHd+AzJXcGnQ/+v2PdA=
Date: Fri, 6 Dec 2019 11:03:43 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v8 07/21] ppc: well form kvmppc_hint_smt_possible error
 hint helper
Message-ID: <20191206000343.GH5031@umbus.fritz.box>
References: <20191205174635.18758-1-vsementsov@virtuozzo.com>
 <20191205174635.18758-8-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="pfTAc8Cvt8L6I27a"
Content-Disposition: inline
In-Reply-To: <20191205174635.18758-8-vsementsov@virtuozzo.com>
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
Cc: Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--pfTAc8Cvt8L6I27a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 05, 2019 at 08:46:21PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> Make kvmppc_hint_smt_possible hint append helper well formed:
> switch errp paramter to Error *const * type, as it has uncommon
> behavior: not change the pointer to return error, but operate on
> already existent error object.
> Rename function to be kvmppc_error_append_*_hint.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Greg Kurz <groug@kaod.org>

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

--pfTAc8Cvt8L6I27a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3pmt8ACgkQbDjKyiDZ
s5Lt8w//eMkuCs3v2svlWS3nZ98IhymwRk37PQkdztFghZa9TeDL3ZBh81eDoHMG
gU3h1slBtfy6jjd4ohw0AQMgltCXWENGJYI5IwNbiznnUFIWfuNedigXDvsozoow
3Cyoc4kH5DWNhM3Cd+YuqxmhHNHFuXiNR95B6Ojp/sPt/FCYVZ3iJZTjDLR8f4JG
veLJ7rr7dCUgK/UZchuDYVGiy/YdmDpwD9RGbZxCejKyDG3ePn/qQ93GwxZXElJz
0k0AyCzVYucET/vDmC/JjexOb6wZEsQFrt6D+OLq3ElcqHCV0ZRCvccBVNKdZKZ0
Wo3nxEFVxqbBoCIcyO8EKm/rlAO+pJfXI9o5Jl4aJbJoTqHNY31GoZkTtWkthLzS
h96hTHT1JaT8Ap6bewBwTIQm2BxunfUEWWNRCvIRED/xYMWqkoDtJw5TPGqYLzRN
yzBGoB4dmmsIPY4MX3Ac8Kf/uzGSQaEgXDAQlzWNvK4PRRw7z1iXQk28gb+qv4+X
I1raP2jIuT7VU7VA+kTTOzMmI/vqOAP+Ktw5LF89GSPGNIZV27IfITESw9adM/yW
qj73kWAs+/pRbjrXuhEZ9rznLu3X+OAkaYUxPXmIkXYqqMpbzdpuelcaMehWo7Sf
oX2clM4nHp0hf2Jy3nLsuF+ZJmSrijNRi+10TFkmL6isueh8acI=
=Eapp
-----END PGP SIGNATURE-----

--pfTAc8Cvt8L6I27a--

