Received: from eggs.gnu.org ([2001:4830:134:3::10]:40425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gS69I-0004wK-N7
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 15:09:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gS69C-0003fN-UD
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 15:09:28 -0500
References: <20181128195802.B9C0F745714@zero.eik.bme.hu>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <91948a94-9753-0fd1-7091-ee713f041995@redhat.com>
Date: Wed, 28 Nov 2018 21:09:09 +0100
MIME-Version: 1.0
In-Reply-To: <20181128195802.B9C0F745714@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Add more files to sam460ex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Peter Maydell <peter.maydell@linaro.org>, Philippe Mathieu-Daude <philmd@redhat.com>, Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>

On 2018-11-28 20:41, BALATON Zoltan wrote:
> The sm501 model belonged to SH before but that seems to be inactive
> now and latest changes were for sam460ex which is the more active user
> of this device at the moment so let's adopt sm501 for sam460ex.
>=20
> Also add device tree and firmware sources and binaries.
>=20
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  MAINTAINERS | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 63effdc473..0c373be86e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1003,8 +1003,12 @@ sam460ex
>  M: BALATON Zoltan <balaton@eik.bme.hu>
>  L: qemu-ppc@nongnu.org
>  S: Maintained
> +F: hw/display/sm501*
>  F: hw/ide/sii3112.c
>  F: hw/timer/m41t80.c
> +F: pc-bios/canyonlands.dt[sb]
> +F: pc-bios/u-boot-sam460ex-20100605.bin
> +F: roms/u-boot-sam460ex

Thanks for the update! ... but in case the SH4 R2D maintainer is
interested in the sm501 device, too, I think it would maybe be cleaner
to add a new paragraph in the  "Devices" section of the MAINTAINERS file
for the sm501 device...?

Otherwise:
Reviewed-by: Thomas Huth <thuth@redhat.com>
