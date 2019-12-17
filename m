Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA13C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 00:39:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 486FE21D7D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 00:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ojg4Lb+o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 486FE21D7D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih0tL-0005yd-ET
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 19:39:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44526)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ih0sX-0005LO-4e
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 19:38:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ih0sV-0007MZ-Ie
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 19:38:21 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:53175)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ih0sV-0007Cw-7t; Mon, 16 Dec 2019 19:38:19 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47cK4R1dbkz9sR8; Tue, 17 Dec 2019 11:38:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576543095;
 bh=89x0utMTOHf8gbZvo52y9jTIFn4YzatGfx+8UjHxG9k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ojg4Lb+oTAdjswHSakghdMS62Apwm00aCodYsWT0Df2nB8C+56B9VeTGS8qBsPcc7
 2rNpBTp2YEsdz+htQiCF8PtDBEEYa5g0k78e0qB2FlfjxkKCsTto37n0So5fploPo5
 W+RBt0/nHEyd6Q+GsWtXco3LgjiNh19R+8jWGpyQ=
Date: Tue, 17 Dec 2019 11:31:15 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: [PATCH] ppc: remove excessive logging
Message-ID: <20191217003115.GI6242@umbus.fritz.box>
References: <20191214121347.17071-1-joakim.tjernlund@infinera.com>
 <4a608af2-62a2-3ffb-0c02-8e0ca699d586@redhat.com>
 <alpine.BSF.2.21.99999.352.1912151147300.3618@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="K1SnTjlYS/YgcDEx"
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.99999.352.1912151147300.3618@zero.eik.bme.hu>
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
Cc: qemu-ppc <qemu-ppc@nongnu.org>,
 Joakim Tjernlund <joakim.tjernlund@infinera.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--K1SnTjlYS/YgcDEx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 15, 2019 at 11:59:22AM +0100, BALATON Zoltan wrote:
> On Sun, 15 Dec 2019, Philippe Mathieu-Daud=E9 wrote:
> > Hi Joakim,
> >=20
> > I'm cc'ing the PPC maintainers for you, so they won't miss your patch
> > (see
> > https://wiki.qemu.org/Contribute/SubmitAPatch#CC_the_relevant_maintainer
> > and the output of ./scripts/get_maintainer.pl -f
> > target/ppc/excp_helper.c).
> >=20
> > On 12/14/19 1:13 PM, Joakim Tjernlund wrote:
> > > From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
> > >=20
> > > ppc logs every type of Invalid instruction. This generates a lot
> > > of garbage on console when sshd/ssh_keygen executes as
> > > they try various insn to optimize its performance.
> > > The invalid operation log is still there so an unknown insn
> > > will still be logged.
> > >=20
> > > Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
> > > ---
> > >=20
> > > 	As far as I can see, ppc is the only one emiting thsi
> > > 	debug msg for Invalid insns.
> > >=20
> > > target/ppc/excp_helper.c | 1 -
> > >   1 file changed, 1 deletion(-)
> > >=20
> > > diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> > > index 50b004d00d..45c2fa3ff9 100644
> > > --- a/target/ppc/excp_helper.c
> > > +++ b/target/ppc/excp_helper.c
> > > @@ -326,7 +326,6 @@ static inline void powerpc_excp(PowerPCCPU *cpu,
> > > int excp_model, int excp)
> > >               env->spr[SPR_BOOKE_ESR] =3D ESR_FP;
> > >               break;
> > >           case POWERPC_EXCP_INVAL:
> > > -            LOG_EXCP("Invalid instruction at " TARGET_FMT_lx "\n",
> > > env->nip);
> >=20
> > I don't think we want to remove a such important log. Since it make
> > sense to not disturb the console, maybe we can replace some of the
> > LOG_EXCP() calls by qemu_log_mask(LOG_GUEST_ERROR,...) instead?
>=20
> I don't think that's a good idea. That would flood the -d guest_errors log
> with unwanted messages that are normal not really due to guest errors. The
> LOG_EXCP() is not enabled by default, you have to edit source to enable it
> so you can also then edit the unwanted messages as well (like commenting
> this one out if you don't like it). If this is removed, invalid opcodes a=
re
> still logged from translate.c but the exception generated for them is not
> logged. I don't know if that's useful or not but these are debug logs so
> depends on what do you want to debug. I don't mind this being removed but
> would be also happy leaving it as it is as it's only shown for developers
> who enable it and might help debugging. Or maybe these could be converted=
 to
> traces (although I generally find traces to be less convenient to work wi=
th
> than debug logs and not sure about potential performance impact). So my
> preferences would be in order: 1. leave it alone, 2. remove it, 3. convert
> to traces.

Yes, that's my preference as well.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--K1SnTjlYS/YgcDEx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl34IdMACgkQbDjKyiDZ
s5IEYA//dlSR35iF0ZPPdQm3l9745g8HN6VQd3OceqP5pRe+hTaa61bt1taYgw3b
Cq8esOQtwZ1cmFKPUW+OByNzZVrw2DR7quX3GLz9CW7iXl9KL7ERWcecKdr4Tm3+
bOuA9ggXVysjUBfTlWWatrDBUwiLedVxyf6DA85TPWNn4GsMs1TwSsd+rSHO1FgI
iRBFV5I8Il8FKQEZHPEWlRiVlsOSvWSvuPspIxQJh8V34ruoI/ZgaHSnkQSAepBp
GquqQrG22ccgFi6KNtbfvMGtk5xFot5AoB39QMsjJ8K5sK2H4t2bFYQrLN0aI/ah
HMyNTlJaY8BqmJY9Vr/7Onq0lFS4pYI+tU24HYRMeKK02S6Iwsm9hPR+gZQwF2+8
/2HJvPfhv2NJA3lA89C0QYPYxnMNZ9hMKTb2fVnn2KVNUqO4c3bokvoRDEh97cDe
AZHWZMh6Zt48GPMLmuxNMTi4vSt/q2PQWUfPDRueRSRIAhGJv1S+o+V2o0lJ0Oox
Q7sR9gVmzyaR956BrMQUX4zDsTC5LbYZPmvpgctoFaobAKeYnlDsX9kBYMLIcrBI
32cMcyPgF/t4vAuq28LTEpYKP1iF5gO+8wy/GRypg7+Ne4p/BS3edn7xHVkW89xp
YTRukOUYUlbUBfpGCnso46Aa7PTGEfzbG1fxH1y2JqIZ9/l9b7E=
=MzJd
-----END PGP SIGNATURE-----

--K1SnTjlYS/YgcDEx--

