Received: from eggs.gnu.org ([2001:4830:134:3::10]:49612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cJF7T-0006T6-Jv
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 02:46:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cJF7L-0006bL-Ja
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 02:45:55 -0500
Received: from mail.ispras.ru ([83.149.199.45]:35118)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cJF7K-0006ZJ-Uo
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 02:45:47 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <000301d259dc$f9d097c0$ed71c740$@ru>
In-Reply-To: <000301d259dc$f9d097c0$ed71c740$@ru>
Date: Tue, 20 Dec 2016 10:45:44 +0300
Message-ID: <000601d25a95$12b1b9f0$38152dd0$@ru>
MIME-Version: 1.0
Content-Language: ru
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] qemu-2.8-rc4 is broken
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org, 'Pavel Dovgalyuk' <pavel.dovgaluk@ispras.ru>

It also fails much earlier when I enable logs with "-d int -D log".

Here is backtrace for this failure:

 

#0  0x0000000076e79e52 in ntdll!EtwpCreateEtwThread ()

   from /c/Windows/SYSTEM32/ntdll.dll

#1  0x0000000076e56965 in ntdll!EtwEventSetInformation ()

   from /c/Windows/SYSTEM32/ntdll.dll

#2  0x0000000076e942d9 in ntdll!RtlLogStackBackTrace ()

   from /c/Windows/SYSTEM32/ntdll.dll

#3  0x0000000076e3797c in ntdll!TpAlpcRegisterCompletionList ()

   from /c/Windows/SYSTEM32/ntdll.dll

#4  0x000007fefdc810c8 in msvcrt!free () from /c/Windows/system32/msvcrt.dll

#5  0x000000000040b6b4 in invalidate_page_bitmap (p=0x10c33498, p=0x10c33498)

    at D:/Projects/QEMU/qemu/translate-all.c:880

#6  page_flush_tb_1 (level=level@entry=0, lp=0x54f4fb0)

    at D:/Projects/QEMU/qemu/translate-all.c:899

#7  0x000000000040b6ee in page_flush_tb_1 (level=1, lp=0xac8ac0 <l1_map>)

    at D:/Projects/QEMU/qemu/translate-all.c:905

#8  0x000000000040b7b3 in page_flush_tb ()

    at D:/Projects/QEMU/qemu/translate-all.c:915

#9  do_tb_flush (cpu=<optimized out>, tb_flush_count=...)

    at D:/Projects/QEMU/qemu/translate-all.c:953

#10 0x0000000000519ac1 in process_queued_cpu_work (cpu=0x5412fd0)

    at cpus-common.c:338

#11 0x0000000000439761 in qemu_wait_io_event_common (cpu=0x5412fd0)

    at D:/Projects/QEMU/qemu/cpus.c:942

#12 qemu_tcg_wait_io_event (cpu=<optimized out>)

    at D:/Projects/QEMU/qemu/cpus.c:957

#13 qemu_tcg_cpu_thread_fn (arg=arg@entry=0x5412fd0)

    at D:/Projects/QEMU/qemu/cpus.c:1216

#14 0x000000000072c285 in win32_start_routine (arg=0x543ba70)

    at util/qemu-thread-win32.c:406

#15 0x000007fefdc8415f in srand () from /c/Windows/system32/msvcrt.dll

#16 0x000007fefdc86ebd in msvcrt!_ftime64_s ()

   from /c/Windows/system32/msvcrt.dll

#17 0x0000000076cc59cd in KERNEL32!BaseThreadInitThunk ()

   from /c/Windows/system32/kernel32.dll

#18 0x0000000076dfa561 in ntdll!RtlUserThreadStart ()

   from /c/Windows/SYSTEM32/ntdll.dll

#19 0x0000000000000000 in ?? ()

 

 

 

Another example of backtrace is the following:

 

#0  0x0000000076e8f3b0 in ntdll!RtlUnhandledExceptionFilter ()

   from /c/Windows/SYSTEM32/ntdll.dll

#1  0x0000000076e8f9c6 in ntdll!EtwEnumerateProcessRegGuids ()

   from /c/Windows/SYSTEM32/ntdll.dll

#2  0x0000000076e90592 in ntdll!RtlQueryProcessLockInformation ()

   from /c/Windows/SYSTEM32/ntdll.dll

#3  0x0000000076e92204 in ntdll!RtlLogStackBackTrace ()

   from /c/Windows/SYSTEM32/ntdll.dll

