Received: from eggs.gnu.org ([2001:4830:134:3::10]:58773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1capkI-0002xO-Sw
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 15:18:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1capkF-0005SC-Nx
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 15:18:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48230)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1capkF-0005Ry-Fq
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 15:18:39 -0500
References: <cover.1486285434.git.ben@skyportsystems.com>
	<9a2d2cb01e42d6e61c6198356781dbb2919aca05.1486285434.git.ben@skyportsystems.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <32b79ef4-6d0f-efa5-9da9-5955c4cf39ec@redhat.com>
Date: Mon, 6 Feb 2017 14:18:36 -0600
MIME-Version: 1.0
In-Reply-To: <9a2d2cb01e42d6e61c6198356781dbb2919aca05.1486285434.git.ben@skyportsystems.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qAkqcjRLAJqaJtoQo9RDxxM9RnPScJxNV"
Subject: Re: [Qemu-devel] [PATCH v5 03/10] docs: VM Generation ID device
 description
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ben@skyportsystems.com, qemu-devel@nongnu.org
Cc: Gal Hammer <ghammer@redhat.com>, imammedo@redhat.com, lersek@redhat.com, mst@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qAkqcjRLAJqaJtoQo9RDxxM9RnPScJxNV
From: Eric Blake <eblake@redhat.com>
To: ben@skyportsystems.com, qemu-devel@nongnu.org
Cc: Gal Hammer <ghammer@redhat.com>, imammedo@redhat.com, lersek@redhat.com,
 mst@redhat.com
Message-ID: <32b79ef4-6d0f-efa5-9da9-5955c4cf39ec@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 03/10] docs: VM Generation ID device
 description
References: <cover.1486285434.git.ben@skyportsystems.com>
 <9a2d2cb01e42d6e61c6198356781dbb2919aca05.1486285434.git.ben@skyportsystems.com>
In-Reply-To: <9a2d2cb01e42d6e61c6198356781dbb2919aca05.1486285434.git.ben@skyportsystems.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/05/2017 03:11 AM, ben@skyportsystems.com wrote:
> From: Ben Warren <ben@skyportsystems.com>
>=20
> This patch is based off an earlier version by
> Gal Hammer (ghammer@redhat.com)
>=20
> Requirements section, ASCII diagrams and overall help
> provided by Laszlo Ersek (lersek@redhat.com)
>=20
> Signed-off-by: Gal Hammer <ghammer@redhat.com>
> Signed-off-by: Ben Warren <ben@skyportsystems.com>
> ---
>  docs/specs/vmgenid.txt | 239 +++++++++++++++++++++++++++++++++++++++++=
++++++++
>  1 file changed, 239 insertions(+)
>  create mode 100644 docs/specs/vmgenid.txt
>=20

> +

> +
> +Design Details:
> +---------------
> +
> +Requirements R1a through R1e dicate that the memory holding the

s/dicate/dictate/

> +VM Generation ID must be allocated and owned by the guest operating sy=
stem,

> +
> +GUID Storage Format:
> +--------------------
> +
> +In order to work with OVMF "SDT Header Probe Supressor", the contents =
of

s/Supressor/Suppressor/

> +the vmgenid fw_cfg blob are not simply a 128-bit GUID.  There is also
> +significant padding in order to align and fill a memory page, as shown=
 in the
> +following diagram:
> +
> ++----------------------------------+
> +| SSDT with OEM Table ID =3D VMGENID |
> ++----------------------------------+
> +| ...                              |       TOP OF PAGE
> +| VGIA dword object ---------------|-----> +--------------------------=
-+
> +| ...                              |       | fw-allocated array for   =
 |
> +| _STA method referring to VGIA    |       | "etc/vmgenid"        |

Inconsistent whitespace

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--qAkqcjRLAJqaJtoQo9RDxxM9RnPScJxNV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYmNocAAoJEKeha0olJ0NqcZ4H/2tu0PM1tn+YWvQLSOeuFBPp
UZNZ+GDhWBvB94krWu1cXC4MJET/mhqaMNYsknFEWkshrLvlr3m8fBSC6YIwo2qJ
87il/IHKWiuVkkNghlCKSJ/E8/qMzaRRhFmC4Eskhvkq96OVJd5kIAXA2gCkGnPZ
1CCFPQMec+r0emymboxuuWb/Av2vOKcC6GL+CGZhe/RCio2Gg0pspg+vowvUEHap
rhgz5GpNk3/koa82OppDNkg51x0GITMtJdt2EUS/J/yM+GxFA3yJ8q8zgPYhypn+
sFnDu8e24zt2S8ZqJbtqVhqFX1so6Rg74dOB074+XGvXcjsqRvQFGHHdO4GRBKw=
=HF6o
-----END PGP SIGNATURE-----

--qAkqcjRLAJqaJtoQo9RDxxM9RnPScJxNV--
