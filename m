Received: from eggs.gnu.org ([2001:4830:134:3::10]:52150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cQxOC-0004L0-In
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 09:27:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cQxO8-0000wp-KK
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 09:27:04 -0500
References: <1484014214-32533-1-git-send-email-joserz@linux.vnet.ibm.com>
	<1484014214-32533-2-git-send-email-joserz@linux.vnet.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <06e76bc5-d233-ff2b-1f62-ef23c3f20066@redhat.com>
Date: Tue, 10 Jan 2017 08:26:57 -0600
MIME-Version: 1.0
In-Reply-To: <1484014214-32533-2-git-send-email-joserz@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="VuTohf5acbm6CSotoO6rIw9fORATS6t10"
Subject: Re: [Qemu-devel] [PATCH v5 1/7] host-utils: Move 128-bit guard
 macro to .c file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, nikunj@linux.vnet.ibm.com, bharata@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VuTohf5acbm6CSotoO6rIw9fORATS6t10
From: Eric Blake <eblake@redhat.com>
To: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au,
 nikunj@linux.vnet.ibm.com, bharata@linux.vnet.ibm.com
Message-ID: <06e76bc5-d233-ff2b-1f62-ef23c3f20066@redhat.com>
Subject: Re: [PATCH v5 1/7] host-utils: Move 128-bit guard macro to .c file
References: <1484014214-32533-1-git-send-email-joserz@linux.vnet.ibm.com>
 <1484014214-32533-2-git-send-email-joserz@linux.vnet.ibm.com>
In-Reply-To: <1484014214-32533-2-git-send-email-joserz@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/09/2017 08:10 PM, Jose Ricardo Ziviani wrote:
> It is not possible to implement functions in host-utils.c for
> architectures with quadwords because the guard is implemented in the
> Makefile. This patch move the guard out of the Makefile to the

s/move/moves/

> implementation file.
>=20
> Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
> ---
>  util/Makefile.objs | 2 +-
>  util/host-utils.c  | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--VuTohf5acbm6CSotoO6rIw9fORATS6t10
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYdO8xAAoJEKeha0olJ0Nq9TsH/3M4uIZz0qw0EqKZu2ZR/nIU
gJHT7sTD8R/ZTzhYLMmJf0C1mPGrDht0+YgnPDeB/XZYuoqynq0S1q/bidvKhntl
LAPLQswm5FjwxpQcWtfTD934uK0BH8ATN0lWKQzMQNxez+NpQ3H9ww6QHng5ABh2
sXJ1EFQ24Z+FQIRA7YO/2o/2I120+EZBSLS6GjWxHejp3Asc/jaaoNOzaHsO0Msf
1lDiZqh+QBRq8ilnAOe5XdBVe49all5VOg8ZdmbHEqZlgqiVtGNos0KvvJ5heYUM
AyJMB0kMbq+VQbIJIBjhDS3DixQ+tRrylrUIvZZfPwkOmUOAc6d4wMKxGnn/tA0=
=/DSn
-----END PGP SIGNATURE-----

--VuTohf5acbm6CSotoO6rIw9fORATS6t10--
