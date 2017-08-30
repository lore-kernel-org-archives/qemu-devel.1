Received: from eggs.gnu.org ([2001:4830:134:3::10]:49945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dn4H2-0007H2-VS
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 10:47:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dn4H2-0008V2-7o
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 10:47:21 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1503938283-12404-1-git-send-email-sundeep.lkml@gmail.com>
	<1503938283-12404-5-git-send-email-sundeep.lkml@gmail.com>
	<10da5552-c90a-21e6-43ac-829932f64930@amsat.org>
	<CAFEAcA9W=YqbeYKuAxvfNyjfCWGyAXuPdxwFrpLmoezLJ4pm-A@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <40ca8d07-75e5-e0b3-021e-5abaffd16b78@amsat.org>
Date: Wed, 30 Aug 2017 11:47:07 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9W=YqbeYKuAxvfNyjfCWGyAXuPdxwFrpLmoezLJ4pm-A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu devel v7 PATCH 4/5] msf2: Add Smartfusion2
 SoC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Subbaraya Sundeep <sundeep.lkml@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alistair Francis <alistair23@gmail.com>

On 08/30/2017 09:26 AM, Peter Maydell wrote:
> On 30 August 2017 at 03:45, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> I think they might be issues if you start QEMU without -serial and then use
>> a firmware polling for an uart, the device won't be mapped and the memory
>> accesses are mostly ignored.
>>
>> I'd rather use:
>>
>>      for (i = 0; i < MSF2_NUM_UARTS && i < MAX_SERIAL_PORTS; i++) {
>>          static const char *serial[] = {"serial0", "serial1"};
>>
>>          if (!serial_hds[i]) {
>>              serial_hds[i] = qemu_chr_new(serial[i], "null");
>>
>>          }
>>
>>> +            serial_mm_init(get_system_memory(), uart_addr[i], 2,
>>> +                           qdev_get_gpio_in(armv7m, uart_irq[i]),
>>> +                           115200, serial_hds[i], DEVICE_NATIVE_ENDIAN);
>>> +        }
>>> +    }
> 
> It would be better to fix serial_mm_init() to handle having
> a NULL chardev pointer, because we already have a lot of
> SoC code that just passes it serial_hds[] regardless.

clever :)

> I'd leave this code as it is and we can fix serial_mm_init
> separately (somebody pointed out this issue for a xilinx
> board recently).

Sure.
