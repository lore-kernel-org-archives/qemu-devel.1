Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBE3C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 11:36:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36F7E2078B
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 11:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Bq3OzQjT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36F7E2078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k95La-0001yv-FR
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 07:36:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37946)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k94eM-0008UC-Gf; Fri, 21 Aug 2020 06:51:58 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:59401)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k94eJ-00058y-5k; Fri, 21 Aug 2020 06:51:58 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BXyxw6qFbz9sR4; Fri, 21 Aug 2020 20:51:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1598007108;
 bh=+spgGaH6U9/mqSGv17WVEOOGe6VWba8ySCJcnoWPGvo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Bq3OzQjTIL0axj4klTDvN5xl4EHqvaG8t2p/XWzrMIVyFDVmZLkFigiA7S6O8WxZq
 NXEf2zFQQRabEdBNNgOlRhdCF9hhAShgBCGVpPXibEWVkdaI64TypSXU+Lehmvsh3p
 y1nmTzE2uZVwjqsNNrfXR7Hj5D0whK15yEBrXtDw=
Date: Fri, 21 Aug 2020 17:01:53 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2] spapr/xive: Use the xics flag to check for XIVE-only
 IRQ backends
Message-ID: <20200821070153.GX271315@yekko.fritz.box>
References: <20200820140106.2357228-1-clg@kaod.org>
 <20200820232237.GU271315@yekko.fritz.box>
 <83b3dff5-0b6c-699d-cc29-577ee009d038@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="R0SsnouPYaG+7rP6"
Content-Disposition: inline
In-Reply-To: <83b3dff5-0b6c-699d-cc29-577ee009d038@kaod.org>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 6
X-Spam_score: 0.6
X-Spam_bar: /
X-Spam_report: (0.6 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=1, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Gustavo Romero <gromero@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--R0SsnouPYaG+7rP6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2020 at 07:39:34AM +0200, C=E9dric Le Goater wrote:
> On 8/21/20 1:22 AM, David Gibson wrote:
> > On Thu, Aug 20, 2020 at 04:01:06PM +0200, C=E9dric Le Goater wrote:
> >> The sPAPR machine has four different IRQ backends, each implementing
> >> the XICS or XIVE interrupt mode or both in the case of the 'dual'
> >> backend.
> >>
> >> If a machine is started in P8 compat mode, QEMU should necessarily
> >> support the XICS interrupt mode and in that case, the XIVE-only IRQ
> >> backend is invalid. Currently, spapr_irq_check() tests the pointer
> >> value to the IRQ backend to check for this condition, instead use the
> >> 'xics' flag. It's equivalent and it will ease the introduction of new
> >> XIVE-only IRQ backends if needed.
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >=20
> > Thanks, applied to ppc-for-5.2.
> >=20
> > I still kind of want to remove the last vestiges of those
> > "backends", but I'm unlikely to have time to do so soon.
>=20
> What did you have in mind ?=20
>=20
> Move the 'xics' and 'xive' flags directly under the spapr machine ?=20
> It would add state.

Looking at my draft patches, looks like I was planning to replace the
flags with spapr caps.  IIRC there was migration breakage with my
draft, though, can't remember what would be needed to fix it.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--R0SsnouPYaG+7rP6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8/cWAACgkQbDjKyiDZ
s5IOFBAA0ELEyT3d7J9nrjNyBhSmjQseVzBeQV6ltUcFDuVtaxKdzPDgNdpE1iec
vBpTDVkEEoKGGa5+BLcER6RADfgA9P/2IVeW7k1FCxtaFmxpDMM+/UgbqsTkCdHo
ifnotD+gkyITfU5IEBL1OUEFx512XiEQVEiGfiyfiMvs57UOxH6w+eP9O3NMayja
+eBpx4O7fphiZ9paGGT68NfhpUv4srIyP4OfZM2P5zf4kMUgiwaslY4xNO0Pd07J
Pd3Cdbxa1BT702ONn7dclTCaMQ2Ai4LyXjT3hrAqEeY/S/jjnEOQfnpCQr5JZhcf
uBmuRJ2IaOwriGlwHMzUyjo+S87SrGT9NQZUJTy8365tWDHqiz/FZEESr80XHCkO
hWgdQ7ym17q/Hx2P1fbHKr6s/R6WzHUHzBoFgKleYl5mPqTFbMJifAarm8Fnpsxp
QYdX8NnuariDaLu2R9aM37KMsN1c0M65kCJDdZ5jQ54RoB0Fn2ppGTWFopm2+t/n
h3uNwzwGpfXelBcyVzchFk8pDyJA+ODdhWy0BkkGtk+COqTe8nstlsrLnyEnd5ES
2l7uqKpybi6AYIzV++n53klwBAjHu9+Cv+hCJdofMR04kkCU7bCq3bCWK0POwbUN
CpJ6FxXBuhEiBx0TameaI1gpkwyJraRenqlyrLN2I561C6xNGoc=
=K3P/
-----END PGP SIGNATURE-----

--R0SsnouPYaG+7rP6--

