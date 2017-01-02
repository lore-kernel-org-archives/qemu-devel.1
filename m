Received: from eggs.gnu.org ([2001:4830:134:3::10]:35738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cOCF1-0005DX-0s
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 18:42:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cOCEz-0006OK-QV
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 18:42:11 -0500
Date: Tue, 3 Jan 2017 09:28:31 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170102222831.GB12761@umbus.fritz.box>
References: <20161231011831.4097-1-zxq_yx_007@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yEPQxsgoJgBvi8ip"
Content-Disposition: inline
In-Reply-To: <20161231011831.4097-1-zxq_yx_007@163.com>
Subject: Re: [Qemu-devel] [PATCH 0/4] QOM'ify work for ppc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xiaoqiang zhao <zxq_yx_007@163.com>
Cc: qemu-devel@nongnu.org, agraf@suse.de, peter.maydell@linaro.org, qemu-ppc@nongnu.org


--yEPQxsgoJgBvi8ip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 31, 2016 at 09:18:27AM +0800, xiaoqiang zhao wrote:
> This is some QOM'ify work relate with ppc.
> See each commit message for details.
>=20
> xiaoqiang zhao (4):
>   hw/gpio: QOM'ify mpc8xxx.c
>   hw/ppc: QOM'ify e500.c
>   hw/ppc: QOM'ify ppce500_spin.c
>   hw/ppc: QOM'ify spapr_vio.c
>=20
>  hw/gpio/mpc8xxx.c     | 20 +++++++++++---------
>  hw/ppc/e500.c         | 17 ++++-------------
>  hw/ppc/ppce500_spin.c | 18 ++++++++----------
>  hw/ppc/spapr_vio.c    |  2 --
>  4 files changed, 23 insertions(+), 34 deletions(-)

Patches 1-3 all have the same problem - they move memory region
initialization and similar to an instance_init function.  This is not
how things are generally done in the qdev model.  Instead that phase
of initialization should be done from a dc->realize() function.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--yEPQxsgoJgBvi8ip
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYatQMAAoJEGw4ysog2bOSs5oQALvswDELksY3Wkph8kEwMVD1
SdB9vGO4fwG27A+WPcf7edM4msTXUUsuJVvnkjjTkP0RiJzFMt5kR2TnM1yQKqP9
ECJs3cGriX2H8RXAvvNdN1f8ouJJ1QAUnfeEQVIdc82R769MvLk3HQO1kDb0DhlG
BrwBNBawNavkQQAmAShhwUXBE3TCnc0aaKAe6pW0CWNG/u7AGa9FFdM1WIru7hfM
ZajXYGsSi2IjGtv758xAe2lORAv4EbHn0QrHMlEzgk5EeW99VkaLTmVJLTGc6Fuv
1NpF+WagjWsYZ/dHdgkU+nBHxBFJRptfyMJKUl8EqRGd5UXV41+5IH4K898QVSI5
phq17Kc/3iyFE3Co8SZSKzhoyzuTxmOBWT8gtNsOl4qHUmv3vPz/ou+nUZRY8UQG
iw2g5Qdqb+sxdPEgA0wc1ba0zbJwXrXt99wYLBDvLeaYaB2E6NXgshn+iDMGbuZH
Ns+hZz7EMR+twHmBjagFAZZzdsV0vNsRXGRKzszt9DIcXi3nEXet7Zt9GTI/QxEk
DcetwTvWuQ14FIkEsaFNN+ieIx5/WzCTxGtUp+jeTn/EuFlxQ4JYG8+dZxevRY7T
tzy4g9LpCYlO1R9Tma4q86yHT+6HuFsVXG7jS5vIxmNkMdNSq3L6xWpoUPRn91XH
eFnnuND/Dc5xOkAulTOD
=AIdZ
-----END PGP SIGNATURE-----

--yEPQxsgoJgBvi8ip--
