Received: from eggs.gnu.org ([2001:4830:134:3::10]:47913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgC6P-0002nn-EZ
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 10:11:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgC6L-0004D6-H5
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 10:11:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58976)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cgC6L-0004Cn-BD
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 10:11:37 -0500
References: <9533ba99-b143-b577-0115-742119d089a4@kamp.de>
From: Eric Blake <eblake@redhat.com>
Message-ID: <441ede06-2908-93eb-1428-529d5e6a31ea@redhat.com>
Date: Tue, 21 Feb 2017 09:11:35 -0600
MIME-Version: 1.0
In-Reply-To: <9533ba99-b143-b577-0115-742119d089a4@kamp.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="WwBhqV3baxrpl5C2A8O9kClk4u7FkaoLX"
Subject: Re: [Qemu-devel] Qemu and Changed Block Tracking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WwBhqV3baxrpl5C2A8O9kClk4u7FkaoLX
From: Eric Blake <eblake@redhat.com>
To: Peter Lieven <pl@kamp.de>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Message-ID: <441ede06-2908-93eb-1428-529d5e6a31ea@redhat.com>
Subject: Re: [Qemu-devel] Qemu and Changed Block Tracking
References: <9533ba99-b143-b577-0115-742119d089a4@kamp.de>
In-Reply-To: <9533ba99-b143-b577-0115-742119d089a4@kamp.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/21/2017 06:43 AM, Peter Lieven wrote:
> Hi,
>=20
>=20
> is there anyone ever thought about implementing something like VMware
> CBT in Qemu?
>=20
>=20
> https://kb.vmware.com/selfservice/microsites/search.do?language=3Den_US=
&cmd=3DdisplayKC&externalId=3D1020128

Yes; in fact, the work on persistent dirty bitmaps and on NBD
BLOCK_STATUS reporting is what we envision as the building blocks for an
upper layer software to be able to grab CBT information on which blocks
are dirty.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--WwBhqV3baxrpl5C2A8O9kClk4u7FkaoLX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYrFinAAoJEKeha0olJ0NqNgwH/2HN0RJ+lyar5EKh42Pnxn1e
fuwFao+srPdkviZtVSs3yRx5xE4gzDYHxvRjVX6u7T7qhByftgyF5BQ0cC/ot2wa
AScGjNOKSqyreG1qfpkhaWjw5heaKYgL3sT8YMTLvLRCGw+Tq9PJfavX6sCHdWJs
F1XUHOQgFVhUOsV0fdHU01gmSi18eUZcUEEt6yoS/++e2AcuwpGnR9BlX3FVoire
K7yfHJVFsOaTWNpE3tBRa2z1LhKInb/DQDpHLuVPa3jL41j/o3sPMTO9e9VkUQmG
LE/KK/ET1ml2IbA3pbroTPxC2B0sGYV/MKz25gi30lLAYrZXEw3lN7X8MwXFl5U=
=Evxn
-----END PGP SIGNATURE-----

--WwBhqV3baxrpl5C2A8O9kClk4u7FkaoLX--
