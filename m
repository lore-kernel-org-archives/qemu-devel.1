Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A11FC5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 06:56:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5584220663
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 06:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="jC9E2IHp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5584220663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhqEc-0003RP-I1
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 02:56:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48061)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hhqDk-0002rx-NM
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 02:55:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hhqDj-0004sq-KJ
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 02:55:24 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:52709 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hhqDg-0004jB-7D; Mon, 01 Jul 2019 02:55:22 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45cdRK60qpz9s4Y; Mon,  1 Jul 2019 16:55:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1561964109;
 bh=8BXKtOLYhN/aRIuMesERv7H7+rTnn3EiRNh8Rss3M5M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jC9E2IHpwAe5qwL4f5+vnMl/KCrUApJaQ1uayWhQboewkEPlbzmaOLpKM0wmoKmeN
 xWN2lpf1OC9v6vLCaPN2j292L5SKQfyj1u7oo1S/gVWUh12FV1Q0KOo1y7Ii7dncre
 jn/E62g6ITiCA+RKrkwupdZu4GaWy5ymANxQ/1ks=
Date: Mon, 1 Jul 2019 16:52:15 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Message-ID: <20190701065215.GQ2138@umbus.fritz.box>
References: <156070574343.343123.16772707632470400458.stgit@bahia.lan>
 <20190619093617.GC22560@umbus.BigPond>
 <a2d8e209-4431-ec77-b5a6-8f755731e433@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="sBcizk6cgRZY6rnJ"
Content-Disposition: inline
In-Reply-To: <a2d8e209-4431-ec77-b5a6-8f755731e433@kaod.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH] spapr/xive: Add proper rollback to
 kvmppc_xive_connect()
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
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--sBcizk6cgRZY6rnJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 01, 2019 at 08:13:07AM +0200, C=E9dric Le Goater wrote:
> On 19/06/2019 11:36, David Gibson wrote:
> > On Sun, Jun 16, 2019 at 07:22:23PM +0200, Greg Kurz wrote:
> >> Make kvmppc_xive_disconnect() able to undo the changes of a partial
> >> execution of kvmppc_xive_connect() and use it to perform rollback.
> >>
> >> Based-on: <20190614165920.12670-2-clg@kaod.org>
> >> Signed-off-by: Greg Kurz <groug@kaod.org>
> >=20
> > I'm afraid this doesn't apply clean on my current ppc-for-4.1.
>=20
> With the patch you have taken, this one should now apply.

I'm afraid I've lost track of what's still left.  Can you rebase on my
current ppc-for-4.1, and repost anything that's still outstanding.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--sBcizk6cgRZY6rnJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0ZrZwACgkQbDjKyiDZ
s5JKPBAAgfThrlb6gB19uZvKhGbET7dFN4Rl9mtN16KnXRE681UZsx0JtnqbuV2f
IWYUFK+AWh93+4VUBHUtU4V3uvS9ruO1ZlQcOxd2FWrQ8gNdNYXampsiq32+h0gU
63kvAQBl5AUyl6+qP3Xog7guG07BI2UzQTchcVPX1ePS8v1t5/hxanQPsFmYY0qK
BWw0fSfIZbQrxWXVDsXG/QN8BKlYo8MZoY4qXg49disiogpY/ySof3i7bAA1g3nq
7h2MgPKfnd+XfN4SLGq7cLd5nCjLdWUTOZMa9EXBOVQgd3a5p1SoOWzqZIDd44XC
157OgyEB8+fD8szqhLdnWGwuVWSNhA9hoaf2OlqRWKf+gCDYLzRex+A1QTMy2A9a
AP1DUBOd8fbSpX1+6JAhAadjpUN7DfCpo6FDVowmp6CE3IGNtQBy45cVdQKAEsei
ui1RepaTYyqHUKQbAyq3nNHwMctArj5EmOfFer/nvwA5FpCWPoWOu7a8fYnhuQMu
Nxr+yGvCF8P7EzxvCSOksJjxB8O7Qz+jAqdKJatjCOYs/E77PHrVCxexCPCiaqk+
T0ZVvK6HQaq2mCioA7E6xVzk8ladxvO7WtPLTBj14ErIM9eieNXYyxuqbnAXLkSI
2voz7BUERPXdv3kn4qY05F2coAF+852ROVAPHuYNAVpw6kM4tPg=
=YEcb
-----END PGP SIGNATURE-----

--sBcizk6cgRZY6rnJ--

