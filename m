Received: from eggs.gnu.org ([2001:4830:134:3::10]:40238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d7lk3-0001St-Tu
	for qemu-devel@nongnu.org; Mon, 08 May 2017 12:42:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d7lk0-00045G-Qz
	for qemu-devel@nongnu.org; Mon, 08 May 2017 12:42:35 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:35013)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1d7lk0-00045C-MH
	for qemu-devel@nongnu.org; Mon, 08 May 2017 12:42:32 -0400
Received: by mail-qt0-x244.google.com with SMTP id r58so10282491qtb.2
	for <qemu-devel@nongnu.org>; Mon, 08 May 2017 09:42:32 -0700 (PDT)
Date: Mon, 8 May 2017 12:42:30 -0400
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170508164230.GD22428@stefanha-x1.localdomain>
References: <1493966082-9352-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="q9KOos5vDmpwPx9o"
Content-Disposition: inline
In-Reply-To: <1493966082-9352-1-git-send-email-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PULL v2 00/28] QAPI patches for 2017-05-04
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org


--q9KOos5vDmpwPx9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 05, 2017 at 08:34:42AM +0200, Markus Armbruster wrote:
> [v2]: Fix trailing space, note tweaks to PATCH 12 properly in the
>
> commit message=20
> The following changes since commit e619b14746e5d8c0e53061661fd0e1da01fd4d=
60:
>=20
>   Merge remote-tracking branch 'sthibault/tags/samuel-thibault' into stag=
ing (2017-05-02 15:16:29 +0100)
>=20
> are available in the git repository at:
>=20
>   git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2017-05-04-v2

make check fails when I apply this series:

  GTESTER tests/test-char
  GTester: last random seed: R02S47a681e3e741223084711f7aacacb19a
  GTester: last random seed: R02S739de30ffeb0f93caedc22b2863f60a7

Output from gdb is:

  /char/socket:=20
  Thread 1 "test-char" received signal SIGSEGV, Segmentation fault.
  0x00005555555b8b09 in qdict_find (bucket=3D<optimized out>, key=3D0x55555=
55da9dd "port", qdict=3D0x0) at qobject/qdict.c:110
  110	    QLIST_FOREACH(entry, &qdict->table[bucket], next)
  (gdb) bt
  bt
  #0  0x00005555555b8b09 in qdict_find (bucket=3D<optimized out>, key=3D0x5=
555555da9dd "port", qdict=3D0x0) at qobject/qdict.c:110
  #1  qdict_get (qdict=3D0x0, key=3D0x5555555da9dd "port") at qobject/qdict=
=2Ec:157
  #2  0x00005555555b8cf9 in qdict_get_str (qdict=3D<optimized out>, key=3D<=
optimized out>) at qobject/qdict.c:256
  #3  0x0000555555565917 in char_socket_test () at tests/test-char.c:310
  #4  0x00007ffff79327d1 in g_test_run_suite_internal () from /lib64/libgli=
b-2.0.so.0
  #5  0x00007ffff793299f in g_test_run_suite_internal () from /lib64/libgli=
b-2.0.so.0
  #6  0x00007ffff7932bae in g_test_run_suite () from /lib64/libglib-2.0.so.0
  #7  0x00007ffff7932bd1 in g_test_run () from /lib64/libglib-2.0.so.0
  #8  0x0000555555564c67 in main (argc=3D<optimized out>, argv=3D<optimized=
 out>) at tests/test-char.c:608

--q9KOos5vDmpwPx9o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZEJ/2AAoJEJykq7OBq3PIAQQH/0qNGJ0cmj73wsX7qlIMWVLu
Yd7uvz0RDKAxmrIs3LzZ5zvn/1nfRNnZkOYKZ5EiPZpVC/Zyp2wJf6s+AvPULQo0
yQ3gyzJBcMSzg8jetXhK4dX8Yp4OEx1X93iyai8ucsErvzhn6x4Qaz5JOv8WGAfU
1XhgGx1cQvSWpnPTiruxLP5nk9Mu+cThT3sZ4RRZUk4I5cKMoSKvnvHu2BEzQUew
g2+JCwX0bOjwXPnQYGEI732/rq8st+nr0BxuVpXvCC11dczlNSWl6vDRZ5whtNN9
izWh0g0jSLH4blrP3sD2OQpVCWREb29t/74dzfEOrYzSgPcrDZyRr0RlJ6gMDVs=
=WulX
-----END PGP SIGNATURE-----

--q9KOos5vDmpwPx9o--
