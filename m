Received: from eggs.gnu.org ([2001:4830:134:3::10]:53045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dIbyy-0003VZ-5t
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 10:30:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dIbyv-0005Xd-2k
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 10:30:48 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:35963)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dIbyu-0005XE-Sn
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 10:30:45 -0400
Received: by mail-wm0-x243.google.com with SMTP id k15so2857035wmh.3
	for <qemu-devel@nongnu.org>; Wed, 07 Jun 2017 07:30:44 -0700 (PDT)
Date: Wed, 7 Jun 2017 15:30:41 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170607143041.GC21990@stefanha-x1.localdomain>
References: <1496754467-20893-1-git-send-email-bru.dominguez@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mvpLiMfbWzRoNl4x"
Content-Disposition: inline
In-Reply-To: <1496754467-20893-1-git-send-email-bru.dominguez@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2] configure: split c and cxx extra flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bruno Dominguez <bru.dominguez@gmail.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org


--mvpLiMfbWzRoNl4x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 06, 2017 at 02:07:47PM +0100, Bruno Dominguez wrote:
> There was no possibility to add specific cxx flags using the configure
> file. So A new entrance has been created to support it.
>=20
> Duplication of information in configure and rules.mak. Taking
> QEMU_CFLAGS and add them to QEMU_CXXFLAGS, now the value of
> QEMU_CXXFLAGS is stored in config-host.mak, so there is no need for
> it.
>=20
> The makefile for libvixl was adding flags for QEMU_CXXFLAGS in
> QEMU_CFLAGS because of the addition in rules.mak. That was removed, so
> adding them where it should be.
>=20
> Signed-off-by: Bruno Dominguez <bru.dominguez@gmail.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> v2:
>  * Matching --extra-cxxflags description with --cxx
>  * Removing some extra spaces indicated by checkpatch script
>  * Fixed patch format
> ---
>  configure                   | 74 +++++++++++++++++++++++++--------------=
------
>  disas/libvixl/Makefile.objs |  2 +-
>  rules.mak                   |  3 --
>  3 files changed, 43 insertions(+), 36 deletions(-)

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--mvpLiMfbWzRoNl4x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZOA4RAAoJEJykq7OBq3PIqGQH/2J5qXWb8wIJDzX7MT/ZiFET
2QK3XxXNgaLunFKLAlWo5zEWnsjc0hsyd7IqCZMVTBgLNQrPb2uoNLEiHrAVSwPQ
v6+hF+Xd8XX5alg2rZyeH6slfmOlImjzZt3Q3wKBBGlWrDg3XAzOyynEcyji4Nxc
qfKhH0VgZaokjVs0dSpv3fGPoqp9t7Z/PmNL9Gw9ditdh4wTvEidEd6hReUSGMhU
+4GAsIzKJ25uDdFVhgrzTdfZBitJCt81qOGuwyKriBYkVgo1iwWaz88mnflPz87D
HIzkY0KDls2eMnObMBfakcXiIJCQAiuHsByE1OER3U+6OjdwP9Lw+gFpa8fBR6g=
=xock
-----END PGP SIGNATURE-----

--mvpLiMfbWzRoNl4x--
