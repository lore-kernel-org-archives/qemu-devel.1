Received: from eggs.gnu.org ([2001:4830:134:3::10]:56871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dKiTC-0000ie-4p
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 05:50:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dKiT9-00035z-35
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 05:50:42 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:34502)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dKiT8-00035q-Rk
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 05:50:39 -0400
Received: by mail-lf0-x243.google.com with SMTP id o28so11775376lfk.1
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 02:50:38 -0700 (PDT)
Date: Tue, 13 Jun 2017 10:50:30 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170613095030.GB29273@stefanha-x1.localdomain>
References: <20170524150753.GB23327@stefanha-x1.localdomain>
	<1497334024.13717.8.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TRYliJ5NKNqkz5bu"
Content-Disposition: inline
In-Reply-To: <1497334024.13717.8.camel@linux.intel.com>
Subject: Re: [Qemu-devel] Status of q35-lite?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Chao Peng <chao.p.peng@linux.intel.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, rjones@redhat.com, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>


--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 13, 2017 at 02:07:04PM +0800, Chao Peng wrote:
> On Wed, 2017-05-24 at 16:07 +0100, Stefan Hajnoczi wrote:
> > Hi Chao,
> > Last year there was an effort to make "built-in" hardware optional so
> > that VMs can be launched with a minimal set of devices.=A0=A0You made
> > SATA,
> > PIT, and SMBus optional.
> >=20
> > What is the current status of this work?
> >=20
> > Are there more devices that could benefit from an optional switch?
>=20
> Hi Stefan, in terms of making device optional, we don't have more
> follow-ups basically because other build-in devices do not have
> significant performance impact. For other optimizations (like
> optimizing/skipping BIOS), we are still working on them.

Excellent to hear!  If you want early feedback on BIOS optimizations
then this mailing list or SeaBios/ed2k might be good places to discuss.

KVM Forum proposals can be submitted until Thursday, June 15th.  That
would be a good forum to present your work:
http://events.linuxfoundation.org/events/kvm-forum/program/cfp

Stefan

--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZP7VlAAoJEJykq7OBq3PIIrwH/AsW44E8/T/HRQLWarWXtWEV
pcniSGMiWfOfG7ZvnB4jvanuMsPl/Yc3kwxV00QezS5CRG0FqSCxfCa+oonmE8U5
But80vnteqNAELtM0KWpUdH7zOIw1tekdE9EwjQatxgbqfk7s3DGNbyeTpor4dSS
VbVH2U26xZtnW4FvQyek0Pu3FhoptVOzTzuds7cye9grQPyzbfRkThm3Q5v9ivRS
rLHvK2EPCdnBdu+cMfpD7i3cBWCNBuF964ryDG3uxVtBjFXaNL43/oaO7h4A8iDE
bwX6va8WPSHGDJ5pyNx6ECoPxre8HcFiPDp1ulrbUZwGNCg1yYdvW82LZBEABiQ=
=E0qw
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--
