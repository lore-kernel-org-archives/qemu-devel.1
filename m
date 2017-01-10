Received: from eggs.gnu.org ([2001:4830:134:3::10]:55486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cQxc9-0007nB-JG
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 09:41:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cQxc6-0005iB-7M
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 09:41:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34176)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cQxc6-0005i1-0y
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 09:41:26 -0500
References: <148405872846.9522.17126828396099315346.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<148405873540.9522.2224634666374633695.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<b227e7dc-ba0b-7da7-8fdb-dece1cbe51d4@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1436b9db-dea9-cfa4-65f8-bd1455394e6f@redhat.com>
Date: Tue, 10 Jan 2017 08:41:23 -0600
MIME-Version: 1.0
In-Reply-To: <b227e7dc-ba0b-7da7-8fdb-dece1cbe51d4@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DlkgaeasKogtJIF41Rq8lo2CL800itUoS"
Subject: Re: [Qemu-devel] [PATCH 1/7] 9pfs: restrict open to regular files
 and directories
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DlkgaeasKogtJIF41Rq8lo2CL800itUoS
From: Eric Blake <eblake@redhat.com>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Message-ID: <1436b9db-dea9-cfa4-65f8-bd1455394e6f@redhat.com>
Subject: Re: [PATCH 1/7] 9pfs: restrict open to regular files and directories
References: <148405872846.9522.17126828396099315346.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
 <148405873540.9522.2224634666374633695.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
 <b227e7dc-ba0b-7da7-8fdb-dece1cbe51d4@redhat.com>
In-Reply-To: <b227e7dc-ba0b-7da7-8fdb-dece1cbe51d4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/10/2017 08:38 AM, Eric Blake wrote:
> I think you need to rework this patch to open() first, then validate
> (closing the fd if necessary); the open can be done with O_NONBLOCK to
> avoid hanging on a pipe.

And O_NOCTTY to avoid becoming the controlling process of a terminal.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--DlkgaeasKogtJIF41Rq8lo2CL800itUoS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYdPKTAAoJEKeha0olJ0Nqf6EH+wV6l0QXE4nPapIGGD4B7m8n
QoSXau1hbEZge/538MUEYuU1r2xnoUnmnwdEUH86UG/8siWJAE2r1vPmDIn0XRbw
0jV72+5cR3t8mb+p3KcbUKWDDRE9NwnNa33qN8/teBUkdYrrE+l6k21BTXVD3+/P
awt1qRkxTaC4MfNxDJvL0BcI3u9RBpNuK3GWZ18UCe4C5jTFxQWI4245PwInEksu
hq2tfyVuqJWdhLZ9bZOjwc/KFkaW4dbOtZZTHQKWL5WTE6Qhw1uEnGJr/LRJ2yQh
bP7Yox4t8bgO0MiylRDq+3tQPeWZVXNy8BCLFYq/bksNGKK1OAN0tWig2rVZ+hw=
=qIGK
-----END PGP SIGNATURE-----

--DlkgaeasKogtJIF41Rq8lo2CL800itUoS--
