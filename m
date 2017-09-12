Received: from eggs.gnu.org ([2001:4830:134:3::10]:52844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1drmT9-0005ex-Ed
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:47:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1drmT3-00030Y-NY
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:47:19 -0400
Received: from 2.mo1.mail-out.ovh.net ([178.32.119.250]:46721)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1drmT3-0002t9-IJ
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:47:13 -0400
Received: from player691.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id F1ADC93745
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 16:47:05 +0200 (CEST)
Date: Tue, 12 Sep 2017 16:46:44 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170912164644.2a0b6977@bahia.lan>
In-Reply-To: <20170912140149.7692-1-lvivier@redhat.com>
References: <20170912140149.7692-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/i.ApcJMV0GdXfvlPdJ1DGjK";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v3 0/3] hmp: fix "dump-quest-memory"
 segfault
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, ehabkost@redhat.comdgilbert@redhat.com

--Sig_/i.ApcJMV0GdXfvlPdJ1DGjK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 12 Sep 2017 16:01:46 +0200
Laurent Vivier <lvivier@redhat.com> wrote:

> Fix aarch64 and ppc when dump-guest-memory is
> used with none machine type and no CPU.
>=20
> The other machine types don't have the problem.
>=20
> Update test-hmp, to test none machine type
> with (2 MB) and without memory, and add a test
> to test dump-quest-memory without filter parameters
> (it needs the fix from Cornelia Huck to work)
>=20
> v3:
>   - remove blank line after a comment
>   - forbid memory dump when there is no CPU
>=20

So in the end, we would forbid dump on aarch64 and
ppc, while it is allowed on i386... I don't really
care about which behavior is more appropriate but
I guess they should be consistent at least.

Cc'ing some x86 and HMP people.

> v2:
>   - add arm fix
>   - update test-hmp
>=20
> Laurent Vivier (3):
>   hmp: fix "dump-quest-memory" segfault (ppc)
>   hmp: fix "dump-quest-memory" segfault (arm)
>   tests/hmp: test "none" machine with memory
>=20
>  target/arm/arch_dump.c | 11 +++++++++--
>  target/ppc/arch_dump.c | 11 +++++++++--
>  tests/test-hmp.c       |  4 ++++
>  3 files changed, 22 insertions(+), 4 deletions(-)
>=20


--Sig_/i.ApcJMV0GdXfvlPdJ1DGjK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQQr1DtEU17Ap5iU26IC/DrrAQHbwgUCWbfzVQAKCRAC/DrrAQHb
wsbCAJ0Qtc/uTwfheyO5xyrUL30XOwEmvgCghh8Pc0TnfWH2C64EDkHscryirA0=
=C7p7
-----END PGP SIGNATURE-----

--Sig_/i.ApcJMV0GdXfvlPdJ1DGjK--
