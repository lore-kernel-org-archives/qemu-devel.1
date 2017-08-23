Received: from eggs.gnu.org ([2001:4830:134:3::10]:45294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dkWvb-0004UW-O1
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 10:46:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dkWva-0006lD-Q7
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 10:46:43 -0400
References: <20170823134242.12080-1-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <64d71d45-39e0-9005-7e91-355e3c7881c8@redhat.com>
Date: Wed, 23 Aug 2017 09:46:24 -0500
MIME-Version: 1.0
In-Reply-To: <20170823134242.12080-1-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BJ7Tsf8rK7vAclftFTS18vFAFb7egEtnj"
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
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, stefanha@redhat.com, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BJ7Tsf8rK7vAclftFTS18vFAFb7egEtnj
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 stefanha@redhat.com, Max Reitz <mreitz@redhat.com>
Message-ID: <64d71d45-39e0-9005-7e91-355e3c7881c8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 0/4] block: Fix non-shared storage
 migration
References: <20170823134242.12080-1-famz@redhat.com>
In-Reply-To: <20170823134242.12080-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/23/2017 08:42 AM, Fam Zheng wrote:
> This fixes the issue reported as https://bugs.launchpad.net/bugs/171160=
2
>=20
> Fam Zheng (3):
>   block-backend: Refactor inactivate check
>   block-backend: Allow more "can inactivate" cases
>   mirror: Mark target BB as "force allow inactivate"
>=20
> Stefan Hajnoczi (1):
>   block: Update open_flags after ->inactivate() callback

Placing on my queue for a 2.10-rc4 pull request

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--BJ7Tsf8rK7vAclftFTS18vFAFb7egEtnj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmdlUAACgkQp6FrSiUn
Q2pB8wf+J6WSnMmbz32BgcaNI4RDDXRw6AEU2dDBK9Y83o/PzRwXE5nkKd6FJKtE
msQGG0w3Yck0UV+6WMwt9arQ8eFlN7oP7dsJ0QgQc5AvsvDt+Xvfsd4Rm3BRTbrg
Mjg6ZT7qub8PRx7b4GuknDGC0bm56jMU3FXOx/eZLJrk2qttDHYDv4nfdmzXiDM3
DLBGZcMQv2PAQ3msUh8ZnvKx3kpoaOG62Xfq1T4qLuUmxG+32REBSYSFc5QCfo8p
vXV9uAh4/kl66jz/9lkx4EyUvxces/w7AvVBuhaYYM+VZImHk678wPFARnsSi7HG
Wnb5h4AArvickksxra7gWljWTGudQg==
=PvXP
-----END PGP SIGNATURE-----

--BJ7Tsf8rK7vAclftFTS18vFAFb7egEtnj--
