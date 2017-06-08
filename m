Received: from eggs.gnu.org ([2001:4830:134:3::10]:53349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dIuWe-0002oD-P8
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 06:18:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dIuWZ-0008I9-NN
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 06:18:48 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:32941)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dIuWZ-0008I5-GI
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 06:18:43 -0400
Received: by mail-wm0-x244.google.com with SMTP id x3so6547377wme.0
	for <qemu-devel@nongnu.org>; Thu, 08 Jun 2017 03:18:43 -0700 (PDT)
Date: Thu, 8 Jun 2017 11:18:40 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170608101840.GD4145@stefanha-x1.localdomain>
References: <20170606072229.9302-1-haozhong.zhang@intel.com>
	<20170606072229.9302-4-haozhong.zhang@intel.com>
	<20170607152749.GF21990@stefanha-x1.localdomain>
	<20170608063948.vpv5ndka76dyyxp4@hz-desktop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wULyF7TL5taEdwHz"
Content-Disposition: inline
In-Reply-To: <20170608063948.vpv5ndka76dyyxp4@hz-desktop>
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


--wULyF7TL5taEdwHz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 08, 2017 at 02:39:48PM +0800, Haozhong Zhang wrote:
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
> I think the the name "readonly" is not precise, because QEMU only sets
> one bit and does not prevent guest writes. It's guest decision to
> treat the vNVDIMM devices as read-only (e.g. Linux kernel).
>=20
> We may use "unsafe-write" instead.

I agree, "readonly" isn't accurate.  I would use the NFIT terminology
and call it "armed".

--wULyF7TL5taEdwHz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZOSSAAAoJEJykq7OBq3PIKIsH+wYZPnWPl1bhFCi8nRO8Xd/B
XPApqS67irumIHZdiCw7D/Al6S0H3Rx2MM5jlskVTBZ8daLbFEFy5EsvufJTBJu6
clmzovB1oKu5o4mNwnVXwiWkxef9lvr1oR8/p2yX1IaPLgHJ48XGMlAwn/4hVNuE
aJwxX+OOR+6XE2un1ACXzJIP+AAYUJwoM5QEJzKKpeCAAMsCyHul8slP3qddnsKB
0t/OoiPVtpPuzMq1xt6xb2n4IAIj2oYjrgF3kGvDzGFqeynXfpMjdG4OKUAvD4or
crCpBrRNq//vsaW7ZjntzHur6ZxZt3ds1NdZG79FWQJKu3MoDktdfZEtcUCkAkM=
=2uBi
-----END PGP SIGNATURE-----

--wULyF7TL5taEdwHz--
