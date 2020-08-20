Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8922DC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 00:07:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53BC820702
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 00:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="fVcPyMd3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53BC820702
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8ub8-00031x-LR
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 20:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48700)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k8uXI-0007fO-P8; Thu, 20 Aug 2020 20:04:00 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:54369 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k8uXC-0008I6-VY; Thu, 20 Aug 2020 20:04:00 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BXhZF29ywz9sTW; Fri, 21 Aug 2020 10:03:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1597968229;
 bh=awmz4G1fz+JyodTjpJ7Hyqh2y9/Se62bIq1kBMeAcyI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fVcPyMd32+tJpMn35DEFTLTUQFlvzlS5gV02Zb9EUjqIP9CwLnMEOFrSbMbFbvTVW
 XB0XdUC9rE0EtvCnD3ta0qDDcifIVtN9JMnkyWQRFteXUKXss/SKb9wTUvGdN+Z+C2
 qVu9tRZFFIBgNabotD3Pr8sIZvajptWw6A8lvnV4=
Date: Fri, 21 Aug 2020 09:22:37 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2] spapr/xive: Use the xics flag to check for XIVE-only
 IRQ backends
Message-ID: <20200820232237.GU271315@yekko.fritz.box>
References: <20200820140106.2357228-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="aZ/0/p6gSDXwzas7"
Content-Disposition: inline
In-Reply-To: <20200820140106.2357228-1-clg@kaod.org>
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--aZ/0/p6gSDXwzas7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2020 at 04:01:06PM +0200, C=E9dric Le Goater wrote:
> The sPAPR machine has four different IRQ backends, each implementing
> the XICS or XIVE interrupt mode or both in the case of the 'dual'
> backend.
>=20
> If a machine is started in P8 compat mode, QEMU should necessarily
> support the XICS interrupt mode and in that case, the XIVE-only IRQ
> backend is invalid. Currently, spapr_irq_check() tests the pointer
> value to the IRQ backend to check for this condition, instead use the
> 'xics' flag. It's equivalent and it will ease the introduction of new
> XIVE-only IRQ backends if needed.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Thanks, applied to ppc-for-5.2.

I still kind of want to remove the last vestiges of those
"backends", but I'm unlikely to have time to do so soon.

> ---
>  hw/ppc/spapr_irq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 80cf1c3d6bb2..d036c8fef519 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -172,7 +172,7 @@ static int spapr_irq_check(SpaprMachineState *spapr, =
Error **errp)
>           * To cover both and not confuse the OS, add an early failure in
>           * QEMU.
>           */
> -        if (spapr->irq =3D=3D &spapr_irq_xive) {
> +        if (!spapr->irq->xics) {
>              error_setg(errp, "XIVE-only machines require a POWER9 CPU");
>              return -1;
>          }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--aZ/0/p6gSDXwzas7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8/Bb0ACgkQbDjKyiDZ
s5JiPw/+IaOWccL7+wmdrXqpPtp+N/61+mMSpqoG+A727Iu6UPmPnDUzSY8HDPxE
4BnW+EYOjvmwnXzTyj4otPHc3Zjjl+2JKY5r93hhv1/BHc1ldjX8SG69zNE8NT0F
fboiopqPCcV1+E4YJO7EUCNdaEBl6B2znpp7o1Z7Z7MyHhkI38hfsj2wBQebzIOa
+kuVGhjRTMTkZffnfOnu6EBfsHhF1RLYN08eBnCQaIHJnu1zNGnnIurl72RG4gRv
qu/lcgo/iFY6HFv98CMg/z2mK1dYGzq5oLGY/eRBiH5iwVDG+RpQuDy0F44A4Nfu
pRoUIYcv4zqdc+iSIeMvgixLudZY53KhUrKGZby4CJt92wU5gqkV9eoGO8L5oWQd
a9hU5FuVHBzTcYBFEaTRc8qJttlJJujG9+r0qNwaYtgWPak6L4EWb03V2WlA0L1R
CG951LH85TnboRzX0EoyC/DV7CrticF8qI8kSkxPMiV9uDKt2E6nSXUzW61qNAqt
9D3+Toz42BWh7RbccgMEqMuIV9VMtT6iypF3Ch8x+lD9SxUXXfSa39H3+LPkiFQ4
159dwo2iwFv2/GzhpE0QwNphoYrB6G3YvXAHJ2vPFfeQ5iREc+3sZ60B+fh5yCfQ
hgizEzbibeNJpcmATZ7tkqQe29B5oY5u+9Iv3bhp4X/xgPKMNes=
=clqF
-----END PGP SIGNATURE-----

--aZ/0/p6gSDXwzas7--

