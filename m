Received: from eggs.gnu.org ([2001:4830:134:3::10]:49464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ctwmV-0003Tl-0s
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 09:39:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ctwmR-0002z5-QB
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 09:39:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:21743)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ctwmR-0002yF-Hz
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 09:39:55 -0400
References: <20170331101947.2046-1-vfeenstr@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9bdac750-f62d-b010-db4b-0f42cb1d0a21@redhat.com>
Date: Fri, 31 Mar 2017 08:39:53 -0500
MIME-Version: 1.0
In-Reply-To: <20170331101947.2046-1-vfeenstr@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Sh9KH7abNicCf9wwLtkRuQp4i8DEVjnhe"
Subject: Re: [Qemu-devel] [PATCH v3] qemu-ga: add guest-get-osrelease command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vinzenz 'evilissimo' Feenstra <vfeenstr@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@gmail.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Sh9KH7abNicCf9wwLtkRuQp4i8DEVjnhe
From: Eric Blake <eblake@redhat.com>
To: Vinzenz 'evilissimo' Feenstra <vfeenstr@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@gmail.com
Message-ID: <9bdac750-f62d-b010-db4b-0f42cb1d0a21@redhat.com>
Subject: Re: [PATCH v3] qemu-ga: add guest-get-osrelease command
References: <20170331101947.2046-1-vfeenstr@redhat.com>
In-Reply-To: <20170331101947.2046-1-vfeenstr@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/31/2017 05:19 AM, Vinzenz 'evilissimo' Feenstra wrote:
> From: Vinzenz Feenstra <vfeenstr@redhat.com>
>=20
> This is a concept change over v2 of the guest-get-osinfo command.
> The command now adds all information in the os-release format.

Cover letters are not necessary (but don't hurt) for one-patch series -
but if you DO use a cover letter, please also turn on numbering, so that
the subject lines can be distinguished between the 0/1 cover letter and
1/1 patch.  'git config format.coverletter auto' will make the creation
of cover letters happen only when you send multi-patch series.

>=20
> Vinzenz Feenstra (1):
>   qemu-ga: add guest-get-osrelease command
>=20
>  qga/commands-posix.c |  41 +++++++++++++++++
>  qga/commands-win32.c | 127 +++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  qga/qapi-schema.json |  29 ++++++++++++
>  3 files changed, 197 insertions(+)
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--Sh9KH7abNicCf9wwLtkRuQp4i8DEVjnhe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY3lwpAAoJEKeha0olJ0NqgjIIAILAdI0u1RnsyrGbo1IcXq8x
2kY+Nyp21g3oAddAqIK+0S+WeO4QVUqea9xKZChuDw09MgsqQo1/8czPRVjFiuMl
n1ggGRk0p0E5R7o8rCXUfyu2+00s8zXOKmwHZTgYmz03kKB1AfsQKclUcgKUeiSq
DvWxcEhZDkzggZtkYQ4wWRChIRQ2NGp/CHgBNVNfMtUM4vkFnUZaoBAG5qHKcmii
qdTTjLzSoqQ3Rcf0vY6tm8Gr/ADgJdIzWetXDA5stFG+8wRpSyGe/uuaxLBBckiy
i4W8U3GyU4kbF9lHJHRcfqhsySfZ8upPssjyX/xpLyYonCnxzray0xZOQa7bcnM=
=uejK
-----END PGP SIGNATURE-----

--Sh9KH7abNicCf9wwLtkRuQp4i8DEVjnhe--
