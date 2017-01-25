Received: from eggs.gnu.org ([2001:4830:134:3::10]:47573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cWQOQ-0004d7-VR
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 11:25:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cWQOP-0006Sv-Sx
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 11:25:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59834)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cWQOP-0006Sg-Ja
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 11:25:53 -0500
References: <20170125161417.31949-1-berrange@redhat.com>
	<20170125161417.31949-2-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <27d30dd2-dd58-9157-3ed3-2e34c7aa0bd4@redhat.com>
Date: Wed, 25 Jan 2017 10:25:51 -0600
MIME-Version: 1.0
In-Reply-To: <20170125161417.31949-2-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="EFcwV9ogdomaQRsoQlbqBC5kgUqagTe2U"
Subject: Re: [Qemu-devel] [PATCH v4 1/8] make: move top level dir to end of
 include search path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EFcwV9ogdomaQRsoQlbqBC5kgUqagTe2U
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>,
 Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <27d30dd2-dd58-9157-3ed3-2e34c7aa0bd4@redhat.com>
Subject: Re: [PATCH v4 1/8] make: move top level dir to end of include search
 path
References: <20170125161417.31949-1-berrange@redhat.com>
 <20170125161417.31949-2-berrange@redhat.com>
In-Reply-To: <20170125161417.31949-2-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/25/2017 10:14 AM, Daniel P. Berrange wrote:

> If there are generated headers files to be used by the migration
> code in '$BUILD_DIR/migration', these will not be found by the
> relative include, an absolute include is needed instead. This
> has not been a problem so far, since nothing has been generating
> headers in sub-dirs, but the trace code will shortly be doing
> that. So it is needed to list '-I$(BUILD_DIR)/$(@D)' as well as
> '-I$(@D)' to ensure both directories are searched when building
> target dependant code. So the search order ends up being:
>=20
>   1. source dir corresponding to input file (implicit by compiler)
>   2. build dir corresponding to output file (absolute)
>   3. build dir corresponding to output file (relative to cwd)
>   4. top level build dir
>   5. top level source dir
>   6. top level source include/ dir

Lots clearer than v3.

>=20
> One final complication is that the absolute '-I$(BUILD_DIR)/$(@D)'
> will sometimes end up pointing to a non-existant directory if
> that sub-dir does not have any target-independant files to be
> built. Rather than try to dynamically filter this, a simple
> 'mkdir' ensures $(BUILD_DIR)/$(@D) is guaranteed to exist at
> all times.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  rules.mak | 30 +++++++++++++++++++++++-------
>  1 file changed, 23 insertions(+), 7 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--EFcwV9ogdomaQRsoQlbqBC5kgUqagTe2U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYiNGPAAoJEKeha0olJ0NqkxAH/RpzU9pP7YmTlq4yGUdpvV0C
Mp52LCMBiQY8lFUtzZPJ3Dk7i6fsm6hLzmZyZVwfxujydHMWTsvhPrFaaOmbWaeC
/HTR5fXgdcdOsI/KmgePXcoL27Wv5LfKB471NH0qVLlzvcA9O6TN3BP4ru1hboDL
4/WF6Ko6Bb0L4w3VJ6nfneYnaSapjJKygjLr7LsOA7Yy2Sg7pYaItV3+7yJzP7qs
kgZwgokTN3CCBnAOuBEUXtkCZIJ5Dr3hECyRlMRRDh3YQ8eOxqs0oplNuiM1QdtX
M/GVue3bIjlu4oIfR2uCM/uHz5QlA2qsvSs76CpK723Q8F+BPVYQqe6Vs57r4nE=
=1IHR
-----END PGP SIGNATURE-----

--EFcwV9ogdomaQRsoQlbqBC5kgUqagTe2U--
