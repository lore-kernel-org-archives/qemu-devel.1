Received: from eggs.gnu.org ([2001:4830:134:3::10]:49180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1egvEP-0006iX-8g
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 11:27:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1egvEN-00056q-Sg
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 11:27:29 -0500
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:39541)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1egvEN-00056Y-Gm
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 11:27:27 -0500
Received: by mail-lf0-x244.google.com with SMTP id w27so21622233lfd.6
	for <qemu-devel@nongnu.org>; Wed, 31 Jan 2018 08:27:27 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <0090cd85-3277-3c8c-5399-0681bbe2ab86@amsat.org>
References: <20180123020820.1288-1-f4bug@amsat.org>
	<0090cd85-3277-3c8c-5399-0681bbe2ab86@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 31 Jan 2018 08:26:55 -0800
Message-ID: <CAKmqyKMA9RteZfQruGj9zhtOe_Sm4XnL7U-CtkXW4Pjd7pRVRQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v9 00/16] SDHCI: clean v1/v2 Specs (part 2)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Krzysztof Kozlowski <krzk@kernel.org>, Kevin O'Connor <kevin@koconnor.net>, Marcel Apfelbaum <marcel@redhat.com>

On Wed, Jan 31, 2018 at 6:09 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> ping?
>
> Patches missing review: 2 (PCI qtesting),11,13,15

Sorry about the slowness. Besides 2 they should be all reviewed now,
let me know if anything else needs to be done.

As for 2 I don't have much experience with Qtest, I'll try to go over
it, but ideally someone who knows Qtest should look at it.

Thanks,
Alistair

