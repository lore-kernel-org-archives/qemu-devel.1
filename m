Received: from eggs.gnu.org ([209.51.188.92]:37782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hBey8-0003UZ-9O
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 08:26:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hBey7-000483-Ha
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 08:26:16 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:50364)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hBey7-00046e-58
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 08:26:15 -0400
Received: by mail-wm1-x344.google.com with SMTP id z11so7240498wmi.0
	for <qemu-devel@nongnu.org>; Wed, 03 Apr 2019 05:26:14 -0700 (PDT)
Date: Wed, 3 Apr 2019 13:26:11 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190403122611.GD32425@stefanha-x1.localdomain>
References: <20190401154028.GA10574@erokenlabserver>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wULyF7TL5taEdwHz"
Content-Disposition: inline
In-Reply-To: <20190401154028.GA10574@erokenlabserver>
Subject: Re: [Qemu-devel] [PATCH v2] Replace calls to object_child_foreach()
 with object_child_foreach_recursive()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ernest Esene <eroken1@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>


--wULyF7TL5taEdwHz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 01, 2019 at 04:40:28PM +0100, Ernest Esene wrote:
> Replace calls to object_child_foreach() with object_child_foreach_recursi=
ve()
> when applicable: nvdimm_device_list, nmi_monitor_handle,
> find_sysbus_device,
> pc_dimm_slot2bitmap, build_dimm_list.
>=20
> Signed-off-by: Ernest Esene <eroken1@gmail.com>
>=20
> ---
> v2:
>   * applied changes suggested by Paolo
> ---
>  hw/acpi/nvdimm.c           |  4 +---
>  hw/core/sysbus.c           | 11 ++++-------
>  hw/mem/pc-dimm.c           |  3 +--
>  hw/virtio/virtio-balloon.c |  3 +--
>  4 files changed, 7 insertions(+), 14 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--wULyF7TL5taEdwHz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcpKZjAAoJEJykq7OBq3PINSsH/i7+3q2WTThvejCJAiDQ1Ykf
r2xaIquB1A48jweuGa9I87s3l2U1TNgUdyyc3G1VOGONxRloHAfGFwzXOJMgFTzq
BRxqKbjKTXUjCDKrFpl+skpx4fBXpl6Roonn13137+zMo+QVlV90DjTYrrwVqr43
8vVx1cwRMNuNZ64crUzUoer5IDpW8FGRZQXhf+ADRDmiJWJzQRTHM7ZLKOXgVtub
my17P0v7nlyy00N+HEhWhT7WzAhpkI60aHdMEZlmUcQaNBDyLmwT3ehxuVXrr5fc
flsLdMpanV6O9Cp5Cm+3VT6Mo5pEd8nj8XD1RDh1EBiH9SFE8YUaL/SyeuYzYD4=
=dWSF
-----END PGP SIGNATURE-----

--wULyF7TL5taEdwHz--
