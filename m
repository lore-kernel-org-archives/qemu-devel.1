Received: from eggs.gnu.org ([209.51.188.92]:37763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1h1tUX-00078m-Gr
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 08:55:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1h1tUW-0001D7-4d
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 08:55:21 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:31510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1h1tUV-0001C0-P7
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 08:55:20 -0500
Date: Thu, 7 Mar 2019 14:55:17 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <201903070647.13740.randrianasulu@gmail.com>
Message-ID: <alpine.BSF.2.21.9999.1903071434410.53555@zero.eik.bme.hu>
References: <201903070647.13740.randrianasulu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v5-resend 0/2] Basic ATI VGA emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Randrianasulu <randrianasulu@gmail.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

Hello,

On Thu, 7 Mar 2019, Andrew Randrianasulu wrote:
> Tried this with mac99 machine and lubuntu 16.04 ppc.

Thanks for testing it. Do you want to add a Tested-by: tag? You can reply 
to the patch (or series cover letter for all patches) with your Tested-by: 
to declare that.

> After upgrading r128 driver to -hwe part to get past this bug
> https://bugs.freedesktop.org/show_bug.cgi?id=91622
>
> and disabling accel I can see some image and cursor!

Good. Accel is still not quite right, I now about that but couldn't fix it 
yet. I'd need more time for that which I don't have now. So for now only 
console and unaccelerated X is expected to work.

> qemu command:
>
> ppc64-softmmu/qemu-system-ppc64 -M mac99 -device ati-vga \
> -cdrom /mnt/sdb1/ISO/lubuntu-16.04-desktop-powerpc.iso -m 1G -boot d -cpu g4 -device usb-mouse -smp 1

The -cpu g4 is not needed as that's the default (it's also single core so 
-smp 1 is not needed either). You're probably also better off using -M 
mac99,via=pmu which is closer to real hardware and adds USB keyboard and 
mouse as well instead of ADB ones so you can omit the -device usb-mouse 
option with that as well.

> model rv100 doesn't recognized by openfirmware, so no output from it.

rv100 is only supported for fulong2e console at the moment because drivers 
for it probably need more features of the GPU implemented (such as command 
FIFO) that aren't emulated yet. At first I only target rage128p as found 
in PowerMac3,1 without 3D for Linux, X, MorphOS and maybe MacOS.

> Menus in wondows still at wrong place (not shown, even), but generally speaking some image is on screen.

I wonder if it's a bug in guest or due to Linux FB using some 2D ops that 
are not correct? Maybe this could be cross-checked with an Intel version 
of the same lubuntu version to make sure it's not a PPC specific xorg 
problem.

Regards,
BALATON Zoltan
