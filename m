Received: from eggs.gnu.org ([2001:4830:134:3::10]:40511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dGmkI-00041K-K9
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 09:36:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dGmkH-0004mb-Lq
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 09:36:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33828)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dGmkH-0004lX-Db
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 09:36:05 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7549061E48
	for <qemu-devel@nongnu.org>; Fri,  2 Jun 2017 13:36:04 +0000 (UTC)
References: <20170601214056.30387-1-quintela@redhat.com>
	<20170601214056.30387-5-quintela@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a8269150-c182-24d6-089d-9bafdd3dd5ac@redhat.com>
Date: Fri, 2 Jun 2017 08:36:01 -0500
MIME-Version: 1.0
In-Reply-To: <20170601214056.30387-5-quintela@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NRCM42Sf8h6V7KsWgvLvRSulcHjA1UDQ1"
Subject: Re: [Qemu-devel] [PATCH 4/4] ram: Now POSTCOPY_ACTIVE is the same
 that STATUS_ACTIVE
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
--NRCM42Sf8h6V7KsWgvLvRSulcHjA1UDQ1
From: Eric Blake <eblake@redhat.com>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com
Message-ID: <a8269150-c182-24d6-089d-9bafdd3dd5ac@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/4] ram: Now POSTCOPY_ACTIVE is the same
 that STATUS_ACTIVE
References: <20170601214056.30387-1-quintela@redhat.com>
 <20170601214056.30387-5-quintela@redhat.com>
In-Reply-To: <20170601214056.30387-5-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/01/2017 04:40 PM, Juan Quintela wrote:
> Merge them.
>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/migration.c | 12 ------------
>  1 file changed, 12 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--NRCM42Sf8h6V7KsWgvLvRSulcHjA1UDQ1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZMWnBAAoJEKeha0olJ0NqjhgH/1sMtwYGeLX+UzShLy5Apv/f
mekS3r4FfWasCu9sFEx060TliC3rUvfzIOoDy/B5jt/4L6pNFKyYPBn7IDn4Mgkr
Ay4AmyD5hHsC3NG64j2iMCOLxSCy48fJ37REoTT6Le6Hp9lul8IDjsFlBsxjHZ0l
8NOIIiCRk7FYaRfEQMM4XYB5hHipUzKH3HtU7F0CWn9rgVpSZjiy3AMncLCVDVCJ
qF5fBA0oMitk6gStIz2lneT8Xq6HAB50oBTOHFpGaU4mOPhZfWlvtRQkcosSLui0
71+fnBVMbh2wURbrJh/n84kKcB22JA86eQ7DhccEVqqIWUijng/WyohyV1Mq72A=
=P82N
-----END PGP SIGNATURE-----

--NRCM42Sf8h6V7KsWgvLvRSulcHjA1UDQ1--
