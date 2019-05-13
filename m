Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A63C04AB1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 05:56:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECF0620873
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 05:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="MS0P4ZDn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECF0620873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51494 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQ3wV-0005S1-Ai
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 01:56:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hQ3vD-0004oY-Lf
	for qemu-devel@nongnu.org; Mon, 13 May 2019 01:54:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hQ3vC-000294-Fi
	for qemu-devel@nongnu.org; Mon, 13 May 2019 01:54:47 -0400
Received: from ozlabs.org ([203.11.71.1]:35965)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hQ3vB-00027x-58; Mon, 13 May 2019 01:54:46 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 452VQ94Z0dz9sMr; Mon, 13 May 2019 15:54:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1557726881;
	bh=FWEQLHIWZJhLznhuLuF4QgrKwmBVZa0axwi3nXtg4pY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MS0P4ZDn8BzsKxQnEagMlm479oEr9Fl6ktqCJXhQgP34eW/MjN1g2EL0wD3xmqmiZ
	q5fJ9kTR7RcPvoV5/6FK32/y/EgGzWbHJVLzwYrlBjTb/Qr3JgC9WlTCIM23z3tX7K
	Ttj/QOg+X1NQmX1bmkZiDNUdOX3YrMRs/GmtvuRs=
Date: Mon, 13 May 2019 15:53:38 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <20190513055337.GB12044@umbus.fritz.box>
References: <20190507004811.29968-1-anton@ozlabs.org>
	<20190507004811.29968-5-anton@ozlabs.org>
	<20190507052243.GH7073@umbus.fritz.box>
	<20190509104912.6b754dff@kryten>
	<bf74cceb-eb22-7d64-fd6b-6b14d11c444f@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rS8CxjVDS/+yyDmU"
Content-Disposition: inline
In-Reply-To: <bf74cceb-eb22-7d64-fd6b-6b14d11c444f@ilande.co.uk>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH v2] target/ppc: Fix xvabs[sd]p, xvnabs[sd]p,
 xvneg[sd]p, xvcpsgn[sd]p
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: ego@linux.vnet.ibm.com, sandipandas1990@gmail.com,
	richard.henderson@linaro.org, qemu-devel@nongnu.org,
	f4bug@amsat.org, qemu-ppc@nongnu.org, Anton Blanchard <anton@ozlabs.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--rS8CxjVDS/+yyDmU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2019 at 04:02:56PM +0100, Mark Cave-Ayland wrote:
> On 09/05/2019 01:49, Anton Blanchard wrote:
>=20
> > We were using set_cpu_vsr*() when we should have used get_cpu_vsr*().
> >=20
> > Fixes: 8b3b2d75c7c0 ("introduce get_cpu_vsr{l,h}() and set_cpu_vsr{l,h}=
() helpers for VSR register access")
> > Signed-off-by: Anton Blanchard <anton@ozlabs.org>
> > ---
> >  target/ppc/translate/vsx-impl.inc.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate=
/vsx-impl.inc.c
> > index b487136d52..4b7627f53b 100644
> > --- a/target/ppc/translate/vsx-impl.inc.c
> > +++ b/target/ppc/translate/vsx-impl.inc.c
> > @@ -859,8 +859,8 @@ static void glue(gen_, name)(DisasContext *ctx)    =
              \
> >          xbh =3D tcg_temp_new_i64();                                \
> >          xbl =3D tcg_temp_new_i64();                                \
> >          sgm =3D tcg_temp_new_i64();                                \
> > -        set_cpu_vsrh(xB(ctx->opcode), xbh);                      \
> > -        set_cpu_vsrl(xB(ctx->opcode), xbl);                      \
> > +        get_cpu_vsrh(xbh, xB(ctx->opcode));                      \
> > +        get_cpu_vsrl(xbl, xB(ctx->opcode));                      \
> >          tcg_gen_movi_i64(sgm, sgn_mask);                         \
> >          switch (op) {                                            \
> >              case OP_ABS: {                                       \
>=20
> Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Applied, thanks.

>=20
>=20
> ATB,
>=20
> Mark.
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--rS8CxjVDS/+yyDmU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzZBmEACgkQbDjKyiDZ
s5Lc2w/+OXTHQixfOf0+TUv0hWJlzWhOsOzuC15anFBY3VfxLtIunYARNtoktamr
BdF3pdyNNFVa6sTDCzF/morqZcJgNOTCfpSqSEuL0V6DohF9pEqFduijq6STaNYx
IHBCMx2rDYNsiA4Gd8mVf92lEyIWmGVnejkHdLt+4GeDe5YNJGPZJq75QRjEjnm5
mxVEDns7Lx6Bb/wvyiOTQ0LaKR6FcsWcyQIzdLmMd1YZjwf1FXK6GEt7UATiyG1i
Z0vJr8DJa0yazbP3so2Rw31vdHaV/jLhf5j5cdWfeafW0s6lXjxStC0ZAlXDYhkC
g9Kv+zsmicDoXJT/HZ/aTMonjx6xqPp6h8RXxahfA8iarZJ+96YEahCj8e+VcDnE
Qq1NZ3qANdmK11oOcBgWnjf/NaC7WkpdHKgGniXo5EE0fGwdU/Gx7x5fvP+S7CwR
VkaCL5ntviGWM124xh27jrYWyfhuBjZyrJcF0d+OOuhh7hAAGc2cGM63Iycsmd2j
MnXrHwI2hZ3O5LxF9DuxLohv9OabNjYhT+ogzbRz+FqH45/APr9wbcj57GXpayKM
bHxdhPt2NrDV0s4zfmUZ9hviKS7KlFDOkNCW0vm1yzog2Pc/0j6QwbXEpYk9YzYt
oIe2wujPkS9jv5PcScWNXobXdN3CNL6o/xPGZFABfoWMhA7nsnY=
=zqY8
-----END PGP SIGNATURE-----

--rS8CxjVDS/+yyDmU--

