Received: from eggs.gnu.org ([2001:4830:134:3::10]:46442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eP51u-0008Bx-Pu
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 06:16:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eP51q-00058S-NH
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 06:16:50 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:38963)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eP51q-00057y-GA
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 06:16:46 -0500
Received: by mail-wm0-x244.google.com with SMTP id i11so4297560wmf.4
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 03:16:46 -0800 (PST)
Date: Wed, 13 Dec 2017 11:16:43 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171213111643.GJ16782@stefanha-x1.localdomain>
References: <20171211072806.2812-1-haozhong.zhang@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k1BdFSKqAqVdu8k/"
Content-Disposition: inline
In-Reply-To: <20171211072806.2812-1-haozhong.zhang@intel.com>
Subject: Re: [Qemu-devel] [PATCH for-2.12 v4 0/3] nvdimm: fixes for
 (non-)dax backends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Haozhong Zhang <haozhong.zhang@intel.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, ehabkost@redhat.com, Xiao Guangrong <guangrong.xiao@gmail.com>, Dan Williams <dan.j.williams@intel.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>


--k1BdFSKqAqVdu8k/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2017 at 03:28:03PM +0800, Haozhong Zhang wrote:
> Previous versions can be found at
>   v3: https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg04785.html
>   v2: https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg01203.html
>   v1: https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg05919.html
>=20
> Changes in v4:
>  * Document new memory-backend-file option 'align' in qemu-options.hx. (E=
duardo Habkost)
>  * Add endian conversion when setting the unarmed flag in NFIT. (Stefan H=
ajnoczi)
>=20
> Changes in v3:
>  * Add an option 'align' to 'memory-backend-file' to address the
>    failure when mmap device dax (patch 1).
>  * Remove device dax check, which needs to access sysfs and may not
>    work with SELinux.
>  * Add a boolean option 'unarmed' to '-device nvdimm', which allows
>    users to control the unarmed flag in guest ACPI NFIT. I don't make
>    it as OnOffAuto, because of the remove of device dax check.
>  * Document new options added by this patch series.
>=20
> Haozhong Zhang (3):
>   hostmem-file: add "align" option
>   nvdimm: add a macro for property "label-size"
>   nvdimm: add 'unarmed' option
>=20
>  backends/hostmem-file.c | 41 ++++++++++++++++++++++++++++++++++++++++-
>  docs/nvdimm.txt         | 31 +++++++++++++++++++++++++++++++
>  exec.c                  |  8 +++++++-
>  hw/acpi/nvdimm.c        |  7 +++++++
>  hw/mem/nvdimm.c         | 28 +++++++++++++++++++++++++++-
>  include/exec/memory.h   |  3 +++
>  include/hw/mem/nvdimm.h | 12 ++++++++++++
>  memory.c                |  2 ++
>  numa.c                  |  2 +-
>  qemu-options.hx         |  9 ++++++++-
>  10 files changed, 138 insertions(+), 5 deletions(-)

Looks good to me.  I suggest taking this through Eduardo/Igor's host
memory backend tree.

Stefan

--k1BdFSKqAqVdu8k/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaMQwbAAoJEJykq7OBq3PIUY4H/0Vusa18lvB8pKxLWkRwo9//
AhXFggRDHCdKk7M7AAo5Oebz6ztmclf4q6xG9FXIik7tpu4T7W4gHT98gsYq1PvZ
ZTwOh4i3Azc0bWBpHXovzR7z3sRRutTLyfB5GPVz5w2RXOl3MrckUm//J9qf5XXy
hEA0PDHtPsfWphowioTTezp5GDp7QUhnbzsEbstoAKFHZItzV1Sr68M528t5oly5
DH5EOXFq3LMFRGY1DDDrj+pX1SWEhrA54DzREQ4+s1sSowr30TLOt6Sgsc+7OQVR
o4UtmjM3pJSMjvOWgctvqt2wHKTufHzA+eZr+NdmLoZSsfPmXKiyxpAuuoddJqU=
=Xz/8
-----END PGP SIGNATURE-----

--k1BdFSKqAqVdu8k/--
