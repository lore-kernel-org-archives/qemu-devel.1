Received: from eggs.gnu.org ([2001:4830:134:3::10]:52861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ckvKr-0000Ce-LW
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 11:18:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ckvKo-00083q-HK
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 11:18:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37470)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ckvKo-00083T-4F
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 11:18:06 -0500
References: <148878895545.4635.12311472774377490920.stgit@bahia>
	<148878897279.4635.8320563171450519845.stgit@bahia>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9a146539-e628-cbd6-93ba-fc41e54fed99@redhat.com>
Date: Mon, 6 Mar 2017 10:18:03 -0600
MIME-Version: 1.0
In-Reply-To: <148878897279.4635.8320563171450519845.stgit@bahia>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="N1568R6HgT51gBqQioMiTPdt701HQXCNs"
Subject: Re: [Qemu-devel] [PATCH v2 1/2] 9pfs: fix O_PATH build break with
 older glibc versions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--N1568R6HgT51gBqQioMiTPdt701HQXCNs
From: Eric Blake <eblake@redhat.com>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <9a146539-e628-cbd6-93ba-fc41e54fed99@redhat.com>
Subject: Re: [PATCH v2 1/2] 9pfs: fix O_PATH build break with older glibc
 versions
References: <148878895545.4635.12311472774377490920.stgit@bahia>
 <148878897279.4635.8320563171450519845.stgit@bahia>
In-Reply-To: <148878897279.4635.8320563171450519845.stgit@bahia>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/06/2017 02:29 AM, Greg Kurz wrote:
> When O_PATH is used with O_DIRECTORY, it only acts as an optimization: =
the
> openat() syscall simply finds the name in the VFS, and doesn't trigger =
the
> underlying filesystem.
>=20
> On systems that don't define O_PATH, because they have glibc version 2.=
13
> or older for example, we can safely omit it. We don't want to deactivat=
e
> O_PATH globally though, in case it is used without O_DIRECTORY. The is =
done
> with a dedicated macro.

May be worth adding:

Systems without O_PATH may thus fail to resolve names that involve
unreadable directories, compared to newer systems succeeding, but such
corner case failure is our only option on those older systems to avoid
the security hole of chasing symlinks inappropriately.

>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/9pfs/9p-util.h |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--N1568R6HgT51gBqQioMiTPdt701HQXCNs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYvYu7AAoJEKeha0olJ0Nqn0sIAKA2sGle2ZZqyh4cP4KnhIxO
fTPSNYbOxyNuNabbeCyQpUtz4kdl0f5I8NcJJEVmemZOGcvF45OzRV0AeS2xC8pT
2hD/kDrvqcEebb1hQ1ZMjav08sS5+TiTCH8YB5MyOHrSnS8QfJbx2E726MIiVBMV
PmG3i1z2QUq2om0JpHvw3cNLRAWrElZS7s+hSuL7KmVjBUSoLfVsnHPTREMQvqx4
oXaF6CV18vIiOxgwIk9MueYmQDTnUKFTkRWKYAsqhIheIswQPgs122jNbA314kaC
gbVu2wLzVwtcIeYkHwzXqk1YfryNjjX/imgsvJl7hcO01LG2owK8QosMkTULklg=
=1pDv
-----END PGP SIGNATURE-----

--N1568R6HgT51gBqQioMiTPdt701HQXCNs--
