Received: from eggs.gnu.org ([209.51.188.92]:58104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gwvmh-0004LE-AC
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 16:21:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gwvmg-0005zW-FL
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 16:21:35 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:53531)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gwvmg-0005yj-0b
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 16:21:34 -0500
Date: Thu, 21 Feb 2019 16:21:30 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20190221212130.GA6971@flamenco>
References: <20190219233421.388-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219233421.388-1-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v2 0/3] target/arm: Reduce overhead of
 cpu_get_tb_cpu_state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, alex.bennee@linaro.org

On Tue, Feb 19, 2019 at 15:34:18 -0800, Richard Henderson wrote:
> Changes since v1:
>   * Apparently I had started a last-minute API change, and failed to
>     covert all of the users, and also failed to re-test afterward.
>   * Retain assertions for --enable-debug-tcg.

This brings my arm-softmmu bootup+shutdown test to an early death:

[...]
VFS: Mounted root (ext4 filesystem) readonly on device 254:1.
devtmpfs: mounted
Freeing unused kernel memory: 300K (80669000 - 806b4000)
BUG: unsupported FP instruction in kernel mode
Internal error: Oops - undefined instruction: 0 [#1] SMP ARM
Modules linked in:
CPU: 0 PID: 1 Comm: init Not tainted 4.5.0-ajb #10
Hardware name: Generic DT based system
task: eec58000 ti: eec52000 task.ti: eec52000
PC is at vfp_reload_hw+0xc/0x44
LR is at __und_usr_fault_32+0x0/0x8
pc : [<8000ab94>]    lr : [<800136c0>]    psr: 000c0013
sp : eec53fb0  ip : 7eb88918  fp : 00000000
r10: eec520f8  r9 : 8001371c  r8 : 00000b00
r7 : 00000001  r6 : eec5204c  r5 : 40000000  r4 : 00000000
r3 : 806e1058  r2 : 76fc1362  r1 : 40000000  r0 : ecac8b10
Flags: nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 30c5387d  Table: ae4048c0  DAC: fffffffd
Process init (pid: 1, stack limit = 0xeec52210)
Stack: (0xeec53fb0 to 0xeec54000)
3fa0:                                     7eb888f0 00000000 003fb0d6 fffffd90
3fc0: 7eb888e0 76fd8050 00000000 7eb88ab0 00000000 0001223c 76fd8958 7eb88a90
3fe0: 7eb88918 7eb888c0 76fbb187 76fc1362 600c0030 ffffffff 00000000 00000000
[<8000ab94>] (vfp_reload_hw) from [<800136c0>] (__und_usr_fault_32+0x0/0x8)
Code: 0a000010 e58ab110 eee85a10 e783a10b (ecba0b20)
---[ end trace 26acd422f5b3785f ]---
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

Thanks,

		Emilio
