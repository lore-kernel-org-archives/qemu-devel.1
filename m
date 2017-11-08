Received: from eggs.gnu.org ([2001:4830:134:3::10]:38781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eCUH8-00016J-E9
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 12:36:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eCUH3-0001Gw-FV
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 12:36:30 -0500
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:43315)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eCUH3-0001Gf-87
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 12:36:25 -0500
Received: by mail-wr0-x230.google.com with SMTP id 4so3177327wrt.0
	for <qemu-devel@nongnu.org>; Wed, 08 Nov 2017 09:36:25 -0800 (PST)
Date: Wed, 8 Nov 2017 17:11:20 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171108171120.GA8403@stefanha-x1.localdomain>
References: <CAJSP0QUOCzWfM614zRKme+GecU+NVNOFcoGz1wdBcdgKzrq-LQ@mail.gmail.com>
	<1a47a48e-0917-23ba-6b83-e22e35289f86@weilnetz.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
In-Reply-To: <1a47a48e-0917-23ba-6b83-e22e35289f86@weilnetz.de>
Subject: Re: [Qemu-devel] Moving release tarballs to a CDN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <stefan.weil@weilnetz.de>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, Jeff Cody <jcody@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 08, 2017 at 05:19:25PM +0100, Stefan Weil wrote:
> Am 08.11.2017 um 16:33 schrieb Stefan Hajnoczi:
> > Hi Mike and Jeff,
> > qemu.org's bandwidth usage is dominated by release tarball downloads.
> > This puts qemu.org bandwidth usage in the 2+ TB/month range.
>=20
> Hi Stefan,
>=20
> how much of this traffic is caused by web spiders?
>=20
> From my own binaries I know that the bots of the
> different search engines cause most of the traffic,
> if they are allowed to do so.
>=20
> Usually they respect robots.txt. There is no
> https://www.qemu.org/robots.txt currently.
> Nor is there a https://download.qemu.org/robots.txt.
> Adding both would reduce the downloads, maybe
> enough to fix the problem.
>=20
> Or do you see an advantage from bots which download
> QEMU tarballs? robots.txt can also block only
> selected bots.
>=20
> Regards
> Stefan
>=20
> PS. There is a https://git.qemu.org/robots.txt.

Great idea!  It's an easy to try adding a robots.txt and check how
bandwidth uses changes over the next month.

Jeff: Want to try this?

Stefan

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaAzq4AAoJEJykq7OBq3PID3wIAMBJmXHnEyQt7AoKBkDCS2Ug
sjGQv3T4ggCik0qzIYvZkYJHpLsBwW0pMOr3Kpd1i8tovrY+lx9uHafeLX6FADrT
UI6clzhX95hYnFxl8JBijnRmZR0O7P15wMeardj7n88bU4HqiLP5rfSR7ZcyJPM9
Q9ICe/OGMhSm9p/9ThNpyNgiIVIkZe7wCdQrdlogttwC+B2+cLskjYhFYZSNNOeu
g7VDmi3YK7jKhcwwIgp4aarkRXiHkdNJrnCVSDLm7RH7Ax3OkcoZGglJSXNne4ZO
e6hRbuOtDQmpkGsobWC04qkPBsiw0sqCynoQrm+MxLQyQPcVJggD/swLvI7/yBc=
=DIRp
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
