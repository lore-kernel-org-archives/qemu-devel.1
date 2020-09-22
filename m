Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B07C4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 01:26:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F42423A62
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 01:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="I0mcnmrc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F42423A62
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKX4v-0005JA-DH
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 21:26:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34160)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kKX4M-0004sh-1T
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 21:26:10 -0400
Received: from ozlabs.org ([203.11.71.1]:53867)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kKX4G-0006BF-T0
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 21:26:09 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BwNtB4P5dz9sTh; Tue, 22 Sep 2020 11:25:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1600737954;
 bh=e4kAdbjFVqxoM3qvCqMxzo/52ElOYuuBhaNFCOCtS64=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=I0mcnmrcdqoZs123Fjdu1vUnFkaveL6bYBVuPD7+e71IsUO8a/gCQsnsHmngn4jiZ
 hQBxEQ6XxVYmb8rtYwJQeWgWNDXntzIEx9uDEfYQzkkW1J0tIO+6hsLvM9X8eVwMBu
 pDGW8aqH4vvg8wmcAqR/BofTY2dtfVFjmD0uErP0=
Date: Tue, 22 Sep 2020 10:46:15 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH] migration: increase max-bandwidth to 128 MiB/s (1 Gib/s)
Message-ID: <20200922004615.GE17169@yekko.fritz.box>
References: <20200921144957.979989-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="M/SuVGWktc5uNpra"
Content-Disposition: inline
In-Reply-To: <20200921144957.979989-1-lvivier@redhat.com>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 21:25:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Greg Kurz <groug@kaod.org>,
 qemu-devel@nongnu.org, Andrea Bolognani <abologna@redhat.com>,
 David Gibson <dgibson@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Frediano Ziglio <fziglio@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--M/SuVGWktc5uNpra
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2020 at 04:49:57PM +0200, Laurent Vivier wrote:
> max-bandwidth is set by default to 32 MiB/s (256 Mib/s)
> since 2008 (5bb7910af031c).
>=20
> Most of the CPUs can dirty memory faster than that now,
> and this is clearly a problem with POWER where the page
> size is 64 kiB and not 4 KiB.
>=20
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  migration/migration.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/migration/migration.c b/migration/migration.c
> index 58a5452471f9..1c4174947181 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -57,7 +57,7 @@
>  #include "qemu/queue.h"
>  #include "multifd.h"
> =20
> -#define MAX_THROTTLE  (32 << 20)      /* Migration transfer speed thrott=
ling */
> +#define MAX_THROTTLE  (128 << 20)      /* Migration transfer speed throt=
tling */
> =20
>  /* Amount of time to allocate to each "chunk" of bandwidth-throttled
>   * data. */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--M/SuVGWktc5uNpra
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl9pSVcACgkQbDjKyiDZ
s5ILQA/+N7u84W+a7grYWHwPo3D+qGXjeBdG7Xq3ZvHlf/3qChvv/l7hsgJHPluf
GqjuH1fjrbsVjLB2z6fi7rBq7gXufBJPdA0fjWyAFmGywUJ5NCS0GzJPAGYxfi81
pv253MO+N7VC5p1q42DPjEoqeEzD80q8jmkUE2fvn8lHnHmZToRvvKE4klrndxbO
yn2tSEASmHly+EA8A/MeRAVqkJNEAEMc0qJMVh/GX5qtXlC6FUFN2sqEYYtu7sP3
FuCAp1d1Ow4JPTJMutguA1D1NkbYs6jFrvU+FUDv10efPgL8FTmMNBwggij9LO/2
oMKHGzCyKa0uXMEv2GaieOkhlErqWOfWd/YvYSxU7E2DPsjL++svOXtJ0LxgjQ0s
HdvCMa1UIxgHIp9/xaJJqniIsRGxIpjAIzrJF8TyQMdZuNTqoCpog/6c15NcqlsJ
0B3v32HWI5u4tUSxcvnFT2qcuSTY6A7PmktPsUXtU3alILFuMXvouf1hKHmE93+v
TD3SdZZYTaCPbFMSjjXDiuYBDadGm/4mj3J9Tl9nHTt47dHKkv7RM3+q6GURsbzp
KXG81ZA3tsAc6mLy40/XFPzJgEMuhCkgCwye6dfUsvhxiiwz6KuXRJvqgkEFXLio
qLE6qnBJS9/eLEK3ZMw43WXbed5337VYegG+NDl5LzL+YtKEeK8=
=smhN
-----END PGP SIGNATURE-----

--M/SuVGWktc5uNpra--

