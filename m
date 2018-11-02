Received: from eggs.gnu.org ([2001:4830:134:3::10]:36211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1gIPZj-0003ha-FH
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 22:52:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1gIPZh-0004Vg-HW
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 22:52:42 -0400
Sender: Guenter Roeck <groeck7@gmail.com>
References: <20181102001303.32640-1-f4bug@amsat.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <b32bf2a0-08ac-6b16-6372-455f9a239f9f@roeck-us.net>
Date: Thu, 1 Nov 2018 19:52:25 -0700
MIME-Version: 1.0
In-Reply-To: <20181102001303.32640-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for 3.2 v2 0/7] hw/arm/bcm2835: Add basic
 support for cprman (clock subsystem)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org

On 11/1/18 5:12 PM, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> This series is a mix of a previous work I had for the raspi, and a patch from
> Guenter: https://lists.gnu.org/archive/html/qemu-devel/2018-07/msg03153.html
> 
> The final patch keep Guenter ideas and comments, but is mostly a rewrite.
> I dropped the A2W code from this work, it doesn't seems unuseful to me.
> 
> Guenter can you test this series?
> 

arm/raspi2 works, but aarch64/raspi3 stalls.

[   45.683302] Run /sbin/init as init process
[   50.745961] random: dd: uninitialized urandom read (512 bytes read)
[   77.478266] Writes:  Total: 2074828  Max/Min: 0/0   Fail: 0

... then nothing else until I abort the session.

This is with the series applied on top of master.

Guenter

> I kept Guenter S-o-b and (C), is that OK? (Guenter?, Peter?)
> 
> - patches 1, 7: obvious updates in MAINTAINERS
> - patches 3, 4: simple cleanups
> - patches 2, 5: add UNIMP code
> - patch 6: add the cprman (KISS init values from Guenter)
> 
> Peter: can you take patch #1 for 3.1?
> 
> Regards,
> 
> Phil.
> 
> Philippe Mathieu-Daudé (7):
>    MAINTAINERS: Add an entry for the Raspberry Pi machines
>    hw/misc/bcm2835_property: Handle the 'domain state' property
>    hw/arm/bcm2835: Use 0x prefix for hex numbers
>    hw/arm/bcm2835: Rename some definitions
>    hw/arm/bcm2835: Add various unimplemented peripherals
>    hw/arm/bcm2835: Add basic support for cprman (clock subsystem)
>    MAINTAINERS: Volunteer to review Raspi patches
> 
>   MAINTAINERS                          |   7 +
>   hw/arm/bcm2835_peripherals.c         |  42 +++-
>   hw/char/bcm2835_aux.c                |   2 +-
>   hw/intc/bcm2836_control.c            |   4 +-
>   hw/misc/Makefile.objs                |   1 +
>   hw/misc/bcm2835_cprman.c             | 277 +++++++++++++++++++++++++++
>   hw/misc/bcm2835_property.c           |   8 +-
>   hw/misc/trace-events                 |   8 +
>   include/hw/arm/bcm2835_peripherals.h |  11 ++
>   include/hw/arm/raspi_platform.h      |   6 +-
>   include/hw/misc/bcm2835_cprman.h     |  28 +++
>   11 files changed, 387 insertions(+), 7 deletions(-)
>   create mode 100644 hw/misc/bcm2835_cprman.c
>   create mode 100644 include/hw/misc/bcm2835_cprman.h
> 
