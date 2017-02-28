Received: from eggs.gnu.org ([2001:4830:134:3::10]:39856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cipRe-0007Hy-RW
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 16:36:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cipRb-00047U-OA
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 16:36:30 -0500
Received: from chuckie.co.uk ([82.165.15.123]:43517
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1cipRb-000458-HN
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 16:36:27 -0500
References: <CAFEAcA_KVG19uhPuBUNx4ySmebnL1Hit6=HUX9ug0FkBFMwasg@mail.gmail.com>
	<4b5d1228-fb99-6b8f-6f8b-bab42b84e7ce@redhat.com>
	<61a443e9-2e69-149c-1c2f-7c0cd53ba6a2@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <bc547cf1-a5b1-c60e-51b9-8e559e37195e@ilande.co.uk>
Date: Tue, 28 Feb 2017 21:35:58 +0000
MIME-Version: 1.0
In-Reply-To: <61a443e9-2e69-149c-1c2f-7c0cd53ba6a2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] intermittent make check failure:
 "tcg_handle_interrupt: assertion failed: (qemu_mutex_iothread_locked())"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>

On 28/02/17 21:28, Thomas Huth wrote:

>> Maybe worth mentioning that the prom-env test for sparc64 has just been
>> enabled a couple of commits ago (6b591ad613010f13). There was an issue
>> with that test for the sparc64 target last year, but IIRC it only
>> affected 32-bit hosts and has been fixed, so I think/hope this is a
>> different issue now...
> 
> OK, I think this is definitively not related to the prom-env test, but
> to MTTCG (or something else in TCG): I can reproduce this problem
> reliably when I run QEMU in s390 mode with the Moon Buggy disk image
> from the QEMU advent calendar
> (http://www.qemu-advent-calendar.org/2014/download/s390-moon-buggy.tar.xz):
> 
> qemu-system-s390x -nographic -kernel s390-bb.kernel \
>                   -initrd s390-moon-buggy.initrd
> 
> ... starts the kernel, but aborts very soon with:
> 
> ERROR:qemu/translate-common.c:34:tcg_handle_interrupt: assertion failed:
> (qemu_mutex_iothread_locked())
> Aborted (core dumped)

FWIW I've spent some time running the "make check" regression tests
locally this evening and I can't seem to reproduce the failure here on
my normal qemu-system-ppc/qemu-system-sparc/qemu-system-sparc64 setup.


ATB,

Mark.