>
> On 01/22/2018 11:08 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> Since v8:
>> - we keep the 'capareg' property, this simplify a lot the series
>> - the Zynq 7000 uses the datasheet CAPAREG
>> - reset R-b/A-b
>>
>> Since v7:
>> - use error_propagate()
>>
>> Since v6:
>> - rebased on upstream to use DEFINE_SDHCI_COMMON_PROPERTIES
>> - included qtests back
>> - add PCI qtests
>> - series was getting big, splitting again; next one is "implement Spec v=
3"
>> - following Alistair advice, new properties default to current
>>   SDHC_CAPAB_REG_DEFAULT (probably 'default' for historical reason, bein=
g
>>   the first capabilities set). This leads to weird properties imho, i.e.
>>   defaulting 'max-frequency' to 52 MHz, the Exynos SoC has to set this
>>   property to 0.
>> - addressed Alistair reviews
>> - confirmed the Exynos4210 specs after chatting on IRC with Krzysztof
>>   Kozlowski who kindly verified in the datasheet.
>>
>> Since v5:
>> - addressed Alistair reviews
>> - dropped "abstract generic-sdhci"
>> - dropped Linux Device Tree names
>> - split qtests in another series
>> - change the bcm2835 minimum blocksize to 1KB (Andrew Baumann)
>> - added Alistair R-b
>> - based on Alistair work:
>>   - add SD tunning sequence via Host Control 2 to use UHS-I cards
>>   - add CMD/DAT[] fields in the Present State (used in next series
>>     to switch card voltage)
>>
>> based on Alistair work:
>> - add SD tunning sequence via Host Control 2 to use UHS-I cards
>> - add CMD/DAT[] fields in the Present State (used in next series
>>   to switch card voltage)
>>
>> Since v4 ("SDHCI: add qtests and fix few issues"):
>> - spec_version default to v2 (current behaviour)
>> - addressed Alistair review (no v1, tell user about valid version)
>>
>> Since v3:
>> - no change, but split back in 2 series, 1st part is "SDHCI: housekeepin=
g v5",
>>
>> Since v2:
>> - more detailed 'capabilities', all boards converted to use these proper=
ties
>> - since all qtests pass, removed the previous 'capareg' property
>> - added Stefan/Alistair R-b
>> - corrected 'access' LED behavior (Alistair's review)
>> - more uses of the registerfields API
>> - remove some dead code
>> - cosmetix:
>>   - added more comments
>>   - renamed a pair of registers
>>   - reordered few struct members
>>
>> Since v1:
>> - addressed Alistair Francis review comments, added some R-b
>> - only move register defines to "sd-internal.h"
>> - fixed deposit64() arguments
>> - dropped unuseful s->fifo_buffer =3D NULL
>> - use a qemu_irq for the LED, restrict the logging to ON/OFF
>> - fixed a trace format string error
>> - included Andrey Smirnov ACMD12ERRSTS write patch
>> - dropped few unuseful patches, and separate the Python polemical ones f=
or later
>>
>> From the "SDHCI housekeeping" series:
>> - 1: we restrict part of "sd/sd.h" into local "sd-internal.h",
>> - 2,3: we somehow beautiful the code, no logical changes,
>> - 4-7: we refactor the common sysbus/pci qdev code,
>> - 8-10: we add plenty of trace events which will result useful later,
>> - 11: we finally expose a "dma-memory" property.
>> From the "SDHCI: add a qtest and fix few issues" series:
>> - 12,13: fix registers
>> - 14,15: boards can specify which SDHCI Spec to use (v2 and v3 so far)
>> - 15-20: HCI qtest
>>
>> Regards,
>>
>> Phil.
>>
>> $ git backport-diff with v8
>> 001/16:[----] [--] 'sdhci: use error_propagate(local_err) in realize()'
>> 002/16:[0004] [FC] 'sdhci: add qtest to check the SD capabilities regist=
er'
>> 003/16:[----] [--] 'sdhci: add check_capab_readonly() qtest'
>> 004/16:[----] [--] 'sdhci: add a check_capab_baseclock() qtest'
>> 005/16:[----] [--] 'sdhci: add a check_capab_sdma() qtest'
>> 006/16:[----] [--] 'sdhci: add qtest to check the SD Spec version'
>> 007/16:[0022] [FC] 'sdhci: add a 'spec_version property' (default to v2)=
'
>> 008/16:[down] 'sdhci: use a numeric value for the default CAPAB register=
'
>> 009/16:[down] 'sdhci: simplify sdhci_get_fifolen()'
>> 010/16:[down] 'sdhci: check the Spec v1 capabilities correctness'
>> 011/16:[----] [--] 'sdhci: add BLOCK_SIZE_MASK for DMA'
>> 012/16:[----] [--] 'sdhci: Fix 64-bit ADMA2'
>> 013/16:[down] 'sdhci: check Spec v2 capabilities (DMA and 64-bit bus)'
>> 014/16:[down] 'hw/arm/exynos4210: access the 64-bit capareg with qdev_pr=
op_set_uint64()'
>> 015/16:[down] 'hw/arm/exynos4210: add a comment about a very similar SDH=
CI (Spec. v2)'
>> 016/16:[down] 'hw/arm/xilinx_zynq: fix the capabilities register to matc=
h the datasheet'
>>
>> Philippe Mathieu-Daud=C3=A9 (15):
>>   sdhci: use error_propagate(local_err) in realize()
>>   sdhci: add qtest to check the SD capabilities register
>>   sdhci: add check_capab_readonly() qtest
>>   sdhci: add a check_capab_baseclock() qtest
>>   sdhci: add a check_capab_sdma() qtest
>>   sdhci: add qtest to check the SD Spec version
>>   sdhci: add a 'spec_version property' (default to v2)
>>   sdhci: use a numeric value for the default CAPAB register
>>   sdhci: simplify sdhci_get_fifolen()
>>   sdhci: check the Spec v1 capabilities correctness
>>   sdhci: add BLOCK_SIZE_MASK for DMA
>>   sdhci: check Spec v2 capabilities (DMA and 64-bit bus)
>>   hw/arm/exynos4210: access the 64-bit capareg with qdev_prop_set_uint64=
()
>>   hw/arm/exynos4210: add a comment about a very similar SDHCI (Spec. v2)
>>   hw/arm/xilinx_zynq: fix the capabilities register to match the datashe=
et
>>
>> Sai Pavan Boddu (1):
>>   sdhci: Fix 64-bit ADMA2
>>
>>  include/hw/sd/sdhci.h  |   2 +
>>  hw/sd/sdhci-internal.h |  43 ++++++---
>>  hw/arm/exynos4210.c    |  14 ++-
>>  hw/arm/xilinx_zynq.c   |  53 +++++-----
>>  hw/sd/sdhci.c          | 257 ++++++++++++++++++++++++++++++++----------=
-------
>>  tests/sdhci-test.c     | 216 +++++++++++++++++++++++++++++++++++++++++
>>  hw/sd/trace-events     |   1 +
>>  tests/Makefile.include |   3 +
>>  8 files changed, 464 insertions(+), 125 deletions(-)
>>  create mode 100644 tests/sdhci-test.c
>>
>
