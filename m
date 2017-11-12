Received: from eggs.gnu.org ([2001:4830:134:3::10]:38216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <somlo@cmu.edu>) id 1eDrYy-0004tA-Ml
	for qemu-devel@nongnu.org; Sun, 12 Nov 2017 07:40:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <somlo@cmu.edu>) id 1eDrYv-0005r4-LJ
	for qemu-devel@nongnu.org; Sun, 12 Nov 2017 07:40:36 -0500
Received: from smtp.andrew.cmu.edu ([128.2.105.203]:52688)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <somlo@cmu.edu>) id 1eDrYv-0005qf-GB
	for qemu-devel@nongnu.org; Sun, 12 Nov 2017 07:40:33 -0500
Date: Sun, 12 Nov 2017 07:40:30 -0500
From: "Gabriel L. Somlo" <somlo@cmu.edu>
Message-ID: <20171112124030.GB19857@hedwig.ini.cmu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20171031151938.14982-2-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 1/5] fw_cfg: fix the command line module
 name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: linux-kernel@vger.kernel.org, somlo@cmu.edu, qemu-devel@nongnu.org, mst@redhat.com

On Tue, Oct 31, 2017 at 04:19:34PM +0100, Marc-Andr=E9 Lureau wrote:
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>

Acked-by: Gabriel Somlo <somlo@cmu.edu>

> ---
>  drivers/firmware/qemu_fw_cfg.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_=
cfg.c
> index 0e2011636fbb..5cfe39f7a45f 100644
> --- a/drivers/firmware/qemu_fw_cfg.c
> +++ b/drivers/firmware/qemu_fw_cfg.c
> @@ -10,9 +10,9 @@
>   * and select subsets of aarch64), a Device Tree node (on arm), or usi=
ng
>   * a kernel module (or command line) parameter with the following synt=
ax:
>   *
> - *      [fw_cfg.]ioport=3D<size>@<base>[:<ctrl_off>:<data_off>]
> + *      [qemu_fw_cfg.]ioport=3D<size>@<base>[:<ctrl_off>:<data_off>]
>   * or
> - *      [fw_cfg.]mmio=3D<size>@<base>[:<ctrl_off>:<data_off>]
> + *      [qemu_fw_cfg.]mmio=3D<size>@<base>[:<ctrl_off>:<data_off>]
>   *
>   * where:
>   *      <size>     :=3D size of ioport or mmio range
> @@ -21,9 +21,9 @@
>   *      <data_off> :=3D (optional) offset of data register
>   *
>   * e.g.:
> - *      fw_cfg.ioport=3D2@0x510:0:1		(the default on x86)
> + *      qemu_fw_cfg.ioport=3D2@0x510:0:1		(the default on x86)
>   * or
> - *      fw_cfg.mmio=3D0xA@0x9020000:8:0		(the default on arm)
> + *      qemu_fw_cfg.mmio=3D0xA@0x9020000:8:0	(the default on arm)
>   */
> =20
>  #include <linux/module.h>
> --=20
> 2.15.0.rc0.40.gaefcc5f6f
>=20
