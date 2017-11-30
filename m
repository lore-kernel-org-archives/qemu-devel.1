Received: from eggs.gnu.org ([2001:4830:134:3::10]:50664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eKPir-0001NF-86
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 09:21:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eKPiq-0000IZ-9a
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 09:21:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57308)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1eKPiq-0000Hb-2p
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 09:21:52 -0500
References: <3c1d9325-56a9-225d-4ff8-230f8ed52fed@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <76f5ec24-112f-455a-4ad4-5c97d7182f36@redhat.com>
Date: Thu, 30 Nov 2017 15:21:47 +0100
MIME-Version: 1.0
In-Reply-To: <3c1d9325-56a9-225d-4ff8-230f8ed52fed@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QDtfAc2h404MN5TnKwfAG8Wn0vU8C7Gfm"
Subject: Re: [Qemu-devel] export root node for write through NBD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Denis V. Lunev" <den@openvz.org>, Nikolay Shirokovskiy <nshirokovskiy@virtuozzo.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QDtfAc2h404MN5TnKwfAG8Wn0vU8C7Gfm
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Nikolay Shirokovskiy <nshirokovskiy@virtuozzo.com>
Message-ID: <76f5ec24-112f-455a-4ad4-5c97d7182f36@redhat.com>
Subject: Re: export root node for write through NBD
References: <3c1d9325-56a9-225d-4ff8-230f8ed52fed@virtuozzo.com>
In-Reply-To: <3c1d9325-56a9-225d-4ff8-230f8ed52fed@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-30 08:47, Vladimir Sementsov-Ogievskiy wrote:
> Hi all.
>=20
> We need the following option: start vm in stopped mode (-S) and write
> it's disk before start through NBD.
> It should be absolutely safe, but unfortunately it is disallowed by roo=
t
> role of the disk.
> Is there any workaround or if not, what is a true way to implement this=

> possibility?
>=20
> ----
> error message:
> =C2=A0=C2=A0=C2=A0 unable to execute QEMU command 'nbd-server-add': Con=
flicts with use
> by drive0 as 'root', which does not allow 'write' on #block100
>=20
> --=20

One thing that comes to mind is adding the guest device only after you
are done with NBD.

The other of course is to set share-rw=3Don for the device.

Max


--QDtfAc2h404MN5TnKwfAG8Wn0vU8C7Gfm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlogE/sSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A+ucH/0JsWtV10o6TO+GqlblrgKT2S1/mleN3
NFST90nC+yxMSyi4/Rwq4nebF5YBd30rOnBGdASL9VyIK2vDsv47ndzGjaBSj/BT
1Oxyi27Gb/3rc6qV1kb8bp33gsZvGT9A5FbellCnmNvjXR15Xiozbf+F0keoF9zr
nxtx267NfeDkwLOpK0chAg1BtSQ5DxbbQmNpLJTAS0Ga7UK/2Ln8X/0ZFSEfXwWV
TZKBzYJvunfscAJXFMHfZcoFYCCjhMJYa8kfhp93Z6l0Lgs2ZOIcqpoLEQCNvxzM
Kwa37PhDJwhFHLuXH9AEof4jss8woHdQoGtkYxr9YQ+ZnwiWmqDJ8+I=
=zoM+
-----END PGP SIGNATURE-----

--QDtfAc2h404MN5TnKwfAG8Wn0vU8C7Gfm--
