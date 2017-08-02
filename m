Received: from eggs.gnu.org ([2001:4830:134:3::10]:43035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dctoc-00049d-11
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 09:35:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dctoY-0000n1-Qu
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 09:35:58 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:37105)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dctoY-0000lO-Ga
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 09:35:54 -0400
Received: by mail-wm0-x22d.google.com with SMTP id t201so41907524wmt.0
	for <qemu-devel@nongnu.org>; Wed, 02 Aug 2017 06:35:52 -0700 (PDT)
Date: Wed, 2 Aug 2017 14:35:49 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170802133549.GK5531@stefanha-x1.localdomain>
References: <20170731085110.1050-1-apahim@redhat.com>
	<20170731085110.1050-3-apahim@redhat.com>
	<20170801100925.GF13521@stefanha-x1.localdomain>
	<20170801105052.GA3108@localhost.localdomain>
	<CALAZnb0kbXYFiyg6EYUDe_zjph7YxtLCyw67uvnGr0P9Hj31+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YQEH9CATo+4lan7A"
Content-Disposition: inline
In-Reply-To: <CALAZnb0kbXYFiyg6EYUDe_zjph7YxtLCyw67uvnGr0P9Hj31+w@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v6 2/7] qemu.py: fix is_running() return
 before first launch()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amador Pahim <apahim@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Daniel Berrange <berrange@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>, =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>


--YQEH9CATo+4lan7A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 01, 2017 at 02:56:55PM +0200, Amador Pahim wrote:
> On Tue, Aug 1, 2017 at 12:50 PM, Eduardo Habkost <ehabkost@redhat.com> wr=
ote:
> > On Tue, Aug 01, 2017 at 11:09:25AM +0100, Stefan Hajnoczi wrote:
> >> On Mon, Jul 31, 2017 at 10:51:05AM +0200, Amador Pahim wrote:
> >> > is_running() returns None when called before the first time we
> >> > call launch():
> >> >
> >> >     >>> import qemu
> >> >     >>> vm =3D qemu.QEMUMachine('qemu-system-x86_64')
> >> >     >>> vm.is_running()
> >> >     >>>
> >> >
> >> > It should retunt False instead. This patch fixes that.
> >>
> >> s/retunt/return/
> >>
>=20
> Ack
>=20
> >> >
> >> > Signed-off-by: Amador Pahim <apahim@redhat.com>
> >> > ---
> >> >  scripts/qemu.py | 2 +-
> >> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >> >
> >> > diff --git a/scripts/qemu.py b/scripts/qemu.py
> >> > index 2f1984c93c..77565eb092 100644
> >> > --- a/scripts/qemu.py
> >> > +++ b/scripts/qemu.py
> >> > @@ -86,7 +86,7 @@ class QEMUMachine(object):
> >> >              raise
> >> >
> >> >      def is_running(self):
> >> > -        return self._popen and (self._popen.poll() is None)
> >> > +        return self._popen is not None and (self._popen.poll() is N=
one)
> >>
> >> The parentheses are inconsistent:
> >>
> >>   return (self._popen is not None) and (self._popen.poll() is None)
>=20
> Parentheses are not needed here. I can remove the other one, if you want.

That would be fine.  There are no other instances in the file and PEP8
doesn't cover this either.

> >>
> >> An alternative:
> >>
> >>   return bool(self._popen and self._popen.poll())
> >
> > is_running() should be True only if self._popen.poll() is None
> > (and not if it's 0), so the "self._popen.poll() is None" part is
> > necessary.
>=20
> +1

oops :)

Stefan

--YQEH9CATo+4lan7A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZgdU1AAoJEJykq7OBq3PIDJwIAMlKnyXJce4m3UCuoqIreHjQ
Z5eUue4pLwYvVWw78E+OyMR+XGM+S1GPi7xRRyLRfIXsLi25Zh/QJU0TGIGGNR7/
MTESPLgKj217NmGp5Ff5QtkpUWL57LJQlcwH9ceigdz3ef/Wf0lFoOfa7HVs0bnB
3Ow5odGUCwgxfnTCHicB7yppRhx2xR2XEOQHgMe8Me/jq9sWcmJ02uTWdfDJs+c9
jyQcNR+tCFenOpxLSVPLywQP6ZVXh4ClgTgQckv7qT4gCn+WgNnLqOZPSk68PsbN
HV7NL24eUMbNS5WEnSDwYnvl/OWNbMtjfeg0ahrX165OJij7Qvd48161vqwRgYQ=
=3got
-----END PGP SIGNATURE-----

--YQEH9CATo+4lan7A--
