Received: from eggs.gnu.org ([208.118.235.92]:51596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gfR6V-0001pW-OD
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 10:09:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gfR6S-00007I-MA
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 10:09:43 -0500
Date: Fri, 4 Jan 2019 15:09:32 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190104150932.GI30381@stefanha-x1.localdomain>
References: <1545474448-24488-1-git-send-email-wangjian161@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k9xkV0rc9XGsukaG"
Content-Disposition: inline
In-Reply-To: <1545474448-24488-1-git-send-email-wangjian161@huawei.com>
Subject: Re: [Qemu-devel] [PATCH v2] qemu: avoid memory leak while remove
 disk
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com
Cc: kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, famz@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, eric.fangyi@huawei.com, w00426999 <wangjian161@huawei.com>


--k9xkV0rc9XGsukaG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 22, 2018 at 06:27:28PM +0800, w00426999 wrote:
> Memset vhost_dev to zero in the vhost_dev_cleanup function.
> This causes dev.vqs to be NULL, so that
> vqs does not free up space when calling the g_free function.
> This will result in a memory leak. But you can't release vqs
> directly in the vhost_dev_cleanup function, because vhost_net
> will also call this function, and vhost_net's vqs is assigned by array.
> In order to solve this problem, we first save the pointer of vqs,
> and release the space of vqs after vhost_dev_cleanup is called.
>=20
> Signed-off-by: Jian Wang <wangjian161@huawei.com>
> ---
>  hw/block/vhost-user-blk.c | 7 +++++--
>  hw/scsi/vhost-scsi.c      | 3 ++-
>  hw/scsi/vhost-user-scsi.c | 3 ++-
>  3 files changed, 9 insertions(+), 4 deletions(-)

This patch can go through Michael's tree.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--k9xkV0rc9XGsukaG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcL3csAAoJEJykq7OBq3PIRc4H/3+96c/gp2pjih5ENhgRwKhi
ZnC07WjV9r1EWM+LJtVVkxSavHdUI+vWlXiqirOVFj9ZMeKktNDstXnrgopDI1/F
2fQwgbDtA63YmVnQUwgW2MH2T+EOPB/M4vKiyXARGymXHAyElWZIbYKjmCV1ITIA
LbRuCP5a5DQoGp+OLmWSpFcTPFDcZiSb0iUhGSbhiJ5RnF4t3z8pR2TFZ4BzbweK
VQwtxJvckoGMU35nMTGp7bdiPvSdpM7ma30qufYQxxqYbfrJJvZC45u9I3Yp6ZRe
Zyd25AyxtY2cLAjSTqXiFjm8aSXXkBWRucpCYtEq55RqDACWEM2KnG+muPe7Rbg=
=R1lK
-----END PGP SIGNATURE-----

--k9xkV0rc9XGsukaG--
