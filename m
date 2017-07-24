Received: from eggs.gnu.org ([2001:4830:134:3::10]:47005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dZeW8-0007GZ-Fn
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:39:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dZeW7-00059F-Nz
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:39:28 -0400
Date: Mon, 24 Jul 2017 15:39:20 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170724143920.GI2784@stefanha-x1.localdomain>
References: <20170714094521.4909-1-el13635@mail.ntua.gr>
	<20170714094521.4909-4-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4LwthZj+AV2mq5CX"
Content-Disposition: inline
In-Reply-To: <20170714094521.4909-4-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [PATCH 3/7] block: tidy ThrottleGroupMember
 initializations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-block <qemu-block@nongnu.org>


--4LwthZj+AV2mq5CX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 14, 2017 at 12:45:17PM +0300, Manos Pitsidianakis wrote:
> Move the CoMutex and CoQueue inits inside throttle_group_register_tgm()
> which is called whenever a ThrottleGroupMember is initialized. There's
> no need for them to be separate.
>=20
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
> ---
>  block/block-backend.c   | 3 ---
>  block/throttle-groups.c | 3 +++
>  2 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--4LwthZj+AV2mq5CX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZdgaYAAoJEJykq7OBq3PImK8H/ibmdqRlLk40yAcFTFo39NTv
juB7eTTrZZyQtmMTMxvcC04PuVR9mN8Ra3naDs1ojci0L8Jvb8kYBRBhVDtgvS1d
2aNqq7jNda7YQ1TuixlRZQgTtskaIObq5OlHX8WXnTUTDGFwkGxX17vdfuuQulOX
Hu5hR8dfaIWqlq5by4ilKDzKGDIe7Veus+gNvkpUWXWrgVqk8jYPjzEi9L+bNEol
lsla/QSyNBip7QY4e6MUmmlDNRuon5o5BSDBSLWh0MzyqttaoV8ZC93DokhqnWSU
+lkxdMnh62VE6BJCV65ow1cdj22IUmdA/rSF0Zu/p5DYS1lA6LaREhNudNrdozo=
=qlHF
-----END PGP SIGNATURE-----

--4LwthZj+AV2mq5CX--
