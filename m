Received: from eggs.gnu.org ([2001:4830:134:3::10]:58440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fQAO4-0006Ko-Pj
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 07:44:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fQAO1-0008Oy-O0
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 07:44:28 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:40740)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fQAO1-0008OV-G9
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 07:44:25 -0400
Received: by mail-wm0-x241.google.com with SMTP id n5-v6so4452491wmc.5
	for <qemu-devel@nongnu.org>; Tue, 05 Jun 2018 04:44:25 -0700 (PDT)
Date: Tue, 5 Jun 2018 12:44:22 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180605114422.GG11888@stefanha-x1.localdomain>
References: <1527840629-18648-1-git-send-email-junyan.he@gmx.com>
	<1527840629-18648-6-git-send-email-junyan.he@gmx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Zrag5V6pnZGjLKiw"
Content-Disposition: inline
In-Reply-To: <1527840629-18648-6-git-send-email-junyan.he@gmx.com>
Subject: Re: [Qemu-devel] [PATCH V6 5/7] mem/nvdimm: ensure write
 persistence to PMEM in label emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: junyan.he@gmx.com
Cc: qemu-devel@nongnu.org, Haozhong Zhang <haozhong.zhang@intel.com>, xiaoguangrong.eric@gmail.com, crosthwaite.peter@gmail.com, mst@redhat.com, dgilbert@redhat.com, ehabkost@redhat.com, quintela@redhat.com, Junyan He <junyan.he@intel.com>, stefanha@redhat.com, pbonzini@redhat.com, imammedo@redhat.com, rth@twiddle.net


--Zrag5V6pnZGjLKiw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 01, 2018 at 04:10:27PM +0800, junyan.he@gmx.com wrote:
> From: Junyan He <junyan.he@intel.com>
>=20
> Guest writes to vNVDIMM labels are intercepted and performed on the
> backend by QEMU. When the backend is a real persistent memort, QEMU
> needs to take proper operations to ensure its write persistence on the
> persistent memory. Otherwise, a host power failure may result in the
> loss of guest label configurations.
>=20
> Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> ---
>  hw/mem/nvdimm.c     |  9 ++++++++-
>  include/qemu/pmem.h | 23 +++++++++++++++++++++++
>  stubs/Makefile.objs |  1 +
>  stubs/pmem.c        | 19 +++++++++++++++++++
>  4 files changed, 51 insertions(+), 1 deletion(-)
>  create mode 100644 include/qemu/pmem.h
>  create mode 100644 stubs/pmem.c

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Zrag5V6pnZGjLKiw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbFneWAAoJEJykq7OBq3PIixQIAKJ1S885J/CCHF5jznLg0oTy
z7QnSNQZae4Tk2ZpQVp2pTY3jwYgMx/dMuY9U1cyk17Zwd8SMr+faJuKXRFGZ67G
0CbpqvDDbZzg1Etlo3yvwPE0l00geRZvZ1MMDqfdh2+QQylMg2RelDIDWpvn081g
cVgrMlgLeNG4Nz9HTDeuxTXWU/j5TCJ2JXsUuoq3WbqJK3f+GQTbx/kDOsYCx/7g
Sw1YX6mMcP32gZyH3jtVeYiEPFZG+9WetVl3aB7AUqP0x1ThZ/ePHrwv8rHbkZfi
JwEpbHTSu3tluyr7O0sPZlojfAeRzUc1rTW+Bg76QQdeCtJxDuwtas1188hF/Og=
=Q6FB
-----END PGP SIGNATURE-----

--Zrag5V6pnZGjLKiw--
