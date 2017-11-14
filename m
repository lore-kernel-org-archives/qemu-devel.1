Received: from eggs.gnu.org ([2001:4830:134:3::10]:35037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEkdy-0003Be-J2
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 18:29:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEkdx-00024Z-T1
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 18:29:26 -0500
References: <20171114180128.17076-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <3bf50366-6d6b-4385-b670-82d70ca65843@redhat.com>
Date: Wed, 15 Nov 2017 00:29:16 +0100
MIME-Version: 1.0
In-Reply-To: <20171114180128.17076-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9wmvaPaMhbAJCXdf08uTefMd5miE2O0gb"
Subject: Re: [Qemu-devel] [PATCH for-2.11? v7 0/6] block: Don't compare
 strings in bdrv_reopen_prepare()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9wmvaPaMhbAJCXdf08uTefMd5miE2O0gb
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Message-ID: <3bf50366-6d6b-4385-b670-82d70ca65843@redhat.com>
Subject: Re: [PATCH for-2.11? v7 0/6] block: Don't compare strings in
 bdrv_reopen_prepare()
References: <20171114180128.17076-1-mreitz@redhat.com>
In-Reply-To: <20171114180128.17076-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-14 19:01, Max Reitz wrote:
> bdrv_reopen_prepare() assumes that all BDS options are strings, which i=
s
> not necessarily correct. This series introduces a new qobject_is_equal(=
)
> function which can be used to test whether any options have changed,
> independently of their type.

Aaand once again applied to my block branch.

(As always, thank you for reviewing, Eric -- I'm happy to have expanded
your knowledge on obscure C behavior. :-))

Max


--9wmvaPaMhbAJCXdf08uTefMd5miE2O0gb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloLfEwSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AT0MH/jctgKiYIVV3mjuyIrYwgzmzX/+WjQF6
/hwroOLhaFgQx4JJ4vi2fhLsAB0aZmGTNIvXTyDtcF14wfaSmufU7LQGGZzp+ujt
KF4NWpvdWjTZqo3SsdnP0pJbzQyDZrwHax756ixdKEBXD/EUZBVxjBMhRwA3Xr4r
E23O0KVYPkCp3CwBdyLocXdlfSimFLPYNKjZdaNjqXOf5iLlAyLxhwFWN34TD/Nl
dt1vEI4EBTh1/fhKEpUqL3fD5CKil52n9nZY0yjZF0lr1oOgsGVyrK+3DI845b5q
4Sqq7A2ala+JcuIU92edVDV3PLZINOGlJTxnU3y5qigKk7fFTZQwq68=
=pU9n
-----END PGP SIGNATURE-----

--9wmvaPaMhbAJCXdf08uTefMd5miE2O0gb--
