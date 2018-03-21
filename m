Received: from eggs.gnu.org ([2001:4830:134:3::10]:41767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hsp.cat7@gmail.com>) id 1eygdw-0005ep-5f
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 12:31:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hsp.cat7@gmail.com>) id 1eygdv-0002oe-0y
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 12:31:16 -0400
Received: from mail-oi0-x22d.google.com ([2607:f8b0:4003:c06::22d]:43045)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hsp.cat7@gmail.com>) id 1eygdu-0002oa-QS
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 12:31:14 -0400
Received: by mail-oi0-x22d.google.com with SMTP id y27-v6so4819615oix.10
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 09:31:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <84d2ded7-fdd5-0367-ad5d-b0443c4a945a@redhat.com>
References: <CABLmASFYSu4zQ_35WJLJ6izNGdyn-JuLTzgVm_Bxc3MOkkGo6w@mail.gmail.com>
	<fc09dac9-edbb-cd35-d02a-8db797879363@redhat.com>
	<CABLmASEF+e-h-nKunLd6QrnKaCAiR0d=GJZq9tN+CrvZh5iL7A@mail.gmail.com>
	<035198fa-b9e1-6084-d9c2-4d344e7058d7@redhat.com>
	<CABLmASFEhaKB1Hh91p+RM+TX+zTTDuNixWy=16rUC+GC_0KKtg@mail.gmail.com>
	<397a5759-de49-33a1-300a-67e8b7022678@redhat.com>
	<CABLmASHkjz=UDbHMRRtJKhu1bF28NGTzRjTo-GKbCd6dp-6qQQ@mail.gmail.com>
	<84d2ded7-fdd5-0367-ad5d-b0443c4a945a@redhat.com>
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Wed, 21 Mar 2018 17:31:13 +0100
Message-ID: <CABLmASFvQED-tsDGCgmw3LYx_CkLeKTGoQ_oU9qLHpGu=a=-hg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Bug AioContext polling is not implemented on
 Windows with qemu-system-ppc.exe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>

On Wed, Mar 21, 2018 at 5:25 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 21/03/2018 17:23, Howard Spoelstra wrote:
>> warning: FTH: (10844): *** Fault tolerant heap shim applied to current
>> process. This is usually due to previous crashes. ***
>> [New Thread 10844.0x1224]
>> [New Thread 10844.0x2a30]
>> [New Thread 10844.0x2594]
>> [New Thread 10844.0x32a8]
>>
>> Thread 1 hit Breakpoint 1, aio_context_set_poll_params (ctx=0xc14a9b0,
>> max_ns=32768, grow=0, shrink=0, errp=0x362f968)
>>     at util/aio-win32.c:413
>> 413     in util/aio-win32.c
>> (gdb) s
>> error_setg_internal (errp=0x362f968, src=0xe166e0 <__func__.58569+32>
>> "util/aio-win32.c", line=413,
>>     func=0xe16740 <__func__.59050> "aio_context_set_poll_params",
>>     fmt=0xe16708 <__func__.58569+72> "AioContext polling is not
>> implemented on Windows") at util/error.c:91
>> 91      util/error.c: No such file or directory.
>> (gdb) s
>> 94      in util/error.c
>
> Great!  Now do "bt".
>
> Paolo

(gdb) bt full
#0  aio_context_set_poll_params (ctx=0xc16a9b0, max_ns=32768, grow=0,
shrink=0, errp=0x362f968) at util/aio-win32.c:413
        __func__ = "aio_context_set_poll_params"
#1  0x00000000005f7563 in iothread_complete (obj=0xc16a290,
errp=0x362fa50) at iothread.c:143
        local_error = 0x0
        iothread = 0xc16a290
        __func__ = "iothread_complete"
        name = 0xde8be9 <container_info+265> "user-creatable"
        thread_name = 0x400000000 <error: Cannot access memory at
address 0x400000000>
#2  0x0000000000831716 in user_creatable_complete (obj=0xc16a290,
errp=0x362fa50) at qom/object_interfaces.c:24
        ucc = 0x7fec650
        uc = 0xc16a290
        __func__ = "user_creatable_complete"
#3  0x000000000082cde1 in object_new_with_propv (typename=0xc4b14b
<__func__.56984+43> "iothread", parent=0xc169e50,
    id=0xc12494 <__emutls_t.iothread_locked+19167> "mon_iothread",
