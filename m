Received: from eggs.gnu.org ([208.118.235.92]:60447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@redhat.com>) id 1geWI7-0000EO-Kd
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 21:29:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@redhat.com>) id 1geWI4-0004i5-F3
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 21:29:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@redhat.com>) id 1geWI4-0004hk-9v
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 21:29:52 -0500
Date: Wed, 2 Jan 2019 13:29:41 +1100
From: David Gibson <dgibson@redhat.com>
Message-ID: <20190102132941.0b887a22@umbus.fritz.box>
In-Reply-To: <87k1k5lv96.fsf@dusky.pond.sub.org>
References: <20181211095057.14623-1-fli@suse.com>
	<20181211095057.14623-7-fli@suse.com>
	<87y38tc2fb.fsf@dusky.pond.sub.org>
	<20181214112447.510e4691@umbus.fritz.box>
	<87k1k5lv96.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/403t/VmrCqaCjJYSdUS=F4_";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH for-4.0 v8 6/7] qemu_thread_create:
 propagate the error to callers to handle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Fei Li <fli@suse.com>, qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

--Sig_/403t/VmrCqaCjJYSdUS=F4_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 19 Dec 2018 10:29:41 +0100
Markus Armbruster <armbru@redhat.com> wrote:

> David Gibson <dgibson@redhat.com> writes:
>=20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>=20
> Double-checking: is it okay to report some failures of this function
> (one of two H_RESOURCE failures, to be precise), but not others?

Yes.  The distinction is whether the failure is likely to be of
relevance to the *host* administrator, or just to the guest.

Although.. come to think of it possibly that reported failure should be
H_HARDWARE to the guest, rather than H_RESOURCE.

--=20
David Gibson <dgibson@redhat.com>
Principal Software Engineer, Virtualization, Red Hat

--Sig_/403t/VmrCqaCjJYSdUS=F4_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwsIhUACgkQbDjKyiDZ
s5LRHw//aIRZPGbzMwWNNjxKyU8rm3eDTK2mybf/FszzhguRTnQ6nHcIPn+QI0pi
j577NaQU9nu4d7K2kkMAO4H0IUnBN5hqC8biy3edUr8xXtZbBcuMfMmTgTfs1HHb
7pLrHeEYvtOjk5WoLhkJsU5vNm34Vl78KZpMC2yPScdOCUwkEr8y4MmmU9y+egFZ
Rmw3uLCs8dntdbN3KiHxZEDwVRuq1jg8wghGeCAwY7YX17Jv20sM7oME628usZ2g
WVuM4MvexR6+LLr6UjToExatH4SY7F+5fWHmgF/jwNnQkuEaa/o5WrprGhyzkxII
/kC7VmbQlsDfy+YuZP5IEUXeLxb0wlxpvxo+qIaLsDEf6Llg4v0cXvvOpDlt3BZV
6WI2p5Fm0ZZVgkv0fyf2iRUPsqiwSWUu0Jxu5fZPhtww/+nuM+GQARhTd6QXzWCl
TdOmYcMt6Etrp0xTO21skfJjxo5tmi0dIEkuqUcSDYop3Gajo/I4u5ijU1BvtMWW
sTJ/UjHPnur+6XWeHbM6k9Mp80eBasDYKHOnvmqYzjriTvN4/A9tcXE0MkOo5N0m
0Tv91ocoFLH3WzMItSJj3pqK2ijNNT3dyAngQfYgHM1/YFpmDnM/06KwHFSh8GvB
yxW6e3On3eEpjZbPXCDemGkgmj9FjVpaOKdYTzukb6lc4K4Ukdk=
=UTdW
-----END PGP SIGNATURE-----

--Sig_/403t/VmrCqaCjJYSdUS=F4_--