#4  0x0000000076e2d21c in ntdll!RtlIsDosDeviceName_U ()

   from /c/Windows/SYSTEM32/ntdll.dll

#5  0x000007fefdc810c8 in msvcrt!free () from /c/Windows/system32/msvcrt.dll

#6  0x000000000040c57d in invalidate_page_bitmap (p=<optimized out>,

    p=<optimized out>) at D:/Projects/QEMU/qemu/translate-all.c:880

#7  tb_invalidate_phys_page_range (start=826113, end=end@entry=826116,

    is_cpu_write_access=is_cpu_write_access@entry=0)

    at D:/Projects/QEMU/qemu/translate-all.c:1526

#8  0x000000000040c5ed in tb_invalidate_phys_range_1 (end=826116,

    start=<optimized out>) at D:/Projects/QEMU/qemu/translate-all.c:1413

#9  tb_invalidate_phys_range (start=start@entry=826113, end=end@entry=826116)

    at D:/Projects/QEMU/qemu/translate-all.c:1423

#10 0x0000000000402e5f in invalidate_and_set_dirty (mr=mr@entry=0x53fe980,

    addr=<optimized out>, length=<optimized out>)

    at D:/Projects/QEMU/qemu/exec.c:2511

#11 0x0000000000406af7 in cpu_physical_memory_write_rom_internal (

    type=WRITE_DATA, len=3, buf=0x22f141 "", addr=826113,

    as=0xab4280 <address_space_memory>) at D:/Projects/QEMU/qemu/exec.c:2795

#12 cpu_physical_memory_write_rom (as=0xab4280 <address_space_memory>,

    addr=<optimized out>, buf=<optimized out>, len=<optimized out>)

    at D:/Projects/QEMU/qemu/exec.c:2813

#13 0x0000000000470a35 in apic_sync_vapic (s=s@entry=0x507f0a0,

    sync_type=sync_type@entry=4) at D:/Projects/QEMU/qemu/hw/intc/apic.c:125

#14 0x000000000047163e in apic_set_irq (s=0x507f0a0,

    vector_num=<optimized out>, trigger_mode=0)

    at D:/Projects/QEMU/qemu/hw/intc/apic.c:396

#15 0x0000000000471aa3 in apic_bus_deliver (deliver_bitmask=<optimized out>,

    delivery_mode=<optimized out>, vector_num=<optimized out>,

    trigger_mode=<optimized out>) at D:/Projects/QEMU/qemu/hw/intc/apic.c:234

#16 0x0000000000471b1e in apic_deliver_irq (dest=1 '\001',

    dest_mode=1 '\001', delivery_mode=1 '\001', vector_num=163 '\243',

    trigger_mode=0 '\000') at D:/Projects/QEMU/qemu/hw/intc/apic.c:284

#17 0x0000000000471bf2 in apic_send_msi (msi=msi@entry=0x22f320)

    at D:/Projects/QEMU/qemu/hw/intc/apic.c:753

#18 0x0000000000471f76 in apic_mem_writel (opaque=<optimized out>, addr=4100,

    val=419) at D:/Projects/QEMU/qemu/hw/intc/apic.c:768

#19 0x000000000044bcbd in memory_region_oldmmio_write_accessor (mr=0x507f110,

    addr=4100, value=<optimized out>, size=4, shift=0, mask=4294967295,

    attrs=...) at D:/Projects/QEMU/qemu/memory.c:500

#20 0x0000000000448576 in access_with_adjusted_size (addr=addr@entry=4100,

    value=value@entry=0x22f620, size=size@entry=4,

    access_size_min=access_size_min@entry=1,

    access_size_max=access_size_max@entry=4,

    access=access@entry=0x44bc20 <memory_region_oldmmio_write_accessor>,

    mr=mr@entry=0x507f110, attrs=attrs@entry=...)

    at D:/Projects/QEMU/qemu/memory.c:592

#21 0x000000000044cdae in memory_region_dispatch_write (mr=<optimized out>,

    mr@entry=0x507f110, addr=4100, data=data@entry=419, size=<optimized out>,

    size@entry=4, attrs=attrs@entry=...)

    at D:/Projects/QEMU/qemu/memory.c:1336

#22 0x0000000000409f63 in address_space_stl_internal (

    endian=DEVICE_LITTLE_ENDIAN, result=0x0, attrs=..., val=419,

    addr=1756135440, as=0x0) at D:/Projects/QEMU/qemu/exec.c:3433

