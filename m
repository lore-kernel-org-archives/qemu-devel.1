Received: from eggs.gnu.org ([2001:4830:134:3::10]:35586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ePw1G-0002Qr-0y
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 14:51:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ePw1F-00012b-8y
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 14:51:42 -0500
References: <20171215080446.10671-1-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cf7ac628-39a5-13bd-e234-f9964ea89f05@redhat.com>
Date: Fri, 15 Dec 2017 13:51:29 -0600
MIME-Version: 1.0
In-Reply-To: <20171215080446.10671-1-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BHLM5qXXEObXo8lmceGLuGR4UNpUPtf5x"
Subject: Re: [Qemu-devel] [PATCH 0/2] block: Fix qemu-img creating overlay
 when guest running
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BHLM5qXXEObXo8lmceGLuGR4UNpUPtf5x
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <cf7ac628-39a5-13bd-e234-f9964ea89f05@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] block: Fix qemu-img creating overlay
 when guest running
References: <20171215080446.10671-1-famz@redhat.com>
In-Reply-To: <20171215080446.10671-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/15/2017 02:04 AM, Fam Zheng wrote:
> Shared write lock is not strictly necessary for creating the overlay im=
age, if
> all what we want is to probe the size.

Theoretically, the size could be changing due to a resize operation.
But realistically, even if that happens, we will (hopefully) see either
the old size or the new size atomically (that is, I seriously doubt the
size information is split across multiple sectors of the in-use image to
the point that we could shard the read).

Series:
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--BHLM5qXXEObXo8lmceGLuGR4UNpUPtf5x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlo0J8EACgkQp6FrSiUn
Q2oENwf/UCatBQx0/VMl9CwDi5lo1v/ysSQj8raLj8mNUZQjudv2M9u/aidUG+sa
JUTgdmUp50heurPAw4fmnRvMLhPxGezmxbYTSWcDsj/NMR6Uc84qEJBBd4M2LOI0
y/5OyRXjGxrMLrDy5jEvAWfFrq7sUCT2EZh8AXUq89s5C64PbO4O7QLJ4oLIkak4
d9blebi0HMPKMFk4b6+XaM1hnOSQ2we2WCX7rCmknt+rglg3lfwN2xRaFUpUIyDx
+AaLfmqM0bOjqCBS+VHtGpwB+SBY5s7+C7JBB/GUSsBDTgYVtAXt1zaztP4V5xES
gFwP4c8YHl913DKyGbRC5+tUBrqXHg==
=KMaw
-----END PGP SIGNATURE-----

--BHLM5qXXEObXo8lmceGLuGR4UNpUPtf5x--
