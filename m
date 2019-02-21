Received: from eggs.gnu.org ([209.51.188.92]:35740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gwmGm-0006Jw-Vj
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 06:12:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gwmGl-00010z-UZ
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 06:12:00 -0500
Date: Thu, 21 Feb 2019 11:11:47 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190221111147.GB3282@stefanha-x1.localdomain>
References: <VI1PR0602MB32452A8FD128F63FFAC0CEADA4920@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<20190204060636.GF29758@stefanha-x1.localdomain>
	<AM5PR0602MB32368CB5ADDEC05F42D8BC8FA46D0@AM5PR0602MB3236.eurprd06.prod.outlook.com>
	<AM5PR0602MB32368CB5ADDEC05F42D8BC8FA46D0@AM5PR0602MB3236.eurprd06.prod.outlo>
	<VI1PR0602MB3245FD0A939EC3E28CA0F740A46F0@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<20190211031725.GB18083@stefanha-x1.localdomain>
	<VI1PR0602MB3245424120D151F29884A7E2A4630@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<20190220165839.GJ30403@stefanha-x1.localdomain>
	<f168e72e-89fe-cf9b-89ff-3eb820f8a5cf@redhat.com>
	<VI1PR0602MB32456F471A198636E7C7C0B1A47D0@VI1PR0602MB3245.eurprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LpQ9ahxlCli8rRTG"
Content-Disposition: inline
In-Reply-To: <VI1PR0602MB32456F471A198636E7C7C0B1A47D0@VI1PR0602MB3245.eurprd06.prod.outlook.com>
Subject: Re: [Qemu-devel] [Qemu-block] Guest unresponsive after Virtqueue
 size exceeded error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fernando Casas =?iso-8859-1?Q?Sch=F6ssow?= <casasfernando@outlook.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>


--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 20, 2019 at 06:56:04PM +0000, Fernando Casas Sch=F6ssow wrote:
> Regarding the dumps I have three of them including guest memory, 2 for vi=
rtio-scsi, 1 for virtio-blk, in case a comparison may help to confirm which=
 is the proble.) I can upload them to a server you indicate me or I can als=
o put them on a server so you can download them as you see fit. Each dump, =
compressed, is around 500MB.

Hi Fernando,
It would be great if you could make a compressed coredump and the
corresponding QEMU executable (hopefully with debug symbols) available
on a server so Paolo and/or I can download them.

If you're wondering about the debug symbols, since you built QEMU from
source the binary in x86_64-softmmu/qemu-system-x86_64 should have the
debug symbols.

"gdb path/to/qemu-system-x86_64" will print "Reading symbols from
qemu-system-x86_64...done." if symbols are available.  Otherwise it will
say "Reading symbols from qemu-system-x86_64...(no debugging symbols
found)...done.".

Thanks,
Stefan

--LpQ9ahxlCli8rRTG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcbodzAAoJEJykq7OBq3PIfZIH/24Fa7lH9JZGNpIBi5Ua2mxe
x0Wrt/lvJHEBxmGy4TXED5V0wYqsyhT0q+1gW+HoDAKCqhJwsWJLiTDBLgA2b7v4
dSrE+uA8HqivFe3+i57wvEzdRgi1L4xtGw93L/yQCtwP9+3XKvwwgUtfCUSgB6+C
AO9opFIbRR6YEUMXiOay10HgWb5M+YW58TFjnO/BDhy8QZnqBQ7ZQT2lBly3zqNd
q5V2LE2CWLGfOI+M3S3z3iOibgE4JU0Ne68hLpjfzMAnk73TjHxN1OMNNrtAXIZt
RdP/f3u0HY4s1gbsh4L3uH7BGJGbkHBRRWrmJSDmz8uVHU+n4Ow5K1o//AZ+3bw=
=S66C
-----END PGP SIGNATURE-----

--LpQ9ahxlCli8rRTG--
