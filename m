Received: from eggs.gnu.org ([2001:4830:134:3::10]:38620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cECFJ-0006on-P5
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 04:41:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cECFE-0003gY-Sn
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 04:41:09 -0500
Received: from mail-wj0-f196.google.com ([209.85.210.196]:34094)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cECFE-0003gN-KX
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 04:41:04 -0500
Received: by mail-wj0-f196.google.com with SMTP id xy5so42773267wjc.1
	for <qemu-devel@nongnu.org>; Tue, 06 Dec 2016 01:41:04 -0800 (PST)
Date: Tue, 6 Dec 2016 09:40:01 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20161206094001.GD12630@stefanha-x1.localdomain>
References: <1480935840-3961-1-git-send-email-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fOHHtNG4YXGJ0yqR"
Content-Disposition: inline
In-Reply-To: <1480935840-3961-1-git-send-email-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PULL for-2.8 0/4] vga fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org


--fOHHtNG4YXGJ0yqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 05, 2016 at 12:03:56PM +0100, Gerd Hoffmann wrote:
>   Hi,
>=20
> Here is a last-minute poll for 2.8-rc3, bringing some vga fixes.
>=20
> Most important one is the qxl fix which is quite user-visible.
> Sorry for submitting that late, it lingers in my queue for a while
> already and I through I had that in the last vga pull already, but
> obviously that isn't the case.  If you feel it is too late now it'll
> be -stable instead.
>=20
> cheers,
>   Gerd
>=20
> The following changes since commit bd8ef5060dd2124a54578241da9a572faf7658=
dd:
>=20
>   Merge remote-tracking branch 'dgibson/tags/ppc-for-2.8-20161201' into s=
taging (2016-12-01 13:39:29 +0000)
>=20
> are available in the git repository at:
>=20
>=20
>   git://git.kraxel.org/qemu tags/pull-vga-20161205-1
>=20
> for you to fetch changes up to 4299b90e9ba9ce5ca9024572804ba751aa1a7e70:
>=20
>   display: cirrus: check vga bits per pixel(bpp) value (2016-12-05 11:01:=
55 +0100)
>=20
> ----------------------------------------------------------------
> qxl: fix flickering.
> cirrus: avoid devision by zero.
> virtio-gpu: fix two leaks.
>=20
> ----------------------------------------------------------------
> Christophe Fergeau (1):
>       qxl: Only emit QXL_INTERRUPT_CLIENT_MONITORS_CONFIG on config chang=
es
>=20
> Li Qiang (2):
>       virtio-gpu: fix information leak in getting capset info dispatch
>       virtio-gpu: fix memory leak in update_cursor_data_virgl
>=20
> Prasad J Pandit (1):
>       display: cirrus: check vga bits per pixel(bpp) value
>=20
>  hw/display/cirrus_vga.c    | 14 ++++++++++----
>  hw/display/qxl.c           | 37 ++++++++++++++++++++++++++++++++++++-
>  hw/display/virtio-gpu-3d.c |  1 +
>  hw/display/virtio-gpu.c    |  1 +
>  4 files changed, 48 insertions(+), 5 deletions(-)
>=20

Thanks, applied to my staging tree:
https://github.com/stefanha/qemu/commits/staging

Stefan

--fOHHtNG4YXGJ0yqR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYRodxAAoJEJykq7OBq3PIO1gIAIWFPPQR60Y/1goHU2vnSTUN
4e6bbiMN6MFwqnmQ4Y5sI5nXkA20OO/Id91w5+/AX/j+BmsYGAF4pk9sl2Zks9cn
2nFt5JPiEh0812HtL8Histdw6fOgak6+HEQod59VCsKcJcKmCBFNBB7/wgBgO/xl
OYBX3oTLAqiha+bz9BIU0PJzDZX7T0fQDouPZ2+ZPsxcdbTCQmYWqk86E2xxvOFp
tgT8XORcBVvzm60/NdQtxdX8AHDFOD3XzGTSiqBEpRlxRd/YQS5rhVQaBaPa9d4S
zhVWJkfahuhFn44ndHzUQ3ANZ9sBDOOBI/udDM/3XauXoLmJhjJcyvnE5pRyPJA=
=A3KO
-----END PGP SIGNATURE-----

--fOHHtNG4YXGJ0yqR--
