Received: from eggs.gnu.org ([209.51.188.92]:53635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ghzj5-0008K3-9y
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 11:32:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ghzj4-0003QI-KK
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 11:32:07 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46854)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ghzj4-0003Pr-Dq
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 11:32:06 -0500
Received: by mail-wr1-x441.google.com with SMTP id l9so15798103wrt.13
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 08:32:06 -0800 (PST)
Date: Fri, 11 Jan 2019 16:32:03 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190111163203.GE14776@stefanha-x1.localdomain>
References: <20190111131836.107549-1-sgarzare@redhat.com>
	<20190111131836.107549-2-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HeFlAV5LIbMFYYuh"
Content-Disposition: inline
In-Reply-To: <20190111131836.107549-2-sgarzare@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/4] linuxboot_dma: remove duplicate
 definitions of FW_CFG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, George Kennedy <george.kennedy@oracle.com>, Gerd Hoffmann <kraxel@redhat.com>, Marc-Andre Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Maran Wilson <maran.wilson@oracle.com>, Richard Henderson <rth@twiddle.net>


--HeFlAV5LIbMFYYuh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 11, 2019 at 02:18:33PM +0100, Stefano Garzarella wrote:
> FW_CFG_DMA_CTL_* bits and struct fw_cfg_dma_access are
> defined in the qemu_fw_cfg.h header file already included
> in linuxboot_dma.c, so we can remove the definition of
> BIOS_CFG_DMA_CTL_* and struct FWCfgDmaAccess.
>=20
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  pc-bios/optionrom/linuxboot_dma.c | 20 ++++----------------
>  1 file changed, 4 insertions(+), 16 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--HeFlAV5LIbMFYYuh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcOMUDAAoJEJykq7OBq3PIZZUIALrHnRroHEVwMmrDPRTQt91y
yCP9DcokwLciZ4E1BLAWTcEapWpUO5SZW5xPDMeAHJJ13THVZboDgjRB/Ke2CKVs
7xAklssFE8njGTjYUkLkusI2pmrTujnnaCQHJkuHpzk4kfE8n0BUYwDzVxEedF6U
bippG5h9XFHaizcYgrU8SqafhqQGzvFOyCYtzFpNmnVP3NP+aysLhPMsbJg99gpg
rZdC7YOg6YNxdIkQKA9FZmIYCGoygF76rRiwnh45so+IZC+1QafQNMguf/ItlbwV
qNx8rWqHXyK2ww9U4MNB6JvTcb2J/WRWlAoAWX1G1V32nuNZc6VZe+bWgbTHYzI=
=GXAp
-----END PGP SIGNATURE-----

--HeFlAV5LIbMFYYuh--
