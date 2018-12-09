Received: from eggs.gnu.org ([2001:4830:134:3::10]:37008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gW53Z-00034M-IU
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:48:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gW53V-0007ik-FY
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:48:01 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:46372)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gW53V-0007hK-AC
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:47:57 -0500
Received: by mail-yw1-f66.google.com with SMTP id t13so3157373ywe.13
	for <qemu-devel@nongnu.org>; Sun, 09 Dec 2018 11:47:57 -0800 (PST)
MIME-Version: 1.0
References: <154212865934.10800.13528910091420823354.malonedeb@wampee.canonical.com>
	<154420150844.616.10290043074641688914.malone@chaenomeles.canonical.com>
In-Reply-To: <154420150844.616.10290043074641688914.malone@chaenomeles.canonical.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philippe@mathieu-daude.net>
Date: Sun, 9 Dec 2018 20:47:45 +0100
Message-ID: <CAAdtpL5jbkoKT=AZBm+Q+D=GPJgYLKHrK_ymA0=c4Yaa3PLDrw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Bug 1803160] Re: qemu-3.1.0-rc0: tcg.c crash in
 temp_load
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 1803160@bugs.launchpad.net
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

Hi Alberto,

Can you open another ticket for your new bug?

Thanks.

On Fri, Dec 7, 2018 at 6:22 PM Richard Henderson <rth@twiddle.net> wrote:
>
> This second crash is of course a different bug.
>
> --
> You received this bug notification because you are a member of qemu-
> devel-ml, which is subscribed to QEMU.
> https://bugs.launchpad.net/bugs/1803160
>
> Title:
>   qemu-3.1.0-rc0: tcg.c crash in temp_load
>
> Status in QEMU:
>   Fix Committed
>
> Bug description:
>   QEMU version:
>   -------------
>
>   qemu-3.1.0-rc0 compiled from sources (earlier versions also affected)
>
>   Summary:
>   --------
>
>   TCG crashes in i386 and x86_64 when it tries to execute some specific
>   illegal instructions. When running full OS emulation, both the guest
>   system and QEMU crash.
>
>   The issue has been reproduced in two scenarios:
>
>   Ubuntu x64 host running Debian x86 guest with the following command
>   line: qemu-system-x86_64 -m 4G debian.qcow
>
>   When the attached ELF file is executed inside the guest, QEMU crashes.
>
>   It can also be reproduced from the command line:
>
>   $ qemu-i386 tcg_crash.elf
>   /home/alberto/Documents/qemu-3.1.0-rc0/tcg/tcg.c:2863: tcg fatal error
>   qemu: uncaught target signal 11 (Segmentation fault) - core dumped
>   zsh: segmentation fault (core dumped)  ../qemu-3.1.0-rc0/build/i386-linux-user/qemu-i386 tcg_crash.elf
>
>   GDB backtrace:
>
>   (gdb) bt
>   #0  0x0000000060206488 in raise ()
>   #1  0x0000000060206b8a in abort ()
>   #2  0x0000000060007016 in temp_load (s=s@entry=0x607a2780 <tcg_init_ctx>, ts=ts@entry=0x607a3178 <tcg_init_ctx+2552>, desired_regs=<optimized out>, allocated_regs=allocated_regs@entry=16400)
>       at /home/alberto/Documents/qemu-3.1.0-rc0/tcg/tcg.c:2863
>   #3  0x000000006000a4d9 in tcg_reg_alloc_op (op=0x62808c20, s=<optimized out>) at /home/alberto/Documents/qemu-3.1.0-rc0/tcg/tcg.c:3070
>   #4  tcg_gen_code (s=<optimized out>, tb=tb@entry=0x607ac040 <static_code_gen_buffer+4144>) at /home/alberto/Documents/qemu-3.1.0-rc0/tcg/tcg.c:3598
>   #5  0x000000006003ef9a in tb_gen_code (cpu=cpu@entry=0x627e0010, pc=pc@entry=134512724, cs_base=cs_base@entry=0, flags=flags@entry=4194483, cflags=cflags@entry=0)
>       at /home/alberto/Documents/qemu-3.1.0-rc0/accel/tcg/translate-all.c:1752
>   #6  0x000000006003d979 in tb_find (cf_mask=0, tb_exit=0, last_tb=0x0, cpu=0x0) at /home/alberto/Documents/qemu-3.1.0-rc0/accel/tcg/cpu-exec.c:404
>   #7  cpu_exec (cpu=cpu@entry=0x627e0010) at /home/alberto/Documents/qemu-3.1.0-rc0/accel/tcg/cpu-exec.c:724
>   #8  0x000000006006e1a0 in cpu_loop (env=env@entry=0x627e82c0) at /home/alberto/Documents/qemu-3.1.0-rc0/linux-user/i386/cpu_loop.c:93
>   #9  0x00000000600037c5 in main (argc=2, argv=0x7fffffffdd28, envp=<optimized out>) at /home/alberto/Documents/qemu-3.1.0-rc0/linux-user/main.c:819
>   (gdb)
>
>   Testcase:
>   ---------
>
>   Find ELF file attached.
>
> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/1803160/+subscriptions
>
