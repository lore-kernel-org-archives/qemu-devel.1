Received: from eggs.gnu.org ([2001:4830:134:3::10]:33658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eGoSN-0002NF-K6
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 10:58:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eGoSI-0006B3-ON
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 10:57:59 -0500
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:41810)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eGoSI-0006AZ-HN
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 10:57:54 -0500
Received: by mail-wr0-x235.google.com with SMTP id z14so8501783wrb.8
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 07:57:54 -0800 (PST)
Date: Mon, 20 Nov 2017 15:57:51 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171120155751.GJ4516@stefanha-x1.localdomain>
References: <20171115115246.GA1955@redhat.com>
	<20171116144746.GE29106@stefanha-x1.localdomain>
	<20171116151031.GV2787@redhat.com>
	<CAJSP0QWop2Xvjp5bObJ0yRoJ=W-6cH84fGHXj5b93Qb6TxCxDA@mail.gmail.com>
	<20171116180054.GZ2787@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d6iqOn7HZPWKXx18"
Content-Disposition: inline
In-Reply-To: <20171116180054.GZ2787@redhat.com>
Subject: Re: [Qemu-devel] Effect of qemu-img convert -m and -W options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: libguestfs@redhat.com, Peter Lieven <pl@kamp.de>, qemu-devel <qemu-devel@nongnu.org>


--d6iqOn7HZPWKXx18
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2017 at 06:00:54PM +0000, Richard W.M. Jones wrote:
> On Thu, Nov 16, 2017 at 05:30:48PM +0000, Stefan Hajnoczi wrote:
> > On Thu, Nov 16, 2017 at 3:10 PM, Richard W.M. Jones <rjones@redhat.com>=
 wrote:
> > > Both local filesystems, but on different SATA devices.
> >=20
> > Okay.  I'm curious what the strace -f output looks like (only the
> > preadv(2)/pwritev(2) syscalls are interesting at the moment).
>=20
> Here's the full strace from one run:
>=20
>   http://oirase.annexia.org/tmp/strace.xz
>=20
> The command is (with the output.qcow2 file created in a previous run):
>=20
>   $ strace -o /tmp/strace -f -s 1024 qemu-img convert -f raw fedora-27.im=
g -O qcow2 /var/tmp/output.qcow2 -m 8 -W -n
>=20
> The version of qemu is: qemu-2.10.0-7.fc28.x86_64

Requests are being handled in parallel and the exact order is random due
to I/O completion times and thread scheduling.

I didn't see an obvious pattern to optimize but only spent a little time
studying the strace.

Stefan

--d6iqOn7HZPWKXx18
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaEvt/AAoJEJykq7OBq3PIZVMH/RU9S6cnAiFLey1/BAVjYbMx
g2NMOyVloKCJ/Yd3ipYX3ASgm/fddU6vxWCOw8WXvVYkszbOCBcH11bNLYIUduWx
KIQo/RacuYZ3RUTt/mfJqu9PT/6Ha7V0k+vev+B6AzopGBqbru0YPCUUcdcf9qlG
CuhSKdBBYtxUVe9XctmmNZbqAqtOk8vn2U5+YtrJ92TnQbztRzqM5SPzu6N18voG
gakQ4VYOP4QUOe9gZzSM5kdw+9b53lt5FGG8pVSxetPGM8a4/MgHo3mKEkicfn6Y
/yfXzF4h38s94d46fZSyyudFehjAHavk3O8oY0sYZZcrea1pu9dTijeHFGQkNow=
=m8OP
-----END PGP SIGNATURE-----

--d6iqOn7HZPWKXx18--
