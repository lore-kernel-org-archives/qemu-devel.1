Received: from eggs.gnu.org ([2001:4830:134:3::10]:47868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fAO1B-0005ob-Qn
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 19:03:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fAO18-0005jC-Ly
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 19:03:37 -0400
Received: from mail-qt0-x229.google.com ([2607:f8b0:400d:c0d::229]:35124)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fAO18-0005iv-GU
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 19:03:34 -0400
Received: by mail-qt0-x229.google.com with SMTP id s2-v6so15728886qti.2
	for <qemu-devel@nongnu.org>; Sun, 22 Apr 2018 16:03:34 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <CAKmqyKPZ3AUwGFwp6zK+aFSd6R3p8c+pP-i-W-g=t6ZfR5GVaA@mail.gmail.com>
	<87lghd3mq6.fsf@linaro.org>
	<CAKmqyKMgrU+4ABijd0SgomyZriVjVFMYt=TXs5b9--w_kenZ+Q@mail.gmail.com>
	<CAKmqyKMopCi5jaDstAX0Q3CzLdQ9wRgKWT2ggR_Or8Yh09zkrQ@mail.gmail.com>
	<0b0a9968-02bf-9273-e5fe-a69e04cf7f5e@redhat.com>
	<CAKmqyKMAy3qjjTFdtw4ksa=wJQYVzYZqvSopQ_cHbqwd0tr2cg@mail.gmail.com>
	<87tvv1ydjl.fsf@linaro.org>
	<CAKmqyKM10j7yyyhJn8SAv7K3EkZbmL-ckiv5_qQrFqiHvJ2z8g@mail.gmail.com>
	<87r2q4yl3p.fsf@linaro.org>
	<CAKmqyKPfE_Zrww5Ayc=bL4RLWpON14aoBkzTcUEafzikPrRohQ@mail.gmail.com>
	<CAKmqyKOXV91ex4Ohqy54Df4nLVC5S51EXth9etK1Tudmt6h1vQ@mail.gmail.com>
	<87po5nxh5a.fsf@linaro.org>
	<CAKmqyKNUYPJ68Ub-RbNL_C12vXyf+i=4FQbcvu16G0ErZVACPw@mail.gmail.com>
	<CAKmqyKOqbJ+-t0SeyZDzDM9RLEQX63WM3-wyJTbiMGHRKtHPYQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <695f7798-edb1-ed17-ee9c-9f40da35f319@amsat.org>
Date: Sun, 22 Apr 2018 20:03:29 -0300
MIME-Version: 1.0
In-Reply-To: <CAKmqyKOqbJ+-t0SeyZDzDM9RLEQX63WM3-wyJTbiMGHRKtHPYQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] MTTCG External Halt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair@alistair23.me>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

