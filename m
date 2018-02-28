Received: from eggs.gnu.org ([2001:4830:134:3::10]:52636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eqyNl-0004j3-4w
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 04:50:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eqyNi-0006NF-1t
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 04:50:41 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55440 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eqyNh-0006N7-ST
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 04:50:37 -0500
Date: Wed, 28 Feb 2018 09:50:30 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180228095030.GB13990@stefanha-x1.localdomain>
References: <1519613598-12270-1-git-send-email-suhang16@mails.ucas.ac.cn>
	<20180227173234.GI32480@stefanha-x1.localdomain>
	<CAFEAcA9UftR-D5k9D2RrBUKvGWo_nC-+jfBKZAOjsHUAjyMs0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pd0ReVV5GZGQvF3a"
Content-Disposition: inline
In-Reply-To: <CAFEAcA9UftR-D5k9D2RrBUKvGWo_nC-+jfBKZAOjsHUAjyMs0A@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 RFC] scripts/checkpatch.pl: add check
 for `while` and `for`
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Su Hang <suhang16@mails.ucas.ac.cn>, Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>


--Pd0ReVV5GZGQvF3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2018 at 05:42:50PM +0000, Peter Maydell wrote:
> On 27 February 2018 at 17:32, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > On Mon, Feb 26, 2018 at 10:53:18AM +0800, Su Hang wrote:
> >> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> >> index 1b4b812e28fa..10c138344fa9 100755
> >> --- a/scripts/checkpatch.pl
> >> +++ b/scripts/checkpatch.pl
> >> @@ -2353,7 +2353,8 @@ sub process {
> >>               }
> >>
> >>  # check for missing bracing round if etc
> >
> > Please fix the pre-existing typo in the comment:
> >
> > s/round/around/
>=20
> That's not really a typo IMHO -- both 'round' and 'around'
> seem fine to me here. (The OED entry for 'around' notes
> "There is variation with 'round' adv. and prep. in many of the
> senses below; in general 'around' is less usual in British usage",
> so some of this is US-vs-UK usage or personal idiolect.)

Thanks!  I hear British people use it frequently but thought it was a
colloquialism that isn't used in written form, innit? :)  I stand
corrected.

Stefan

--Pd0ReVV5GZGQvF3a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJalntmAAoJEJykq7OBq3PIExAH/jjxoEteGRxZpr8T9nlItGCR
qLzOYv4T386w7J/hopwjXGip7dk52SD+LrHwEMEWWon83qL6qnsHiyeijEkmV4Jh
UhbXMV5BcUj92Wb/fn5FsHXjZ5Fk5Tbpi9Xo5E4l3eWjgh//xe66hDiC/13oMhNA
inWEWSW1AIUUruO/UXiQe7gZlUxmGhAHFsA4bONub9WDPktIMSIjoUTzlpPiMB3y
VFUhkdfsfAy4fKVlIQ/+xP5uBw/GtrKz3YmneIryUOWJCcqo/eBGR/wTpzB4Oy01
/ZKWnf/Io8QXFmr9s+sNsXSfoNmdB+jVhXNWMy8gon+UP1zSeL7IMYwtqbpiPR0=
=3LbA
-----END PGP SIGNATURE-----

--Pd0ReVV5GZGQvF3a--
