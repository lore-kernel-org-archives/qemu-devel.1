Received: from eggs.gnu.org ([209.51.188.92]:58881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gwwxO-0000Q9-S8
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 17:36:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gwwxO-0000uU-1q
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 17:36:42 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33275)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gwwxN-0000nG-Az
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 17:36:41 -0500
Received: by mail-wr1-x441.google.com with SMTP id i12so278721wrw.0
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 14:36:27 -0800 (PST)
References: <20190219233421.388-1-richard.henderson@linaro.org>
	<20190221212130.GA6971@flamenco>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190221212130.GA6971@flamenco>
Date: Thu, 21 Feb 2019 22:36:25 +0000
Message-ID: <87va1c3h1y.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
To: "Emilio G. Cota" <cota@braap.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, peter.maydell@linaro.org


Emilio G. Cota <cota@braap.org> writes:

> On Tue, Feb 19, 2019 at 15:34:18 -0800, Richard Henderson wrote:
>> Changes since v1:
>>   * Apparently I had started a last-minute API change, and failed to
>>     covert all of the users, and also failed to re-test afterward.
>>   * Retain assertions for --enable-debug-tcg.
>
> This brings my arm-softmmu bootup+shutdown test to an early death:

Can you retry with --enable-tcg-debug?

>
> [...]
> VFS: Mounted root (ext4 filesystem) readonly on device 254:1.
> devtmpfs: mounted
> Freeing unused kernel memory: 300K (80669000 - 806b4000)
> BUG: unsupported FP instruction in kernel mode
> Internal error: Oops - undefined instruction: 0 [#1] SMP ARM
> Modules linked in:
> CPU: 0 PID: 1 Comm: init Not tainted 4.5.0-ajb #10
> Hardware name: Generic DT based system
> task: eec58000 ti: eec52000 task.ti: eec52000
> PC is at vfp_reload_hw+0xc/0x44
> LR is at __und_usr_fault_32+0x0/0x8
> pc : [<8000ab94>]    lr : [<800136c0>]    psr: 000c0013
> sp : eec53fb0  ip : 7eb88918  fp : 00000000
> r10: eec520f8  r9 : 8001371c  r8 : 00000b00
> r7 : 00000001  r6 : eec5204c  r5 : 40000000  r4 : 00000000
> r3 : 806e1058  r2 : 76fc1362  r1 : 40000000  r0 : ecac8b10
> Flags: nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
> Control: 30c5387d  Table: ae4048c0  DAC: fffffffd
> Process init (pid: 1, stack limit =3D 0xeec52210)
> Stack: (0xeec53fb0 to 0xeec54000)
> 3fa0:                                     7eb888f0 00000000 003fb0d6 ffff=
fd90
> 3fc0: 7eb888e0 76fd8050 00000000 7eb88ab0 00000000 0001223c 76fd8958 7eb8=
8a90
> 3fe0: 7eb88918 7eb888c0 76fbb187 76fc1362 600c0030 ffffffff 00000000 0000=
0000
> [<8000ab94>] (vfp_reload_hw) from [<800136c0>] (__und_usr_fault_32+0x0/0x=
8)
> Code: 0a000010 e58ab110 eee85a10 e783a10b (ecba0b20)
> ---[ end trace 26acd422f5b3785f ]---
> Kernel panic - not syncing: Attempted to kill init! exitcode=3D0x0000000b
> ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=3D0=
x0000000b
>
> Thanks,
>
> 		Emilio


--
Alex Benn=C3=A9e
