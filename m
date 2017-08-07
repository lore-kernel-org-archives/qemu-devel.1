Received: from eggs.gnu.org ([2001:4830:134:3::10]:50821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dedVd-0002yt-Nv
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 04:35:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dedVZ-0004Rf-4L
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 04:35:33 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:38184)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dedVY-0004Qp-TD
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 04:35:29 -0400
Received: by mail-wm0-x242.google.com with SMTP id y206so174394wmd.5
	for <qemu-devel@nongnu.org>; Mon, 07 Aug 2017 01:35:27 -0700 (PDT)
Date: Mon, 7 Aug 2017 09:35:22 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170807083522.GA3191@stefanha-x1.localdomain>
References: <CADsqsq+TieaYKCUDLetQR7QVkubTV4w+82ByAQGzrrM6ebcGYg@mail.gmail.com>
	<5c835b9a-cf6e-6c00-119c-c6082f288bf5@weilnetz.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
In-Reply-To: <5c835b9a-cf6e-6c00-119c-c6082f288bf5@weilnetz.de>
Subject: Re: [Qemu-devel] Editing qemu source code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shantanu Agarwal <shantanu16111994@gmail.com>
Cc: Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 06, 2017 at 01:44:52PM +0200, Stefan Weil wrote:
> Am 06.08.2017 um 13:25 schrieb Shantanu Agarwal:
> > Hello all,
> > I was reading about qemu, trying to understand the source code. I found
> > that vl.c is considered the main file of qemu source code from where all
> > the execution starts. So I flipped some values, i even put a exit(0) ju=
st
> > after the int main starts, but nothing is changed. Qemu is fully
> > functional. Also i put many printf's in between but no output at all. A=
m I
> > missing something or vl.c is not the main file.
> >=20
>=20
> Hi,
>=20
> the main function in vl.c is the correct entry point.
> If you don't see an effect of your changes, then you
> are probably calling an executable which is not the
> changed one.

Yes, this is a common cause for this problem.  Are you launching the
correct QEMU binary?

For example, the x86 full-system emulator built in the source tree can
be run like this:

  $ cd qemu
  $ x86_64-softmmu/qemu-system-x86_64

Remember that operating systems resolve shell commands using the PATH
environment variable.  If you ran 'qemu-system-x86_64' without a
relative or absolute path then you are probably running the QEMU binary
that was installed from a package somewhere else on your system (e.g.
/usr/bin/qemu-system-x86_64).

If you ran 'make install' then make sure to give the full path to the
QEMU binary (e.g. /usr/local/bin/qemu-system-x86_64) or set PATH so
/usr/local/bin comes before other directories in the search path.

Stefan

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZiCZKAAoJEJykq7OBq3PIyI4IAKpZVpf2yUwKrR84DrA6lssA
5aZjlsk65NFgoKNqn+0l/z/9aYwKK0yreOc0JTQvavrOZE6CoQ1/isKneEvLRmky
X2Qa6yj6Bp7BP5l4EBhJFRKuTLS26G5fqHXTp4Rp5wn7YwVG67ovIlVqUsYnnRuV
SmwqXmlaoc0nzJDcpu1xymuGIKD2asbIQxySqBWuiEQJU0EpaeRsNfPyuWGm3mB6
16l2wCv7XMcw1Z2ZV/Ycp5eepbeihwPV2khhFDuIG0O6KQ9K0BL3l/OI/QvOYDLI
75BwdcIqJp6E3svlcif/IRZdkwOEh0GQXgp6ckdxPibUr97jsH0+xNZx+veV/zM=
=t7ZF
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
