Received: from eggs.gnu.org ([2001:4830:134:3::10]:47910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1fiVVQ-0005Wl-Tc
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 21:55:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1fiVVO-00046K-06
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 21:55:52 -0400
MIME-Version: 1.0
Sender: joel.stan@gmail.com
In-Reply-To: <20180702122510.GB2155@stefanha-x1.localdomain>
References: <20180627143815.1829-1-joel@jms.id.au>
	<20180627143815.1829-2-joel@jms.id.au>
	<20180702122510.GB2155@stefanha-x1.localdomain>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 26 Jul 2018 11:25:28 +0930
Message-ID: <CACPK8Xc0-0pTtKdCdz1xNy4d5qgfuX2=vQrX_YGqJKh0vdLLfA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 1/3] arm: Add Nordic Semiconductor nRF51
 SoC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Jim Mussared <jim.mussared@gmail.com>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <contrib@steffen-goertz.de>, Julia Suvorova <jusual@mail.ru>

On 2 July 2018 at 21:55, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Thu, Jun 28, 2018 at 12:08:13AM +0930, Joel Stanley wrote:
>> +/* TODO: Flash size should be defined by the board. Microbit uses 256KB */
>> +#define FLASH_BASE      0x00000000
>> +#define FLASH_SIZE      (256 * 1024)
>> +
>> +/* TODO: Flash size should be defined by the board. Microbit uses 16KB */
>> +#define SRAM_BASE       0x20000000
>> +#define SRAM_SIZE       (16 * 1024)
>
> Making FLASH_SIZE and SRAM_SIZE properties of the NRF51State object.
> Then microbit.c can set them.

I chose not to do this, as they are properties of the SoC, not of the
microbit machine.

If in the future someone wanted to support more than the NRF51822,
they could make them properties and set them in a sub-class the NRF51.

I don't think this complexity is warranted while the only implemented
machine is the NRF51822.

>
>> +typedef struct NRF51State {
>> +    /*< private >*/
>> +    SysBusDevice parent_obj;
>> +
>> +    /*< public >*/
>> +    char *kernel_filename;
>
> Is this used by anything?

I removed it in v3.
