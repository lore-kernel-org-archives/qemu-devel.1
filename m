Received: from eggs.gnu.org ([2001:4830:134:3::10]:40281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cv7xW-0000D3-Sd
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 15:48:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cv7xV-0004tf-TY
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 15:48:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54100)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cv7xV-0004t3-KL
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 15:48:13 -0400
References: <C885D0FF6A27744DB0B822E32DF6EF029B1CA14A@SESTOEX04.enea.se>
	<9b05e60a-f8c2-ea4f-6be4-f17c0adec510@redhat.com>
	<20170403081542.GA5036@noname.str.redhat.com>
	<33ced3d3-acd7-2945-518d-465a4621b151@redhat.com>
	<20170403130041.GD5036@noname.str.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3e72904f-c9f9-0ec0-5a32-49be400b7ac3@redhat.com>
Date: Mon, 3 Apr 2017 14:48:10 -0500
MIME-Version: 1.0
In-Reply-To: <20170403130041.GD5036@noname.str.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DDLxTc1wMM1ewo2f0OjJm9kdaCD7xmvof"
Subject: Re: [Qemu-devel] nbd: Possible regression in 2.9 RCs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: Ciprian Barbu <Ciprian.Barbu@enea.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, pkrempa@redhat.com, Alexandru Avadanii <Alexandru.Avadanii@enea.com>, Jeff Cody <jcody@redhat.com>, Markus Armbruster <armbru@redhat.com>, svc-armband <armband@enea.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DDLxTc1wMM1ewo2f0OjJm9kdaCD7xmvof
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: Ciprian Barbu <Ciprian.Barbu@enea.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, pkrempa@redhat.com,
 Alexandru Avadanii <Alexandru.Avadanii@enea.com>,
 Jeff Cody <jcody@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 svc-armband <armband@enea.com>
Message-ID: <3e72904f-c9f9-0ec0-5a32-49be400b7ac3@redhat.com>
Subject: Re: [Qemu-devel] nbd: Possible regression in 2.9 RCs
References: <C885D0FF6A27744DB0B822E32DF6EF029B1CA14A@SESTOEX04.enea.se>
 <9b05e60a-f8c2-ea4f-6be4-f17c0adec510@redhat.com>
 <20170403081542.GA5036@noname.str.redhat.com>
 <33ced3d3-acd7-2945-518d-465a4621b151@redhat.com>
 <20170403130041.GD5036@noname.str.redhat.com>
In-Reply-To: <20170403130041.GD5036@noname.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/03/2017 08:00 AM, Kevin Wolf wrote:
>> The question remains whether it is practical not to make an exception.=

>> As far as I know, libvirt is only guaranteed to support older qemu
>> versions, not necessarily future ones. So we should be allowed to brea=
k
>> existing use cases here until libvirt is updated (assuming it is
>> possible for libvirt to express "guest device allows shared writes" as=

>> an option for its next release).
>=20
> If I understand correctly, this is a case of incoming live migration,
> i.e. the virtio-blk device which is blocking the writes to the image
> doesn't really belong to a running guest yet.
>=20
> So if we need to make an exception (and actually reading the context
> makes it appear so), I guess it would have to be that devices actually
> can share the write permission during incoming migration, but not any
> more later (unless the share-rw flag is set).

That sounds like the right approach - if nbd-server-add can detect that
it is being invoked during the window between 'qemu -S' and before
'migrate', and allow the shared-rw at that time, then revoke it at the
time the migrate command hits.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--DDLxTc1wMM1ewo2f0OjJm9kdaCD7xmvof
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY4qb6AAoJEKeha0olJ0NqKI4H/jK5M60FjzlL7059F2P912TD
KT8EsLbhCofAohA3N9evJe0ccOzngifCFse8ILDrEIFCpfPEo9IW7B1o5MnBXqVV
oOvHLhl0lMSN+M/x2trmZ2AMfiXY9HBpoNJGOusKsnXaDP5B2E+hyyua1dMVViok
NSIANTDLpIG7meODlb4iV/9YzBAAV/CF5EJHDaIRnBJA3bJgox8qTm5BGm0oonyW
lPxN0rEe4xoveYu4Dswlz01JTnnjcCwLvj328OmVBQWILB2pGz7HTNWEQ4q2/pFM
zZUAUkRPsr03+mM0wgRBiDaMcHSiHEb4FlTAKIkFBKduSITU/r+TnOibepnhjcM=
=aQNg
-----END PGP SIGNATURE-----

--DDLxTc1wMM1ewo2f0OjJm9kdaCD7xmvof--
