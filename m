Received: from eggs.gnu.org ([2001:4830:134:3::10]:36186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1ff4Fv-0000Eg-VC
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 10:13:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1ff4Fr-0002V4-0G
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 10:13:39 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:39934)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <groeck7@gmail.com>) id 1ff4Fq-0002Ue-P9
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 10:13:34 -0400
Received: by mail-pf0-x242.google.com with SMTP id j8-v6so1716434pff.6
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 07:13:34 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
References: <1529355846-25102-1-git-send-email-linux@roeck-us.net>
	<CAFEAcA9fvZbZGjm8Z5nJKi37J7Qma+bSFd0mRQ7tZ1X2NDRqQg@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <050c8913-5fb3-6044-c145-f83b1c02a6b7@roeck-us.net>
Date: Mon, 16 Jul 2018 07:13:32 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9fvZbZGjm8Z5nJKi37J7Qma+bSFd0mRQ7tZ1X2NDRqQg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] bcm2835_aux: Swap RX and TX interrupt
 assignments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 07/16/2018 06:48 AM, Peter Maydell wrote:
> On 18 June 2018 at 22:04, Guenter Roeck <linux@roeck-us.net> wrote:
>> RX and TX interrupt bits were reversed, resulting in an endless sequence
>> of serial interupts in the emulated system and the following repeated
>> error message when booting Linux.
>>
>> serial8250: too much work for irq61
>>
>> This results in a boot failure most of the time.
>>
>> Qemu command line used to reproduce the problem:
>>
>>          qemu-system-aarch64 -M raspi3 -m 1024 \
>>          -kernel arch/arm64/boot/Image \
>>          --append "rdinit=/sbin/init console=ttyS1,115200"
>>          -initrd rootfs.cpio \
>>          -dtb arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dtb \
>>          -nographic -monitor null -serial null -serial stdio
>>
>> This is with arm64:defconfig. The root file system was generated using
>> buildroot.
> 
> Worth mentioning in the commit message that there is an
> error in the BCM2835 datasheet for the TX_INT and RX_INT
> bits in the AUX_MU_IER_REG description (as per
> https://elinux.org/BCM2835_datasheet_errata)
> 

I didn't know that ;-). I found out the hard way.

Guenter
