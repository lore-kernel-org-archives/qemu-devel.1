Received: from eggs.gnu.org ([2001:4830:134:3::10]:58586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eR4YD-0000me-R3
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 18:10:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eR4YD-0001Vn-10
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 18:10:25 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171215031547.31006-1-f4bug@amsat.org>
	<20171215031547.31006-17-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ee9ec12e-b559-a059-e0ab-3db30be4b1c6@amsat.org>
Date: Mon, 18 Dec 2017 20:10:13 -0300
MIME-Version: 1.0
In-Reply-To: <20171215031547.31006-17-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 16/20] sdhci: add qtest to check the SD
 Spec version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Michael Walle <michael@walle.cc>, Andrzej Zaborowski <balrogg@gmail.com>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Andrey Yurovsky <yurovsky@gmail.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Prasad J Pandit <pjp@fedoraproject.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Sai Pavan Boddu <saipava@xilinx.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 12/15/2017 12:15 AM, Philippe Mathieu-Daudé wrote:
> +static const struct sdhci_t {
> +    const char *arch;
> +    const char *machine;
> +    struct {
> +        uintptr_t addr;
> +        uint8_t version;
> +    } sdhci;
> +} models[] = {
> +    { "arm",    "smdkc210",
> +        {0x12510000, 2} },
> +    { "arm",    "sabrelite",
> +        {0x02190000, 3} },
> +    { "arm",    "raspi2",           /* bcm2835 */
> +        {0x3f300000, 3} },
> +    { "arm",    "xilinx-zynq-a9",   /* exynos4210 */

Just noticed this comment is for the smdkc210 above,
I'll fix in respin.

> +        {0xe0100000, 3} },
> +};
