Received: from eggs.gnu.org ([2001:4830:134:3::10]:37328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gHNfq-0001Ll-GO
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 02:38:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gHNfp-0005d6-OO
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 02:38:46 -0400
Date: Tue, 30 Oct 2018 07:38:30 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181030063830.edjacusffvgwvnt2@sirius.home.kraxel.org>
References: <20181029223207.31878-1-philmd@redhat.com>
	<20181029223207.31878-4-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181029223207.31878-4-philmd@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/3] arm: allwinner: Enable USB EHCI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Icenowy Zheng <icenowy@aosc.xyz>, Guenter Roeck <linux@roeck-us.net>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Beniamino Galvani <b.galvani@gmail.com>

On Mon, Oct 29, 2018 at 11:32:07PM +0100, Philippe Mathieu-Daud=E9 wrote:
> From: Guenter Roeck <linux@roeck-us.net>
>=20
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> [PMD: Intented tabs -> space]
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  hw/arm/allwinner-a10.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
> index 0a8ac929f5..92ab66354a 100644
> --- a/hw/arm/allwinner-a10.c
> +++ b/hw/arm/allwinner-a10.c
> @@ -116,6 +116,8 @@ static void aw_a10_realize(DeviceState *dev, Error =
**errp)
>      if (machine_usb(current_machine)) {
>          sysbus_create_simple("sysbus-ohci", 0x01c14400, s->irq[64]);
>          sysbus_create_simple("sysbus-ohci", 0x01c1c400, s->irq[65]);
> +        sysbus_create_simple(TYPE_AW_A10_EHCI, 0x01c14000, s->irq[39])=
;
> +        sysbus_create_simple(TYPE_AW_A10_EHCI, 0x01c1c000, s->irq[40])=
;

Hmm, is this a companion controller setup?  If so, then this is a bit
more complicated  (see ehci_create_ich9_with_companions()).

cheers,
  Gerd
