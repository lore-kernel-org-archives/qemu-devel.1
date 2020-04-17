Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4DB4C352BE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 09:27:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9A1B206B9
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 09:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="VMMAoOwI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9A1B206B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPNHS-0004Ze-T0
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 05:27:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58928)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jPNGj-0003vi-OW
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 05:26:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jPNGi-0004Ph-1J
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 05:26:41 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:57433 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jPNGh-0004FI-12; Fri, 17 Apr 2020 05:26:39 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 493W1k35p5z9sQx; Fri, 17 Apr 2020 19:26:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1587115594;
 bh=gj+oTXydjebIj/8QtQS9oYeLjQSlQIB2KnLNFigsVI0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VMMAoOwI3QqBSYuKfxigQNYJzkGdjcC2ku6T0SraTfIxP4fHS3Pu7YN4my/OMcG8n
 bQS2BqRzPFC3hSLn25GXt3n+z3RO13LpPtM7M6PTHJLSBHt02Ym2ExXe6t85e2Uvel
 YFeYxJksNA3xnpoR5/Zpuy/UtmZqdJS7oDXTzEqQ=
Date: Fri, 17 Apr 2020 19:22:30 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 0/3] ppc-for-5.0 queue 20200417
Message-ID: <20200417092230.GF2102@umbus.fritz.box>
References: <20200417050514.235060-1-david@gibson.dropbear.id.au>
 <CAFEAcA8qLznGS2YCFxz7QYrhbociZsqzEcxQPdp1rUy4OnnnFQ@mail.gmail.com>
 <20200417091431.GC2102@umbus.fritz.box>
 <20200417091812.GE2102@umbus.fritz.box>
 <CAFEAcA8xOqLo==umgMY+N9UvpkH8w61epP52y+vuAaQkyoqxYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="eDB11BtaWSyaBkpc"
Content-Disposition: inline
In-Reply-To: <CAFEAcA8xOqLo==umgMY+N9UvpkH8w61epP52y+vuAaQkyoqxYQ@mail.gmail.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>,
 Greg Kurz <groug@kaod.org>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--eDB11BtaWSyaBkpc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2020 at 10:21:34AM +0100, Peter Maydell wrote:
> On Fri, 17 Apr 2020 at 10:18, David Gibson <david@gibson.dropbear.id.au> =
wrote:
> > On Fri, Apr 17, 2020 at 07:14:31PM +1000, David Gibson wrote:
> > > But, I guess throw them in if something else does force an rc4.
> >
> > Oof.  Such as, perhaps the TCG temp leak in slbia.  That one *is* a
> > regression :(.
>=20
> Yeah, but it's basically harmless -- it's invisible unless
> you deliberately build with debug, and it would only
> cause a problem if guest code had a huge long run of
> slbia insns all in a row, which it won't unless it's
> being deliberately silly.

Yeah, fair call.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--eDB11BtaWSyaBkpc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl6ZdVUACgkQbDjKyiDZ
s5I5nQ//cz61MHGBBXICSYZkGQ15lPsXx1zPpkR9Qi2WhmzAPARuTOSG4WVr2PUi
D3y2WkHZ/aHhXLq8elBAxBiOsiTyfK3h0OHDM9e6w78xa1sZK3NPgyMstS3gWwv/
gxh70z0KkQXZYv0VZ8W6qyrjv9PZdSI+547fjuezRZa2T5yMRhLZEJUJoCfqQ7qO
QjubXfHrmUUweQkNB8yTYF43EvAmRuPA25czpcFz8nrQZR6lSYteDh8BCnfIUjOv
g/28dihMgIcruQXl3ACN3ffO6wGS7RE2NCL1N35U0YyE0qoMlqQuaqOJsvlCD5HE
HFZoDMcdmy1EKaWF2TUmd8VOR8GLqtXw5L4LxOhmUK7wXhyJG/Qr4oZ5XhdZMu+t
QP2ZXSntKhfoL8tCzJIWoQDYHxG/Fj5N32BTc7q62CqXID/29/wm1/T3t8/TgqXO
EZBoBGh3T/xi6AYz2FcBsub8p6WMcma/mHlJ+uR+LdgqTPUwQYUKWmFtzyPeUBBr
3fSXcxzp3q2yPIBkvVdTdtJbPQbM98rTtZQM9ft5LI2DrgTdkU31tqLTgW+Xw4wJ
aaw+Sv+043+ezr+6HjjqOPtxuVdpPFKrxCDAF8M+Y6yayvfwKU1NPZJi5dm88HQG
8qkm0ooYpKnoXYC8HXVwuyFkWa3Prmw7jZX+jRkKNDsglWNclGs=
=ZnND
-----END PGP SIGNATURE-----

--eDB11BtaWSyaBkpc--

