Received: from eggs.gnu.org ([2001:4830:134:3::10]:38548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ea2zf-0001R9-0f
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 12:19:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ea2ze-0002zR-2i
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 12:19:51 -0500
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242]:44825)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ea2zd-0002zE-RU
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 12:19:50 -0500
Received: by mail-io0-x242.google.com with SMTP id k18so6579977ioc.11
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 09:19:49 -0800 (PST)
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <CAFEAcA98b9NBUvGHsSDB3NfNVsjB6maa0j=7oF0a9csAZr_jFQ@mail.gmail.com>
References: <20180111193021.17466-1-f4bug@amsat.org>
	<20180111193021.17466-14-f4bug@amsat.org>
	<CAFEAcA98b9NBUvGHsSDB3NfNVsjB6maa0j=7oF0a9csAZr_jFQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 12 Jan 2018 14:19:48 -0300
Message-ID: <CAAdtpL7YTZ2T4CYjnfWh6XFP5YjXrcb66R4rxWh4CoHKVbwPTg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 13/13] sdhci: add a "dma" property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>

On Fri, Jan 12, 2018 at 2:03 PM, Peter Maydell <peter.maydell@linaro.org> w=
rote:
> On 11 January 2018 at 19:30, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
>> Add a dma property allowing machine creation to provide the address-spac=
e
>> sdhci dma operates on.
>>
>> [based on a patch from Alistair Francis <alistair.francis@xilinx.com>
>>  from qemu/xilinx tag xilinx-v2016.1]
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
>> ---
>>  include/hw/sd/sdhci.h |  2 ++
>>  hw/sd/sdhci.c         | 36 +++++++++++++++++++++++-------------
>>  2 files changed, 25 insertions(+), 13 deletions(-)
>
> This looks OK for the sysbus sdhci controller, but not for the
> PCI one:
>  (1) the link property is meaningless for PCI, and we shouldn't
>      expose a meaningless thing to the end user
>  (2) the PCI device should surely be doing its DMA via the AS
>      returned by pci_get_address_space() ?  (compare pci_dma_read &c
>      in include/hw/pci/pci.h)
>
> 2 is a bugfix to the existing code, of course, but if we're
> going to tidy this up then the right answer to 2 may affect
> how you want to handle 1.

Ok. I'll respin, thanks for your review :)
