Received: from eggs.gnu.org ([2001:4830:134:3::10]:54371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1fYOk8-00081S-89
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 00:41:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1fYOk3-0003mq-Bd
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 00:41:16 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:44323)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <groeck7@gmail.com>) id 1fYOk3-0003mU-4J
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 00:41:11 -0400
Received: by mail-pg0-x242.google.com with SMTP id b10-v6so1894884pgq.11
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 21:41:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
References: <20180627185248.GA19743@roeck-us.net>
	<96809884-2f46-ed63-48fd-9fd4c5050e20@amsat.org>
	<20180627205915.GA22693@roeck-us.net>
	<20180627224718.ewamlt42kvyirhjw@toto>
	<ae120580-01f2-672d-edc0-440c2dd3f248@roeck-us.net>
	<20180628041217.qxlspqzqfm4gszxd@toto>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <4193ce56-e3f8-d3f7-52a1-170f2d9185bb@roeck-us.net>
Date: Wed, 27 Jun 2018 21:41:07 -0700
MIME-Version: 1.0
In-Reply-To: <20180628041217.qxlspqzqfm4gszxd@toto>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Linux kernel configurations for various Microblaze
 systems
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Michal Simek <monstr@monstr.eu>, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, Alistair Francis <alistair@alistair23.me>, KONRAD Frederic <frederic.konrad@adacore.com>

On 06/27/2018 09:12 PM, Edgar E. Iglesias wrote:
> On Wed, Jun 27, 2018 at 05:34:15PM -0700, Guenter Roeck wrote:
>> Hi Edgar,
>>
>> On 06/27/2018 03:47 PM, Edgar E. Iglesias wrote:
>>
>>>
>>> Hi Guenter,
>>>
>>> Re: ml605
>>> The thing to watch out for with kernel configs for microblaze systems is the
>>> physmem address setting. Unfortunately the kernel does not auto-detect this.
>>>
>>> I'm attaching a kernelconfig for the ml605 that works for me and a qemu commandline.
>>>
>>> qemu-system-microblazeel -M petalogix-ml605 -m 256 -serial mon:stdio -dtb petalogix-ml605.dtb -kernel arch/microblaze/boot/linux.bin -append rdinit=/bin/sh
>>>
>>
>> Can you also send me the dtb file or even better its source ? I don't think
>> the one in qemu is correct. It lists the serial port at 0x83e00000, but qemu
>> instantiates it at 0x83e01000.
> 
> I used the one from QEMU. IIRC, there's some offsetting going on there
> that differs between the Xilinx version and the PC version of these
> UARTs...

Yes, I noticed after I sent the previous e-mail.

> 
> Can you try again and see how it goes?
> If it doesn't work, I can share my kernel Image and we can compare from there.
> 

I tried lots of things, nothing worked. Until I got your e-mail, tried again,
and suddenly it works just great. Go figure. Turns out I had used a big endian
toolchain to build a little endian target. Shameface.

I do get this odd gcc warning:

cc1: warning: -mxl-multiply-high can be used only with -mcpu=v6.00.a or greater

Actual parameters are "-mcpu=v10.0 -mxl-multiply-high", so that doesn't really make
sense to me. I tried various toolchains, all with the same result. Any idea what
that is about ?

Thanks,
Guenter
