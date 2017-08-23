Received: from eggs.gnu.org ([2001:4830:134:3::10]:44069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dkWqf-0001wh-Ja
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 10:41:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dkWqe-0004Ke-Pr
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 10:41:37 -0400
References: <20170823134242.12080-1-famz@redhat.com>
	<20170823142917.GC2100@work-vm>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cf66082b-a08b-2c0a-4150-9ae7bc807300@redhat.com>
Date: Wed, 23 Aug 2017 09:41:25 -0500
MIME-Version: 1.0
In-Reply-To: <20170823142917.GC2100@work-vm>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1AmU9SHPixiT9mT9kq7I0fCc6fOWT1jLv"
Subject: Re: [Qemu-devel] [PATCH for-2.10 0/4] block: Fix non-shared storage
 migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, stefanha@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1AmU9SHPixiT9mT9kq7I0fCc6fOWT1jLv
From: Eric Blake <eblake@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Fam Zheng <famz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, stefanha@redhat.com,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <cf66082b-a08b-2c0a-4150-9ae7bc807300@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 0/4] block: Fix non-shared storage
 migration
References: <20170823134242.12080-1-famz@redhat.com>
 <20170823142917.GC2100@work-vm>
In-Reply-To: <20170823142917.GC2100@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/23/2017 09:29 AM, Dr. David Alan Gilbert wrote:
> * Fam Zheng (famz@redhat.com) wrote:
>> This fixes the issue reported as https://bugs.launchpad.net/bugs/17116=
02
>=20
> Yep, that fixes it in my test setup (1 of 1 passes!)

As mentioned on IRC, I'll treat this as a Tested-by: tag on 4/4 in my
pull request.  Thanks for helping check things.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--1AmU9SHPixiT9mT9kq7I0fCc6fOWT1jLv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmdlBUACgkQp6FrSiUn
Q2qEOwf+Iu4DKwgnS5NKZybwGPu2J92Q3C1+ql/HtaiIiEW8MmdAIgOxD/yOdXf/
evTSx/BdawSlcm90lvEmT7V5fK+nUYANaIKX+j0s3aDdafmjkRPAylxB7dz+NJXG
I5/Dpkm0qEocUAt5MRvKSdxGJnchr4rgA/PmqyyGxJ3cKoa/rhFcvv+w8fwkZxxK
7JIlOb5rtlfI1j+q16+OhRDCCB0FaSQ4KMeKSLJea+xYyMDSlK09V4Bs02AJZs5f
ZOiNc79NXQfK/ZLtEhM855DtQr0MeAMOrgiLQj0FAsIUglc46PoI8JZQTjd+wDIr
zMDfXcKtQ72lniniCz7vcegEWyJfEQ==
=AMR5
-----END PGP SIGNATURE-----

--1AmU9SHPixiT9mT9kq7I0fCc6fOWT1jLv--