> On Fri, Feb 2, 2018 at 1:49 PM, Alistair Francis
> <alistair.francis@xilinx.com> wrote:
>> On Fri, Feb 2, 2018 at 12:37 PM, Alex Bennée <alex.bennee@linaro.org> wrote:
>>>
>>> Alistair Francis <alistair.francis@xilinx.com> writes:
>>>
>>>> On Thu, Feb 1, 2018 at 9:13 AM, Alistair Francis
>>>> <alistair.francis@xilinx.com> wrote:
>>>>> On Thu, Feb 1, 2018 at 4:01 AM, Alex Bennée <alex.bennee@linaro.org> wrote:
>>>>>>
>>>>>> Alistair Francis <alistair.francis@xilinx.com> writes:
>>>>>>
>>>>>>> On Wed, Jan 31, 2018 at 12:32 PM, Alex Bennée <alex.bennee@linaro.org> wrote:
>>>>>>>>
>>>>>>>> Alistair Francis <alistair.francis@xilinx.com> writes:
>>>>>>>>
>>>>>>>>> On Tue, Jan 30, 2018 at 8:26 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>>>>>>>>> On 30/01/2018 18:56, Alistair Francis wrote:
>>>>>>>>>>>
>>>>>>>>>>> I don't have a good solution though, as setting CPU_INTERRUPT_RESET
>>>>>>>>>>> doesn't help (that isn't handled while we are halted) and
>>>>>>>>>>> async_run_on_cpu()/run_on_cpu() doesn't reliably reset the CPU when we
>>>>>>>>>>> want.
>>>>>>>>>>>
>>>>>>>>>>> I've ever tried pausing all CPUs before reseting the CPU and them
>>>>>>>>>>> resuming them all but that doesn't seem to to work either.
>>>>>>>>>>
>>>>>>>>>> async_safe_run_on_cpu would be like async_run_on_cpu, except that it
>>>>>>>>>> takes care of stopping all other CPUs while the function runs.
>>>>>>>>>>
>>>>>>>>>>> Is there
>>>>>>>>>>> anything I'm missing? Is there no reliable way to reset a CPU?
>>>>>>>>>>
>>>>>>>>>> What do you mean by reliable?  Executing no instruction after the one
>>>>>>>>>> you were at?
>>>>>>>>>
>>>>>>>>> The reset is called by a GPIO line, so I need the reset to be called
>>>>>>>>> basically as quickly as the GPIO line changes. The async_ and
>>>>>>>>> async_safe_ functions seem to not run quickly enough, even if I run a
>>>>>>>>> process_work_queue() function afterwards.
>>>>>>>>>
>>>>>>>>> Is there a way to kick the CPU to act on the async_*?
>>>>>>>>
>>>>>>>> Define quickly enough? The async_(safe) functions kick the vCPUs so they
>>>>>>>> will all exit the run loop as they enter the next TB (even if they loop
>>>>>>>> to themselves).
>>>>>>>
>>>>>>> We have a special power controller CPU that wakes all the CPUs up and
>>>>>>> at boot the async_* functions don't wake the CPUs up. If I just use
>>>>>>> the cpu_rest() function directly everything starts fine (but then I
>>>>>>> hit issues later).
>>>>>>>
>>>>>>> If I forcefully run process_queued_cpu_work() then I can get the CPUs
>>>>>>> up, but I don't think that is the right solution.
>>>>>>>
>>>>>>>>
>>>>>>>> From an external vCPUs point of view those extra instructions have
>>>>>>>> already executed. If the resetting vCPU needs them to have reset by the
>>>>>>>> time it executes it's next instruction it should either cpu_loop_exit at
>>>>>>>> that point or ensure it is the last instruction in it's TB (which is
>>>>>>>> what we do for the MMU flush cases in ARM, they all end the TB at that
>>>>>>>> point).
>>>>>>>
>>>>>>> cpu_loop_exit() sounds like it would help, but as I'm not in the CPU
>>>>>>> context it just seg faults.
>>>>>>
>>>>>> What context are you in? gdb-stub does have to something like this.
>>>>>
>>>>> gdb-stub just seems to use vm_stop() and vm_start().
>>>>>
>>>>> That fixes all hangs/asserts, but now Linux only brings up 1 CPU (instead of 4).
>>>>
>>>> Hmmm... Interesting if I do this on reset events:
>>>>
>>>>         pause_all_vcpus();
>>>>         cpu_reset(cpu);
>>>>         resume_all_vcpus();
>>>>
>>>> it hangs, while if I do this
>>>>
>>>>         if (runstate_is_running()) {
>>>>             vm_stop(RUN_STATE_PAUSED);
>>>>         }
>>>>         cpu_reset(cpu);
>>>>         if (!runstate_needs_reset()) {
>>>>             vm_start();
>>>>         }
>>>>
>>>> it doesn't hang but CPU bringup doesn't work.
>>>
>>> Hmm I'm still confused what context you are in. Is this an externally
>>> triggered reset via the (qemu) prompt or something?
>>
>> This gets called from a variety of places. But most likely it's called
>> from a second QEMU process that is triggering an interrupt through a
>> device.
> 
> Something like this:
> 
> #0  0x0000555555807350 in cpu_reset_gpio (opaque=0x555557272100,
> irq=0, level=0) at /scratch/alistai/master-qemu/exec.c:3853
> #1  0x0000555555a20336 in dep_register_refresh_gpios
> (reg=reg@entry=0x555556fa5ad0, old_value=old_value@entry=2147496974)
>     at hw/core/register-dep.c:246
> #2  0x0000555555a2067b in dep_register_write (reg=0x555556fa5ad0,
> val=<optimized out>, we=<optimized out>)
>     at hw/core/register-dep.c:142
> #3  0x0000555555841ae8 in memory_region_write_accessor
> (mr=0x555556fa5b80, addr=0, value=<optimized out>, size=4,
> shift=<optimized out>, mask=<optimized out>, attrs=...) at
> /scratch/alistai/master-qemu/memory.c:617
> #4  0x000055555583e57d in access_with_adjusted_size
> (addr=addr@entry=0, value=value@entry=0x7fffffffd218,
> size=size@entry=4, access_size_min=<optimized out>,
> access_size_max=<optimized out>, access_fn=
>     0x555555841a70 <memory_region_write_accessor>, mr=0x555556fa5b80,
> attrs=...) at /scratch/alistai/master-qemu/memory.c:684
> #5  0x0000555555843cda in memory_region_dispatch_write
> (mr=0x555556fa5b80, addr=0, data=<optimized out>, size=4, attrs=...)
>     at /scratch/alistai/master-qemu/memory.c:1789
> #6  0x00005555557fbcb1 in flatview_write_continue (mr=0x555556fa5b80,
> l=<optimized out>, addr1=<optimized out>, len=4, buf=0x7fff900047c0
> "\f4", attrs=..., addr=4246339844, fv=0x5555574cdc10) at
> /scratch/alistai/master-qemu/exec.c:3076
> #7  0x00005555557fbcb1 in flatview_write (fv=0x5555574cdc10,
> addr=<optimized out>, attrs=..., buf=<optimized out>, len=<optimized
> out>) at /scratch/alistai/master-qemu/exec.c:3145
> #8  0x000055555586eb1b in dma_memory_rw_relaxed_attr (attr=...,
> dir=DMA_DIRECTION_FROM_DEVICE, len=<optimized out>,
> buf=0x7fff900047c0, addr=<optimized out>, as=<optimized out>) at
> /scratch/alistai/master-qemu/include/sysemu/dma.h:96
> #9  0x000055555586eb1b in dma_memory_rw_attr (attr=...,
> dir=DMA_DIRECTION_FROM_DEVICE, len=<optimized out>,
> buf=0x7fff900047c0, addr=<optimized out>, as=<optimized out>) at
> /scratch/alistai/master-qemu/include/sysemu/dma.h:120

