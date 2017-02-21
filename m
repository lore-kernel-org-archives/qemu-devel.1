Received: from eggs.gnu.org ([2001:4830:134:3::10]:36094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgD4O-0003sg-3x
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 11:13:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgD4N-0005uI-0Z
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 11:13:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:8635)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cgD4M-0005th-QV
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 11:13:38 -0500
References: <20170221104256.5153-1-pbonzini@redhat.com>
	<20170221104256.5153-4-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8a3b1720-7670-01df-9e58-490b340bb82d@redhat.com>
Date: Tue, 21 Feb 2017 10:13:34 -0600
MIME-Version: 1.0
In-Reply-To: <20170221104256.5153-4-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1VSlPthUsiQpb7ksBEoxe83g49mbA1Ksj"
Subject: Re: [Qemu-devel] [PATCH 3/3] vl: pass CPUState to
 qemu_system_guest_panicked
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: anton.nefedov@virtuozzo.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1VSlPthUsiQpb7ksBEoxe83g49mbA1Ksj
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: anton.nefedov@virtuozzo.com, den@openvz.org
Message-ID: <8a3b1720-7670-01df-9e58-490b340bb82d@redhat.com>
Subject: Re: [PATCH 3/3] vl: pass CPUState to qemu_system_guest_panicked
References: <20170221104256.5153-1-pbonzini@redhat.com>
 <20170221104256.5153-4-pbonzini@redhat.com>
In-Reply-To: <20170221104256.5153-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/21/2017 04:42 AM, Paolo Bonzini wrote:
> qemu_system_guest_panicked was already using current_cpu implicitly,
> so it makes sense for it to receive a CPUState.  This lets the
> function call cpu_get_crash_info and free the result.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/sysemu/sysemu.h |  2 +-
>  kvm-all.c               |  2 +-
>  vl.c                    | 13 ++++++++++---
>  3 files changed, 12 insertions(+), 5 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--1VSlPthUsiQpb7ksBEoxe83g49mbA1Ksj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYrGcuAAoJEKeha0olJ0NqoFYH/1tANI6fIARxOY4RIsIdSE8Z
X6yvpsFlvOVvfv9HT5UrvbhtU4J7T/0J/3vEN2X28rL/6PqtS+s+eYZ0aVRiOs/c
rLIcaM3E/DlMNI0dwh80UwwRYhGMzhErEeuy4kR787/2Hm1bVHGEZurODMhA/zWA
NT3hnKrw9Czttbr3PKFZoGB5SWdNWJmGf+RJsG8GTRl/UKSfhPqK0S3HZrZlImrW
Fbkiug69B2ggSCjjAQIpwmVkbAG4TgbYCnjWEytOC8OJvz293VWKpcM8YeoPu44C
G6cAZuwcQyfF7TSGB6CJXqUDTzgalg0ldmtDyzp6M1FvtVP7rqgC4MBIqfsC5bU=
=gBuM
-----END PGP SIGNATURE-----

--1VSlPthUsiQpb7ksBEoxe83g49mbA1Ksj--
