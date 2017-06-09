Received: from eggs.gnu.org ([2001:4830:134:3::10]:57654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dJHvd-0000t5-Ck
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 07:18:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dJHvc-0005Wc-Cn
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 07:18:09 -0400
References: <20170608222617.20376-1-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <094b3fd7-245f-076c-6d05-672f0efef645@redhat.com>
Date: Fri, 9 Jun 2017 06:17:59 -0500
MIME-Version: 1.0
In-Reply-To: <20170608222617.20376-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ObA2EaQAlLVqN3h9NTJ9Pg61S8SPvfX44"
Subject: Re: [Qemu-devel] [PATCH] nbd: Fix regression on resiliency to port
 scan
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, pbonzini@redhat.com, "open list:Block layer core" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ObA2EaQAlLVqN3h9NTJ9Pg61S8SPvfX44
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, pbonzini@redhat.com,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Message-ID: <094b3fd7-245f-076c-6d05-672f0efef645@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] nbd: Fix regression on resiliency to port
 scan
References: <20170608222617.20376-1-eblake@redhat.com>
In-Reply-To: <20170608222617.20376-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/08/2017 05:26 PM, Eric Blake wrote:
> Back in qemu 2.5, qemu-nbd was immune to port probes (a transient
> server would not quit, regardless of how many probe connections
> came and went, until a connection actually negotiated).  But we
> broke that in commit ee7d7aa

> Simple test across two terminals:
> $ qemu-nbd -f raw -p 30001 file
> $ nmap 127.0.0.1 -p 30001 && \
>   qemu-io -c 'r 0 512' -f raw nbd://localhost:30001

This is now being assigned a CVE.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--ObA2EaQAlLVqN3h9NTJ9Pg61S8SPvfX44
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZOoPnAAoJEKeha0olJ0NqFVkH/RcCKu3ZBlgICDXYpexdISiI
Nf5T+q9tjkvcyJMRQfiK7UE9qgZ+rC+qYxfR+Bd6YhI5MqCbLO4MIWowZ3azUhVx
HNALehasNPPM9Y0ASAJJDWZVz/NmOjl4QDIUN2epDuFTmYSYxIxVncRvsMzpkYiV
3eP4KZN55vlsgLzmpe5P3RyQYCu3C1XhvtsVoo1gK+zrAwyHaT/4a7zP7DqmIQ8e
stofQdGFdlKkpAv5X/IS2Gp+N31YWEZ7b1971JeVU2Al4b3HATaREPcMEbpqHaJf
YBrnxYIq6z3DSFzmfxy0Kr3OG6p8P9B6n4IE7YewHxyiJtRUzoqri6VLcYZ2wkQ=
=q7ax
-----END PGP SIGNATURE-----

--ObA2EaQAlLVqN3h9NTJ9Pg61S8SPvfX44--
