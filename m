Received: from eggs.gnu.org ([2001:4830:134:3::10]:44267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuFfn-0007YS-Tj
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 07:27:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuFfn-0007NU-AE
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 07:27:07 -0400
References: <20180823222249.13518-1-jsnow@redhat.com>
	<20180823222249.13518-4-jsnow@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <50fb1b99-3586-19ab-df2a-a489c0740064@redhat.com>
Date: Mon, 27 Aug 2018 13:26:52 +0200
MIME-Version: 1.0
In-Reply-To: <20180823222249.13518-4-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="J834ogyofIYjZ0ekrH2aaPGup2F7zkCck"
Subject: Re: [Qemu-devel] [PATCH v2 03/13] block/stream: add block job
 creation flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Markus Armbruster <armbru@redhat.com>, jtc@redhat.com, Jeff Cody <jcody@redhat.com>, Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--J834ogyofIYjZ0ekrH2aaPGup2F7zkCck
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Markus Armbruster <armbru@redhat.com>, jtc@redhat.com,
 Jeff Cody <jcody@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <50fb1b99-3586-19ab-df2a-a489c0740064@redhat.com>
Subject: Re: [PATCH v2 03/13] block/stream: add block job creation flags
References: <20180823222249.13518-1-jsnow@redhat.com>
 <20180823222249.13518-4-jsnow@redhat.com>
In-Reply-To: <20180823222249.13518-4-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-24 00:22, John Snow wrote:
> Add support for taking and passing forward job creaton flags.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  block/stream.c            | 5 +++--
>  blockdev.c                | 3 ++-
>  include/block/block_int.h | 5 ++++-
>  3 files changed, 9 insertions(+), 4 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--J834ogyofIYjZ0ekrH2aaPGup2F7zkCck
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluD3/wACgkQ9AfbAGHV
z0Aw7QgAslStGbY7heXbqSczjKstzE32Z6BPedyRwYGLxlshRCfVw1K5ukIMFssV
gnfh2KKktNHkN2yvYYFKWyt7i9GB1LsvdlHfJeNpPuH1ZTprnU0WxiB2Mu2+8dSV
hIx3+II/PgeaYz/UXWm1ALhWxwVRp8GqkQi4sg2L91dqZ9mrKP6XS2VzLhLYlCeU
8moX5MlowoDdae5RhhMAH0pUu0rr1oplbQejOpyoSRoGfL5JeGHJeL8rioWwRyNE
NGmmuyOrZa4Jx04JeSH+g0RmWO+bH+XpoLZDQsDkwejxLtyBynWTBfcygeNqBpNn
5JCmY9KpQ0FGy0DC1xBoSv5IZ0YCVQ==
=ym1O
-----END PGP SIGNATURE-----

--J834ogyofIYjZ0ekrH2aaPGup2F7zkCck--
