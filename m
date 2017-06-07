Received: from eggs.gnu.org ([2001:4830:134:3::10]:40810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dIcwL-00012u-CT
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 11:32:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dIcwI-0003fH-9J
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 11:32:09 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:36838)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dIcwI-0003ez-2V
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 11:32:06 -0400
Received: by mail-wm0-x236.google.com with SMTP id 7so120931914wmo.1
	for <qemu-devel@nongnu.org>; Wed, 07 Jun 2017 08:32:05 -0700 (PDT)
Date: Wed, 7 Jun 2017 16:32:03 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170607153203.GI21990@stefanha-x1.localdomain>
References: <20170607080639.22120-1-haozhong.zhang@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l0l+eSofNeLXHSnY"
Content-Disposition: inline
In-Reply-To: <20170607080639.22120-1-haozhong.zhang@intel.com>
Subject: Re: [Qemu-devel] [PATCH] nvdimm acpi: fix region format interface
 code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Haozhong Zhang <haozhong.zhang@intel.com>
Cc: qemu-devel@nongnu.org, Xiao Guangrong <guangrong.xiao@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Dan Williams <dan.j.williams@intel.com>


--l0l+eSofNeLXHSnY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 07, 2017 at 04:06:39PM +0800, Haozhong Zhang wrote:
> Per ACPI 6.2, section 5.2.25.6 and JEDEC Annex L Release 3, the
> current region format interface code 0x201 indicates the block
> addressed function interface 1, rather than a byte addressable
> interface. Fix it by using 0x301 which indicates the byte addressable
> no energy backed function interface 1.
>=20
> Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> ---
>  hw/acpi/nvdimm.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--l0l+eSofNeLXHSnY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZOBxzAAoJEJykq7OBq3PIYKcIAJAdZbahnuvlRIdSQ7tWveIc
L85TiIS4G9adRJAnVq685Ho8vtycXRE+2QZabNoVahHCmdkNr1ErH/9NceSlku9g
3h3hHCH1UiiORPbvb/EE6ilVbn6gQR109M4DVETHs3LWaqxr/spDGxPkqvoZlPuz
pLdETyrx2l7xEttGed5wZPBnR3G1mDils3zKwQZEgAouk2jBtgPMxXrhlk7jN+l7
zgwuibgoPM69VWpLxAk8o2SyD6eCnrAs+4JOtfH4sMp0VC37RuZ7KQkouQqw4GQu
y6yhCaYD9MO72slYp17J4G6g2YW8us3YCkAJGB+X2pyKmwHJPwmsJ4UfQkgTSxM=
=Oo/D
-----END PGP SIGNATURE-----

--l0l+eSofNeLXHSnY--
