Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B45C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 12:13:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F6B32084E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 12:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="YwaPQsUg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F6B32084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60376 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heIQA-0002Dd-Bw
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 08:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58787)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1heILU-0008Pl-B3
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 08:08:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1heILN-0000sS-2B
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 08:08:41 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:51313)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1heILK-0000dJ-J5; Fri, 21 Jun 2019 08:08:36 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45VcsJ09GCz9sN6; Fri, 21 Jun 2019 22:08:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1561118900;
 bh=s0hDjapZ0r6IfUsybwCFZqy1wsEY+F8HOHSpAneEiAE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YwaPQsUgy6zT8+eHtKPRhNSUt3Py36hdS6l4u40kre1fjxzEWGdjRHICPQc2KWCXR
 2V05FQH3VtIWBRJC0Mp7tYVZVtxJetK9jsIk58VvEphO5OEJcuM5PLMouWG6t9Gjzi
 HISbMvqWPx3faMe5b/aBK/nqw8BSVifehq4cvlak=
Date: Fri, 21 Jun 2019 21:59:11 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Message-ID: <20190621115911.GH8232@umbus.BigPond>
References: <156051052402.224162.13664250996245267046.stgit@bahia.lan>
 <156051056289.224162.15553539098911498678.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="CNfT9TXqV7nd4cfk"
Content-Disposition: inline
In-Reply-To: <156051056289.224162.15553539098911498678.stgit@bahia.lan>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH 7/7] target/ppc/machine: Add
 kvmppc_pvr_workaround_required() stub
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


--CNfT9TXqV7nd4cfk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2019 at 01:09:22PM +0200, Greg Kurz wrote:
> This allows to drop the CONFIG_KVM guard from the code.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied, thanks.

> ---
>  target/ppc/kvm_ppc.h |    5 +++++
>  target/ppc/machine.c |    2 --
>  2 files changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> index e642aaaf9226..98bd7d5da6d6 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -399,6 +399,11 @@ static inline int kvmppc_resize_hpt_commit(PowerPCCP=
U *cpu,
>      return -ENOSYS;
>  }
> =20
> +static inline bool kvmppc_pvr_workaround_required(PowerPCCPU *cpu)
> +{
> +    return false;
> +}
> +
>  #endif
> =20
>  #ifndef CONFIG_KVM
> diff --git a/target/ppc/machine.c b/target/ppc/machine.c
> index 5ad7b40f4533..e82f5de9db7c 100644
> --- a/target/ppc/machine.c
> +++ b/target/ppc/machine.c
> @@ -378,11 +378,9 @@ static int cpu_post_load(void *opaque, int version_i=
d)
>       * receive the PVR it expects as a workaround.
>       *
>       */
> -#if defined(CONFIG_KVM)
>      if (kvmppc_pvr_workaround_required(cpu)) {
>          env->spr[SPR_PVR] =3D env->spr_cb[SPR_PVR].default_value;
>      }
> -#endif
> =20
>      env->lr =3D env->spr[SPR_LR];
>      env->ctr =3D env->spr[SPR_CTR];
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--CNfT9TXqV7nd4cfk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0Mxo8ACgkQbDjKyiDZ
s5IXaBAAtFm2Yi9vvcmwxdNerbhDzof1oHKwjI3QSZg26wVJVL/tqtJnjx1HGrl+
lR2A5cFXzh1zuxpd8utdJIkQnvb/miJmqN7A/RWBZcDUI9E2YtnS+E/IkwSE0yEy
CJ7Okx0vC3Pn33/87GYuDfxqRw9GceNGgafi5rzbyoJbIXzSfpErrsxppuFa0krF
z8TmLHaD1V+W/vK6JaK+yqihXjrK6YsLHMEm8Gp59NxWysXhqhXqEvQxudPYc8if
2fFWOqbV+GkhX/eJY6joIkPvvXTM/B2LcBwFY492S5lmQOkwwzfofUWhknErbFkg
tudM/AE839hTnwWlJPmgGBZXiw2iB4jQJER7yJ6ps+EBnyfw+FEIpO4NAB7sk6Up
4V0pyEyLcjiDqtc/JmTMiPf8ezYYOEk/kNIqa5rbCVxU2epXPvouymWxaAvWIOUf
Kvr6CFvBkYGEyRfAiPjHuGTJptugPQtEX824KN6JeZ9ZAmfyVAAbDreIgG5hEiwn
QP/Uz36MJ0Geq/6OFtoiOqES5yU9h1QlllDU/4qCETRjRe2PC/Hy219KVrntrRkt
i/kEGlxh30HS94MmUVLRquvPH2jPiSbN4RfDj58IFIj+xzP8DlgLRcVNpv2AjWMJ
IKwCSsBDjXGNMJknZK7y5tQ1nkZixDIMz7/PYs13ecAwDmkOSZQ=
=Tp+6
-----END PGP SIGNATURE-----

--CNfT9TXqV7nd4cfk--

