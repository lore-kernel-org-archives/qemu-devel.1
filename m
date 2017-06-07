Received: from eggs.gnu.org ([2001:4830:134:3::10]:39730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dIcsG-0006fg-GT
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 11:27:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dIcsD-0002fz-Cr
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 11:27:56 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:35135)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dIcsD-0002fV-3t
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 11:27:53 -0400
Received: by mail-wm0-x234.google.com with SMTP id x70so60386972wme.0
	for <qemu-devel@nongnu.org>; Wed, 07 Jun 2017 08:27:53 -0700 (PDT)
Date: Wed, 7 Jun 2017 16:27:49 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170607152749.GF21990@stefanha-x1.localdomain>
References: <20170606072229.9302-1-haozhong.zhang@intel.com>
	<20170606072229.9302-4-haozhong.zhang@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4VrXvz3cwkc87Wze"
Content-Disposition: inline
In-Reply-To: <20170606072229.9302-4-haozhong.zhang@intel.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/4] nvdimm: add a boolean option
 "restrict"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Haozhong Zhang <haozhong.zhang@intel.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Xiao Guangrong <guangrong.xiao@gmail.com>, Dan Williams <dan.j.williams@intel.com>


--4VrXvz3cwkc87Wze
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 06, 2017 at 03:22:28PM +0800, Haozhong Zhang wrote:
> If a vNVDIMM device is not backed by a DAX device and its "restrict"
> option is enabled, bit 3 of state flags in its region mapping
> structure will be set, in order to notify the guest of the lack of
> write persistence guarantee. Once this bit is set, the guest OS may
> mark the vNVDIMM device as read-only.
>=20
> This option is disabled by default for backwards compatibility. It's
> recommended to enable for the formal usage.

Good idea.  I think the following is cleaner:

DEFINE_PROP_ON_OFF_AUTO("readonly") on the 'nvdimm' device.  The
following states are available:

 * 'on' - ACPI_NFIT_MEM_NOT_ARMED is set
 * 'off' - ACPI_NFIT_MEM_NOT_ARMED is clear
 * 'auto' - ACPI_NFIT_MEM_NOT_ARMED set if backend is not persistent

This new property defaults to 'auto'.  Machine types older than
pc-i440fx-2.10 and pc-q35-2.10 default to 'on'.

--4VrXvz3cwkc87Wze
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZOBt1AAoJEJykq7OBq3PI8TEH/i6+5lyu5WgdASiizf8E8GIU
l23/AbH+bnRib3JwdRGTmNsd398lM32B4YVfS1xkhBqsHmm0+aIQ+AwhkxK4n7Vf
P3si0lOu4IdC0xI0c6EvNc42RKQBUliaLpTC1JGBewH4KjMi7JgMOpetY1zsSQW7
1WtbU8Kf3Upr5RQ2SVj/TrZ7p6odUGyBJy0j+6KO0DK7IfdV7MCYu33l0XytlFGI
sfNL3urVOtBvoTU7MhFqslUl659xaiFTrQU9e82ZFhDCQLL4eGWjpRcXZTxSp2C3
FnDz/av7skUfW34i2qVTUURA2SkhVNEoJ4UTXAvmOftaTh2zVyoJ/jBJEgbPkq8=
=kHNO
-----END PGP SIGNATURE-----

--4VrXvz3cwkc87Wze--
