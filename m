Received: from eggs.gnu.org ([2001:4830:134:3::10]:50057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fYOIE-0002zt-Lk
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 00:12:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fYOI9-0001Co-Lo
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 00:12:26 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:41035)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fYOI9-0001Ag-D1
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 00:12:21 -0400
Received: by mail-lj1-x241.google.com with SMTP id a17-v6so197426ljd.8
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 21:12:21 -0700 (PDT)
Date: Thu, 28 Jun 2018 06:12:18 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <20180628041217.qxlspqzqfm4gszxd@toto>
References: <20180627185248.GA19743@roeck-us.net>
	<96809884-2f46-ed63-48fd-9fd4c5050e20@amsat.org>
	<20180627205915.GA22693@roeck-us.net>
	<20180627224718.ewamlt42kvyirhjw@toto>
	<ae120580-01f2-672d-edc0-440c2dd3f248@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae120580-01f2-672d-edc0-440c2dd3f248@roeck-us.net>
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
To: Guenter Roeck <linux@roeck-us.net>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Michal Simek <monstr@monstr.eu>, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, Alistair Francis <alistair@alistair23.me>, KONRAD Frederic <frederic.konrad@adacore.com>

On Wed, Jun 27, 2018 at 05:34:15PM -0700, Guenter Roeck wrote:
> Hi Edgar,
> 
> On 06/27/2018 03:47 PM, Edgar E. Iglesias wrote:
> 
> > 
> > Hi Guenter,
> > 
> > Re: ml605
> > The thing to watch out for with kernel configs for microblaze systems is the
> > physmem address setting. Unfortunately the kernel does not auto-detect this.
> > 
> > I'm attaching a kernelconfig for the ml605 that works for me and a qemu commandline.
> > 
> > qemu-system-microblazeel -M petalogix-ml605 -m 256 -serial mon:stdio -dtb petalogix-ml605.dtb -kernel arch/microblaze/boot/linux.bin -append rdinit=/bin/sh
> > 
> 
> Can you also send me the dtb file or even better its source ? I don't think
> the one in qemu is correct. It lists the serial port at 0x83e00000, but qemu
> instantiates it at 0x83e01000.

I used the one from QEMU. IIRC, there's some offsetting going on there
that differs between the Xilinx version and the PC version of these
UARTs...

Can you try again and see how it goes?
If it doesn't work, I can share my kernel Image and we can compare from there.

Cheers,
Edgar

> 
> > Re: pmu
> > The PMU board does not run Linux, it runs baremetal power-management related firmware.
> > 
> 
> Ah, good to know.
> 
> Thanks!
> Guenter
> 
