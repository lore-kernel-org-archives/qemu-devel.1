Received: from eggs.gnu.org ([209.51.188.92]:38423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gzlJt-00038d-2l
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:47:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gzlJr-0007X0-Gy
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:47:32 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43458)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gzlJr-0007Vr-6u
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:47:31 -0500
Received: by mail-wr1-x443.google.com with SMTP id d17so26536806wre.10
	for <qemu-devel@nongnu.org>; Fri, 01 Mar 2019 08:47:31 -0800 (PST)
Date: Fri, 1 Mar 2019 16:47:28 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190301164728.GE18260@stefanha-x1.localdomain>
References: <20190214031004.32522-1-stefanha@redhat.com>
	<20190214031004.32522-2-stefanha@redhat.com>
	<20190214072629.GA18896@richard>
	<20190214081619.GB7652@stefanha-x1.localdomain>
	<20190301114006.043e20cc@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BZaMRJmqxGScZ8Mx"
Content-Disposition: inline
In-Reply-To: <20190301114006.043e20cc@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/2] hostmem: simplify ifdef-s in
 file_backend_memory_alloc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Wei Yang <richardw.yang@linux.intel.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org


--BZaMRJmqxGScZ8Mx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 01, 2019 at 11:40:06AM +0100, Igor Mammedov wrote:
> On Thu, 14 Feb 2019 16:16:19 +0800
> Stefan Hajnoczi <stefanha@redhat.com> wrote:
>=20
> > On Thu, Feb 14, 2019 at 03:26:29PM +0800, Wei Yang wrote:
> > > Maybe change the title=20
> > >=20
> > >    s/hotmem/hostmem-file/
> > >=20
> > > would be more proper.
> > >=20
> > > I missed this in previous review. =20
> >=20
> > You're right.  This can be fixed when merging the patch.
> >=20
> > Stefan
>=20
> Did this patch fall through cracks?

Eduardo has been away.  It wasn't urgent but I'd be happy if either you
or Eduardo picks up these patches.

Thanks,
Stefan

--BZaMRJmqxGScZ8Mx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJceWIgAAoJEJykq7OBq3PIoWYH/j/jRXDiGSu2amImgYV5EmXB
QJOvpprSkBS7YWwIPCz2hYnldbDuE1gTb63sdYTu7DujivdatiuL2MLKefnrgpiE
dnPF02qZpo9DkjcFoZnNy403Ufx3nkby0GkStmXvaWvaX4NvKeQ0C580l+o/C5aO
h39j2RvpA35+QX6yK4xHEWiYbzGCnbveY7SIafEHYbu8cBcFgDFW/1rQhAZ7a7cH
/MiTwu+dUu8d/D2S2qjBiG+m/ZthENK9CPkPPspqvFl/0lUA8sE9QGAszyuWxmEf
obqGeufXkyk8j0ksmadgWTW+yhmZSYnYzcqX3dPHHadTX7ZNvOnpJ3IVw2g8GDI=
=DJTI
-----END PGP SIGNATURE-----

--BZaMRJmqxGScZ8Mx--
