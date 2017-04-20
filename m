Received: from eggs.gnu.org ([2001:4830:134:3::10]:35550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d1DIO-0003Pd-12
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 10:43:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d1DIJ-0004hF-Tf
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 10:42:56 -0400
References: <20170420120058.28404-1-pbonzini@redhat.com>
	<20170420120058.28404-17-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1e66d128-b5db-c121-9297-0bbaa66080bc@redhat.com>
Date: Thu, 20 Apr 2017 09:42:43 -0500
MIME-Version: 1.0
In-Reply-To: <20170420120058.28404-17-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="e91VfehwNdpFTbqNA184rRfcIid4QPVdb"
Subject: Re: [Qemu-devel] [PATCH 16/17] block: protect modification of dirty
 bitmaps with a mutex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--e91VfehwNdpFTbqNA184rRfcIid4QPVdb
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org
Message-ID: <1e66d128-b5db-c121-9297-0bbaa66080bc@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 16/17] block: protect modification of dirty
 bitmaps with a mutex
References: <20170420120058.28404-1-pbonzini@redhat.com>
 <20170420120058.28404-17-pbonzini@redhat.com>
In-Reply-To: <20170420120058.28404-17-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/20/2017 07:00 AM, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block/dirty-bitmap.c         | 74 ++++++++++++++++++++++++++++++++++++=
+++++---
>  block/mirror.c               | 11 +++++--
>  include/block/block_int.h    |  4 +--
>  include/block/dirty-bitmap.h | 23 +++++++++++---
>  4 files changed, 97 insertions(+), 15 deletions(-)

Fun conflicts with my pending patches to switch dirty-bitmap to be
byte-based instead of sector-based. I doubt the computer will be able to
resolve nicely, but I think rebasing by hand should be pretty doable, no
matter which of our patches lands first.

https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg02163.html

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--e91VfehwNdpFTbqNA184rRfcIid4QPVdb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY+MjjAAoJEKeha0olJ0Nq3VoH/RYasC8VRGsZoSVJrqgiQ4ga
h8WlCz5rR0Zb97tVrmgVzU8nllTkdsSYLkFD+7ibXds1siQm3rUMPVbXp0vMuPbR
sXyYcA7UuGveKHWz3JLpiEu6DggMfH7D2RV/4I3fitJ5slbXO8SG27gPKBcoEuYO
6sC4w6Hz53fe9F0NY8kH2gLudRE/WlNU5FKUd/7mZBVYW97SbrycuI6PZMpOdg15
2wB+F0v4zkmGqnB45SAIgvrTyC/PPmUd7HWNy7tvz/n7QWRGywz7n15+aYsy2djT
Nub8STWU6RCeZTo65WMayVSN/v4u43ZCPa8jf8vq6CTOiz1g6M7qXOYtmeHTDvM=
=s6O/
-----END PGP SIGNATURE-----

--e91VfehwNdpFTbqNA184rRfcIid4QPVdb--
