Received: from eggs.gnu.org ([2001:4830:134:3::10]:53479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dIuWz-0002y3-Ig
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 06:19:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dIuWu-0008OS-IE
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 06:19:09 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:38858)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dIuWu-0008O8-A2
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 06:19:04 -0400
Received: by mail-wm0-x232.google.com with SMTP id n195so27808132wmg.1
	for <qemu-devel@nongnu.org>; Thu, 08 Jun 2017 03:19:04 -0700 (PDT)
Date: Thu, 8 Jun 2017 11:19:00 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170608101900.GE4145@stefanha-x1.localdomain>
References: <20170606072229.9302-1-haozhong.zhang@intel.com>
	<20170606072229.9302-4-haozhong.zhang@intel.com>
	<20170607152749.GF21990@stefanha-x1.localdomain>
	<20170608014529.5eczic72rw4cxkxl@hz-desktop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ffoCPvUAPMgSXi6H"
Content-Disposition: inline
In-Reply-To: <20170608014529.5eczic72rw4cxkxl@hz-desktop>
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
To: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Xiao Guangrong <guangrong.xiao@gmail.com>, Dan Williams <dan.j.williams@intel.com>


--ffoCPvUAPMgSXi6H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 08, 2017 at 09:45:29AM +0800, Haozhong Zhang wrote:
> On 06/07/17 16:27 +0100, Stefan Hajnoczi wrote:
> > On Tue, Jun 06, 2017 at 03:22:28PM +0800, Haozhong Zhang wrote:
> > > If a vNVDIMM device is not backed by a DAX device and its "restrict"
> > > option is enabled, bit 3 of state flags in its region mapping
> > > structure will be set, in order to notify the guest of the lack of
> > > write persistence guarantee. Once this bit is set, the guest OS may
> > > mark the vNVDIMM device as read-only.
> > >=20
> > > This option is disabled by default for backwards compatibility. It's
> > > recommended to enable for the formal usage.
> >=20
> > Good idea.  I think the following is cleaner:
> >=20
> > DEFINE_PROP_ON_OFF_AUTO("readonly") on the 'nvdimm' device.  The
> > following states are available:
> >=20
> >  * 'on' - ACPI_NFIT_MEM_NOT_ARMED is set
> >  * 'off' - ACPI_NFIT_MEM_NOT_ARMED is clear
> >  * 'auto' - ACPI_NFIT_MEM_NOT_ARMED set if backend is not persistent
> >=20
> > This new property defaults to 'auto'.  Machine types older than
> > pc-i440fx-2.10 and pc-q35-2.10 default to 'on'.
>=20
> Shouldn't it be 'off' on older machine types? The older machine types
> and older QEMU never check the backend and never set ACPI_NFIT_MEM_NOT_AR=
MED.

You are right.  'readonly' should be 'off' for older machine types.

--ffoCPvUAPMgSXi6H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZOSSUAAoJEJykq7OBq3PIYiYH/RGNw48hHAjYhltcLn1eIA9O
lLnuejnaFYxbxgzOKRNlqiK124byCwTjwcdrKRSGcEYwlrvZ02uN2jTWSurtQIFB
ljsUhXhTMdaSyhhNjmg0BwimjV4y1gGmPLQPD81VgVaa/ZewtOdxt5y40MtEBYdT
OizFzRm77Jb+hrwyKr9t9etx4Wi5D9J8FO7Ilj0Md1oCNQOexydqWrTNBBTo0Fo5
t/cPKasLQGn5MiMJpoDbyBwh/1dYHsHkw2k2Ofu58e04r3OCqHgXXwhP2pZg8L5y
7DaqD/hCrbaNaBKCwhOadXo+5A2sfAQWv4ezszf5yele99pCGAKd4SY7oF11IEo=
=HsBm
-----END PGP SIGNATURE-----

--ffoCPvUAPMgSXi6H--
