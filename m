Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF0F7C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 11:13:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEAF520791
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 11:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="JeIIFEHz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEAF520791
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6BAu-0005wK-Uz
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 07:13:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k6B7b-0000fv-5L; Thu, 13 Aug 2020 07:10:11 -0400
Received: from ozlabs.org ([203.11.71.1]:57179)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k6B7Z-0002oo-6S; Thu, 13 Aug 2020 07:10:10 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BS3kc2jyDz9sTd; Thu, 13 Aug 2020 21:10:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1597317000;
 bh=foQMAWmt7AjawlqZj8XJbw5C3NIXPcleCTuzk4f8zlM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JeIIFEHziX5jWZwGSjMdpBSxdAPPzevrbhcQT1sQeGZPV/mnGEGSxdQazboP//SDq
 wFh10yTPlWXcD5RpID9BFHYm9S/A08DfSFMlH/Lt7k4XUmnKJxqm5N/VDPPhnKfKUx
 liOwvMvWmQh3wIXPh7A74WUsK1Q+WGb5a2hCOIZ4=
Date: Thu, 13 Aug 2020 21:09:53 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 14/14] spapr/xive: Simplify error handling of
 kvmppc_xive_cpu_synchronize_state()
Message-ID: <20200813110953.GE6255@yekko.fritz.box>
References: <159707843034.1489912.1082061742626355958.stgit@bahia.lan>
 <159707852916.1489912.8376334685349668124.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="brEuL7wsLY8+TuWz"
Content-Disposition: inline
In-Reply-To: <159707852916.1489912.8376334685349668124.stgit@bahia.lan>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 06:45:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: qemu-ppc@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--brEuL7wsLY8+TuWz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2020 at 06:55:29PM +0200, Greg Kurz wrote:
> Now that kvmppc_xive_cpu_get_state() returns negative on error, use that
> and get rid of the temporary Error object and error_propagate().
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-5.2.

> ---
>  hw/intc/spapr_xive_kvm.c |   14 ++++++--------
>  include/hw/ppc/xive.h    |    2 +-
>  2 files changed, 7 insertions(+), 9 deletions(-)
>=20
> diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
> index e9a36115bed6..d871bb1a0016 100644
> --- a/hw/intc/spapr_xive_kvm.c
> +++ b/hw/intc/spapr_xive_kvm.c
> @@ -119,7 +119,8 @@ int kvmppc_xive_cpu_get_state(XiveTCTX *tctx, Error *=
*errp)
> =20
>  typedef struct {
>      XiveTCTX *tctx;
> -    Error *err;
> +    Error **errp;
> +    int ret;
>  } XiveCpuGetState;
> =20
>  static void kvmppc_xive_cpu_do_synchronize_state(CPUState *cpu,
> @@ -127,14 +128,14 @@ static void kvmppc_xive_cpu_do_synchronize_state(CP=
UState *cpu,
>  {
>      XiveCpuGetState *s =3D arg.host_ptr;
> =20
> -    kvmppc_xive_cpu_get_state(s->tctx, &s->err);
> +    s->ret =3D kvmppc_xive_cpu_get_state(s->tctx, s->errp);
>  }
> =20
> -void kvmppc_xive_cpu_synchronize_state(XiveTCTX *tctx, Error **errp)
> +int kvmppc_xive_cpu_synchronize_state(XiveTCTX *tctx, Error **errp)
>  {
>      XiveCpuGetState s =3D {
>          .tctx =3D tctx,
> -        .err =3D NULL,
> +        .errp =3D errp,
>      };
> =20
>      /*
> @@ -143,10 +144,7 @@ void kvmppc_xive_cpu_synchronize_state(XiveTCTX *tct=
x, Error **errp)
>      run_on_cpu(tctx->cs, kvmppc_xive_cpu_do_synchronize_state,
>                 RUN_ON_CPU_HOST_PTR(&s));
> =20
> -    if (s.err) {
> -        error_propagate(errp, s.err);
> -        return;
> -    }
> +    return s.ret;
>  }
> =20
>  int kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **errp)
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index 785c905357dc..2c42ae92d287 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -488,7 +488,7 @@ void xive_tctx_ipb_update(XiveTCTX *tctx, uint8_t rin=
g, uint8_t ipb);
>  int kvmppc_xive_source_reset_one(XiveSource *xsrc, int srcno, Error **er=
rp);
>  void kvmppc_xive_source_set_irq(void *opaque, int srcno, int val);
>  int kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **errp);
> -void kvmppc_xive_cpu_synchronize_state(XiveTCTX *tctx, Error **errp);
> +int kvmppc_xive_cpu_synchronize_state(XiveTCTX *tctx, Error **errp);
>  int kvmppc_xive_cpu_get_state(XiveTCTX *tctx, Error **errp);
>  int kvmppc_xive_cpu_set_state(XiveTCTX *tctx, Error **errp);
> =20
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--brEuL7wsLY8+TuWz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl81H4EACgkQbDjKyiDZ
s5K7jA//eGSKFcbwni5heY38uEoH86QkSVkxsBQ8pjmzsq+c+d3/Qd1g2Sz41LcC
HENxSvH9jZqNR4qTdEGUzZBwSs5pIACeZW31wCMhYV9AH7r9g3NXNyPJvctXevys
kLV0kWhOVvJq+Z39XtsHFLbsdQjTO28DalsBSjLxhdXqXwFhuvK8fvLOqzYp+XRh
bj/ZS8wUXuvE/x0oECa2bf/cDofT/1uRTOMpnFlweb6MQFzad2HqomEue/hSVVT4
w4xZn0aiWcGlnwHGzi/3f5+dn8wRDmkk5YtfGhDK8er+oeyGHFTo1Q44BoC7iRb8
fQaC8/DTyvvU5uHV3JHsUWH7ZtfuP8dmKKv9UGyGiqKSAM7rPstb+IKzH8CHMQ8H
09x0DnH4VfuHzS6evtnfDrzP+ZCDFTpHY9UoPau40Fc4P6D1O2hDkLoTog0Y/NEK
b6lhdsSgb3ZBADB3e6D3ZnU2/yRUxBVeyhJVN3sN4OxanxK/o61oVkRkzGWu6K0S
uN44fcfCdcW6+dnGbJwy7ZsOYO5s2eF4ulSQaFzaQhqJCFWtfO3j7h+yCYRcfq9i
iQ3MqqRhvPGagLoZzqSDDt7FBPCFMo6rxYihVDKIkmti4w/DUiX7bn2bYr14TeXy
WbiS37DDP8RzeBInZlr59a2ER6Y58PlGcbkkZq35af2fz4ZtU+g=
=YbcJ
-----END PGP SIGNATURE-----

--brEuL7wsLY8+TuWz--

