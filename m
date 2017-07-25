Received: from eggs.gnu.org ([2001:4830:134:3::10]:42785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dZy8W-000260-JP
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 07:36:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dZy8T-0003Ao-Fw
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 07:36:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52044)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dZy8T-0003AH-6N
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 07:36:21 -0400
References: <150097502966.6397.351311629210845503.malonedeb@gac.canonical.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b64e52eb-47ca-7264-0e09-1dc9b3794e92@redhat.com>
Date: Tue, 25 Jul 2017 13:36:16 +0200
MIME-Version: 1.0
In-Reply-To: <150097502966.6397.351311629210845503.malonedeb@gac.canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Bug 1706296] [NEW] Booting NT 4 disk causes
 /home/rjones/d/qemu/cpus.c:1580:qemu_mutex_lock_iothread: assertion failed:
 (!qemu_mutex_iothread_locked())
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1706296 <1706296@bugs.launchpad.net>, qemu-devel@nongnu.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, "Emilio G. Cota" <cota@braap.org>, KONRAD Frederic <fred.konrad@greensocs.com>, Pranith Kumar <bobby.prani@gmail.com>

On 25.07.2017 11:30, Richard Jones wrote:
> ERROR:/home/rjones/d/qemu/cpus.c:1580:qemu_mutex_lock_iothread: asserti=
on failed: (!qemu_mutex_iothread_locked())
> Aborted (core dumped)
>=20
> The stack trace in the failing thread is:
>=20
> Thread 4 (Thread 0x7fffb0418700 (LWP 21979)):
> #0  0x00007fffdd89b64b in raise () at /lib64/libc.so.6
> #1  0x00007fffdd89d450 in abort () at /lib64/libc.so.6
> #2  0x00007fffdff8c75d in g_assertion_message () at /lib64/libglib-2.0.=
so.0
> #3  0x00007fffdff8c7ea in g_assertion_message_expr ()
>     at /lib64/libglib-2.0.so.0
> #4  0x00005555557a7d00 in qemu_mutex_lock_iothread ()
>     at /home/rjones/d/qemu/cpus.c:1580
> #5  0x00005555557cb429 in io_writex (env=3Denv@entry=3D0x555556751400, =
iotlbentry=3D0x55555675b678,=20
>     iotlbentry@entry=3D0x5aaaaae40c918, val=3Dval@entry=3D8, addr=3Dadd=
r@entry=3D2148532220, retaddr=3D0, retaddr@entry=3D93825011136120, size=3D=
size@entry=3D4)
>     at /home/rjones/d/qemu/accel/tcg/cputlb.c:795
> #6  0x00005555557ce0f7 in io_writel (retaddr=3D93825011136120, addr=3D2=
148532220, val=3D8, index=3D255, mmu_idx=3D21845, env=3D0x555556751400)
>     at /home/rjones/d/qemu/softmmu_template.h:265
> #7  0x00005555557ce0f7 in helper_le_stl_mmu (env=3Denv@entry=3D0x555556=
751400, addr=3Daddr@entry=3D2148532220, val=3Dval@entry=3D8, oi=3D<optimi=
zed out>, retaddr=3D93825011136120, retaddr@entry=3D0) at /home/rjones/d/=
qemu/softmmu_template.h:300
> #8  0x000055555587c0a4 in cpu_stl_kernel_ra (env=3D0x555556751400, ptr=3D=
2148532220, v=3D8, retaddr=3D0) at /home/rjones/d/qemu/include/exec/cpu_l=
dst_template.h:182
> #9  0x0000555555882610 in do_interrupt_protected (is_hw=3D<optimized ou=
t>, next_eip=3D<optimized out>, error_code=3D2, is_int=3D<optimized out>,=
 intno=3D<optimized out>, env=3D0x555556751400) at /home/rjones/d/qemu/ta=
rget/i386/seg_helper.c:758
> #10 0x0000555555882610 in do_interrupt_all (cpu=3Dcpu@entry=3D0x5555567=
49170, intno=3D<optimized out>, is_int=3D<optimized out>, error_code=3D2,=
 next_eip=3D<optimized out>, is_hw=3Dis_hw@entry=3D0) at /home/rjones/d/q=
emu/target/i386/seg_helper.c:1252
> #11 0x00005555558839d3 in x86_cpu_do_interrupt (cs=3D0x555556749170)
>     at /home/rjones/d/qemu/target/i386/seg_helper.c:1298
> #12 0x00005555557d2ccb in cpu_handle_exception (ret=3D<synthetic pointe=
r>, cpu=3D0x5555566a4590) at /home/rjones/d/qemu/accel/tcg/cpu-exec.c:465
> #13 0x00005555557d2ccb in cpu_exec (cpu=3Dcpu@entry=3D0x555556749170)
>     at /home/rjones/d/qemu/accel/tcg/cpu-exec.c:670
> #14 0x00005555557a855a in tcg_cpu_exec (cpu=3D0x555556749170)
>     at /home/rjones/d/qemu/cpus.c:1270
> #15 0x00005555557a855a in qemu_tcg_rr_cpu_thread_fn (arg=3D<optimized o=
ut>)
>     at /home/rjones/d/qemu/cpus.c:1365
> #16 0x00007fffddc3d36d in start_thread () at /lib64/libpthread.so.0
> #17 0x00007fffdd975b9f in clone () at /lib64/libc.so.6

Looks like the iothread lock is taken twice here, one time in
accel/tcg/cpu-exec.c around line 465 and one time in
accel/tcg/cputlb.c:795 again.

If I've get that right, the locks have been added by this commit here:

 8d04fb55dec381bc5105cb47f29d918e579e8cbd
 tcg: drop global lock during TCG code execution

so this looks related to the MTTCG reworks that happened recently. I
hope one of the MTTCG gurus has some spare time to look at this...

 Thomas
