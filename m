Received: from eggs.gnu.org ([2001:4830:134:3::10]:41030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1d8TTi-0006Xg-7D
	for qemu-devel@nongnu.org; Wed, 10 May 2017 11:24:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1d8TTg-00028p-NJ
	for qemu-devel@nongnu.org; Wed, 10 May 2017 11:24:38 -0400
MIME-Version: 1.0
In-Reply-To: <031eab53-a6ec-2248-d4ea-b4352243baae@amsat.org>
References: <1494348286-10253-1-git-send-email-sundeep.lkml@gmail.com>
	<031eab53-a6ec-2248-d4ea-b4352243baae@amsat.org>
From: sundeep subbaraya <sundeep.lkml@gmail.com>
Date: Wed, 10 May 2017 20:54:35 +0530
Message-ID: <CALHRZur46TyuemoO8=fMc-DvAzayRjZuV1--AK5TvUmWy5snLw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [Qemu-devel PATCH 0/5] Add support for
 Smartfusion2 SoC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair23@gmail.com>

Hi Philippe,


On Wed, May 10, 2017 at 3:14 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg>
wrote:

> Hi Subbaraya,
>
> This is your v4 of this patch set, please don't forget to include the
> version in your next set.
>
> Please also include changes between versions in your cover letter, it
> eases the review.


Sure. Sorry since this is not RFC i did not include versions. I will add
versions from next iteration.

Thanks,
Sundeep

>
>
> On 05/09/2017 01:44 PM, Subbaraya Sundeep wrote:
>
>> Hi Qemu-devel,
>>
>> I am trying to add Smartfusion2 SoC.
>> SoC is from Microsemi and System on Module(SOM)
>> board is from Emcraft systems. Smartfusion2 has hardened
>> Microcontroller(Cortex-M3)based Sub System and FPGA fabric.
>> At the moment only system timer, sysreg and SPI
>> controller are modelled.
>>
>> Testing:
>> ./arm-softmmu/qemu-system-arm -M smartfusion2-som -serial mon:stdio \
>> -kernel u-boot.bin -display none -drive file=3Dspi.bin,if=3Dmtd,format=
=3Draw
>>
>> U-boot is from Emcraft with modified SPI driver not to use PDMA.
>> Linux is 4.5 linux with Smartfusion2 SoC dts and clocksource
>> driver added by myself @
>> https://github.com/Subbaraya-Sundeep/linux.git
>>
>> Baremetal elfs from Microsemi Softconsole IDE are also working.
>>
>> Thanks,
>> Sundeep
>>
>> Subbaraya Sundeep (5):
>>   msf2: Add Smartfusion2 System timer
>>   msf2: Microsemi Smartfusion2 System Register block.
>>   msf2: Add Smartfusion2 SPI controller
>>   msf2: Add Smartfusion2 SoC.
>>   msf2: Add Emcraft's Smartfusion2 SOM kit.
>>
>>  default-configs/arm-softmmu.mak |   1 +
>>  hw/arm/Makefile.objs            |   3 +-
>>  hw/arm/msf2-soc.c               | 188 ++++++++++++++++++++
>>  hw/arm/msf2-som.c               |  67 +++++++
>>  hw/misc/Makefile.objs           |   1 +
>>  hw/misc/msf2-sysreg.c           | 131 ++++++++++++++
>>  hw/ssi/Makefile.objs            |   1 +
>>  hw/ssi/msf2-spi.c               | 378 ++++++++++++++++++++++++++++++
>> ++++++++++
>>  hw/timer/Makefile.objs          |   1 +
>>  hw/timer/msf2-timer.c           | 252 +++++++++++++++++++++++++++
>>  include/hw/arm/msf2-soc.h       |  60 +++++++
>>  include/hw/misc/msf2-sysreg.h   |  80 +++++++++
>>  include/hw/ssi/msf2-spi.h       | 105 +++++++++++
>>  include/hw/timer/msf2-timer.h   |  85 +++++++++
>>  14 files changed, 1352 insertions(+), 1 deletion(-)
>>  create mode 100644 hw/arm/msf2-soc.c
>>  create mode 100644 hw/arm/msf2-som.c
>>  create mode 100644 hw/misc/msf2-sysreg.c
>>  create mode 100644 hw/ssi/msf2-spi.c
>>  create mode 100644 hw/timer/msf2-timer.c
>>  create mode 100644 include/hw/arm/msf2-soc.h
>>  create mode 100644 include/hw/misc/msf2-sysreg.h
>>  create mode 100644 include/hw/ssi/msf2-spi.h
>>  create mode 100644 include/hw/timer/msf2-timer.h
>>
>>
