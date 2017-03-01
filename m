Received: from eggs.gnu.org ([2001:4830:134:3::10]:50287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cj8pE-0008Hi-9N
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 13:18:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cj8pA-0001Zx-Bg
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 13:18:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34188)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cj8pA-0001YL-3C
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 13:18:04 -0500
References: <CAFEAcA_KVG19uhPuBUNx4ySmebnL1Hit6=HUX9ug0FkBFMwasg@mail.gmail.com>
	<877f492ppx.fsf@linaro.org>
	<e28337d0-d572-cd9a-3f45-0ecc074c32c9@ilande.co.uk>
	<874lzd2mp7.fsf@linaro.org>
	<9efa47c0-2a5f-0229-7e27-97a0142ff22d@ilande.co.uk>
	<871suh2ff3.fsf@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7db26777-18b6-56ac-7bb1-70ac8d9cc758@redhat.com>
Date: Wed, 1 Mar 2017 19:17:59 +0100
MIME-Version: 1.0
In-Reply-To: <871suh2ff3.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On 01.03.2017 16:19, Alex Benn=C3=A9e wrote:
>=20
> Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> writes:
>=20
>> On 01/03/17 12:41, Alex Benn=C3=A9e wrote:
>>
>>>> Here's the backtrace from my test case of qemu-system-sparc running =
on
>>>> an x86_64 host that I posted yesterday:
>>>>
>>>>
>>>> $ gdb --args ./qemu-system-sparc -cdrom
>>>> /home/build/src/qemu/image/sparc32/debian-40r4a-sparc-netinst.iso -b=
oot d
>>>> GNU gdb (GDB) 7.4.1-debian
>>>> Copyright (C) 2012 Free Software Foundation, Inc.
>>>> License GPLv3+: GNU GPL version 3 or later
>>>> <http://gnu.org/licenses/gpl.html>
>>>> This is free software: you are free to change and redistribute it.
>>>> There is NO WARRANTY, to the extent permitted by law.  Type "show co=
pying"
>>>> and "show warranty" for details.
>>>> This GDB was configured as "x86_64-linux-gnu".
>>>> For bug reporting instructions, please see:
>>>> <http://www.gnu.org/software/gdb/bugs/>...
>>>> Reading symbols from /home/build/rel-qemu-git/bin/qemu-system-sparc.=
..done.
>>>> (gdb) r
>>>> Starting program: /home/build/rel-qemu-git/bin/qemu-system-sparc -cd=
rom
>>>> /home/build/src/qemu/image/sparc32/debian-40r4a-sparc-netinst.iso -b=
oot d
>>>> warning: no loadable sections found in added symbol-file system-supp=
lied
>>>> DSO at 0x7ffff7ffa000
>>>> [Thread debugging using libthread_db enabled]
>>>> Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.=
so.1".
>>>> [New Thread 0x7fffe9eee700 (LWP 18040)]
>>>> [New Thread 0x7fffe66d6700 (LWP 18041)]
>>>> [New Thread 0x7fffe5ed5700 (LWP 18042)]
>>>> qemu-system-sparc: -cdrom
>>>> /home/build/src/qemu/image/sparc32/debian-40r4a-sparc-netinst.iso:
>>>> warning: bus=3D0,unit=3D2 is deprecated with this machine type
>>>> [Thread 0x7fffe66d6700 (LWP 18041) exited]
>>>> [New Thread 0x7fffe66d6700 (LWP 18043)]
>>>> **
>>>> ERROR:/home/build/src/qemu/git/qemu/translate-common.c:34:tcg_handle=
_interrupt:
>>>> assertion failed: (qemu_mutex_iothread_locked())
>>>>
>>>> Program received signal SIGABRT, Aborted.
>>>> [Switching to Thread 0x7fffe5ed5700 (LWP 18042)]
>>>> 0x00007ffff2939125 in *__GI_raise (sig=3D<optimized out>) at
>>>> ../nptl/sysdeps/unix/sysv/linux/raise.c:64
>>>>
>>>>
>>>>
>>>> 64      ../nptl/sysdeps/unix/sysv/linux/raise.c: No such file or dir=
ectory.
>>>> (gdb) thread apply all bt
>>>>
>>>> Thread 5 (Thread 0x7fffe66d6700 (LWP 18043)):
>>>> #0  sem_timedwait () at
>>>> ../nptl/sysdeps/unix/sysv/linux/x86_64/sem_timedwait.S:106
>>>> #1  0x000055555591435c in qemu_sem_timedwait (sem=3D0x5555561ad408,
>>>> ms=3D10000) at util/qemu-thread-posix.c:255
>>>> #2  0x000055555590cb51 in worker_thread (opaque=3D0x5555561ad3a0) at
>>>> util/thread-pool.c:92
>>>> #3  0x00007ffff2c9ab50 in start_thread (arg=3D<optimized out>) at
>>>> pthread_create.c:304
>>>> #4  0x00007ffff29e4fbd in clone () at
>>>> ../sysdeps/unix/sysv/linux/x86_64/clone.S:112
>>>> #5  0x0000000000000000 in ?? ()
>>>>
>>>> Thread 4 (Thread 0x7fffe5ed5700 (LWP 18042)):
>>>> #0  0x00007ffff2939125 in *__GI_raise (sig=3D<optimized out>) at
>>>> ../nptl/sysdeps/unix/sysv/linux/raise.c:64
>>>> #1  0x00007ffff293c3a0 in *__GI_abort () at abort.c:92
>>>> #2  0x00007ffff407e477 in g_assertion_message () from
>>>> /lib/x86_64-linux-gnu/libglib-2.0.so.0
>>>> #3  0x00007ffff407e994 in g_assertion_message_expr () from
>>>> /lib/x86_64-linux-gnu/libglib-2.0.so.0
>>>> #4  0x000055555561b54f in tcg_handle_interrupt (cpu=3D0x5555561b3af0=
,
>>>> mask=3D2) at /home/build/src/qemu/git/qemu/translate-common.c:34
>>>> #5  0x00005555556a8e7d in cpu_interrupt (cpu=3D0x5555561b3af0, mask=3D=
2) at
>>>> /home/build/src/qemu/git/qemu/include/qom/cpu.h:801
>>>> #6  0x00005555556a95ec in cpu_check_irqs (env=3D0x5555561bbd80) at
>>>> /home/build/src/qemu/git/qemu/hw/sparc/sun4m.c:157
>>>
>>> Am I correct assuming all the helper functions themselves are concern=
ed
>>> with the vCPU environment they are running in? If so it looking like
>>> cpu_check_irqs() would be the place to wrap the BQL lock in.
>>>
>>> I'll make the change and test against your test case.
>>
>> For the window helpers, definitely yes - each SPARC vCPU contains a
>> large bank of registers of which the current window is a pointer as to
>> which register set is currently active. The current window itself is
>> controlled by a special register called CWP (current window pointer)
>> which is part of the PSR register in 32-bit CPUs or a standalone
>> register for 64-bit CPUs.
>=20
> Actually looking at where cpu_check_irq is I've pushed the BQL wraps
> higher up:
>=20
>   https://github.com/stsquad/qemu/commit/f52e01bf4d3415ce4fad54cbb491f6=
c30a8e1903
>=20
> The reasoning is HW emulation code can expect to be run under the BQL.
> Anything triggered by MMIO for example will automatically have the lock=
.
> The problem is helpers which trigger hardware actions (ARM has ARM_CP_I=
O
> for this). We talk about this in the design document:
>=20
>   http://git.qemu-project.org/?p=3Dqemu.git;a=3Dblob;f=3Ddocs/multi-thr=
ead-tcg.txt;h=3Da99b4564c6258576acfa141f51f4b80131969519;hb=3DHEAD#l201
>=20
>> I ran out of time yesterday to run through all my SPARC64 tests, howev=
er
>> if this is the case then the issue will definitely appear in
>> qemu-system-sparc64 which seems to be supported by people seeing
>> intermittent failures in prom-env-test.
>=20
> So I made the change to both sparc and sparc64 in the above commit.
>=20
> I haven't managed to run into the intermittent trigger yet. How do I ru=
n
> the test directly?
>=20
>   make tests/prom-env-test
>=20
> Just makes the test case and
>=20
>   ./tests/prom-env-test
> **
> ERROR:tests/libqtest.c:589:qtest_get_arch: assertion failed: (qemu !=3D=
 NULL)
> Aborted (core dumped)

QTEST_QEMU_BINARY=3Dsparc64-softmmu/qemu-system-sparc64 \
 tests/prom-env-test

... that should do the job here.
(or use "make check-qtest-sparc64" to run all sparc64 tests)

 Thomas