errp=0x14ae260 <error_abort>, vargs=0x362fb20 "")
    at qom/object.c:555
        obj = 0xc16a290
        klass = 0x7fec020
        local_err = 0x0
        __func__ = "object_new_with_propv"
#4  0x000000000082cc67 in object_new_with_props (typename=0xc4b14b
<__func__.56984+43> "iothread", parent=0xc169e50,
    id=0xc12494 <__emutls_t.iothread_locked+19167> "mon_iothread",
errp=0x14ae260 <error_abort>) at qom/object.c:516
        vargs = 0x362fb20 ""
        obj = 0xd34e26fdf887
#5  0x00000000005f7ced in iothread_create (id=0xc12494
<__emutls_t.iothread_locked+19167> "mon_iothread",
---Type <return> to continue, or q <return> to quit---
    errp=0x14ae260 <error_abort>) at iothread.c:352
        obj = 0x45bef7 <sortcmdlist+137>
        __func__ = "iothread_create"
#6  0x000000000045bf53 in monitor_iothread_init () at
/home/hsp/src/qemu-master/monitor.c:4436
No locals.
#7  0x000000000045bfcb in monitor_init_globals () at
/home/hsp/src/qemu-master/monitor.c:4464
No locals.
#8  0x00000000006064d5 in qemu_main (argc=28, argv=0x5679620,
envp=0x0) at vl.c:4545
        i = 1
        snapshot = 0
        linux_boot = 0
        initrd_filename = 0x0
        kernel_filename = 0x0
        kernel_cmdline = 0xc4e286 <runstate_transitions_def+6918> ""
        boot_order = 0x57052c0 "d"
        boot_once = 0x0
        ds = 0x7ff94aced24c
        opts = 0x5705100
        machine_opts = 0x5705560
        icount_opts = 0x0
        accel_opts = 0x0
        olist = 0xa6e000 <qemu_machine_opts>
        optind = 28
        optarg = 0x56793dd "file=c:\\Mac-disks\\9.2.img,format=raw,media=disk"
---Type <return> to continue, or q <return> to quit---
        loadvm = 0x0
        machine_class = 0x7fb28f0
        cpu_model = 0x0
        vga_model = 0x0
        qtest_chrdev = 0x0
        qtest_log = 0x0
        pid_file = 0x0
        incoming = 0x0
        userconfig = true
        nographic = false
        display_remote = 0
        log_mask = 0x0
        log_file = 0x0
        trace_file = 0x0
        maxram_size = 268435456
        ram_slots = 0
        vmstate_dump_file = 0x0
        main_loop_err = 0x0
        err = 0x0
        list_data_dirs = false
        dir = 0x8026a80 "c:\\qemu-master"
        dirs = 0x8026980
        bdo_queue = {sqh_first = 0x0, sqh_last = 0x362fda0}
        __func__ = "qemu_main"
---Type <return> to continue, or q <return> to quit---
#9  0x00000000005fc507 in SDL_main (argc=28, argv=0x5679620) at vl.c:43
No locals.
#10 0x000000000096e4e8 in main_getcmdline ()
No symbol table info available.
#11 0x00000000004013f7 in __tmainCRTStartup () at ../crt/crtexe.c:334
        lock_free = <optimized out>
        fiberid = <optimized out>
        nested = <optimized out>
        lpszCommandLine = <optimized out>
        StartupInfo = {cb = 104, lpReserved = 0x5787680 "", lpDesktop
= 0x57881f0 "Winsta0\\Default",
          lpTitle = 0x578c000 "c:\\qemu-master\\qemu-system-ppc.exe",
dwX = 0, dwY = 0, dwXSize = 0, dwYSize = 0,
          dwXCountChars = 0, dwYCountChars = 0, dwFillAttribute = 0,
dwFlags = 0, wShowWindow = 0, cbReserved2 = 0,
          lpReserved2 = 0x0, hStdInput = 0xffffffffffffffff,
hStdOutput = 0xffffffffffffffff,
          hStdError = 0xffffffffffffffff}
        inDoubleQuote = <optimized out>
#12 0x00000000004014fb in WinMainCRTStartup () at ../crt/crtexe.c:184
        ret = 255
(gdb)

Finally ;-)

Best,
Howard
