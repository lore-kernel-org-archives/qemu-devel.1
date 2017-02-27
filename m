Received: from eggs.gnu.org ([2001:4830:134:3::10]:53681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ciRQr-0000YH-QD
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 14:58:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ciRQo-0008Cu-Lt
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 14:58:05 -0500
Received: from 2.mo6.mail-out.ovh.net ([46.105.76.65]:56061)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ciRQo-0008CR-F0
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 14:58:02 -0500
Received: from player761.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 03047B37B5
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 20:58:00 +0100 (CET)
Date: Mon, 27 Feb 2017 20:57:53 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170227205753.60b8a225@bahia.lan>
In-Reply-To: <20170227194134.GH2778@thinpad.lan.raisama.net>
References: <20170227162501.29280-1-ehabkost@redhat.com>
	<CAFEAcA8b_tdQAP6YVDRaZKzHLed5xKbfABtJUV0U43HpkTiBdg@mail.gmail.com>
	<20170227194134.GH2778@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/B4EHs+vVyRVf7.lk_I5POe3";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] travis-ci 'make check' timeouts (was Re: [PULL
 00/11] x86 queue, 2017-02-27)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

--Sig_/B4EHs+vVyRVf7.lk_I5POe3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 27 Feb 2017 16:41:34 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Mon, Feb 27, 2017 at 07:16:03PM +0000, Peter Maydell wrote:
> [...]
> > This seemed to hang in 'make check' on x86. I didn't have time to
> > investigate, so I'll have another go with it later. =20
>=20
> I have been seeing lots of travis-ci failures recently because of
> 'make check' taking too long. The jobs seem to timeout while
> running tests/test-aio-multithread.
>=20
> I see similar failures on recent qemu.git master jobs, too:
> https://travis-ci.org/qemu/qemu/builds
>=20
> Are they similar to the hang you have seen?
>=20

The problem with tests/test-aio-multithread got fixed today with the
following commit:

http://git.qemu-project.org/?p=3Dqemu.git;a=3Dcommit;h=3D3b1d8169844fafee18=
4366b0e0d7080534758b4d

--Sig_/B4EHs+vVyRVf7.lk_I5POe3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAli0hMEACgkQAvw66wEB28JTIgCfUImnu5w42BW6NXn514oLbPGz
caUAn0u9h6pkdB1qtdFe0UU/cec/3RL7
=efdr
-----END PGP SIGNATURE-----

--Sig_/B4EHs+vVyRVf7.lk_I5POe3--
