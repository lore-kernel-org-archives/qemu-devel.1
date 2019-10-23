Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0605CA9EB9
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 03:09:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78DFA20684
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 03:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ga4fzf79"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78DFA20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNTVX-0000hi-Fd
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 23:09:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53796)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iNTTK-0006QJ-1X
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 23:07:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iNTTI-0002s6-G9
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 23:07:33 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:39173)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iNTTH-0002nG-43; Wed, 23 Oct 2019 23:07:32 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46zBxS0qnbz9sNx; Thu, 24 Oct 2019 14:07:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1571886444;
 bh=TI2K2tEnS6VS21LfD8G/xnEySo+P63uXvyLkCf2hCj0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ga4fzf79k3ESUsx5ftBAMHpjua4i1MU7U0eGk66dJ89X2+h68fswHm4cN2ZSsqegx
 H/gpnbwk4dui+KgaTcSQEO4EVyE9rhbm4yj0bQ9OgCVzno8cHJDPi7QITvdPRDsWss
 nQpsrXqYdyX/rgJm9NuM5Y1JV+RJ2OeQO7AkUTLU=
Date: Thu, 24 Oct 2019 09:38:17 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] spapr: Don't request to unplug the same core twice
Message-ID: <20191023223817.GL6439@umbus.fritz.box>
References: <157185826035.3073024.1664101000438499392.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="V3eawNQxI9TAjvgi"
Content-Disposition: inline
In-Reply-To: <157185826035.3073024.1664101000438499392.stgit@bahia.lan>
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--V3eawNQxI9TAjvgi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2019 at 09:17:40PM +0200, Greg Kurz wrote:
> We must not call spapr_drc_detach() on a detached DRC otherwise bad things
> can happen, ie. QEMU hangs or crashes. This is easily demonstrated with
> a CPU hotplug/unplug loop using QMP.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Ouch, good catch.  Applied.

I wonder if we have the same problem with other DRC types.

> ---
>  hw/ppc/spapr.c |    7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index f9410d390a07..94f9d27096af 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3741,9 +3741,10 @@ void spapr_core_unplug_request(HotplugHandler *hot=
plug_dev, DeviceState *dev,
>                            spapr_vcpu_id(spapr, cc->core_id));
>      g_assert(drc);
> =20
> -    spapr_drc_detach(drc);
> -
> -    spapr_hotplug_req_remove_by_index(drc);
> +    if (!spapr_drc_unplug_requested(drc)) {
> +        spapr_drc_detach(drc);
> +        spapr_hotplug_req_remove_by_index(drc);
> +    }
>  }
> =20
>  int spapr_core_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--V3eawNQxI9TAjvgi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2w1lkACgkQbDjKyiDZ
s5IMMxAAgCxa35gi8c2yiuv2T6l51YksYKxQq5DokiblWiy0JdLVc+QfyeB/JFnE
nqAGVq0SDexRWBYT4Pz38Ccn7Vi7PEw3q1GcEhELtPoEg0Hs63YpWfOV8eThiJSH
H7ln6eOY2w3j6ArvYouGMA1XArKZ/l3kC8A+p/cVTQ3MDGt6X9TunHmwKytCfHN7
9a9FV6alY2fMgk7gV+R9epS2rFXqvPewCTUfEuM1mPbRX8KnTzXVisA1bJBR0fij
xqVcKfT72NUohtL24/gN5Rab1hBpmPJQ3/mV7PbPUjQFLb/RHUut4iOJEvyxpIeZ
aEKfPpmUg8VUZRMzOLPKAOIbIxI+4Rv0hUcUbl9UgfriqDf2H3CN1FOP7HTJNelV
zQKa2tCsaGLTeJzb9gJtnTkzMNaCh/YdFkxyvJAefULalBAr0mhufJwc1V80KdEO
WWBkrwYGz5xf88NajeqUC0VUZeHJsTjq9a+uuyij2p+vbWkSrdc97VKM8ogvIA5+
u7Qstv6tgSThpcM1R0YfP7tl6YtlpPVOPDvvsVM9+lioM9U2vgZAKIjgc9NvYCtY
dM4C3MmurHU8j85R6t5JXHz0Nq/EP3KbwudSvABAYwaPx2zm4KhnBAG65PU3800m
6WSe0/o2XMnLedPYIk9HX/MS9THAS/5cg3AOWbmjO4Co+ezJFyc=
=iNu5
-----END PGP SIGNATURE-----

--V3eawNQxI9TAjvgi--

