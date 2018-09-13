Received: from eggs.gnu.org ([2001:4830:134:3::10]:43464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g0Yf8-0006YQ-Gq
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 16:56:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g0Yf7-0002Tq-NE
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 16:56:30 -0400
References: <20180913125217.23173-1-kwolf@redhat.com>
	<20180913125217.23173-13-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <9f51d49d-0159-3382-b561-1f33335a2dfd@redhat.com>
Date: Thu, 13 Sep 2018 22:55:54 +0200
MIME-Version: 1.0
In-Reply-To: <20180913125217.23173-13-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="aO2nLOvo5x3dkFV4NhqBS0OSFjoipdaDC"
Subject: Re: [Qemu-devel] [PATCH v2 12/17] mirror: Fix potential
 use-after-free in active commit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, pbonzini@redhat.com, slp@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aO2nLOvo5x3dkFV4NhqBS0OSFjoipdaDC
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, pbonzini@redhat.com, slp@redhat.com, jsnow@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <9f51d49d-0159-3382-b561-1f33335a2dfd@redhat.com>
Subject: Re: [PATCH v2 12/17] mirror: Fix potential use-after-free in active
 commit
References: <20180913125217.23173-1-kwolf@redhat.com>
 <20180913125217.23173-13-kwolf@redhat.com>
In-Reply-To: <20180913125217.23173-13-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 13.09.18 14:52, Kevin Wolf wrote:
> When starting an active commit job, other callbacks can run before
> mirror_start_job() calls bdrv_ref() where needed and cause the nodes to=

> go away. Add another pair of bdrv_ref/unref() around it to protect
> against this case.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/mirror.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>

But...  How?

Like...  You mirror to some target (in an iothread), then you give that
target a backing file, then you cancel the mirror and immediately commit
the target?

Max


--aO2nLOvo5x3dkFV4NhqBS0OSFjoipdaDC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluaztoACgkQ9AfbAGHV
z0BZdgf/cnvfFwgeKnGlDKrxzn5b8cFwJy+BuYo6o0gM8Oijw6w62E+Y/laCFE2Z
+6+9KKbRxAW/B6vZpZORcj88UW2eM6IfhiWWFfTlaxbfTfW0J2wwkUUFwrk+MEby
dvBckrt/8VNAqze9R+DhYq5YX5vpfw8jYG1e/0iu2Q4HrqpfdrTUZEeEUK1hFL68
mxNicFbWYqLTdeIsZnYoaBf3ZOyg4KtmTe5RV+0ckM9uEo2pHceRNlECg/s5fICI
bx4WU8O47F5JY4Fd6hbljoT7q6iTyVXnn36dQcLTfAo1GKoeaya2D/cUSviN2I5V
vjCb3A8fTDYbeQe51wfnhayWWwdQtw==
=GqOK
-----END PGP SIGNATURE-----

--aO2nLOvo5x3dkFV4NhqBS0OSFjoipdaDC--
