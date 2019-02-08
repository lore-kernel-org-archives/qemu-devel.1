Received: from eggs.gnu.org ([209.51.188.92]:50639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gs81z-0005g3-JH
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 10:25:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gs81x-0001ZU-IN
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 10:25:31 -0500
References: <1549638368-530182-1-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3f708207-2172-3c09-e32b-8267e1be9fc1@redhat.com>
Date: Fri, 8 Feb 2019 09:25:15 -0600
MIME-Version: 1.0
In-Reply-To: <1549638368-530182-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="aprQAlyHPvM4JXpzU8n575vsc42XbqdjR"
Subject: Re: [Qemu-devel] [PATCH v14 0/3] qcow2: Add list of bitmaps to
 ImageInfoSpecificQCow2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: fam@euphon.net, kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, berrange@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aprQAlyHPvM4JXpzU8n575vsc42XbqdjR
From: Eric Blake <eblake@redhat.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: fam@euphon.net, kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com,
 berrange@redhat.com, den@openvz.org, vsementsov@virtuozzo.com
Message-ID: <3f708207-2172-3c09-e32b-8267e1be9fc1@redhat.com>
Subject: Re: [PATCH v14 0/3] qcow2: Add list of bitmaps to
 ImageInfoSpecificQCow2
References: <1549638368-530182-1-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1549638368-530182-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/8/19 9:06 AM, Andrey Shinkevich wrote:
> v14:
> The test 242 was amended to be safer against changes in the bitmap allo=
cation
> algorithm because the bitmap directory is reallocated on VM shutdown.
> Unfortunately, an empty line at the end of the benchmark file 242.out p=
ersists.

Easy solution: in 242, add an extra log("Test complete") or similar
after the output that produces the blank line, then 242.out will no
longer have a trailing blank line.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--aprQAlyHPvM4JXpzU8n575vsc42XbqdjR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxdn1sACgkQp6FrSiUn
Q2oQZQf8DgMluiwBlzLR/6axP5N4CO6f6lQ8/syuMVaTr2cMVchpVivTPR0EjjOz
Fmd4784NCCc+Q8ZTujaelSBR1334/VILKOJ/Ccj6yu2isEilfpgkIqndm1TpgGCb
yGLbBxK3zpuUWEtTRur3/reZK5bt3q92PpMZzUbvJTlnEPbK94b2XEbqY5SCyvne
4IxsCeVNYHIC3bA6EKoIOjZ62tcJYn2zpSds/rD1b6Ti9FBaVp1NQObGaWvn1IpJ
pFLm43ECHq8IU62wqxHgBSr7p1yWLshz+h65TvW2vl9PQDcwMIfwTjLRchN/ifg0
gOcOUHObADIp3jeZs5vidWkgdfOqtw==
=fiwV
-----END PGP SIGNATURE-----

--aprQAlyHPvM4JXpzU8n575vsc42XbqdjR--
