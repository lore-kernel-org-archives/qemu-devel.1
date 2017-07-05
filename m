Received: from eggs.gnu.org ([2001:4830:134:3::10]:40004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dSkYJ-0008Mb-42
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 09:41:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dSkYF-0005pa-VT
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 09:41:11 -0400
Date: Wed, 5 Jul 2017 14:41:04 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170705134104.GD1280@stefanha-x1.localdomain>
References: <20170626101159.19676-1-berrange@redhat.com>
	<c4381bd8-a417-0c3b-f3c2-1292ca9f6dfc@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wULyF7TL5taEdwHz"
Content-Disposition: inline
In-Reply-To: <c4381bd8-a417-0c3b-f3c2-1292ca9f6dfc@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] sockets: avoid formatting buffer that may
 not be NULL terminated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>


--wULyF7TL5taEdwHz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 26, 2017 at 12:19:40PM +0200, Thomas Huth wrote:
> On 26.06.2017 12:11, Daniel P. Berrange wrote:
> > The 'sun_path' field in the sockaddr_un struct is not required
> > to be NULL termianted, so when reporting an error, we must use
>=20
> s/NULL/NUL/
>=20
> NULL is a pointer, NUL is the '\0' character.

I wanted to point out the same thing to someone recently, so I chased up
a reference to the NUL character in RFC 20 "ASCII format for Network
Interchange".  After all, no one can argue with an RFC.

What I found shocked me!  There must be a typo in the ASCII RFC:
https://tools.ietf.org/html/rfc20#section-5.2

I closed my browser tab quickly and headed to Wikipedia instead.  If the
primary source didn't support my argument, I could always count on good
old Wikipedia...

But do you know what I found?  Someone had conflated nul and null on the
Wikipedia entry:
https://en.wikipedia.org/wiki/Null_character

Amateurs!  The Wikipedia editors probably didn't have the intellectual
calibre to question the correctness of the RFC text the way I did.

But to cut a long story short, as my search continued the evidence
became overwhelming.  It is acceptable to refer to the nul character as
the null character.

Coming back to the patch in question, although we can't complain about
the "NULL" it's with considerable joy that I'd like to highlight:

s/termianted/terminated/

:)
Stefan

--wULyF7TL5taEdwHz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZXOxvAAoJEJykq7OBq3PIOlIH/jAQV2PBq44J8Cymoj8USWCN
mfE9VdOrQ97H8BSg4cixP+8CRwYlHhedjux+kn7DJN9P7xwE0w8hR1eHy9HR/3sb
USk79KLJ9u6w08lCzosGojqYho/hyQLa65kz1eNFXaSDJrN8QweCdsxOl1yQbvzq
NYh+O1R/9r4f1EBieLWYriFlotCJgRKKuRjfCOjka5Sr2VMGjwSC2dB280gvNIzz
Dn063pWHoBzcrSdy6KkgWVTQH1nrC7XJuhYB1StmBylSzOncIHeqcOyyWRQBbQYR
hcF+BdQmJwl3Xsr3kkLiXxC2YQRYu3z6Lp5Dmmg6AsOe9haQp0UoEr8jGrAsaS0=
=sISa
-----END PGP SIGNATURE-----

--wULyF7TL5taEdwHz--
