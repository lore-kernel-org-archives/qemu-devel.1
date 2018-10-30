Received: from eggs.gnu.org ([2001:4830:134:3::10]:59569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHPBg-0004VA-2a
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 04:15:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHPBe-000159-E1
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 04:15:43 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38883)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gHPBd-0000ZX-UT
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 04:15:42 -0400
Received: by mail-wr1-x442.google.com with SMTP id d10-v6so11487973wrs.5
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 01:15:15 -0700 (PDT)
References: <20181029134000.11157-1-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <97900b04-28f0-975f-b3c0-2c0aa7039a4f@linaro.org>
Date: Tue, 30 Oct 2018 08:15:11 +0000
MIME-Version: 1.0
In-Reply-To: <20181029134000.11157-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, jasowang@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, hpoussin@reactos.org, kraxel@redhat.com, pbonzini@redhat.com, afaerber@suse.de, aurelien@aurel32.net, laurent@vivier.eu

On 10/29/18 1:39 PM, Mark Cave-Ayland wrote:
> You can install your own disk using debian-installer, with:
> 
>     ...
>     -M q800 \
>     -serial none -serial mon:stdio \
>     -m 1000M -drive file=m68k.qcow2,format=qcow2 \
>     -net nic,model=dp83932,addr=09:00:07:12:34:57 \
>     -append "console=ttyS0 vga=off" \
>     -kernel vmlinux-4.15.0-2-m68k \
>     -initrd initrd.gz \
>     -drive file=debian-9.0-m68k-NETINST-1.iso \
>     -drive file=m68k.qcow2,format=qcow2 \
>     -nographic

I tried this and got

Trace 0: 0x7f2e886c7140 [00000000/0000d404/0xe000]
INT      1: Unassigned(0xf4) pc=0000d404 sp=00393e60 sr=2700
INT      2: Access Fault(0x8) pc=00000000 sp=00393e58 sr=2700
            ssw:  00000506 ea:   00000000 sfc:  5    dfc: 5

which lead straight to buserr and panic.  This happens way early in boot --
only 1926 TranslationBlocks generated.

Is there some device missing from the command-line that the kernel is expecting?


r~
