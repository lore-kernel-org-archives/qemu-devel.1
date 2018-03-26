Received: from eggs.gnu.org ([2001:4830:134:3::10]:46638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f0X2G-0005V6-IO
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 14:40:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f0X2F-0000Lh-NA
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 14:40:00 -0400
From: Max Reitz <mreitz@redhat.com>
Message-ID: <4013d078-5496-1b7f-dab3-c70ad75ac061@redhat.com>
Date: Mon, 26 Mar 2018 20:39:44 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="J5lHQqrR8geqBpwoMRwZ9zBIzrMFMToTV"
Subject: [Qemu-devel] nbd BLOCK_STATUS with -m32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Qemu-block <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--J5lHQqrR8geqBpwoMRwZ9zBIzrMFMToTV
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Qemu-block <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Message-ID: <4013d078-5496-1b7f-dab3-c70ad75ac061@redhat.com>
Subject: nbd BLOCK_STATUS with -m32
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

iotests 209 and 123 fail under 32-bit (or at least with -m32), both with
gcc and mingw.

Diff for 209:

@@ -1,2 +1,2 @@
-[{ "start": 0, "length": 524288, "depth": 0, "zero": false, "data": true=
},
-{ "start": 524288, "length": 524288, "depth": 0, "zero": true, "data":
false}]
+qemu-img: Protocol error: invalid payload for NBD_REPLY_TYPE_BLOCK_STATU=
S
+qemu-img: Could not read file metadata: Invalid argument


Diff for 123:

@@ -3,6 +3,10 @@
 Formatting 'TEST_DIR/source.IMGFMT', fmt=3DIMGFMT size=3D1048576
 wrote 1048576/1048576 bytes at offset 0
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+qemu-img: Protocol error: invalid payload for NBD_REPLY_TYPE_BLOCK_STATU=
S
+qemu-img: error getting block status at offset 0: Invalid argument
+qemu-img: error while writing sector 0: Input/output error
+Pattern verification failed at offset 0, 1048576 bytes
 read 1048576/1048576 bytes at offset 0
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)


Max


--J5lHQqrR8geqBpwoMRwZ9zBIzrMFMToTV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlq5PnASHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AnskH/3PS8CsnVyFpYqiDEuXh7wnuGS1Ii3Wr
hEjFy5CPn6r4areY11jpQsI91RsswJ8inRTmlWq63/k4Qb/VBv3UWTWp/oPbno2F
kv9IC+SUHwXUIyaUbVPP/to7js1abFW+ogDUCZJqtMeF9RfEi313yMRB603GxOML
AsBvPVunrVKV5h0S1ErV+MfbM1S8dOyUj7GQw2cd1Wf+oDaJPZrLaP49xGOV9P7K
vrKn67Dr4bhfzNkQGWLQ7km0KOqrZW1HV72ENG5CME+ERu8iJ5JT+AQiJ5I13xdd
d4JyHLrzTN0eKE53Udrvg7hTT3B3gHzoo0PIQvHAWkOUzrwgNafED20=
=3QBR
-----END PGP SIGNATURE-----

--J5lHQqrR8geqBpwoMRwZ9zBIzrMFMToTV--