#23 address_space_stl_le (result=0x0, attrs=..., val=419, addr=1756135440,

    as=0x0) at D:/Projects/QEMU/qemu/exec.c:3470

#24 stl_le_phys (as=as@entry=0xab4280 <address_space_memory>,

    addr=addr@entry=4276097028, val=419) at D:/Projects/QEMU/qemu/exec.c:3488

#25 0x0000000000473941 in ioapic_service (s=0x1182e1d0)

    at D:/Projects/QEMU/qemu/hw/intc/ioapic.c:144

#26 0x000000000059062a in ps2_queue (b=24, opaque=0x11c809d0)

    at hw/input/ps2.c:549

#27 ps2_mouse_send_packet (s=s@entry=0x11c809d0) at hw/input/ps2.c:839

#28 0x0000000000590b51 in ps2_mouse_sync (dev=0x11c809d0)

    at hw/input/ps2.c:927

#29 0x000000000066515a in qemu_input_event_sync_impl () at ui/input.c:351

#30 0x0000000000666917 in sdl_send_mouse_event (dx=<optimized out>,

    dy=<optimized out>, x=<optimized out>, y=<optimized out>, state=0,

    scon=<optimized out>, scon=<optimized out>) at ui/sdl2.c:315

#31 0x0000000000667112 in handle_mousemotion (ev=0x22f970) at ui/sdl2.c:482

#32 sdl2_poll_events (scon=0x1230c260) at ui/sdl2.c:619

#33 0x000000000065f622 in dpy_refresh (s=0x119ba030) at ui/console.c:1560

#34 gui_update (opaque=opaque@entry=0x119ba030) at ui/console.c:200

#35 0x000000000068d60c in timerlist_run_timers (timer_list=0x5022d40)

    at qemu-timer.c:528

#36 0x000000000068d823 in qemu_clock_run_timers (type=<optimized out>)

    at qemu-timer.c:539

#37 qemu_clock_run_all_timers () at qemu-timer.c:653

#38 0x000000000068c94e in main_loop_wait (nonblocking=<optimized out>)

    at main-loop.c:516

#39 0x00000000005023b0 in main_loop () at vl.c:1966

#40 qemu_main (argc=argc@entry=12, argv=argv@entry=0x3a0130,

    envp=envp@entry=0x0) at vl.c:4684

#41 0x00000000005033c8 in SDL_main (argc=argc@entry=12,

    argv=argv@entry=0x3a0130) at vl.c:45

#42 0x000000000074088a in main_utf8 (argv=0x3a0130, argc=<optimized out>)

    at ../src/main/windows/SDL_windows_main.c:126

#43 WinMain (hInst=<optimized out>, hPrev=hPrev@entry=0x0,

    szCmdLine=<optimized out>, sw=<optimized out>)

    at ../src/main/windows/SDL_windows_main.c:189

#44 0x0000000000754862 in main (flags=<optimized out>,

    cmdline=<optimized out>, inst=<optimized out>)

    at C:/repo/mingw-w64-crt-git/src/mingw-w64/mingw-w64-crt/crt/crt0_c.c:18

#45 0x00000000004013ed in __tmainCRTStartup ()

    at C:/repo/mingw-w64-crt-git/src/mingw-w64/mingw-w64-crt/crt/crtexe.c:334

#46 0x00000000004014fb in WinMainCRTStartup ()

    at C:/repo/mingw-w64-crt-git/src/mingw-w64/mingw-w64-crt/crt/crtexe.c:184

 

Pavel Dovgalyuk

 

From: Pavel Dovgalyuk [mailto:dovgaluk@ispras.ru] 
Sent: Monday, December 19, 2016 12:48 PM
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com; peter.maydell@linaro.org; 'Pavel Dovgalyuk'
Subject: qemu-2.8-rc4 is broken

 

Hi!

 

I encountered the following bug with the latest version of QEMU.

I use windows host and start qemu with the following command line:

qemu-system-i386.exe -soundhw ac97 -snapshot -hda disk.qcow2 -net none

 

Guest system is Windows XP 32-bit. It founds new hardware (including audio controller)

and I start playing mp3 file.

After seconds of playing qemu fails with an exception.

 

I tried to bisect between 2.7 and 2.8, but bug is not stable.

It manifested itself at commits "68701de1362b29fd6941a2021e9393ddbe60edd8" and
"6a928d25b6d8bc3729c3d28326c6db13b9481059".

 

Pavel Dovgalyuk

 
