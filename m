Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A3CC49ED7
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 02:23:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09655206A1
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 02:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Q1cjGqIs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09655206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iA39a-0003h2-86
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 22:23:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40445)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iA376-0002B7-LO
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 22:21:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iA374-0007sO-Ux
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 22:21:08 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:51703 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iA373-0007mN-W8; Mon, 16 Sep 2019 22:21:06 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46XRfy5SkZz9sNk; Tue, 17 Sep 2019 12:20:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1568686858;
 bh=0R8EtS6fboExl+R/+cwbXQ2TK5o4KyCJyyOHHrT6nY4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Q1cjGqIs81Du3ivTb34fNvDHbcSleh+akQkH1hD3HPz7R5BabpDTBW2+/ch/eddGy
 zllDziIP+WAcq8RU0IbnrM7D0WDZnk5uzVNdnjohA5D7XdchYOqxyMrUJW0oaEyfdJ
 ISvICOf+sYnL9laPCCnvOIV6BkDs8mg9eqJRNIm0=
Date: Tue, 17 Sep 2019 12:03:20 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Message-ID: <20190917020320.GA8842@umbus.fritz.box>
References: <20190911093951.6244-1-alex.bennee@linaro.org>
 <8f76ef47-0cf8-c662-0100-d416f5f2e0c1@linaro.org>
 <20190916014858.GH2104@umbus.fritz.box> <87pnk01z99.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
In-Reply-To: <87pnk01z99.fsf@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] target/ppc: fix signal delivery
 for ppc64abi32
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
Cc: qemu-ppc@nongnu.org, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2019 at 08:22:42AM +0100, Alex Benn=E9e wrote:
>=20
> David Gibson <david@gibson.dropbear.id.au> writes:
>=20
> > On Wed, Sep 11, 2019 at 10:33:45AM -0400, Richard Henderson wrote:
> >> On 9/11/19 5:39 AM, Alex Benn=E9e wrote:
> >> > We were incorrectly setting NIP resulting in a segfault. This fixes
> >> > linux-test for this ABI.
> >>
> >> Perhaps better:
> >> We were incorrectly using the 64-bit AIX ABI instead of the 32-bit SYS=
V ABI for
> >> setting NIP for the signal handler.
> >
> > Applied to ppc-for-4.2, with Richard's updated description.
> >
> > For future reference, it's better to directly CC me on such patches.
> > I only barely keep on top of the mailing lists, so if you just send it
> > there it's likely to be some time before I pick it up, or even get
> > lost entirely.
>=20
> Should you be added to linux-user/ppc/ in MAINTAINERS?

Hm, maybe.  It's not like I know much about the stuff in there, but
it's also not like anyone else is paying any attention to it.


>=20
> >
> >>
> >> ?
> >>
> >> >
> >> > Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> >> > ---
> >> >  linux-user/ppc/signal.c | 4 +++-
> >> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >> Anyway,
> >> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> >>
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2APuUACgkQbDjKyiDZ
s5KKSA//RhbEfsROOfUk9579623UQyjYDb/Sh2+Hsik3WMgsNP+9gXyuKEVFRPRM
SgK9qGy67ZDXxKeu7gf1Brh+YMFm6bcj0U88jr36SkxsB2olvj8baUyZFQNE9HBB
ByRAJBLHWL0euoekBslXeKbHUJlbmxxsYFM1DVbXRMuKi8hBlMUWJPJOJnc7ndTr
sN37Ti60iNuuZ5zfVl4P2vn+cL+Bm6XXUnpKIJNmmXK4SK2n2/3h29QFxUMvUrfs
FSBq+7W3BNbVlW3RP84R+qkMpkhrS4Dr32G/HnWkULu1ZffudpWJgJ4MIKx/MJNS
MiLX3Z8MwB0W5BvYuXN8ZoL0q2zuOjFETWTa/OjLoKDEPuigWJWZmx/L7PTyY2Yv
dZJW5aJ773vwLQQmpKvpZB5H6TDIh1c7DSDuA4G6EA70YdE2Vu0l6QzWDn1FWBPN
me1r9BB9XjqQfZWpkhPxEZ4VaZyNKn1qMHyOufLDDEp6miulhFNvMusVIhYoZNDv
PMLOg6Y3GJUWdphdA29RnMfrvnq05hIH3KWzSbUpgnY30FioHd8RqG9mTtdjESTE
PA5VH4XXNOwpu/7F5mzX9VVQ7Ka6CyqJOtOsjrM2xG/CgXPZHkcDiLVFaJTDAmbQ
2ZiOwYCzaNsW4mB2LEtRgpnswDdMHOfUti7Bv9/Z14ruEYO8Daw=
=byVV
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--

