Received: from eggs.gnu.org ([2001:4830:134:3::10]:38954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3iwS-000461-OT
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 08:54:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3iwP-0007qI-NX
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 08:54:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53956)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d3iwP-0007q4-Dy
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 08:54:37 -0400
References: <1493260558-20728-1-git-send-email-he.chen@linux.intel.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <24766133-5384-09fd-a24a-8acf964c9367@redhat.com>
Date: Thu, 27 Apr 2017 07:54:31 -0500
MIME-Version: 1.0
In-Reply-To: <1493260558-20728-1-git-send-email-he.chen@linux.intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SFGxETbejil1vbApXHI9CERF8Tv9f05Vl"
Subject: Re: [Qemu-devel] [PATCH v9] Allow setting NUMA distance for
 different NUMA nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: He Chen <he.chen@linux.intel.com>, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, Andrew Jones <drjones@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SFGxETbejil1vbApXHI9CERF8Tv9f05Vl
From: Eric Blake <eblake@redhat.com>
To: He Chen <he.chen@linux.intel.com>, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Andrew Jones <drjones@redhat.com>
Message-ID: <24766133-5384-09fd-a24a-8acf964c9367@redhat.com>
Subject: Re: [PATCH v9] Allow setting NUMA distance for different NUMA nodes
References: <1493260558-20728-1-git-send-email-he.chen@linux.intel.com>
In-Reply-To: <1493260558-20728-1-git-send-email-he.chen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/26/2017 09:35 PM, He Chen wrote:
> This patch is going to add SLIT table support in QEMU, and provides
> additional option `dist` for command `-numa` to allow user set vNUMA
> distance by QEMU command.
>=20
> With this patch, when a user wants to create a guest that contains
> several vNUMA nodes and also wants to set distance among those nodes,
> the QEMU command would like:
>=20
> ```
> -numa node,nodeid=3D0,cpus=3D0 \
> -numa node,nodeid=3D1,cpus=3D1 \
> -numa node,nodeid=3D2,cpus=3D2 \
> -numa node,nodeid=3D3,cpus=3D3 \
> -numa dist,src=3D0,dst=3D1,val=3D21 \
> -numa dist,src=3D0,dst=3D2,val=3D31 \
> -numa dist,src=3D0,dst=3D3,val=3D41 \
> -numa dist,src=3D1,dst=3D2,val=3D21 \
> -numa dist,src=3D1,dst=3D3,val=3D31 \
> -numa dist,src=3D2,dst=3D3,val=3D21 \
> ```
>=20
> Signed-off-by: He Chen <he.chen@linux.intel.com>
>=20
> ---
> Changes since v8:
> * numa_{node, distance}_parse --> parse_numa_{node, distance}
> * Comments refinement.


> ---
>  hw/acpi/aml-build.c         |  26 +++++++++
>  hw/i386/acpi-build.c        |   4 ++
>  include/hw/acpi/aml-build.h |   1 +
>  include/sysemu/numa.h       |   2 +
>  include/sysemu/sysemu.h     |   4 ++
>  numa.c                      | 137 ++++++++++++++++++++++++++++++++++++=
+++++++-
>  qapi-schema.json            |  30 +++++++++-
>  qemu-options.hx             |  16 +++++-
>  8 files changed, 215 insertions(+), 5 deletions(-)

Markus has asked that all new QMP commands have some testsuite exposure;
he may have some advice on what test would be best to modify to give us
some coverage of this feature.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--SFGxETbejil1vbApXHI9CERF8Tv9f05Vl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZAeoHAAoJEKeha0olJ0Nq8m0H+wddRPy5GpN4pkkFckhIzl08
fPtSRA95uVLbGCqPl8RmsUeEFPdhmcD7eW2z+O6zXlxP6B5osb/SLun8uFPT4Dz3
1vyVNRgGPOVInCjwngviHZUYEvGVHhaswasUi64ySFNVWpSEtq4xFYpjOt3GI26D
0WWfeoIrxZn/u2w4cr62BthwM1LjSSx6rwJaoD+Mf996MnoIeH1npAqfqIxK87Vs
aBSNegNfmgH9ilDcB2fFNY+uukltW/4K1Gr37WJ9Z9i9NncMY0o7ZBs9Mztvybml
59NbQyfhua69IAk5nyS6ye28lbEAzMChV77C4f7Ml6QpOUnGqoU5s91mqEjL8S8=
=Y3sl
-----END PGP SIGNATURE-----

--SFGxETbejil1vbApXHI9CERF8Tv9f05Vl--
