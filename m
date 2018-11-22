Received: from eggs.gnu.org ([2001:4830:134:3::10]:60739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gPqe1-0003K3-N7
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 10:11:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gPqdy-0000D3-6C
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 10:11:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57600)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1gPqdx-0000C9-Rp
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 10:11:50 -0500
References: <20181122021139.1486-1-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <61a8ebf8-fb64-1b04-8c92-f14bf5bb61aa@redhat.com>
Date: Thu, 22 Nov 2018 16:11:32 +0100
MIME-Version: 1.0
In-Reply-To: <20181122021139.1486-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.1] MAINTAINERS: Add an entry for the
 Firmware Configuration (fw_cfg) device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, David Gibson <david@gibson.dropbear.id.au>, "Michael S . Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Li Qiang <liq3ea@gmail.com>

On 11/22/18 03:11, Philippe Mathieu-Daud=C3=A9 wrote:
> Step in to maintain it, with Laszlo (EDK2) and Gerd (SeaBIOS)
> as designated reviewers.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> Note than OpenBIOS also consumes this device (PPC/Sparc).
>=20
>  MAINTAINERS | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1032406c56..b28ec13963 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1534,6 +1534,19 @@ F: hw/display/edid*
>  F: include/hw/display/edid.h
>  F: qemu-edid.c
> =20
> +Firmware configuration (fw_cfg)
> +M: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> +R: Laszlo Ersek <lersek@redhat.com>
> +R: Gerd Hoffmann <kraxel@redhat.com>
> +S: Supported
> +F: docs/specs/fw_cfg.txt
> +F: hw/nvram/fw_cfg.c
> +F: include/hw/nvram/fw_cfg.h
> +F: include/standard-headers/linux/qemu_fw_cfg.h
> +F: tests/libqos/fw_cfg.c
> +F: tests/fw_cfg-test.c
> +T: git https://github.com/philmd/qemu.git fw_cfg-next
> +
>  Subsystems
>  ----------
>  Audio
>=20

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thanks!
Laszlo
