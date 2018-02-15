Received: from eggs.gnu.org ([2001:4830:134:3::10]:38712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1emSIo-00060i-W4
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:46:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1emSIo-0000no-1F
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:46:55 -0500
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:44271)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1emSIn-0000n8-PC
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:46:53 -0500
Received: by mail-lf0-x244.google.com with SMTP id c188so1701549lfc.11
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 14:46:53 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20180213040809.26021-31-f4bug@amsat.org>
References: <20180213040809.26021-1-f4bug@amsat.org>
	<20180213040809.26021-31-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 15 Feb 2018 14:46:21 -0800
Message-ID: <CAKmqyKOBnxxjVTxfx3fJoQGJv42Aw7fYfJJHEw2wOpW8ToYNkA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v13 30/30] sdhci: add Spec v4.2 register
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>

On Mon, Feb 12, 2018 at 8:08 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  hw/sd/sdhci-internal.h |  9 +++++++++
>  hw/sd/sdhci.c          | 14 ++++++++++++++
>  2 files changed, 23 insertions(+)
>
> diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
> index 0092627076..e1bb733aed 100644
> --- a/hw/sd/sdhci-internal.h
> +++ b/hw/sd/sdhci-internal.h
> @@ -198,6 +198,10 @@ FIELD(SDHC_HOSTCTL2, V18_ENA,          3, 1); /* UHS=
-I only */
>  FIELD(SDHC_HOSTCTL2, DRIVER_STRENGTH,  4, 2); /* UHS-I only */
>  FIELD(SDHC_HOSTCTL2, EXECUTE_TUNING,   6, 1); /* UHS-I only */
>  FIELD(SDHC_HOSTCTL2, SAMPLING_CLKSEL,  7, 1); /* UHS-I only */
> +FIELD(SDHC_HOSTCTL2, UHS_II_ENA,       8, 1); /* since v4 */
> +FIELD(SDHC_HOSTCTL2, ADMA2_LENGTH,    10, 1); /* since v4 */
> +FIELD(SDHC_HOSTCTL2, CMD23_ENA,       11, 1); /* since v4 */
> +FIELD(SDHC_HOSTCTL2, VERSION4,        12, 1); /* since v4 */
>  FIELD(SDHC_HOSTCTL2, ASYNC_INT,       14, 1);
>  FIELD(SDHC_HOSTCTL2, PRESET_ENA,      15, 1);
>
> @@ -216,10 +220,12 @@ FIELD(SDHC_CAPAB, SUSPRESUME,         23, 1);
>  FIELD(SDHC_CAPAB, V33,                24, 1);
>  FIELD(SDHC_CAPAB, V30,                25, 1);
>  FIELD(SDHC_CAPAB, V18,                26, 1);
> +FIELD(SDHC_CAPAB, BUS64BIT_V4,        27, 1); /* since v4.10 */
>  FIELD(SDHC_CAPAB, BUS64BIT,           28, 1); /* since v2 */
>  FIELD(SDHC_CAPAB, ASYNC_INT,          29, 1); /* since v3 */
>  FIELD(SDHC_CAPAB, SLOT_TYPE,          30, 2); /* since v3 */
>  FIELD(SDHC_CAPAB, BUS_SPEED,          32, 3); /* since v3 */
> +FIELD(SDHC_CAPAB, UHS_II,             35, 8); /* since v4.20 */
>  FIELD(SDHC_CAPAB, DRIVER_STRENGTH,    36, 3); /* since v3 */
>  FIELD(SDHC_CAPAB, DRIVER_TYPE_A,      36, 1); /* since v3 */
>  FIELD(SDHC_CAPAB, DRIVER_TYPE_C,      37, 1); /* since v3 */
> @@ -228,12 +234,15 @@ FIELD(SDHC_CAPAB, TIMER_RETUNING,     40, 4); /* si=
nce v3 */
>  FIELD(SDHC_CAPAB, SDR50_TUNING,       45, 1); /* since v3 */
>  FIELD(SDHC_CAPAB, RETUNING_MODE,      46, 2); /* since v3 */
>  FIELD(SDHC_CAPAB, CLOCK_MULT,         48, 8); /* since v3 */
> +FIELD(SDHC_CAPAB, ADMA3,              59, 1); /* since v4.20 */
> +FIELD(SDHC_CAPAB, V18_VDD2,           60, 1); /* since v4.20 */
>
>  /* HWInit Maximum Current Capabilities Register 0x0 */
>  #define SDHC_MAXCURR                   0x48
>  FIELD(SDHC_MAXCURR, V33_VDD1,          0, 8);
>  FIELD(SDHC_MAXCURR, V30_VDD1,          8, 8);
>  FIELD(SDHC_MAXCURR, V18_VDD1,         16, 8);
> +FIELD(SDHC_MAXCURR, V18_VDD2,         32, 8); /* since v4.20 */
>
>  /* W Force Event Auto CMD12 Error Interrupt Register 0x0000 */
>  #define SDHC_FEAER                     0x50
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index 0cd968fc6b..74b1802503 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -91,6 +91,20 @@ static void sdhci_check_capareg(SDHCIState *s, Error *=
*errp)
>      bool unit_mhz;
>
>      switch (s->sd_spec_version) {
> +    case 4:
> +        val =3D FIELD_EX64(s->capareg, SDHC_CAPAB, BUS64BIT_V4);
> +        msk =3D FIELD_DP64(msk, SDHC_CAPAB, BUS64BIT_V4, 0);
> +        trace_sdhci_capareg("64-bit system bus (v4)", val);
> +
> +        val =3D FIELD_EX64(s->capareg, SDHC_CAPAB, UHS_II);
> +        msk =3D FIELD_DP64(msk, SDHC_CAPAB, UHS_II, 0);
> +        trace_sdhci_capareg("UHS-II", val);
> +
> +        val =3D FIELD_EX64(s->capareg, SDHC_CAPAB, ADMA3);
> +        msk =3D FIELD_DP64(msk, SDHC_CAPAB, ADMA3, 0);
> +        trace_sdhci_capareg("ADMA3", val);
> +
> +    /* fallback */
>      case 3:
>          val =3D FIELD_EX64(s->capareg, SDHC_CAPAB, ASYNC_INT);
>          trace_sdhci_capareg("async interrupt", val);
> --
> 2.16.1
>
>
