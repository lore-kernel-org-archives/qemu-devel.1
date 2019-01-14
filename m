Received: from eggs.gnu.org ([209.51.188.92]:49642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gj2sK-0003ri-Kw
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:06:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gj2sI-0000MQ-E9
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:06:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51306)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gj2sG-0000Gl-FA
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:05:58 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8AE0615552
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 14:05:50 +0000 (UTC)
Date: Mon, 14 Jan 2019 15:05:49 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190114140549.llseltirskd4iac7@sirius.home.kraxel.org>
References: <20190114130829.21790-1-philmd@redhat.com>
	<20190114130829.21790-4-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190114130829.21790-4-philmd@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/3] ui/console: Remove PixelFormat from
 qemu/typedefs.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, Jan 14, 2019 at 02:08:29PM +0100, Philippe Mathieu-Daud=E9 wrote:
> Header files requiring PixelFormat already include "ui/qemu-pixman.h".
>=20
> To clean "qemu/typedefs.h", move the declaration to "ui/qemu-pixman.h"
> (removing the forward declaration).

Acked-by: Gerd Hoffmann <kraxel@redhat.com>

>=20
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  include/qemu/typedefs.h  |  1 -
>  include/ui/console.h     | 10 ----------
>  include/ui/qemu-pixman.h | 10 ++++++++++
>  3 files changed, 10 insertions(+), 11 deletions(-)
>=20
> diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
> index 4cda7343bf..64b8386697 100644
> --- a/include/qemu/typedefs.h
> +++ b/include/qemu/typedefs.h
> @@ -67,7 +67,6 @@ typedef struct PCIExpressHost PCIExpressHost;
>  typedef struct PCIHostDeviceAddress PCIHostDeviceAddress;
>  typedef struct PCIHostState PCIHostState;
>  typedef struct PCMachineState PCMachineState;
> -typedef struct PixelFormat PixelFormat;
>  typedef struct PostcopyDiscardState PostcopyDiscardState;
>  typedef struct Property Property;
>  typedef struct PropertyInfo PropertyInfo;
> diff --git a/include/ui/console.h b/include/ui/console.h
> index aa9f975544..fef900db76 100644
> --- a/include/ui/console.h
> +++ b/include/ui/console.h
> @@ -121,16 +121,6 @@ struct QemuConsoleClass {
> =20
>  #define QEMU_ALLOCATED_FLAG     0x01
> =20
> -struct PixelFormat {
> -    uint8_t bits_per_pixel;
> -    uint8_t bytes_per_pixel;
> -    uint8_t depth; /* color depth in bits */
> -    uint32_t rmask, gmask, bmask, amask;
> -    uint8_t rshift, gshift, bshift, ashift;
> -    uint8_t rmax, gmax, bmax, amax;
> -    uint8_t rbits, gbits, bbits, abits;
> -};
> -
>  typedef struct DisplaySurface {
>      pixman_format_code_t format;
>      pixman_image_t *image;
> diff --git a/include/ui/qemu-pixman.h b/include/ui/qemu-pixman.h
> index b7c82d17fc..0668109305 100644
> --- a/include/ui/qemu-pixman.h
> +++ b/include/ui/qemu-pixman.h
> @@ -53,6 +53,16 @@
> =20
>  /* -------------------------------------------------------------------=
- */
> =20
> +typedef struct PixelFormat {
> +    uint8_t bits_per_pixel;
> +    uint8_t bytes_per_pixel;
> +    uint8_t depth; /* color depth in bits */
> +    uint32_t rmask, gmask, bmask, amask;
> +    uint8_t rshift, gshift, bshift, ashift;
> +    uint8_t rmax, gmax, bmax, amax;
> +    uint8_t rbits, gbits, bbits, abits;
> +} PixelFormat;
> +
>  PixelFormat qemu_pixelformat_from_pixman(pixman_format_code_t format);
>  pixman_format_code_t qemu_default_pixman_format(int bpp, bool native_e=
ndian);
>  pixman_format_code_t qemu_drm_format_to_pixman(uint32_t drm_format);
> --=20
> 2.17.2
>=20
