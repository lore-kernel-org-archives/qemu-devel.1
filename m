Received: from eggs.gnu.org ([209.51.188.92]:54101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ghzlW-0001Uf-7x
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 11:34:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ghzlT-0004Mt-FE
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 11:34:38 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39299)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ghzlQ-0004Hy-Rr
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 11:34:34 -0500
Received: by mail-wm1-x341.google.com with SMTP id y8so2950972wmi.4
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 08:34:23 -0800 (PST)
Date: Fri, 11 Jan 2019 16:34:21 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190111163421.GF14776@stefanha-x1.localdomain>
References: <20190111131836.107549-1-sgarzare@redhat.com>
	<20190111131836.107549-5-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rWhLK7VZz0iBluhq"
Content-Disposition: inline
In-Reply-To: <20190111131836.107549-5-sgarzare@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/4] hw/i386/pc: use PVH option rom
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


--rWhLK7VZz0iBluhq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 11, 2019 at 02:18:36PM +0100, Stefano Garzarella wrote:
> Use pvh.bin option rom when we are booting an uncompressed
> kernel using the x86/HVM direct boot ABI.
>=20
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> Based-on: <1545422632-24444-5-git-send-email-liam.merwick@oracle.com>
> ---
>  hw/i386/pc.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 06bce6a101..deab8a2816 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1005,6 +1005,10 @@ static void load_linux(PCMachineState *pcms,
>              fw_cfg_add_bytes(fw_cfg, FW_CFG_SETUP_DATA,
>                               header, sizeof(header));
> =20
> +            option_rom[nb_option_roms].bootindex =3D 0;
> +            option_rom[nb_option_roms].name =3D "pvh.bin";
> +            nb_option_roms++;
> +

xen_load_linux() has the following:

  assert(!strcmp(option_rom[i].name, "linuxboot.bin") ||
         !strcmp(option_rom[i].name, "linuxboot_dma.bin") ||
         !strcmp(option_rom[i].name, "multiboot.bin"));

I wonder if it needs to be updated for pvh.bin?

--rWhLK7VZz0iBluhq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcOMWNAAoJEJykq7OBq3PIFS8H/RqYaqn/4SKP5giJL+0hL7sw
eb7myH/B6fjy2KGGh2sDB14xrhXbd2sisR9x9ghXkPOsFrPfJWkQO5djrl5NNt5m
J/y/kLVcqjeW9OUn6mMfZO4xUimDtfqlT8xhs+2i3hzFMWGMmPoH/to84r4f2SEn
Xbg5pTs5MR0sxi2oTqIZ2z0x9xqXKlw40/ldLmQOAqQZkcaYY2hQlJZpSVf/Fdmq
77ygS0VJAFGxmsBHiJQu+TBAMm8Gy1Ox1wA+98NRcIFj/tTjWGnV02orciH72p1x
+BdfB4/QKHj8tuueCatzQXKJKqpVNz5hEBJ8Ly88+2OYmCpvRmh8Q9M8KNdyCmE=
=N8Sn
-----END PGP SIGNATURE-----

--rWhLK7VZz0iBluhq--
