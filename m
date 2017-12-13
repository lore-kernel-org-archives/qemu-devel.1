Received: from eggs.gnu.org ([2001:4830:134:3::10]:46066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eP50o-0007do-NM
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 06:15:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eP50n-0004gG-Pe
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 06:15:42 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:45339)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eP50n-0004fv-JH
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 06:15:41 -0500
Received: by mail-wm0-x243.google.com with SMTP id 9so4224377wme.4
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 03:15:41 -0800 (PST)
Date: Wed, 13 Dec 2017 11:15:39 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171213111539.GI16782@stefanha-x1.localdomain>
References: <20171211072806.2812-1-haozhong.zhang@intel.com>
	<20171211072806.2812-4-haozhong.zhang@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pe+tqlI1iYzVj1X/"
Content-Disposition: inline
In-Reply-To: <20171211072806.2812-4-haozhong.zhang@intel.com>
Subject: Re: [Qemu-devel] [PATCH v4 3/3] nvdimm: add 'unarmed' option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Haozhong Zhang <haozhong.zhang@intel.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, ehabkost@redhat.com, Xiao Guangrong <guangrong.xiao@gmail.com>, Dan Williams <dan.j.williams@intel.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Igor Mammedov <imammedo@redhat.com>


--pe+tqlI1iYzVj1X/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2017 at 03:28:06PM +0800, Haozhong Zhang wrote:
> Currently the only vNVDIMM backend can guarantee the guest write
> persistence is device DAX on Linux, because no host-side kernel cache
> is involved in the guest access to it. The approach to detect whether
> the backend is device DAX needs to access sysfs, which may not work
> with SELinux.
>=20
> Instead, we add the 'unarmed' option to device 'nvdimm', so that users
> or management utils, which have enough knowledge about the backend,
> can control the unarmed flag in guest ACPI NFIT via this option. The
> guest Linux NVDIMM driver, for example, will mark the corresponding
> vNVDIMM device read-only if the unarmed flag in guest NFIT is set.
>=20
> The default value of 'unarmed' option is 'off' in order to keep the
> backwards compatibility.
>=20
> Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> ---
>  docs/nvdimm.txt         | 15 +++++++++++++++
>  hw/acpi/nvdimm.c        |  7 +++++++
>  hw/mem/nvdimm.c         | 26 ++++++++++++++++++++++++++
>  include/hw/mem/nvdimm.h |  9 +++++++++
>  4 files changed, 57 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--pe+tqlI1iYzVj1X/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaMQvbAAoJEJykq7OBq3PIO/4IAKBoofEqHz8TShO/qf70Axty
YXWaXXvkFHT6ZSRxM9h31bJPtzDUTYFm/0p4sJfJh5JPN2dJtsAdaL8QtdmZ65kw
4SwHbBcRJk6jNtZNKiGgZdVNhRynEg2m1xmHKRx8GPINe8kcW3+ozalOpAn9i1Cp
oDovyQzW9KnwhLZHiRbyn7anP1NMt4XBQ+xKesweCsruwCfq2L5JuoxVt8YdeQHH
0O2T40fpnssaFAYPTx18pZza//MdvT0CKtFU8k6Tehu7Glva546vNlGbajnh10fa
JPWuZRnfd+Z82DzsF/vQUERow2fI+LvKaTXlLuG1MB7zzPsg+VFHLWtHBQoQ93E=
=m6Qy
-----END PGP SIGNATURE-----

--pe+tqlI1iYzVj1X/--
