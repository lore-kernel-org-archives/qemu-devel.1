Received: from eggs.gnu.org ([2001:4830:134:3::10]:46056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gK6pj-00007G-Pv
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 14:16:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gK6pe-000594-F6
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 14:16:15 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45202)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gK6pc-00053g-C6
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 14:16:10 -0500
Received: by mail-wr1-f67.google.com with SMTP id k15-v6so11843756wre.12
	for <qemu-devel@nongnu.org>; Tue, 06 Nov 2018 11:16:06 -0800 (PST)
References: <CAFEAcA9pvsNML+=2jwygO4ciJWr0GmWHznJ-Lb1bcOsWhYjo4A@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <30bb371d-4183-dd25-3413-08fd60a9eeea@redhat.com>
Date: Tue, 6 Nov 2018 20:16:04 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9pvsNML+=2jwygO4ciJWr0GmWHznJ-Lb1bcOsWhYjo4A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] List of files containing devices which have not
 been QOMified
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On 6/11/18 19:43, Peter Maydell wrote:
> I had an idea for how to get a rough list of source files
> containing devices that haven't been QOMified. The theory
> is that a pre-QOM device generally has an "init" function
> which allocates memory for the device struct. So looking in
> hw/ for files which call g_new*() or g_malloc*() should get
> us all the non-QOM devices (as well as a pile of false
> positives, of course). The following link is the result of
> doing that and then eyeballing the results for false positives
> and throwing those out. It might have missed one or two
> files or included one or two by mistake. But I think it's
> pretty close, and it seems to have caught all the obvious
> ones I knew about. There are 61 files on this list.
> 
> I am also suspicious about hw/bt/ but don't know enough
> about that subsystem to say if it could benefit from
> using QOM objects more.
> 

> hw/arm/exynos4210.c
I already did this one.

 > hw/sd/omap_mmc.c
I will do this one.

 > hw/mips/mips_malta.c
 > hw/timer/mips_gictimer.c
I'm interested in doing those two.

> hw/char/parallel.c
> hw/char/serial.c
> hw/display/vga-isa-mm.c
> hw/input/pckbd.c
> hw/input/ps2.c
I can do those too when QOM'ifying the Malta.

> hw/char/sh_serial.c
> hw/sh4/r2d.c
> hw/sh4/sh7750.c
 > hw/timer/sh_timer.c
If nobody volonteers, I can take those.

Regards,

Phil.
