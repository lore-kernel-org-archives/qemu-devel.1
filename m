Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B53C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 00:44:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8053320820
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 00:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="fpF0dhFS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8053320820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i62MX-0003yJ-Ct
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 20:44:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60982)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i62Lj-0003X5-G8
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 20:43:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i62Lg-0006aV-UB
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 20:43:39 -0400
Received: from ozlabs.org ([203.11.71.1]:45661)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1i62Le-0006Tv-2V
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 20:43:35 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46Pf1Y0TnCz9sN1; Fri,  6 Sep 2019 10:43:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1567730609;
 bh=6vWCFeN6iWo7SLNkroKiSUE7kt5pNtg0WZpV1QML1sk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fpF0dhFSFE3ovnh5zLicyLylFO4ZVV1bXWx8ju8VItPih//LhNe7y6tgE8r34Mree
 HKYjMjqcZ3OBguIYbz1gT6VT1kCzjg4iDLUSREgKTlvN+4dBbePUkp718vYwyrwXm0
 /2ju1tKAxX3nQTYaT4KOyJ6uS2h1SnMeiJyg9Pmo=
Date: Fri, 6 Sep 2019 10:34:16 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Cleber Rosa <crosa@redhat.com>
Message-ID: <20190906003416.GA12820@umbus.fritz.box>
References: <20190829013125.GG16342@umbus.fritz.box>
 <20190830175648.GE3694@habkost.net>
 <20190831014834.GC12065@umbus.fritz.box>
 <20190904195717.GA2311@localhost.localdomain>
 <20190905020924.GB2120@umbus.fritz.box>
 <20190905133824.GA12364@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
In-Reply-To: <20190905133824.GA12364@localhost.localdomain>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] Cryptic errors from PIP install if missing
 openssl-devel
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
Cc: ldoktor@redhat.com, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 05, 2019 at 09:38:24AM -0400, Cleber Rosa wrote:
> On Thu, Sep 05, 2019 at 12:09:24PM +1000, David Gibson wrote:
> > On Wed, Sep 04, 2019 at 03:57:17PM -0400, Cleber Rosa wrote:
> > >=20
> > > Hi David,
> > >=20
> > > I've pushed a branch here (most of the commits have already been sent
> > > separately):
> > >=20
> > >    https://github.com/clebergnu/qemu/tree/ppc64
> > >=20
> > > I've tested on a RHEL 8 ppc64le Power 9, and it seems to work for me.
> > > My steps for building QEMU:
> > >=20
> > >   - Configured with: '/home/cleber/src/qemu/configure' '--enable-slir=
p=3Dgit' '--python=3D/usr/bin/python3' '--target-list=3Dx86_64-softmmu,ppc6=
4-softmmu,arm-softmmu,aarch64-softmmu,mips-softmmu,mipsel-softmmu,mips64-so=
ftmmu,mips64el-softmmu,sh4-softmmu,s390x-softmmu,alpha-softmmu,m68k-softmmu=
,riscv64-softmmu'
> > >   - make
> > >   - make check-acceptance
> > >=20
> > > Would you be able to test if that branch works smoothly for you?
> >=20
> > So, with this tree I'm no longer getting problems if openssl-devel is
> > not installed, so that much looks good.
> >=20
> > I am getting some different errors - I was seeing this before (with
> > openssl-devel installed) sometimes, but only sometimes.  I haven't yet
> > worked out a pattern for when they appeared.  They also don't appear
> > to be fatal, the rest of the tests seem to be running ok.  Any ideas?
> >=20
> >  VENV    /home/dwg/qemu/build/rhel8/tests/venv
> >   PIP     /home/dwg/qemu/tests/requirements.txt
> >   AVOCADO tests/acceptance
> > Error running method "run" of plugin "html": 'Namespace' object has no =
attribute 'get'
> > Error running method "run" of plugin "varianter_cit": 'Namespace' objec=
t has no attribute 'get'
>=20
> Hi David,
>=20
> Yes, those should not be fatal.  Anyway, they are caused by two things:
>=20
>  1) A second set of Avocado plugins installation with different versions
>     than the Avocado installation on QEMU's tests venv

Ah!  That'll be from the Avocado setup that Luka=C5=A1 set up on there for
some different tests.

>  2) The tests' venv, which is created with "--system-site-packages",
>     option that is described as "Give the virtual environment access
>     to the system site-packages dir."
>=20
> The motivation to have "--system-site-packages" is that, if the user
> had any of the "requirements.txt" depedencies installed system wide,
> the venv would simply use it and skip downloads.  Maybe we should make
> that an optional feature, disabled by default, so that the test's venv
> is better isolated and more predictable by default.

If pip doesn't have good enough version tracking that it's verifying
the correct versions of the installed packages as well as the
presence, then yes I tend to agree that keeping it better isolated
would be preferable.

>=20
> Eduardo,
>=20
> I remember we discussed #2, so your opinion is appreciated here.
>=20
> Thanks,
> - Cleber.
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1xqYUACgkQbDjKyiDZ
s5LdEw//dES/P3SVxRtF+PVD+SAlxvHPJ/C0QG1Bein3+biG2222BMhceTqR8Dre
7YdL4PwEriMQ2eSbTdu9KF/N0fppisskT7tt+/GKzPGRWr4arHzT2Bnfk+h2Qp1b
GKtFoI4uBhPFL5UmxCf7n/+wywjNb6uK2Bj+YBcUGit3tBNPn+6laMMCTo3cl0tB
nsIOJud2O47+6a99RSFmo7vVR2eZzIJPW3IrpmLzO7zMaqtO634izWvCwOhbxWxO
yjrZ9T7v8AANKZ6tmD39s2Hvk1peixOgC9BlPo+78wceOBg/hFX6cy4ldsMF/ZqQ
3IuF5su4GIw2F3qEzz2atCHKaQttGrXk+reLab8SsN12bzkgALBUaOH+6b37g2y7
88JoFVX2GRxJ6e494xQ6gh7z5L3Gq5aB5eOiZqpd6jlrjz8aEuMXDteFmOlos0EA
H3oAynZADABT4qX8OiAN2cbsNO9L8wH4mu83qD7c811NTrv2LyLMxjis0Z20qfnJ
g39mjR2FkcME8SlX1EBYTtRoI1Bum4zHvlphZxhMCoIKDW9fGD2JaVw5A2C4JS7T
iSnCQ+sBveTZh76Kesu0Bn1KeX3JS9/u4tWhGl1g/5BzBeoLiMoW4L3r8N47gbyN
G6KU+Uyb8eeFMLjmsARNrl0x0l2nFiTh5GXUcJ2mzy0dIplVSHQ=
=PQoP
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--

