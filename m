Received: from eggs.gnu.org ([2001:4830:134:3::10]:37872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cJHY6-0006xL-W5
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 05:21:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cJHY2-0007q1-71
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 05:21:35 -0500
Received: from mail-wj0-x242.google.com ([2a00:1450:400c:c01::242]:36359)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cJHY1-0007pM-TE
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 05:21:30 -0500
Received: by mail-wj0-x242.google.com with SMTP id j10so26984041wjb.3
	for <qemu-devel@nongnu.org>; Tue, 20 Dec 2016 02:21:29 -0800 (PST)
Date: Tue, 20 Dec 2016 10:21:26 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20161220102126.GE5602@stefanha-x1.localdomain>
References: <000301d259dc$f9d097c0$ed71c740$@ru>
	<000601d25a95$12b1b9f0$38152dd0$@ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k3qmt+ucFURmlhDS"
Content-Disposition: inline
In-Reply-To: <000601d25a95$12b1b9f0$38152dd0$@ru>
Subject: Re: [Qemu-devel] qemu-2.8-rc4 is broken
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, 'Pavel Dovgalyuk' <pavel.dovgaluk@ispras.ru>, peter.maydell@linaro.org


--k3qmt+ucFURmlhDS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 20, 2016 at 10:45:44AM +0300, Pavel Dovgalyuk wrote:
> It also fails much earlier when I enable logs with "-d int -D log".
>=20
> Here is backtrace for this failure:
>=20
> =20
>=20
> #0  0x0000000076e79e52 in ntdll!EtwpCreateEtwThread ()
>=20
>    from /c/Windows/SYSTEM32/ntdll.dll
>=20
> #1  0x0000000076e56965 in ntdll!EtwEventSetInformation ()
>=20
>    from /c/Windows/SYSTEM32/ntdll.dll
>=20
> #2  0x0000000076e942d9 in ntdll!RtlLogStackBackTrace ()
>=20
>    from /c/Windows/SYSTEM32/ntdll.dll
>=20
> #3  0x0000000076e3797c in ntdll!TpAlpcRegisterCompletionList ()
>=20
>    from /c/Windows/SYSTEM32/ntdll.dll
>=20
> #4  0x000007fefdc810c8 in msvcrt!free () from /c/Windows/system32/msvcrt.=
dll

Looks like a heap corruption bug since free() is failing.

QEMU 2.8.0 is scheduled for release today.  I have checked that
qemu-system-i386.exe works but without playing an MP3 file in Windows
XP.

I plan to go ahead with the release unless information becomes available
that suggests it affects more than just this one scenario.

>=20
> #5  0x000000000040b6b4 in invalidate_page_bitmap (p=3D0x10c33498, p=3D0x1=
0c33498)
>=20
>     at D:/Projects/QEMU/qemu/translate-all.c:880
>=20
> #6  page_flush_tb_1 (level=3Dlevel@entry=3D0, lp=3D0x54f4fb0)
>=20
>     at D:/Projects/QEMU/qemu/translate-all.c:899
>=20
> #7  0x000000000040b6ee in page_flush_tb_1 (level=3D1, lp=3D0xac8ac0 <l1_m=
ap>)
>=20
>     at D:/Projects/QEMU/qemu/translate-all.c:905
>=20
> #8  0x000000000040b7b3 in page_flush_tb ()
>=20
>     at D:/Projects/QEMU/qemu/translate-all.c:915
>=20
> #9  do_tb_flush (cpu=3D<optimized out>, tb_flush_count=3D...)
>=20
>     at D:/Projects/QEMU/qemu/translate-all.c:953
>=20
> #10 0x0000000000519ac1 in process_queued_cpu_work (cpu=3D0x5412fd0)
>=20
>     at cpus-common.c:338
>=20
> #11 0x0000000000439761 in qemu_wait_io_event_common (cpu=3D0x5412fd0)
>=20
>     at D:/Projects/QEMU/qemu/cpus.c:942
>=20
> #12 qemu_tcg_wait_io_event (cpu=3D<optimized out>)
>=20
>     at D:/Projects/QEMU/qemu/cpus.c:957
>=20
> #13 qemu_tcg_cpu_thread_fn (arg=3Darg@entry=3D0x5412fd0)
>=20
>     at D:/Projects/QEMU/qemu/cpus.c:1216
>=20
> #14 0x000000000072c285 in win32_start_routine (arg=3D0x543ba70)
>=20
>     at util/qemu-thread-win32.c:406
>=20
> #15 0x000007fefdc8415f in srand () from /c/Windows/system32/msvcrt.dll
>=20
> #16 0x000007fefdc86ebd in msvcrt!_ftime64_s ()
>=20
>    from /c/Windows/system32/msvcrt.dll
>=20
> #17 0x0000000076cc59cd in KERNEL32!BaseThreadInitThunk ()
>=20
>    from /c/Windows/system32/kernel32.dll
>=20
> #18 0x0000000076dfa561 in ntdll!RtlUserThreadStart ()
>=20
>    from /c/Windows/SYSTEM32/ntdll.dll
>=20
> #19 0x0000000000000000 in ?? ()
>=20
> =20
>=20
> =20
>=20
> =20
>=20
> Another example of backtrace is the following:
>=20
> =20
>=20
> #0  0x0000000076e8f3b0 in ntdll!RtlUnhandledExceptionFilter ()
>=20
>    from /c/Windows/SYSTEM32/ntdll.dll
>=20
> #1  0x0000000076e8f9c6 in ntdll!EtwEnumerateProcessRegGuids ()
>=20
>    from /c/Windows/SYSTEM32/ntdll.dll
>=20
> #2  0x0000000076e90592 in ntdll!RtlQueryProcessLockInformation ()
>=20
>    from /c/Windows/SYSTEM32/ntdll.dll
>=20
> #3  0x0000000076e92204 in ntdll!RtlLogStackBackTrace ()
>=20
>    from /c/Windows/SYSTEM32/ntdll.dll
>=20
> #4  0x0000000076e2d21c in ntdll!RtlIsDosDeviceName_U ()
>=20
>    from /c/Windows/SYSTEM32/ntdll.dll
>=20
> #5  0x000007fefdc810c8 in msvcrt!free () from /c/Windows/system32/msvcrt.=
dll
>=20
> #6  0x000000000040c57d in invalidate_page_bitmap (p=3D<optimized out>,
>=20
>     p=3D<optimized out>) at D:/Projects/QEMU/qemu/translate-all.c:880
>=20
> #7  tb_invalidate_phys_page_range (start=3D826113, end=3Dend@entry=3D8261=
16,
>=20
>     is_cpu_write_access=3Dis_cpu_write_access@entry=3D0)
>=20
>     at D:/Projects/QEMU/qemu/translate-all.c:1526
>=20
> #8  0x000000000040c5ed in tb_invalidate_phys_range_1 (end=3D826116,
>=20
>     start=3D<optimized out>) at D:/Projects/QEMU/qemu/translate-all.c:1413
>=20
> #9  tb_invalidate_phys_range (start=3Dstart@entry=3D826113, end=3Dend@ent=
ry=3D826116)
>=20
>     at D:/Projects/QEMU/qemu/translate-all.c:1423
>=20
> #10 0x0000000000402e5f in invalidate_and_set_dirty (mr=3Dmr@entry=3D0x53f=
e980,
>=20
>     addr=3D<optimized out>, length=3D<optimized out>)
>=20
>     at D:/Projects/QEMU/qemu/exec.c:2511
>=20
> #11 0x0000000000406af7 in cpu_physical_memory_write_rom_internal (
>=20
>     type=3DWRITE_DATA, len=3D3, buf=3D0x22f141 "", addr=3D826113,
>=20
>     as=3D0xab4280 <address_space_memory>) at D:/Projects/QEMU/qemu/exec.c=
:2795
>=20
> #12 cpu_physical_memory_write_rom (as=3D0xab4280 <address_space_memory>,
>=20
>     addr=3D<optimized out>, buf=3D<optimized out>, len=3D<optimized out>)
>=20
>     at D:/Projects/QEMU/qemu/exec.c:2813
>=20
> #13 0x0000000000470a35 in apic_sync_vapic (s=3Ds@entry=3D0x507f0a0,
>=20
>     sync_type=3Dsync_type@entry=3D4) at D:/Projects/QEMU/qemu/hw/intc/api=
c.c:125
>=20
> #14 0x000000000047163e in apic_set_irq (s=3D0x507f0a0,
>=20
>     vector_num=3D<optimized out>, trigger_mode=3D0)
>=20
>     at D:/Projects/QEMU/qemu/hw/intc/apic.c:396
>=20
> #15 0x0000000000471aa3 in apic_bus_deliver (deliver_bitmask=3D<optimized =
out>,
>=20
>     delivery_mode=3D<optimized out>, vector_num=3D<optimized out>,
>=20
>     trigger_mode=3D<optimized out>) at D:/Projects/QEMU/qemu/hw/intc/apic=
=2Ec:234
>=20
> #16 0x0000000000471b1e in apic_deliver_irq (dest=3D1 '\001',
>=20
>     dest_mode=3D1 '\001', delivery_mode=3D1 '\001', vector_num=3D163 '\24=
3',
>=20
>     trigger_mode=3D0 '\000') at D:/Projects/QEMU/qemu/hw/intc/apic.c:284
>=20
> #17 0x0000000000471bf2 in apic_send_msi (msi=3Dmsi@entry=3D0x22f320)
>=20
>     at D:/Projects/QEMU/qemu/hw/intc/apic.c:753
>=20
> #18 0x0000000000471f76 in apic_mem_writel (opaque=3D<optimized out>, addr=
=3D4100,
>=20
>     val=3D419) at D:/Projects/QEMU/qemu/hw/intc/apic.c:768
>=20
> #19 0x000000000044bcbd in memory_region_oldmmio_write_accessor (mr=3D0x50=
7f110,
>=20
>     addr=3D4100, value=3D<optimized out>, size=3D4, shift=3D0, mask=3D429=
4967295,
>=20
>     attrs=3D...) at D:/Projects/QEMU/qemu/memory.c:500
>=20
> #20 0x0000000000448576 in access_with_adjusted_size (addr=3Daddr@entry=3D=
4100,
>=20
>     value=3Dvalue@entry=3D0x22f620, size=3Dsize@entry=3D4,
>=20
>     access_size_min=3Daccess_size_min@entry=3D1,
>=20
>     access_size_max=3Daccess_size_max@entry=3D4,
>=20
>     access=3Daccess@entry=3D0x44bc20 <memory_region_oldmmio_write_accesso=
r>,
>=20
>     mr=3Dmr@entry=3D0x507f110, attrs=3Dattrs@entry=3D...)
>=20
>     at D:/Projects/QEMU/qemu/memory.c:592
>=20
> #21 0x000000000044cdae in memory_region_dispatch_write (mr=3D<optimized o=
ut>,
>=20
>     mr@entry=3D0x507f110, addr=3D4100, data=3Ddata@entry=3D419, size=3D<o=
ptimized out>,
>=20
>     size@entry=3D4, attrs=3Dattrs@entry=3D...)
>=20
>     at D:/Projects/QEMU/qemu/memory.c:1336
>=20
> #22 0x0000000000409f63 in address_space_stl_internal (
>=20
>     endian=3DDEVICE_LITTLE_ENDIAN, result=3D0x0, attrs=3D..., val=3D419,
>=20
>     addr=3D1756135440, as=3D0x0) at D:/Projects/QEMU/qemu/exec.c:3433
>=20
> #23 address_space_stl_le (result=3D0x0, attrs=3D..., val=3D419, addr=3D17=
56135440,
>=20
>     as=3D0x0) at D:/Projects/QEMU/qemu/exec.c:3470
>=20
> #24 stl_le_phys (as=3Das@entry=3D0xab4280 <address_space_memory>,
>=20
>     addr=3Daddr@entry=3D4276097028, val=3D419) at D:/Projects/QEMU/qemu/e=
xec.c:3488
>=20
> #25 0x0000000000473941 in ioapic_service (s=3D0x1182e1d0)
>=20
>     at D:/Projects/QEMU/qemu/hw/intc/ioapic.c:144
>=20
> #26 0x000000000059062a in ps2_queue (b=3D24, opaque=3D0x11c809d0)
>=20
>     at hw/input/ps2.c:549
>=20
> #27 ps2_mouse_send_packet (s=3Ds@entry=3D0x11c809d0) at hw/input/ps2.c:839
>=20
> #28 0x0000000000590b51 in ps2_mouse_sync (dev=3D0x11c809d0)
>=20
>     at hw/input/ps2.c:927
>=20
> #29 0x000000000066515a in qemu_input_event_sync_impl () at ui/input.c:351
>=20
> #30 0x0000000000666917 in sdl_send_mouse_event (dx=3D<optimized out>,
>=20
>     dy=3D<optimized out>, x=3D<optimized out>, y=3D<optimized out>, state=
=3D0,
>=20
>     scon=3D<optimized out>, scon=3D<optimized out>) at ui/sdl2.c:315
>=20
> #31 0x0000000000667112 in handle_mousemotion (ev=3D0x22f970) at ui/sdl2.c=
:482
>=20
> #32 sdl2_poll_events (scon=3D0x1230c260) at ui/sdl2.c:619
>=20
> #33 0x000000000065f622 in dpy_refresh (s=3D0x119ba030) at ui/console.c:15=
60
>=20
> #34 gui_update (opaque=3Dopaque@entry=3D0x119ba030) at ui/console.c:200
>=20
> #35 0x000000000068d60c in timerlist_run_timers (timer_list=3D0x5022d40)
>=20
>     at qemu-timer.c:528
>=20
> #36 0x000000000068d823 in qemu_clock_run_timers (type=3D<optimized out>)
>=20
>     at qemu-timer.c:539
>=20
> #37 qemu_clock_run_all_timers () at qemu-timer.c:653
>=20
> #38 0x000000000068c94e in main_loop_wait (nonblocking=3D<optimized out>)
>=20
>     at main-loop.c:516
>=20
> #39 0x00000000005023b0 in main_loop () at vl.c:1966
>=20
> #40 qemu_main (argc=3Dargc@entry=3D12, argv=3Dargv@entry=3D0x3a0130,
>=20
>     envp=3Denvp@entry=3D0x0) at vl.c:4684
>=20
> #41 0x00000000005033c8 in SDL_main (argc=3Dargc@entry=3D12,
>=20
>     argv=3Dargv@entry=3D0x3a0130) at vl.c:45
>=20
> #42 0x000000000074088a in main_utf8 (argv=3D0x3a0130, argc=3D<optimized o=
ut>)
>=20
>     at ../src/main/windows/SDL_windows_main.c:126
>=20
> #43 WinMain (hInst=3D<optimized out>, hPrev=3DhPrev@entry=3D0x0,
>=20
>     szCmdLine=3D<optimized out>, sw=3D<optimized out>)
>=20
>     at ../src/main/windows/SDL_windows_main.c:189
>=20
> #44 0x0000000000754862 in main (flags=3D<optimized out>,
>=20
>     cmdline=3D<optimized out>, inst=3D<optimized out>)
>=20
>     at C:/repo/mingw-w64-crt-git/src/mingw-w64/mingw-w64-crt/crt/crt0_c.c=
:18
>=20
> #45 0x00000000004013ed in __tmainCRTStartup ()
>=20
>     at C:/repo/mingw-w64-crt-git/src/mingw-w64/mingw-w64-crt/crt/crtexe.c=
:334
>=20
> #46 0x00000000004014fb in WinMainCRTStartup ()
>=20
>     at C:/repo/mingw-w64-crt-git/src/mingw-w64/mingw-w64-crt/crt/crtexe.c=
:184
>=20
> =20
>=20
> Pavel Dovgalyuk
>=20
> =20
>=20
> From: Pavel Dovgalyuk [mailto:dovgaluk@ispras.ru]=20
> Sent: Monday, December 19, 2016 12:48 PM
> To: qemu-devel@nongnu.org
> Cc: pbonzini@redhat.com; peter.maydell@linaro.org; 'Pavel Dovgalyuk'
> Subject: qemu-2.8-rc4 is broken
>=20
> =20
>=20
> Hi!
>=20
> =20
>=20
> I encountered the following bug with the latest version of QEMU.
>=20
> I use windows host and start qemu with the following command line:
>=20
> qemu-system-i386.exe -soundhw ac97 -snapshot -hda disk.qcow2 -net none
>=20
> =20
>=20
> Guest system is Windows XP 32-bit. It founds new hardware (including audi=
o controller)
>=20
> and I start playing mp3 file.
>=20
> After seconds of playing qemu fails with an exception.
>=20
> =20
>=20
> I tried to bisect between 2.7 and 2.8, but bug is not stable.
>=20
> It manifested itself at commits "68701de1362b29fd6941a2021e9393ddbe60edd8=
" and
> "6a928d25b6d8bc3729c3d28326c6db13b9481059".
>=20
> =20
>=20
> Pavel Dovgalyuk
>=20
> =20
>=20

--k3qmt+ucFURmlhDS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYWQYmAAoJEJykq7OBq3PIKmwIAJ48rahrgqLddTc6LUsCNcqa
MHz0SdVRk6bX0rznpu3myNsw+uYoTQHwVfp5NADWMnbpFEk0rqk2f1JFT0RKMFKa
MU7r5I/CzPMva7QlGQlcj7qXgy1hJ+9tnlvQ/t+ESZvHIAYpfPqQAeKB7QDvRGYa
EkQib+sTSdX/fI9/Lnt0zK07trOXB1IIR8P5g60Qiy0R9VEXNrE5Bgb/85xw2tQ1
7u+FMFjFj5kAkU8WV9XhJGSu0E4cePuXSFRO8eqH0n+OM3znCjPlC4WFieKslg/l
5YjFI3z9Xsh8EVpNdDMIzErMHqclyvWoP4QwqAr5MjszDUYfz+W5KwJ2gaPiU8w=
=9G3U
-----END PGP SIGNATURE-----

--k3qmt+ucFURmlhDS--
