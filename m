Received: from eggs.gnu.org ([2001:4830:134:3::10]:46219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1euLTn-00089M-9k
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:06:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1euLTm-0003R3-Dv
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:06:51 -0500
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:43216)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1euLTm-0003Qx-5j
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:06:50 -0500
Received: by mail-oi0-x241.google.com with SMTP id a207so7466240oii.10
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 09:06:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180309153654.13518-6-f4bug@amsat.org>
References: <20180309153654.13518-1-f4bug@amsat.org>
	<20180309153654.13518-6-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Mar 2018 17:06:29 +0000
Message-ID: <CAFEAcA81Cz2d_7sL1f9piHtGhuYqCWwhV5XkBTFCqOW6Ezv-Ng@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 5/8] sdcard: Implement the UHS-I
 SWITCH_FUNCTION entries (Spec v3)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair@alistair23.me>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, QEMU Developers <qemu-devel@nongnu.org>

On 9 March 2018 at 15:36, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wro=
te:
> [based on a patch from Alistair Francis <alistair.francis@xilinx.com>
>  from qemu/xilinx tag xilinx-v2015.2]
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/sd/sd.c         | 148 +++++++++++++++++++++++++++++++++++++++++++++--=
------
>  hw/sd/trace-events |   1 +
>  2 files changed, 127 insertions(+), 22 deletions(-)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 235e0518d6..b907d62aef 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -124,6 +124,7 @@ struct SDState {
>      bool enable;
>      uint8_t dat_lines;
>      bool cmd_line;
> +    bool uhs_enabled;

Oh, and what's the difference between s->uhs_enabled =3D false
(this patch) and s->uhs_mode =3D UHS_NOT_SUPPORTED (next patch) ?

Do we need both? If so, a comment noting the difference would help
people to know which one various bits of code should be checking.

thanks
-- PMM
