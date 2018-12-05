Received: from eggs.gnu.org ([2001:4830:134:3::10]:59087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gUU3J-0004wG-7s
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 05:05:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gUU3A-0007ED-Gk
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 05:05:07 -0500
Date: Wed, 5 Dec 2018 10:04:56 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20181205100456.GF20933@stefanha-x1.localdomain>
References: <1541479952-32355-1-git-send-email-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UBnjLfzoMQYIXCvq"
Content-Disposition: inline
In-Reply-To: <1541479952-32355-1-git-send-email-dongli.zhang@oracle.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 1/1] virtio-blk: fix comment
 for virtio_blk_rw_complete as nalloc is initially -1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mst@redhat.com, qemu-trivial@nongnu.org, kwolf@redhat.com, stefanha@redhat.com, mreitz@redhat.com


--UBnjLfzoMQYIXCvq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 06, 2018 at 12:52:32PM +0800, Dongli Zhang wrote:
> The initial value of nalloc is -1, but not 1.
>=20
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
> This is based on git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/=
for_upstream
>=20
>  hw/block/virtio-blk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, applied to my block-next tree for QEMU 3.2:
https://github.com/stefanha/qemu/commits/block-next

Stefan

--UBnjLfzoMQYIXCvq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcB6LIAAoJEJykq7OBq3PIy6sH+wS3Y+lpGw/AaEPASEGCawJu
0RPav85ldN/MHDzCbX3EOROxmWylPUwLYLs2svg0XKqdfCtTF9yzlAwzVueq81Gp
+JP/L/zzUZbprEd0AF1g0Hs0Rfk52JTZPQkSfNn422Is49VpLXxvy92+ElH+MoiA
IqZs3CKniGtnGYPLgJ+PcH+doI+d83L7mk8iGrIJJRzkRcSHfcI7bidd1QfkdgMT
Om44lZXbnj9r1E75aRJOKElzvKwbejjGg8r5/r0MYxTCpG6UhUi/N5LJklTxcuIg
D3Mo4f8ZcBFdSrrIUQuBl8VBKJPBt5rfbeoDXhfIyDLiUA9ZHZXhJhjxwGw2YXQ=
=Becf
-----END PGP SIGNATURE-----

--UBnjLfzoMQYIXCvq--
