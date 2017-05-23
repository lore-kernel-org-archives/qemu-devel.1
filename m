Received: from eggs.gnu.org ([2001:4830:134:3::10]:46914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDC5s-0004SU-Rv
	for qemu-devel@nongnu.org; Tue, 23 May 2017 11:51:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDC5q-00057N-BI
	for qemu-devel@nongnu.org; Tue, 23 May 2017 11:51:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:2329)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dDC5q-00057D-27
	for qemu-devel@nongnu.org; Tue, 23 May 2017 11:51:30 -0400
References: <149554993519.23396.2947622015408783770.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<149554995611.23396.9322039196246265398.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <73732d9a-e7df-9d33-1293-eafe5553b8dc@redhat.com>
Date: Tue, 23 May 2017 10:51:26 -0500
MIME-Version: 1.0
In-Reply-To: <149554995611.23396.9322039196246265398.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="OcFJrDMsQghMglo516PTjo2U1JuvHXUfj"
Subject: Re: [Qemu-devel] [PATCH v2 3/4] 9pfs: local: simplify file opening
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Leo Gaspard <leo@gaspard.io>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OcFJrDMsQghMglo516PTjo2U1JuvHXUfj
From: Eric Blake <eblake@redhat.com>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Leo Gaspard <leo@gaspard.io>
Message-ID: <73732d9a-e7df-9d33-1293-eafe5553b8dc@redhat.com>
Subject: Re: [PATCH v2 3/4] 9pfs: local: simplify file opening
References: <149554993519.23396.2947622015408783770.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
 <149554995611.23396.9322039196246265398.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <149554995611.23396.9322039196246265398.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/23/2017 09:32 AM, Greg Kurz wrote:
> The logic to open a path currently sits between local_open_nofollow() a=
nd
> the relative_openat_nofollow() helper, which has no other user.
>=20
> For the sake of clarity, this patch moves all the code of the helper in=
to
> its unique caller. While here we also:
> - drop the code to skip leading "/" because the backend isn't supposed =
to
>   pass anything but relative paths without consecutive slashes. The ass=
ert()
>   is kept because we really don't want a buggy backend to pass   an abs=
olute

odd spacing

>   path to openat().
> - use strchrnul() to get a simpler code. This is ok since virtfs if for=


s/if/is/

>   linux+glibc hosts only.
> - don't dup() the initial directory and add an assert() to ensure we do=
n't
>   return the global mountfd to the caller. BTW, this would mean that th=
e
>   caller passed an empty path, which isn't supposed to happen either.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--OcFJrDMsQghMglo516PTjo2U1JuvHXUfj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZJFp+AAoJEKeha0olJ0Nqrm0IAIEGZZB1PnPaV/vjMQAYaywX
eyYYWRzm/OgsfVO1mqawYyF/07kyoZokEbVcC/dWgU98omiRw9gU+Od2jhptShLz
tq6s/j50vBflHOxLQETxqwnevd9l9pX5PdhMBRQtSzBN/Hcm//ndcMxBlcV1x0RM
KwwPxU0mCOtZl5TwYgRRJmUwobCqvFJIKqCQZfT06wCz9TZ0/tvVqGucQanlwFAU
UMc0AQ8IwDZ1rdV+YaJreKYEkCklqu0TG/EXPO/pd5xTLwTjBoKGnJVNdb8n/74/
qBjPKTi1SMfkYCVq36hREBeThEKH/iHAzBiXrC961EKK5OtcKBF0nMvdT0DTG+w=
=E1T9
-----END PGP SIGNATURE-----

--OcFJrDMsQghMglo516PTjo2U1JuvHXUfj--
