Received: from eggs.gnu.org ([2001:4830:134:3::10]:43107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fdETK-0001ih-Ck
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 08:43:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fdETG-0005XF-G2
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 08:43:54 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42866)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fdETG-0005X9-7i
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 08:43:50 -0400
Received: by mail-wr1-x442.google.com with SMTP id p1-v6so18030049wrs.9
	for <qemu-devel@nongnu.org>; Wed, 11 Jul 2018 05:43:50 -0700 (PDT)
Date: Wed, 11 Jul 2018 13:43:47 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180711124347.GD31228@stefanha-x1.localdomain>
References: <153077727052.29574.3126128933689774889.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tNQTSEo8WG/FKZ8E"
Content-Disposition: inline
In-Reply-To: <153077727052.29574.3126128933689774889.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH v3] accel: forbid early use of
 kvm_enabled() and friends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Anthony Perard <anthony.perard@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>


--tNQTSEo8WG/FKZ8E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 05, 2018 at 09:54:30AM +0200, Greg Kurz wrote:
> It is unsafe to rely on *_enabled() helpers before the accelerator has
> been initialized, ie, accel_init_machine() has succeeded, because they
> always return false. But it is still possible to end up calling them
> indirectly by inadvertance, and cause QEMU to misbehave.
>=20
> This patch causes QEMU to abort if we try to check for any accelerator
> before accel_init_machine() was called. This will help to catch bugs
> earlier.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>=20
> Current master (SHA1 2a018f6e9878) has such a kvm_enabled() misuse that
> triggers the assert:
>=20
> https://travis-ci.org/gkurz/qemu/jobs/400059821#L8709
>=20
> The fix for the misuse is available, waiting to be merged:
>=20
> https://patchwork.ozlabs.org/patch/938077/
>=20
> v3: - use an inline function
>     - convert all accelerators
>     - dropped David's R-b
>=20
> v2: - dropped change in qom/cpu.c (useless header inclusion)
>     - only #include "sysemu/kvm.h" if we actually need it
>     - added David's R-b from v1 because changes in v2 are minor
> ---
>  accel/accel.c             |    4 ++++
>  include/hw/xen/xen.h      |    3 ++-
>  include/qemu-common.h     |    3 ++-
>  include/sysemu/accel.h    |    8 ++++++++
>  include/sysemu/hvf.h      |    3 ++-
>  include/sysemu/kvm.h      |    3 ++-
>  include/sysemu/qtest.h    |    3 ++-
>  stubs/Makefile.objs       |    1 +
>  stubs/accel.c             |   12 ++++++++++++
>  target/i386/hax-all.c     |    2 +-
>  target/i386/whpx-all.c    |    2 +-
>  tests/ptimer-test-stubs.c |    2 ++
>  12 files changed, 39 insertions(+), 7 deletions(-)
>  create mode 100644 stubs/accel.c

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--tNQTSEo8WG/FKZ8E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbRfuDAAoJEJykq7OBq3PI6lMIAIXL1mRXOWo5fDfLUbeDyJBW
CrHVHW2r9r4bMNg63LiJDThkXnTOQ0B9X/IJ1QHn7jWdrbfylLXHT5yLB8RxbKuS
aiSHRRuL/Jk0meVqOR9db3eWBleCHqJsXtq8PVwipBmDbjmoQBXYbuRRkBwQXSx+
R4o+INwy6S/OOtkyxTDIewxq7xFd1sANbb5zZToGjBQ36Zj9lBZ8wg8P1mfBEq32
pYR7IdjQ/+3ueiDK14OJ9DyqE5HnuP8f/2sU+WqHkXEpWtWObDdqYen42eUoM9SE
o/FqBh35mCq6sOd2d9YKaU5OsDQUezX7fNQM+MgP1bLZvqkHezC3q4a5QXtn5i4=
=oQPa
-----END PGP SIGNATURE-----

--tNQTSEo8WG/FKZ8E--
