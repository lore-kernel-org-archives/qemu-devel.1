Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309DEC10F25
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 02:25:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1DE220637
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 02:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="OWnBsgjr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1DE220637
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBUac-0008UZ-5l
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 22:25:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55666)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jBUZu-0007tj-Fo
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 22:25:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jBUZt-0005k1-1Q
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 22:25:06 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:34105 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jBUZs-0005gD-7L; Mon, 09 Mar 2020 22:25:04 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48bzSs13f8z9sRR; Tue, 10 Mar 2020 13:25:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1583807101;
 bh=LwesY50a8EIF1ZvoI03LPJiHwBi6XECdriLNRAeap24=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OWnBsgjrEC8gB6xU7GtDoJc/WYJtYTXvljj7sUWkuPHG6K1NOgoTSA+93aAImD7H6
 QToLC59cICdF/eHhBQFfm2FLrBeH/Cfqh+3hsik98cAvbXd6ik15V+rsSQqPGSA5wx
 YE1wvHNnC92txVdGUexCD5+rdXOWRfTHueOJQEC8=
Date: Tue, 10 Mar 2020 12:41:16 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] tests/acceptance/ppc_prep_40p: Use cdn.netbsd.org hostname
Message-ID: <20200310014116.GF660117@umbus.fritz.box>
References: <20200211134504.9156-1-philmd@redhat.com>
 <87eeuewv4k.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="UBnjLfzoMQYIXCvq"
Content-Disposition: inline
In-Reply-To: <87eeuewv4k.fsf@linaro.org>
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
Cc: qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Kamil Rytarowski <kamil@netbsd.org>,
 =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 Cleber Rosa <crosa@redhat.com>, qemu-ppc@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--UBnjLfzoMQYIXCvq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2020 at 04:10:19PM +0000, Alex Benn=E9e wrote:
>=20
> Philippe Mathieu-Daud=E9 <philmd@redhat.com> writes:
>=20
> > Use NetBSD content delivery network to get faster downloads.
>=20
> Even with this patch I get failures on my big dev box:
>=20
>  (48/67) tests/acceptance/ppc_prep_40p.py:IbmPrep40pMachine.test_openbios=
_and_netbsd: INTERRUPTED: Failed to fetch NetBSD-7.1.2-prep.iso.\nRunner er=
ror occurred: Timeout reached\nOriginal status: ERROR\n{'name': '48-tests/a=
cceptance/ppc_prep_40p.py:IbmPrep40pMachine.test_openbios_and_netbsd', 'log=
dir': '/home/alex/lsrc/qemu.git/builds/all/tests/results/jo... (60.31 s)
>=20
> I think ultimately a whole ISO download is just too much for an
> acceptance test.

I tend to agree.  Here in a network-remote part of the world, these
always seem to cause timeouts and other problems, in a bunch of the
testcases.

Those are testing useful things though, so I'd really like to see the
downloads split out into some sort of preparation step that can be
done just once, rather than part of the test proper.

> > Suggested-by: Kamil Rytarowski <kamil@netbsd.org>
> > Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> > ---
> >  tests/acceptance/ppc_prep_40p.py | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/tests/acceptance/ppc_prep_40p.py b/tests/acceptance/ppc_pr=
ep_40p.py
> > index efe06037ba..6729d96f5e 100644
> > --- a/tests/acceptance/ppc_prep_40p.py
> > +++ b/tests/acceptance/ppc_prep_40p.py
> > @@ -34,7 +34,7 @@ def test_factory_firmware_and_netbsd(self):
> >                      '7020-40p/P12H0456.IMG')
> >          bios_hash =3D '1775face4e6dc27f3a6ed955ef6eb331bf817f03'
> >          bios_path =3D self.fetch_asset(bios_url, asset_hash=3Dbios_has=
h)
> > -        drive_url =3D ('https://ftp.netbsd.org/pub/NetBSD/NetBSD-archi=
ve/'
> > +        drive_url =3D ('https://cdn.netbsd.org/pub/NetBSD/NetBSD-archi=
ve/'
> >                       'NetBSD-4.0/prep/installation/floppy/generic_com0=
=2Efs')
> >          drive_hash =3D 'dbcfc09912e71bd5f0d82c7c1ee43082fb596ceb'
> >          drive_path =3D self.fetch_asset(drive_url, asset_hash=3Ddrive_=
hash)
> > @@ -67,7 +67,7 @@ def test_openbios_and_netbsd(self):
> >          :avocado: tags=3Darch:ppc
> >          :avocado: tags=3Dmachine:40p
> >          """
> > -        drive_url =3D ('https://ftp.netbsd.org/pub/NetBSD/iso/7.1.2/'
> > +        drive_url =3D ('https://cdn.netbsd.org/pub/NetBSD/iso/7.1.2/'
> >                       'NetBSD-7.1.2-prep.iso')
> >          drive_hash =3D 'ac6fa2707d888b36d6fa64de6e7fe48e'
> >          drive_path =3D self.fetch_asset(drive_url, asset_hash=3Ddrive_=
hash,
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--UBnjLfzoMQYIXCvq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5m8DwACgkQbDjKyiDZ
s5IeRg/+Lva6H4QRkDmSFg5RpzzvOr24g0Xipzh+09+sErc+lfUdhVXhLInBmdXI
iJo/vl2uLEWg2TZhYJCrES9eXU9wxyXL914TMYVChfCf2vzKTjStFVflIfIQ/51c
curjoxfvd2KQe0k/oXuR9s72TpwBo52ZpM8YV/VbQjwT9Ph7oyMir75zrNuzVz0/
c6fvXrXJK5t1V69CYgwOpwbgCezyt2noTlGdgI5B7AsSfeTZqn5pRv1p05mYCeh5
Hww4pMOVCXDXtbbARBQFSq4qdTW3DtXuTscK91GKoediJ0XgLcIqEpag+zqiBEen
RfLdg5YPMlSS2rhjSG79/Wr+nZg1yoboRpNLc+FDubSYC2ZBpiG+nNX74gVfMqBo
IS9rQgEcKnXW6Dk47RWfwcjHQyFmoMsnaVMkfPAMbHAayUYSj4sU3xWT/RFZbZw+
ws7g5fq9+/AT70Xz4k0SVFkPtWaLyUioOGPKpPDqpqAnAfUFqpk+k/fOT5mERJXg
S6kSjHlYUYsy78Y9BhAxlL0j5swQ+DUmEOiunHdEy+nuiKAKFO1h/RVCn63tasNu
y7TFGzzrp+IjC8dT1mZ6eFlQT2O7u09TsudlLRoL7zdqm39VaTe3BIxuuIfRZlDo
ZEnL1WoHls5sORViWKC7rnOzgERmb/t5L+COV+rx1tybzhkbaew=
=7iwH
-----END PGP SIGNATURE-----

--UBnjLfzoMQYIXCvq--

