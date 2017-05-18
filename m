Received: from eggs.gnu.org ([2001:4830:134:3::10]:36766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dBMlc-0005rr-IX
	for qemu-devel@nongnu.org; Thu, 18 May 2017 10:51:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dBMlZ-0003S1-CG
	for qemu-devel@nongnu.org; Thu, 18 May 2017 10:51:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44334)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dBMlY-0003Rj-UZ
	for qemu-devel@nongnu.org; Thu, 18 May 2017 10:51:01 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D53C1C056784
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 14:50:59 +0000 (UTC)
References: <20170518111837.29212-1-quintela@redhat.com>
	<20170518111837.29212-6-quintela@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d2abdbdb-662a-f372-a1ed-52cfb584e739@redhat.com>
Date: Thu, 18 May 2017 09:50:56 -0500
MIME-Version: 1.0
In-Reply-To: <20170518111837.29212-6-quintela@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XhDinqAW5MoAsogUNg3fxW4greP3LO30c"
Subject: Re: [Qemu-devel] [PATCH 5/5] block migration: Allow compile time
 disable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, armbru@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XhDinqAW5MoAsogUNg3fxW4greP3LO30c
From: Eric Blake <eblake@redhat.com>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com,
 armbru@redhat.com
Message-ID: <d2abdbdb-662a-f372-a1ed-52cfb584e739@redhat.com>
Subject: Re: [PATCH 5/5] block migration: Allow compile time disable
References: <20170518111837.29212-1-quintela@redhat.com>
 <20170518111837.29212-6-quintela@redhat.com>
In-Reply-To: <20170518111837.29212-6-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/18/2017 06:18 AM, Juan Quintela wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> Many users now prefer to use drive_mirror over NBD as an
> alternative to the older migrate -b option; drive_mirror is
> more complex to setup but gives you more options (e.g. only
> migrating some of the disks if some of them are shared).
>=20
> Allow the large chunk of block migration code to be compiled
> out for those who don't use it.
>=20
> Based on a downstream-patch we've had for a while by Jeff Cody.
>=20
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>=20
> --
>=20

With your S-o-b added,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--XhDinqAW5MoAsogUNg3fxW4greP3LO30c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZHbTQAAoJEKeha0olJ0Nqi4sH/1FfCpQM8OwNobMtP+kEwdjS
OaMJubrNTRaQdtrABS6fp62ohug0vbPeMN/ttzLdkLL7Q2YkYAabxqr8iDhuKswp
8FJTtrbWkH7lIFFMLCJXFpxpkh8kmJweFJFI5piLvWYO+ql02F9aL6qR+BEYYZgX
yHeZxjxtMymQFjuCESxYap3UpLQ3SF6WPLVXwopKNc59nq+nBLma2Apll+Wr8+lt
trDy553xN46Syv1+vRpkr3wnW7dpY3AaMe5BLIYh35LB9p09FgrQI6Znue6biI/Y
w43NMVtRHyLPZeGkIXlPK7dbfyxFCvkNL6bpcGSSypEAN+HP8ZLLFPTFDHkcDC8=
=k/k2
-----END PGP SIGNATURE-----

--XhDinqAW5MoAsogUNg3fxW4greP3LO30c--
