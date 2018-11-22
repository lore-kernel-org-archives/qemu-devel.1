Received: from eggs.gnu.org ([2001:4830:134:3::10]:56763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gPehy-0003pR-Fg
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 21:27:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gPeht-0001aL-Fb
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 21:27:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gPeht-0001CM-3G
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 21:27:05 -0500
Date: Thu, 22 Nov 2018 00:26:39 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181122022639.GK4755@habkost.net>
References: <20181122021139.1486-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181122021139.1486-1-philmd@redhat.com>
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
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Peter Maydell <peter.maydell@linaro.org>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, David Gibson <david@gibson.dropbear.id.au>, "Michael S . Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Li Qiang <liq3ea@gmail.com>

On Thu, Nov 22, 2018 at 03:11:39AM +0100, Philippe Mathieu-Daud=E9 wrote:
> Step in to maintain it, with Laszlo (EDK2) and Gerd (SeaBIOS)
> as designated reviewers.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Acked-by: Eduardo Habkost <ehabkost@redhat.com>

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
> +M: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
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
> --=20
> 2.17.2
>=20

--=20
Eduardo
