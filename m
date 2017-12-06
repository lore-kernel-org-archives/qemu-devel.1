Received: from eggs.gnu.org ([2001:4830:134:3::10]:38881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eMXtS-0005P1-4j
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 06:29:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eMXtR-0006gV-6M
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 06:29:38 -0500
Date: Wed, 6 Dec 2017 11:29:26 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171206112926.GA12584@stefanha-x1.localdomain>
References: <20171205104141.28882-1-stefanha@redhat.com>
	<20171205104141.28882-9-stefanha@redhat.com>
	<3d097c24-26d0-ded1-a750-58c5750298a8@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
In-Reply-To: <3d097c24-26d0-ded1-a750-58c5750298a8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 8/9] blockdev: add x-blockdev-set-iothread
 testing command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, qemu-block@nongnu.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2017 at 08:40:42AM -0600, Eric Blake wrote:
> On 12/05/2017 04:41 AM, Stefan Hajnoczi wrote:
> > +##
> > +# @x-blockdev-set-iothread:
> > +#
> > +# Move @node and its children into the @iothread.  If @iothread is emp=
ty then
> > +# move @node and its children into the main loop.
> > +#
> > +# The node must not be attached to a BlockBackend.
> > +#
> > +# @node-name: the name of the block driver node
> > +#
> > +# @iothread: the name of the IOThread object
> > +#
>=20
> > +# 2. Move a node into the main loop
> > +# -> { "execute": "x-blockdev-set-iothread",
> > +#      "arguments": { "node-name": "disk1",
> > +#                     "iothread": "" } }
>=20
> Eww. Special casing of the empty string.  Would it be better design to
> have iothread be optional, and to omit it to move a node into the main
> loop?  Or use the StrOrNull type to allow JSON null instead of "" to
> mean the main loop?

I deliberated about this and chose the empty string because it has
special meaning in other QMP commands too.  But I agree that it's ugly.

StrOrNull is cleaner than using the empty string.  Making it optional
feels strange to me so I'll switch to StrOrNull.

Stefan

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaJ9SWAAoJEJykq7OBq3PIFaoH/0mFJZliGrNTo3Z3nrdd7suy
xBMjVNHssma9Bz7xy/i6QVTwIloZ0jqviwwodZAds9XEAqtgFRfSeDCGA5ONwfxx
dWtknCioyMoTRxa0c9DiEWlmDqrcw7kNF7DPIUvdyJfdtR95adFdLpWFWlh5eloX
WQ25TI6c3m/BroIcZ+IiK7r3O9jUNT9qI/PV6ZGhh6BwEkzElwTlTfUpTJnOLqOg
h40iBgMZZHvj/iTE/llUM/gqp7sz+aq7sjPnKXpGMNzBId0yFe0WuWPzyj/Naqrq
9SaqKb+W1B03Byu3oJ7pEgiy6grEq0eYPQ1H1ukc+QefvzcZVd740OEjFV7LOvU=
=CvFx
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
