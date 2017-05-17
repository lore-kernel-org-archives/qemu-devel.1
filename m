Received: from eggs.gnu.org ([2001:4830:134:3::10]:40851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dB4FC-0008EA-I7
	for qemu-devel@nongnu.org; Wed, 17 May 2017 15:04:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dB4FB-0005ui-Hs
	for qemu-devel@nongnu.org; Wed, 17 May 2017 15:04:22 -0400
References: <684185116.2952708.1495044580181.ref@mail.yahoo.com>
	<684185116.2952708.1495044580181@mail.yahoo.com>
	<3293e70a-71ac-2e6d-433f-06346ad253c9@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <e3ea0ce5-5977-b6c7-ace4-ea5f1caa540f@redhat.com>
Date: Wed, 17 May 2017 15:04:13 -0400
MIME-Version: 1.0
In-Reply-To: <3293e70a-71ac-2e6d-433f-06346ad253c9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Add Markus Armbrusters code for Broadcom
 Perhiperals for ARM.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, John Bradley <flypie1@yahoo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Geert Martin Ijewski <gm.ijewski@web.de>, John Bradley <flypie@rocketmail.com>, Markus Armbruster <armbru@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>



On 05/17/2017 02:27 PM, Eric Blake wrote:
> On 05/17/2017 01:09 PM, John Bradley via Qemu-devel wrote:
>> Also available at 
>>
>> https://www.dropbox.com/s/gwuquw0kirstw7a/0001-Add-Markus-Armbrusters-code-for-Broadcom-Perhiperals.patch?dl=0
> 
> This content belongs...
> 
>>
>> Following suggestions split my original patch up. This the largest monolithic chunk is 
>> additional BCM device support from Markus Armbruster.
>>
>>
>> >From 0b39a04030d5a2cea4fcd2159d365580ca155b78 Mon Sep 17 00:00:00 2001
>> From: John Bradley <flypie@rocketmail.com>
>> Date: Wed, 17 May 2017 18:57:21 +0100
>> Subject: [PATCH] Add Markus Armbrusters code for Broadcom Perhiperals for ARM.

Also, though your patch body says `Subject: [PATCH]`, your actual email
subject does not. It should so that the build bot and maintenance tools
can find it appropriately.

The next version of this that gets sent should also carry the 'v2' tag.

--js

>>
>> Signed-off-by: John Bradley <flypie@rocketmail.com>
> 
> I would expect that if some of this code was written by Markus, then it
> would carry his Signed-off-by.  Or, maybe you just mean that you are
> splitting your patch according to the device Markus gave (in which case,
> a Suggested-by: tag may be appropriate).  Either way, I don't see why
> Markus' name has to be in the subject line (the patch subject should be
> WHAT changed, not WHO suggested the change).
> 
>> ---
> 
> ...here, after the --- separator.  It is useful to reviewers, but should
> not end up as part of the actual commit message.
> 
>> hw/arm/Makefile.objs                 |    2 +-
>> hw/arm/bcm2835.c                     |  114 ++++
>> hw/arm/bcm2835_peripherals.c         |  104 ++++
>> hw/misc/Makefile.objs                |    2 +
>> hw/misc/bcm2835_mphi.c               |  163 ++++++
>> hw/misc/bcm2835_power.c              |  106 ++++
>> hw/timer/Makefile.objs               |    2 +
>> hw/timer/bcm2835_st.c                |  202 +++++++
>> hw/timer/bcm2835_timer.c             |  224 +++++++
>> hw/usb/Makefile.objs                 |    4 +-
>> hw/usb/bcm2835_usb.c                 |  604 +++++++++++++++++++
>> hw/usb/bcm2835_usb_regs.h            | 1061 ++++++++++++++++++++++++++++++++++
> 
> That's still rather large to review in one chunk, especially while
> touching other files.   It can probably still be split up further.
> 
>> include/hw/arm/bcm2835.h             |   37 ++
>> include/hw/arm/bcm2835_peripherals.h |   10 +
>> include/hw/intc/bcm2835_control.h    |   53 ++
>> include/hw/misc/bcm2835_mphi.h       |   28 +
>> include/hw/misc/bcm2835_power.h      |   22 +
>> include/hw/timer/bcm2835_st.h        |   25 +
>> include/hw/timer/bcm2835_timer.h     |   32 +
>> include/hw/usb/bcm2835_usb.h         |   78 +++
>> 20 files changed, 2871 insertions(+), 2 deletions(-)
>> create mode 100644 hw/arm/bcm2835.c
>> create mode 100644 hw/misc/bcm2835_mphi.c
>> create mode 100644 hw/misc/bcm2835_power.c
>> create mode 100644 hw/timer/bcm2835_st.c
>> create mode 100644 hw/timer/bcm2835_timer.c
>> create mode 100644 hw/usb/bcm2835_usb.c
>> create mode 100644 hw/usb/bcm2835_usb_regs.h
>> create mode 100644 include/hw/arm/bcm2835.h
>> create mode 100644 include/hw/intc/bcm2835_control.h
>> create mode 100644 include/hw/misc/bcm2835_mphi.h
>> create mode 100644 include/hw/misc/bcm2835_power.h
>> create mode 100644 include/hw/timer/bcm2835_st.h
>> create mode 100644 include/hw/timer/bcm2835_timer.h
>> create mode 100644 include/hw/usb/bcm2835_usb.h
>>
> 
