Received: from eggs.gnu.org ([2001:4830:134:3::10]:47628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linux@roeck-us.net>) id 1faQMx-00040r-Ee
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 14:49:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linux@roeck-us.net>) id 1faQMw-0004ij-G1
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 14:49:43 -0400
Date: Tue, 3 Jul 2018 11:49:22 -0700
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <20180703184922.GA14422@roeck-us.net>
References: <20180626200008.GA680@roeck-us.net>
	<CAFEAcA_non89OR_-W3Fhr6gG0v0kkgg-ffJx-9K_h=U-Hz_wbg@mail.gmail.com>
	<20180702162733.GB32333@roeck-us.net>
	<CAFEAcA8+ZxcRLBgonZaqpAfumKFvhk7yDhX=Fe0KjoeTxWsczg@mail.gmail.com>
	<20180702170522.GA9885@roeck-us.net>
	<CAFEAcA97xX72WabGwn7GAQJxMcpzYzyV9yDBg1qF0zLuSDZwSA@mail.gmail.com>
	<20180702175740.GA14904@roeck-us.net>
	<CAFEAcA8noUOGt_9LpfRTRX52n4Z66XzudYFfW=180c92vzPH-g@mail.gmail.com>
	<20180702183717.GA22482@roeck-us.net>
	<CAFEAcA_p8vOs_1_4sAf1SvvPb44z885doU0821eh=-e0K5B3_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_p8vOs_1_4sAf1SvvPb44z885doU0821eh=-e0K5B3_A@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] hw/char/cmsdk-apb-timer: Correctly
 identify and set one-shot mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Tue, Jul 03, 2018 at 06:06:24PM +0100, Peter Maydell wrote:
> On 2 July 2018 at 19:37, Guenter Roeck <linux@roeck-us.net> wrote:
> > Please try http://server.roeck-us.net/qemu/an385/
> >
> > vmlinux is plain v4.18-rc3 compiled with the provided defconfig and
> > the provided toolchain (position independent, created with buildroot).
> > defconfig is mps2_defconfig+CONFIG_BLK_DEV_INITRD=y. Older kernels work
> > as well (I tested as far back as 4.9.y), with the same configuration.
> >
> > qemu is from the master-local branch in my repository, built with
> > https://github.com/groeck/linux-build-test/blob/master/qemu/buildall.sh.
> >
> > The boot wrapper was generated from
> > https://github.com/groeck/linux-build-test/tree/master/rootfs/arm/arm-m3-bootwrapper/.
> >
> > run.sh should boot the system into a shell (at least it does for me).
> 
> Thanks. Unfortunately I tried running that a bunch of times with a
> version of your QEMU with the 'set one-shot mode' patch reverted,
> and it still booted every time.
> 

Oddly enough, I now seem to be unable to reproduce the problem either.
Weird, when I wrote the patch it was absolutely necessary.

The only other change I can think of would be the code to set the
serial baud rate in the boot loader, which I did not have initially.
Is it possible that the hangup could have been caused by that ? 

Is it worth tracking it down, or are we ok ?

> However, I think I agree with you that it's better for the timer
> device to avoid doing things that result in the ptimer code emitting
> warnings rather than just dropping the ptimer warning, so I'm going
> to take this patch upstream.
> 
> I also sorted through some of the other corner case issues
> (eg restarting a stopped one-shot timer by writing to VALUE,
> and whether an interrupt should be generated if VALUE is
> written as zero). I'm going to send a patchset in a moment that
> includes this patch and those fixes. I've tested that set by
> applying it to your master-local/ branch and using your testcase
> here, as well as by using my buildroot/uclinux image on an
> upstream QEMU (and a few other RTOS images I had to hand).
> 

The series WFM as well. I'll send out a Tested-by: in a minute.

Thanks,
Guenter
