Received: from eggs.gnu.org ([2001:4830:134:3::10]:38170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gHSWA-0001VR-Du
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 07:49:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gHSW7-00025o-7G
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 07:49:06 -0400
References: <20181029134000.11157-1-mark.cave-ayland@ilande.co.uk>
	<97900b04-28f0-975f-b3c0-2c0aa7039a4f@linaro.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <5c41b46c-70e3-33a0-76cf-ba2fd8155d33@ilande.co.uk>
Date: Tue, 30 Oct 2018 11:48:26 +0000
MIME-Version: 1.0
In-Reply-To: <97900b04-28f0-975f-b3c0-2c0aa7039a4f@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 00/11] hw/m68k: add Apple Machintosh
 Quadra 800 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, jasowang@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, hpoussin@reactos.org, kraxel@redhat.com, pbonzini@redhat.com, afaerber@suse.de, aurelien@aurel32.net, laurent@vivier.eu

On 30/10/2018 08:15, Richard Henderson wrote:

> On 10/29/18 1:39 PM, Mark Cave-Ayland wrote:
>> You can install your own disk using debian-installer, with:
>>
>>     ...
>>     -M q800 \
>>     -serial none -serial mon:stdio \
>>     -m 1000M -drive file=m68k.qcow2,format=qcow2 \
>>     -net nic,model=dp83932,addr=09:00:07:12:34:57 \
>>     -append "console=ttyS0 vga=off" \
>>     -kernel vmlinux-4.15.0-2-m68k \
>>     -initrd initrd.gz \
>>     -drive file=debian-9.0-m68k-NETINST-1.iso \
>>     -drive file=m68k.qcow2,format=qcow2 \
>>     -nographic
> 
> I tried this and got
> 
> Trace 0: 0x7f2e886c7140 [00000000/0000d404/0xe000]
> INT      1: Unassigned(0xf4) pc=0000d404 sp=00393e60 sr=2700
> INT      2: Access Fault(0x8) pc=00000000 sp=00393e58 sr=2700
>             ssw:  00000506 ea:   00000000 sfc:  5    dfc: 5
> 
> which lead straight to buserr and panic.  This happens way early in boot --
> only 1926 TranslationBlocks generated.
> 
> Is there some device missing from the command-line that the kernel is expecting?

Heh that's annoying. The original branch I forked that Laurent was working on had
some extra patches at the start of the series: some were required for q800 whilst
others were for new development. I thought that all of the patches required for q800
had been applied over the past few months, but sadly that isn't the case :(

I've pushed an updated branch to https://github.com/mcayland/qemu/tree/q800-test
which contains the patchset plus two extra patches that are still needed to boot to
the debian installer here:

9281a5371f "tmp"
629754d847 "target/m68k: manage FPU exceptions"

Laurent, are these patches ready for upstream or do they need work in which case we
should leave q800 until the 3.2 cycle?


ATB,

Mark.
