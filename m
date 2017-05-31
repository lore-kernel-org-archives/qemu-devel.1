Received: from eggs.gnu.org ([2001:4830:134:3::10]:52778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dGAZL-0000Cs-TA
	for qemu-devel@nongnu.org; Wed, 31 May 2017 16:50:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dGAZK-0008Jc-U6
	for qemu-devel@nongnu.org; Wed, 31 May 2017 16:50:15 -0400
References: <20170531094330.1808-1-pbonzini@redhat.com>
	<20170531094330.1808-3-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9767a88f-3123-006b-11b4-fceaf79e6b0b@redhat.com>
Date: Wed, 31 May 2017 15:50:04 -0500
MIME-Version: 1.0
In-Reply-To: <20170531094330.1808-3-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fvln9uuFDNEaFWqVMAuRCM2WW9RldULpG"
Subject: Re: [Qemu-devel] [PATCH 02/11] coroutine-lock: add
 qemu_co_rwlock_downgrade and qemu_co_rwlock_upgrade
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fvln9uuFDNEaFWqVMAuRCM2WW9RldULpG
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org,
 mreitz@redhat.com
Message-ID: <9767a88f-3123-006b-11b4-fceaf79e6b0b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 02/11] coroutine-lock: add
 qemu_co_rwlock_downgrade and qemu_co_rwlock_upgrade
References: <20170531094330.1808-1-pbonzini@redhat.com>
 <20170531094330.1808-3-pbonzini@redhat.com>
In-Reply-To: <20170531094330.1808-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/31/2017 04:43 AM, Paolo Bonzini wrote:
> These functions are more efficient in the presence of contention.
> qemu_co_rwlock_downgrade also guarantees not to block, which may
> be useful in some algorithms too.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/qemu/coroutine.h   | 19 +++++++++++++++++++
>  util/qemu-coroutine-lock.c | 35 +++++++++++++++++++++++++++++++++++
>  2 files changed, 54 insertions(+)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--fvln9uuFDNEaFWqVMAuRCM2WW9RldULpG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZLyx8AAoJEKeha0olJ0NqU0cH/3ShpF+Te9KuPe+5DNC0hNTz
w2hCCrqZertNLWcpqdSAG42er2yAc18sKxftPnqqs9yERRzg+QRfpUbDmOx+m/le
rQJTInHdEysrQVTlu8uevWfGxQBOW9JbIlNUOLJbkWfgAZhmVnRjsa7lSyrBirQm
T5AxhSb/SvAnkpJikGPsP+ST37MpSwrqSN02KJk9/bkhPnW/AtXMtSWiTyvdJPbi
JfeVDtYGLmir+2UmIgq6v7RU9NRfMWnGOXnL6guuVdzhe+KlYYCwGmO0NY/SjsrS
nv4sp9sf7P9ECoyNXssv9LaPqx+5qEbWVynwcvO9WCc4reKQNjH/yfSGAsIqAuo=
=mWvH
-----END PGP SIGNATURE-----

--fvln9uuFDNEaFWqVMAuRCM2WW9RldULpG--
