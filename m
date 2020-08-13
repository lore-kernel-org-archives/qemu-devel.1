Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 288B5C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 10:48:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E37F920781
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 10:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="gMF2bjCH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E37F920781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6Amj-0004pn-2y
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 06:48:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k6Aja-0008CK-S7; Thu, 13 Aug 2020 06:45:22 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:58949 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k6AjY-0008ME-On; Thu, 13 Aug 2020 06:45:22 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BS39z0KLCz9sTj; Thu, 13 Aug 2020 20:45:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1597315511;
 bh=q4gYJWkIdYjm9hJUn0/xiTHgYeLWh7RS1NWQY8LP+6c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gMF2bjCHtkD7xFunJa98527QPOOQev5LZC/UGN474Bnrq3Kpw4+dTb+hCSWlfZyNI
 2EV5EIpmDlEDLTL2WsbAtNvxKggHuEnGOsRL7pb8eiXplk20z0msLNOTduOqUJAnu0
 ezRQ2TazWxndsE3yq4u6mt3nHzlvjaU6Q9dIbwxg=
Date: Thu, 13 Aug 2020 20:28:42 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 09/14] spapr/kvm: Fix error handling in
 kvmppc_xive_pre_save()
Message-ID: <20200813102842.GL181791@yekko.fritz.box>
References: <159707843034.1489912.1082061742626355958.stgit@bahia.lan>
 <159707849455.1489912.6034461176847728064.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="p7S+EREVcBHk3zUG"
Content-Disposition: inline
In-Reply-To: <159707849455.1489912.6034461176847728064.stgit@bahia.lan>
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


--p7S+EREVcBHk3zUG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2020 at 06:54:54PM +0200, Greg Kurz wrote:
> Now that kvmppc_xive_get_queues() returns a negative errno on failure, ch=
eck
> with that because it is preferred to local_err. And most of all, propagate
> it because vmstate expects negative errnos.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Fixed a conflict and applied to ppc-for-5.2.

> ---
>  hw/intc/spapr_xive_kvm.c |    7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
> index f2dda692183b..1686b036eb2d 100644
> --- a/hw/intc/spapr_xive_kvm.c
> +++ b/hw/intc/spapr_xive_kvm.c
> @@ -604,16 +604,17 @@ void kvmppc_xive_synchronize_state(SpaprXive *xive,=
 Error **errp)
>  int kvmppc_xive_pre_save(SpaprXive *xive)
>  {
>      Error *local_err =3D NULL;
> +    int ret;
> =20
>      assert(xive->fd !=3D -1);
> =20
>      /* EAT: there is no extra state to query from KVM */
> =20
>      /* ENDT */
> -    kvmppc_xive_get_queues(xive, &local_err);
> -    if (local_err) {
> +    ret =3D kvmppc_xive_get_queues(xive, &local_err);
> +    if (ret < 0) {
>          error_report_err(local_err);
> -        return -1;
> +        return ret;
>      }
> =20
>      return 0;
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--p7S+EREVcBHk3zUG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl81FdoACgkQbDjKyiDZ
s5LW2g//bVyimU08Lhv86FfCJe1g1KHA+hCGJfjY4VrqFcbux/z+k3RFzEOO5P9V
ebDFL0+gIocYaxNVh2lE0hu1D6bm4XOzfGCG5/3+CnWQSKcIMRC+5hGggRG6NvTK
vP5AufCsy7UEMbogcO5iXQzAG9adOsi6sA/cRpg95IBZXMUQWh9VtYf3Be0Ym6gY
Ubw6i+6VFvu4ZoEKu8yVlWUKxN5QDo17liXbI0nfnZMJo1gZ3nSeQGWzlmiHea+5
ljInDKWY6nOS0AJm6TKIkkZ1q/p6d9uNdcpFWWN9q7EGQVlfVAr3JLnxMN3K65HU
szgLC/iqklcLRPIKlmSz330vv0XhnLq2xS+bL16OKHNAd2Pp7qzW0C1HAG5ExqT2
2sRsTXah/h4z3ywPKKWM1Eijr6lKug0+6jMKo3lB/VtwJbtZnTVsL+As5xkwFxrR
DP8853YaFoDHD0Q8oEZRNcnG+vlEMVFI2+z3TJhjvI4zuyrjVMW/SsjcHMUf9FPD
ZvJc7QqiFy2aC7efSmZ9g1M6QjgO3v97fvOtV/58AhXL2TAQMkX1Z+Tm1RMlslpx
3n/x2KVL01yONQUmN0RfvZdpQUC7EhFIZ98lgTqj6sPZcSukYzzTVrbiEWg4JJMv
tX/oa/XyauWcYgNBl3lGhhFy+KG7Oc/0riKx0oO6VEtoB0UkUt8=
=yub7
-----END PGP SIGNATURE-----

--p7S+EREVcBHk3zUG--

