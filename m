Received: from eggs.gnu.org ([2001:4830:134:3::10]:35512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eMbMl-0000C1-ND
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 10:12:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eMbMf-0006Zp-Pn
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 10:12:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58716)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eMbMf-0006Ze-J7
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 10:12:01 -0500
Date: Wed, 6 Dec 2017 15:11:55 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171206151155.GC22757@stefanha-x1.localdomain>
References: <20171205063313.GB4102@yangzhon-Virtual>
	<20171205120623.GB31150@stefanha-x1.localdomain>
	<5f9f2835-5811-3ee0-9049-0d2cddc08958@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DSayHWYpDlRfCAAQ"
Content-Disposition: inline
In-Reply-To: <5f9f2835-5811-3ee0-9049-0d2cddc08958@redhat.com>
Subject: Re: [Qemu-devel] About the light VM solution!
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>
Cc: berrange@redhat.com, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>


--DSayHWYpDlRfCAAQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2017 at 02:35:42PM +0100, Paolo Bonzini wrote:
> On 05/12/2017 13:06, Stefan Hajnoczi wrote:
> > On Tue, Dec 05, 2017 at 02:33:13PM +0800, Yang Zhong wrote:
> Referring to your slides, the remaining points for fast boot are:
>=20
> * parallelize VCPU initialization: do you have patches? :)
>=20
> * q35-lite: any other machine options that have not been merged yet?
>=20
> * SeaBIOS+Option ROM: can you take new numbers with DMA-based option
> ROM, or with qboot?
>=20
> * guest kernel: my proposal to make Linux a multiboot kernel has been
> nacked upstream, but Oracle is working on supporting Xen PVH binaries in
> QEMU.  These are very similar to multiboot and in particular they're
> uncompressed.

By the way, sending a separate patch series for each optimization is
good.  That way patches requiring more discussion don't hold up patches
that could be applied immediately.  It also makes reviewing and
understanding performance results easier since there is only one change.

Stefan

--DSayHWYpDlRfCAAQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaKAi7AAoJEJykq7OBq3PI0yUH/RMgge9S6qaZodYQaKxswUXL
alGxW2Jd/JaIK9Tom1j0vCrLymVI5tCAuPr+t46miQDP8w1JSm+WzpNa4tGMNxk0
1vH+o67T9rogBaDmAQR4yVAScEo6xWSwGJzTXjzIVS2SqlHlTWwh3Q5GEoxmYnbx
KBZhd6qTAF48fsgKFdwq4V+iRT5S9HscbYBzCqhyB/vPGabf3Iqrh3lP4yVQJe9e
sz7sXrvA81C9zEO2sMYx/cu1UCYRUZz+03gfeOqbXbbetTlGUNyfIqe+v0Rp7xCW
y3pTnUjIGiTSwkSI723Sd8VpurHUieSkHpfSxdJ3P0BNCP65BvfZ9+CaLbaWkfc=
=ZYfM
-----END PGP SIGNATURE-----

--DSayHWYpDlRfCAAQ--
