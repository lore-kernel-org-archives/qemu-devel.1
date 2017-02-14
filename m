Received: from eggs.gnu.org ([2001:4830:134:3::10]:49000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cdkkK-0002UC-FM
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 16:34:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cdkkH-0002Gj-Ak
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 16:34:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60720)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cdkkH-0002Gc-1u
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 16:34:45 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2E3B87FB67
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 21:34:45 +0000 (UTC)
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
	<1487067971-10443-7-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ec8be224-2e06-5444-0631-bca12d8b20a2@redhat.com>
Date: Tue, 14 Feb 2017 15:34:43 -0600
MIME-Version: 1.0
In-Reply-To: <1487067971-10443-7-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SU5dETuJRQCaSpVNDgN4MVjG48NVkxBcO"
Subject: Re: [Qemu-devel] [PATCH 06/24] util/cutils: Rename qemu_strtoll(),
 qemu_strtoull()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SU5dETuJRQCaSpVNDgN4MVjG48NVkxBcO
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <ec8be224-2e06-5444-0631-bca12d8b20a2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 06/24] util/cutils: Rename qemu_strtoll(),
 qemu_strtoull()
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
 <1487067971-10443-7-git-send-email-armbru@redhat.com>
In-Reply-To: <1487067971-10443-7-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/14/2017 04:25 AM, Markus Armbruster wrote:
> The name qemu_strtoll() suggests conversion to long long, but it
> actually converts to int64_t.  Rename to qemu_strtoi64().
>=20
> The name qemu_strtoull() suggests conversion to unsigned long long,
> but it actually converts to uint64_t.  Rename to qemu_strtou64().
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  include/qemu/cutils.h |   6 +-
>  qobject/qdict.c       |   2 +-
>  qtest.c               |  34 ++---
>  tests/test-cutils.c   | 366 +++++++++++++++++++++++++++---------------=
--------
>  util/cutils.c         |   4 +-
>  util/log.c            |   4 +-
>  6 files changed, 224 insertions(+), 192 deletions(-)

Thankfully, not too many existing clients (except in the testsuite).
Mechanical search-and-replace, and I don't see anything missed, so:

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--SU5dETuJRQCaSpVNDgN4MVjG48NVkxBcO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYo3fzAAoJEKeha0olJ0NqrykIAI0mMeg61qlSQZ8FjWdDAuvW
tFtiaGVh0pgtD3NGWE0OkBZq4HrvAOvr5BAWMOvAkq7YraOB4/5bLMqgukHHvyco
pWk11N43r3OVczQXCDyTRZjr/39z+6o3pu9f44RmrFXbv4uOw7Mvl5xV1bEPs/an
KDQwxyJ/ITLFE55fq2dg5wpJwMwjrNcjrP+iHKns6zVTyFyHg0kkkZqbABshphZQ
n/BIaxjRUKzJFNBhWqrOs6nfz3qZYdHcF5xx7spot3cRzNjb6Dv91JvNttzDI/R2
zDCu1wLc8gwRnQf18+v9+q0qGVV/NhHL6mOA9qVQkcPMiwleCWtsay8AL4EOf6g=
=bV6P
-----END PGP SIGNATURE-----

--SU5dETuJRQCaSpVNDgN4MVjG48NVkxBcO--
