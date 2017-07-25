Received: from eggs.gnu.org ([2001:4830:134:3::10]:46660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1da1WR-0002bg-CR
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:13:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1da1WQ-0007XE-BF
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:13:19 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:37634)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1da1WQ-0007Ws-4k
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:13:18 -0400
Received: by mail-wr0-x22f.google.com with SMTP id 33so63903972wrz.4
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 08:13:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87fudkefdw.fsf@linaro.org>
References: <150097502966.6397.351311629210845503.malonedeb@gac.canonical.com>
	<b64e52eb-47ca-7264-0e09-1dc9b3794e92@redhat.com>
	<87fudkefdw.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Jul 2017 16:12:56 +0100
Message-ID: <CAFEAcA_HW4CVa+V0KjTxpTaLVpppmquea9ZgLC=7oeoHCsGYTg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Bug 1706296 <1706296@bugs.launchpad.net>, Jan Kiszka <jan.kiszka@siemens.com>, QEMU Developers <qemu-devel@nongnu.org>, "Emilio G. Cota" <cota@braap.org>, Pranith Kumar <bobby.prani@gmail.com>, KONRAD Frederic <fred.konrad@greensocs.com>

On 25 July 2017 at 15:54, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>
> Thomas Huth <thuth@redhat.com> writes:
>
>> On 25.07.2017 11:30, Richard Jones wrote:
>>> ERROR:/home/rjones/d/qemu/cpus.c:1580:qemu_mutex_lock_iothread: asserti=
on failed: (!qemu_mutex_iothread_locked())
>>> Aborted (core dumped)
>>>
>>> The stack trace in the failing thread is:
>>>
>>> Thread 4 (Thread 0x7fffb0418700 (LWP 21979)):
>>> #0  0x00007fffdd89b64b in raise () at /lib64/libc.so.6
>>> #1  0x00007fffdd89d450 in abort () at /lib64/libc.so.6
>>> #2  0x00007fffdff8c75d in g_assertion_message () at /lib64/libglib-2.0.=
so.0
>>> #3  0x00007fffdff8c7ea in g_assertion_message_expr ()
>>>     at /lib64/libglib-2.0.so.0
>>> #4  0x00005555557a7d00 in qemu_mutex_lock_iothread ()
>>>     at /home/rjones/d/qemu/cpus.c:1580
>>> #5  0x00005555557cb429 in io_writex (env=3Denv@entry=3D0x555556751400, =
iotlbentry=3D0x55555675b678,
>>>     iotlbentry@entry=3D0x5aaaaae40c918, val=3Dval@entry=3D8, addr=3Dadd=
r@entry=3D2148532220, retaddr=3D0, retaddr@entry=3D93825011136120, size=3Ds=
ize@entry=3D4)
>>>     at /home/rjones/d/qemu/accel/tcg/cputlb.c:795
>>> #6  0x00005555557ce0f7 in io_writel (retaddr=3D93825011136120, addr=3D2=
148532220, val=3D8, index=3D255, mmu_idx=3D21845, env=3D0x555556751400)
>>>     at /home/rjones/d/qemu/softmmu_template.h:265
>>> #7  0x00005555557ce0f7 in helper_le_stl_mmu (env=3Denv@entry=3D0x555556=
751400, addr=3Daddr@entry=3D2148532220, val=3Dval@entry=3D8, oi=3D<optimize=
d out>, retaddr=3D93825011136120, retaddr@entry=3D0) at /home/rjones/d/qemu=
/softmmu_template.h:300
>>> #8  0x000055555587c0a4 in cpu_stl_kernel_ra (env=3D0x555556751400, ptr=
=3D2148532220, v=3D8, retaddr=3D0) at /home/rjones/d/qemu/include/exec/cpu_=
ldst_template.h:182
>>> #9  0x0000555555882610 in do_interrupt_protected (is_hw=3D<optimized
>>> out>, next_eip=3D<optimized out>, error_code=3D2, is_int=3D<optimized o=
ut>,
>>> intno=3D<optimized out>, env=3D0x555556751400) at
>>> /home/rjones/d/qemu/target/i386/seg_helper.c:758
>
> Erm, what is happening here? I think the seg_helper is writing a stack
> frame but for some reason to io memory, triggering the BQL. This just
> seems weird.

Even if this happens because the guest is going haywire,
if the guest can provoke it then we need to handle it
without asserting...

thanks
-- PMM
