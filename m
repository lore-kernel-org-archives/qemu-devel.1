Received: from eggs.gnu.org ([2001:4830:134:3::10]:40551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eaALc-00089d-Kr
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 20:11:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eaALb-0004CV-PA
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 20:11:00 -0500
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20180111205626.23291-18-f4bug@amsat.org>
References: <20180111205626.23291-1-f4bug@amsat.org>
	<20180111205626.23291-18-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 12 Jan 2018 17:10:28 -0800
Message-ID: <CAKmqyKP5DAuo8SHupP=_CAQoJ6kXzrAzJgiA6yhWCw40QX7WPg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 17/21] sdhci: add Spec v4.2 register
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
Cc: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Andrey Smirnov <andrew.smirnov@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, =?UTF-8?Q?Gr=C3=A9gory_Estrade?= <gregory.estrade@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Jean-Christophe Dubois <jcd@tribudubois.net>, Sai Pavan Boddu <saipava@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>, Clement Deschamps <clement.deschamps@antfield.fr>, Andrew Baumann <Andrew.Baumann@microsoft.com>

On Thu, Jan 11, 2018 at 12:56 PM, Philippe Mathieu-Daud=C3=A9
<f4bug@amsat.org> wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  hw/sd/sdhci-internal.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
> index ac4704eb61..b82e847636 100644
> --- a/hw/sd/sdhci-internal.h
> +++ b/hw/sd/sdhci-internal.h
> @@ -191,6 +191,10 @@ FIELD(SDHC_HOSTCTL2, V18_ENA,          3, 1); /* UHS=
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
> @@ -219,12 +223,16 @@ FIELD(SDHC_CAPAB, DRIVER_TYPE_C,      37, 1); /* si=
nce v3 */
>  FIELD(SDHC_CAPAB, DRIVER_TYPE_D,      38, 1); /* since v3 */
>  FIELD(SDHC_CAPAB, TIMER_RETUNNING,    40, 4); /* since v3 */
>  FIELD(SDHC_CAPAB, SDR50_TUNNING,      45, 1); /* since v3 */
> +FIELD(SDHC_CAPAB, CLK_MUL,            48, 8); /* since v4.20 */
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
> --
> 2.15.1
>
>
