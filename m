Received: from eggs.gnu.org ([2001:4830:134:3::10]:60961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dwaEE-00065B-D4
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 16:43:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dwaED-0008DC-Fl
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 16:43:46 -0400
References: <20170913181910.29688-1-mreitz@redhat.com>
	<20170913181910.29688-13-mreitz@redhat.com>
	<042b7c75-96a8-a695-5702-289eb68b5f54@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <abdf37da-0c63-c05a-74eb-764aebc14e53@redhat.com>
Date: Mon, 25 Sep 2017 22:43:28 +0200
MIME-Version: 1.0
In-Reply-To: <042b7c75-96a8-a695-5702-289eb68b5f54@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fwtk2FpUeEHbhMtcf5PLDoXeqHdKX3fRL"
Subject: Re: [Qemu-devel] [PATCH 12/18] block/dirty-bitmap: Add
 bdrv_dirty_iter_next_area
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fwtk2FpUeEHbhMtcf5PLDoXeqHdKX3fRL
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 John Snow <jsnow@redhat.com>
Message-ID: <abdf37da-0c63-c05a-74eb-764aebc14e53@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 12/18] block/dirty-bitmap: Add
 bdrv_dirty_iter_next_area
References: <20170913181910.29688-1-mreitz@redhat.com>
 <20170913181910.29688-13-mreitz@redhat.com>
 <042b7c75-96a8-a695-5702-289eb68b5f54@virtuozzo.com>
In-Reply-To: <042b7c75-96a8-a695-5702-289eb68b5f54@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-09-25 17:49, Vladimir Sementsov-Ogievskiy wrote:
> I have a patch on list, which adds hbitmap_next_zero function, it may h=
elp
> https://lists.nongnu.org/archive/html/qemu-devel/2017-02/msg00809.html

Hmmm.  Sounds good, but (1) I would need to directly access the bitmap
instead of the iterator, and (2) I would still need to clear the whole
in the iterator...

It does sound tempting because I could drop the previous patch, then
(and thus wouldn't have to worry about concurrent resetting), but I
don't think the whole implementation would be simpler.

I'll think about it, but thanks for pointing it out in any case!

Max


--fwtk2FpUeEHbhMtcf5PLDoXeqHdKX3fRL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlnJanASHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A4AEH/RFIOFiNrQblytA2zSogWGelqzydbPyn
P04Wn6fRRMD+6zD0XEIo9jjthVlk5bHvA4UI3+37YCKOp+zXF1dWSxhZ/heSY6hG
UdEMuB9TAk3ByEIf+lMPMlUdQAjp7dzK44sS3/FzjZBstgFbWF649bWraArdYzRg
t6NSWLQXiR79cgDW4+yHh3vPDCY6H0YyliY9fhC5mENBKGVAYwQ5zWbxEZW796GJ
oLjLRRF41+Dm/45a6vmhtXT3purpwhBsgqon69butUY7gxX4kK8I+pAL7nE2iNJJ
L8jdG6Q51bQlxKfPy7hNVix1ZzVDh8np4oqlwoSAv7o1cwY88VsG06U=
=flHW
-----END PGP SIGNATURE-----

--fwtk2FpUeEHbhMtcf5PLDoXeqHdKX3fRL--
