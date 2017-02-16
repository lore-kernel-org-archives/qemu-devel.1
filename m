Received: from eggs.gnu.org ([2001:4830:134:3::10]:44560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1ceJGc-0004wi-Fz
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 05:26:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1ceJGb-0008PZ-HN
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 05:26:26 -0500
Received: from mail-it0-x22b.google.com ([2607:f8b0:4001:c0b::22b]:37881)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1ceJGb-0008PI-Ce
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 05:26:25 -0500
Received: by mail-it0-x22b.google.com with SMTP id x75so19379555itb.0
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 02:26:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAO-EVGgMW-w+rD3fwKadKE8=bsq0FvFt9MEs1PLu+UvLKToQBg@mail.gmail.com>
References: <CAO-EVGgMW-w+rD3fwKadKE8=bsq0FvFt9MEs1PLu+UvLKToQBg@mail.gmail.com>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Thu, 16 Feb 2017 11:26:04 +0100
Message-ID: <CACXAS8AsTN9MDObz45WD8YHB19BL3pw2SQoen6QS3am7O43BSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Emulating a Sun Blade 1500,
 with a Ultrasparc IIIi 1.5 GHz, 2GB ECC RAM. SunOS 5.10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: gozulmeunou vasile <gozulmeunou@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

On Wed, Feb 15, 2017 at 11:37 AM, gozulmeunou vasile
<gozulmeunou@gmail.com> wrote:
> Hello,
>
> I have an old Sun Blade 1500, with a Ultrasparc IIIi 1.5 GHz, 2GB ECC RAM.
> SunOS 5.10, ufs filesystem. The hardware (MB, HDD and video card) is
> failing on me and I'm searching for a way to emulate it on x86 hardware, I
> prefer to run the emulator on Linux as OS. I have a DD raw copy of the
> system HDD (80GB). I read about emulating it with qemu but I don't have yet
> much experience with Sun/Solaris and Linux environments.
> Do you think that you can help me with this?

The bad news is that SB1500 is not one of the machines QEMU can emulate.
The probably good news is QEMU can emulate some sparc machines pretty well.

What software are you trying to emulate? Is it available for Solaris 9?
If so, sun4m Emulation (SS-5 or SS-20) is the best choice.
Otherwise you may try your luck with a sun4v Niagara machine.

-- 
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/qemu
