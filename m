Received: from eggs.gnu.org ([2001:4830:134:3::10]:52564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVkTR-00087z-JO
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 16:12:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVkTO-00081H-Aj
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 16:12:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:26741)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dVkTO-00080m-1Z
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 16:12:30 -0400
References: <1499965423-13517-1-git-send-email-peter.maydell@linaro.org>
	<b8786d81-4a28-952d-deba-d808ebf42656@gmx.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <56d7a1c9-ad1f-3397-6885-c58239404dd5@redhat.com>
Date: Thu, 13 Jul 2017 15:12:26 -0500
MIME-Version: 1.0
In-Reply-To: <b8786d81-4a28-952d-deba-d808ebf42656@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eVEdvBjhN7mjApqBsJ4Stt2vIGsxLpAhW"
Subject: Re: [Qemu-devel] [PATCH 0/3] Fix NetBSD build (don't build ivshmem
 tools)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, patches@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eVEdvBjhN7mjApqBsJ4Stt2vIGsxLpAhW
From: Eric Blake <eblake@redhat.com>
To: Kamil Rytarowski <n54@gmx.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, patches@linaro.org
Message-ID: <56d7a1c9-ad1f-3397-6885-c58239404dd5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/3] Fix NetBSD build (don't build ivshmem
 tools)
References: <1499965423-13517-1-git-send-email-peter.maydell@linaro.org>
 <b8786d81-4a28-952d-deba-d808ebf42656@gmx.com>
In-Reply-To: <b8786d81-4a28-952d-deba-d808ebf42656@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/13/2017 01:40 PM, Kamil Rytarowski wrote:

>> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$((RANDOM % 255 + 1))} gtester -k=
 --verbose -m=3Dquick tests/check-qdict
>> sh: arith: syntax error: "RANDOM % 255 + 1"
>>
>> likely because we're using a bashism there.

Yes, assuming that $RANDOM exists is a bashism.

>>
>=20
> This is an extension to a POSIX shell. We were lately adding it as an
> extension to our sh(1) in the distribution. Were also thinking about
> prompting POSIX to standarize it.
>=20
> $ echo $((RANDOM % 255))
> 52
>=20
> As of now, one portable solution is to parse /dev/urandom, or use a 3rd=

> party tool like awk(1).

It's also portable (although less random) to do:

$(( ${RANDOM:-0} + 1))

(the whole idea of MALLOC_PERTURB_ only works on glibc anyways, so it
really doesn't matter what you set it to on other systems).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--eVEdvBjhN7mjApqBsJ4Stt2vIGsxLpAhW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZZ9QqAAoJEKeha0olJ0NqHDEIAJ47YGDIhV+mViEz4pjM/glx
uXVoe9Fo6Q5xEz7GI0eE/F2HThe65JvY4OjxPdLJUeWt8gnxI0jgAmreUwS8AclM
+us289oi7MOk3tNZSTU7Fjh47+gbeMTyNaYi6hDuZwch3EIPynJteXfQ8o+22Wga
6U680bN04Xuiitp82VE3gQBri6T6AIioPs4vu7hC0acm6HISxsAQj1DUKY35fAO9
ZsWyzMCjjTWjzyKFHQczLQMqZMUN44MRNuwJs8nDxuJxUfvGG8zSizwNbaUeOtcf
Czo0Ns5QSyMYT7waZNEFwRQIWGE+DXaC4zVNBzRDGwJPl3PXr5YFj4x2xNkDUZE=
=5Eu0
-----END PGP SIGNATURE-----

--eVEdvBjhN7mjApqBsJ4Stt2vIGsxLpAhW--