Cc'ing Stefan for this part:

> #10 0x000055555586eb1b in rp_cmd_rw (s=0x555556d0bb90,
> pkt=0x7fff90004770, dir=DMA_DIRECTION_FROM_DEVICE)
>     at /scratch/alistai/master-qemu/hw/core/remote-port-memory-slave.c:93
> #11 0x000055555586db53 in rp_process (s=<optimized out>) at
> /scratch/alistai/master-qemu/hw/core/remote-port.c:424
> #12 0x000055555586db53 in rp_event_read (opaque=<optimized out>) at
> /scratch/alistai/master-qemu/hw/core/remote-port.c:460
> #13 0x0000555555c5de14 in aio_dispatch_handlers
> (ctx=ctx@entry=0x555556cf7750) at util/aio-posix.c:406
> #14 0x0000555555c5e6e8 in aio_dispatch (ctx=0x555556cf7750) at
> util/aio-posix.c:437
> #15 0x0000555555c5b6ae in aio_ctx_dispatch (source=<optimized out>,
> callback=<optimized out>, user_data=<optimized out>)
>     at util/async.c:261
> #16 0x00007ffff27a4fb7 in g_main_context_dispatch () at
> /lib/x86_64-linux-gnu/libglib-2.0.so.0
> #17 0x0000555555c5d937 in glib_pollfds_poll () at util/main-loop.c:215
> #18 0x0000555555c5d937 in os_host_main_loop_wait (timeout=<optimized
> out>) at util/main-loop.c:262
> #19 0x0000555555c5d937 in main_loop_wait (nonblocking=<optimized out>)
> at util/main-loop.c:516
> #20 0x00005555557f4c76 in main_loop () at vl.c:2002
> #21 0x00005555557f4c76 in main (argc=<optimized out>, argv=<optimized
> out>, envp=<optimized out>) at vl.c:4949
