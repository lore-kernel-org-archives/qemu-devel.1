Received: from eggs.gnu.org ([2001:4830:134:3::10]:53346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1euKFQ-0007gW-9R
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:47:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1euKFP-0005X3-0a
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:47:56 -0500
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:42515)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1euKFO-0005Wo-S1
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:47:54 -0500
Received: by mail-oi0-x244.google.com with SMTP id c18so7262448oiy.9
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 07:47:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180309153654.13518-3-f4bug@amsat.org>
References: <20180309153654.13518-1-f4bug@amsat.org>
	<20180309153654.13518-3-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Mar 2018 15:47:33 +0000
Message-ID: <CAFEAcA9wjo3k_AXxaq0eXVXw-qGxDg1J7BP6g4xj2z9_amn0Fg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/8] sdcard: Display command name when
 tracing CMD/ACMD
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
> The SDBus will reuse these functions, so we put them in a new source file=
.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/sd/sdmmc-internal.h | 20 ++++++++++++++
>  hw/sd/sd.c             | 13 +++++----
>  hw/sd/sdmmc-internal.c | 72 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  hw/sd/Makefile.objs    |  2 +-
>  hw/sd/trace-events     |  8 +++---
>  5 files changed, 105 insertions(+), 10 deletions(-)
>  create mode 100644 hw/sd/sdmmc-internal.c
>
> diff --git a/hw/sd/sdmmc-internal.h b/hw/sd/sdmmc-internal.h
> index 0e96cb0081..bf6fb06128 100644
> --- a/hw/sd/sdmmc-internal.h
> +++ b/hw/sd/sdmmc-internal.h
> @@ -12,4 +12,24 @@
>
>  #define SDMMC_CMD_MAX 64
>
> +/**
> + * sd_cmd_name:
> + * @cmd: A SD "normal" command, upto SDMMC_CMD_MAX.
> + *
> + * Returns an human useful name describing the command.
> + *
> + * Returns: The command name of @cmd or "UNKNOWN_CMD".
> + */
> +const char *sd_cmd_name(uint8_t cmd);
> +
> +/**
> + * sd_acmd_name:
> + * @cmd: A SD "Application-Specific" command, upto SDMMC_CMD_MAX.
> + *
> + * Returns an human useful name describing the application command.
> + *
> + * Returns: The application command name of @cmd or "UNKNOWN_ACMD".
> + */
> +const char *sd_acmd_name(uint8_t cmd);
> +

"up to", and "a human-readable name". Otherwise:

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
