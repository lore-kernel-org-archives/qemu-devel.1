Received: from eggs.gnu.org ([2001:4830:134:3::10]:50168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d9Gbv-0004Y9-34
	for qemu-devel@nongnu.org; Fri, 12 May 2017 15:52:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d9Gbr-00086w-Pv
	for qemu-devel@nongnu.org; Fri, 12 May 2017 15:52:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41214)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d9Gbr-00083u-GX
	for qemu-devel@nongnu.org; Fri, 12 May 2017 15:52:19 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 12B067E9C4
	for <qemu-devel@nongnu.org>; Fri, 12 May 2017 19:52:18 +0000 (UTC)
References: <20170511163228.6666-1-quintela@redhat.com>
	<20170511163228.6666-2-quintela@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0bbb5f93-83bb-47b9-e7dd-d0824f3d8b61@redhat.com>
Date: Fri, 12 May 2017 14:52:14 -0500
MIME-Version: 1.0
In-Reply-To: <20170511163228.6666-2-quintela@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TVhbmuvFLmA7DsDUgFtxL3TuCWuPvS9w2"
Subject: Re: [Qemu-devel] [PATCH 1/3] migration: Create block capabilities
 for shared and enable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TVhbmuvFLmA7DsDUgFtxL3TuCWuPvS9w2
From: Eric Blake <eblake@redhat.com>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com
Message-ID: <0bbb5f93-83bb-47b9-e7dd-d0824f3d8b61@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] migration: Create block capabilities for
 shared and enable
References: <20170511163228.6666-1-quintela@redhat.com>
 <20170511163228.6666-2-quintela@redhat.com>
In-Reply-To: <20170511163228.6666-2-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/11/2017 11:32 AM, Juan Quintela wrote:
> Those two capabilities were added through the command line.  Notice tha=
t
> we just created them.  This is just the boilerplate.
>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
> --
>=20
> Make migrate_set_block_* take a boolean argument.

Question - do we support the orthogonal selection of all 4 combinations
under HMP 'migrate' (no argument, -b alone, -i alone, -b and -i
together), or are there only 3 actual states? If the latter, should we
represent this as a single enum-valued property, rather than as two
independent boolean properties?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--TVhbmuvFLmA7DsDUgFtxL3TuCWuPvS9w2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZFhJuAAoJEKeha0olJ0NqzgsH/RxCtMbQfYpOZz+V22AWY5WS
srJD3RNiEzNHSKjW6F0+eHlm6zwlM7IMpQ7lh8AoB0n5McfbAZKsozdVjJDATTEF
x62qIPvxWqBeedi3g5b3fETXdtx1a7i+5AX9Gp3k4WkNlx9WAJNKDSlTDZG30FI1
inigWRpDxvdqqZYVllemX8Od4DvqgcATg888NHZzq0gE1YoIqFGI6Q0HXbPT+c7P
p7Oc4fRw6Lwb3dwBBC7iMbH3RB5xvWGKPlK2a39auGMPqCp5bdR+eQwZHKItIq9d
7Qpq8D0UilpkjF7VHiFP6umyLosoGcJr1blitSvCJNiLCA59mOm9NhrsyD0+gbs=
=1xF4
-----END PGP SIGNATURE-----

--TVhbmuvFLmA7DsDUgFtxL3TuCWuPvS9w2--
