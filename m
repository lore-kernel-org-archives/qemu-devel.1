Received: from eggs.gnu.org ([209.51.188.92]:58543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1goAox-0007et-3w
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:35:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1goAov-0008IS-Ba
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:35:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51106)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1goAov-0008G4-34
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:35:41 -0500
Date: Mon, 28 Jan 2019 17:35:36 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190128173536.GE2585@work-vm>
References: <RO1P152MB1483190501127990FEBFCE9A97940@RO1P152MB1483.LAMP152.PROD.OUTLOOK.COM>
	<20190128121331.GB2939@work-vm>
	<RO1P152MB1483C38DCFD740BD8982F39597960@RO1P152MB1483.LAMP152.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <RO1P152MB1483C38DCFD740BD8982F39597960@RO1P152MB1483.LAMP152.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Crash when booting KDE Neon using qxl-vga
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Leonardo Soares =?iso-8859-1?Q?M=FCller?= <leozinho29_eu@hotmail.com>
Cc: "kraxel@redhat.com" <kraxel@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

* Leonardo Soares M=FCller (leozinho29_eu@hotmail.com) wrote:
> Here is the backtrace with the debug symbols added:

OK, great;  can can you confirm the version of the spice packages
on both the guest and host, and the kernel on the guest.

Dave

> (gdb) bt
> #0  0x00007ffff0373e97 in __GI_raise (sig=3Dsig@entry=3D6) at
> ../sysdeps/unix/sysv/linux/raise.c:51
> #1  0x00007ffff0375801 in __GI_abort () at abort.c:79
> #2  0x00007ffff1171cc9 in spice_logv (log_domain=3D0x7ffff11dc9f5 "Spic=
e",
> args=3D0x7fff36028cb0, format=3D0x7ffff11e3c5b "slot_id %d too big,
> addr=3D%lx", function=3D0x7ffff11e3d90 <__FUNCTION__.15594>
> "memslot_get_virt", strloc=3D0x7ffff11e3c78 "memslot.c:111",
> log_level=3DG_LOG_LEVEL_CRITICAL) at log.c:183
> #3  0x00007ffff1171cc9 in spice_log
> (log_level=3Dlog_level@entry=3DG_LOG_LEVEL_CRITICAL,
> strloc=3Dstrloc@entry=3D0x7ffff11e3c78 "memslot.c:111",
> function=3Dfunction@entry=3D0x7ffff11e3d90 <__FUNCTION__.15594>
> "memslot_get_virt", format=3Dformat@entry=3D0x7ffff11e3c5b "slot_id %d =
too
> big, addr=3D%lx") at log.c:196
> #4  0x00007ffff11373b8 in memslot_get_virt
> (info=3Dinfo@entry=3D0x5555579b8630, addr=3Daddr@entry=3D18374686483949=
813760,
> add_size=3Dadd_size@entry=3D10, group_id=3Dgroup_id@entry=3D1,
> error=3Derror@entry=3D0x7fff36028e08)
>     at memslot.c:111
> #5  0x00007ffff11407d0 in red_get_image
> (slots=3Dslots@entry=3D0x5555579b8630, group_id=3Dgroup_id@entry=3D1,
> addr=3D<optimized out>, flags=3Dflags@entry=3D0, is_mask=3Dis_mask@entr=
y=3Dfalse)
> at red-parse-qxl.c:512
> #6  0x00007ffff1140a76 in red_get_copy_ptr
> (slots=3Dslots@entry=3D0x5555579b8630, group_id=3Dgroup_id@entry=3D1,
> red=3Dred@entry=3D0x7fff1409f5f0, qxl=3D0x7fff1fe0107b, flags=3Dflags@e=
ntry=3D0)
> at red-parse-qxl.c:680
> #7  0x00007ffff11419a1 in red_get_native_drawable (flags=3D<optimized
> out>, addr=3D<optimized out>, red=3D<optimized out>, group_id=3D<optimi=
zed
> out>, slots=3D<optimized out>) at red-parse-qxl.c:1072
> #8  0x00007ffff11419a1 in red_get_drawable
> (slots=3Dslots@entry=3D0x5555579b8630, group_id=3D1,
> red=3Dred@entry=3D0x7fff1409f550, addr=3D<optimized out>, flags=3D0) at
> red-parse-qxl.c:1206
> #9  0x00007ffff11543cd in red_process_display (worker=3D0x5555579b85a0,
> ring_is_empty=3D0x7fff36028f9c) at red-worker.c:224
> #10 0x00007ffff1152d21 in flush_commands
> (worker=3Dworker@entry=3D0x5555579b85a0, red_channel=3D0x5555579b4a10,
> process=3Dprocess@entry=3D0x7ffff1154220 <red_process_display>) at
> red-worker.c:315
> #11 0x00007ffff1152e58 in flush_display_commands
> (worker=3Dworker@entry=3D0x5555579b85a0) at red-worker.c:352
> #12 0x00007ffff11534bf in flush_all_qxl_commands (worker=3D0x5555579b85=
a0)
> at red-worker.c:367
> #13 0x00007ffff11534bf in destroy_primary_surface
> (worker=3D0x5555579b85a0, surface_id=3D0) at red-worker.c:558
> #14 0x00007ffff11214f1 in dispatcher_handle_single_read
> (dispatcher=3D0x555556a0c1c0) at dispatcher.c:284
> #15 0x00007ffff11214f1 in dispatcher_handle_recv_read
> (dispatcher=3D0x555556a0c1c0) at dispatcher.c:304
> #16 0x00007ffff1127d7b in watch_func (source=3D<optimized out>,
> condition=3D<optimized out>, data=3D0x5555579b8780) at event-loop.c:128
> #17 0x00007ffff47931f5 in g_main_context_dispatch () at
> /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
> #18 0x00007ffff47935c0 in  () at /usr/lib/x86_64-linux-gnu/libglib-2.0.=
so.0
> #19 0x00007ffff47938d2 in g_main_loop_run () at
> /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
> #20 0x00007ffff1153b3a in red_worker_main (arg=3D0x5555579b85a0) at
> red-worker.c:1372
> #21 0x00007ffff072d6db in start_thread (arg=3D0x7fff3602c700) at
> pthread_create.c:463
> #22 0x00007ffff045688f in clone () at
> ../sysdeps/unix/sysv/linux/x86_64/clone.S:95
>=20
>=20
> =C0s 10:13 de 28/01/2019, Dr. David Alan Gilbert escreveu:
> >=20
> > Thanks for the report,
> >=20
> > Could you install the debug packages of libspice-server on your syste=
m
> > so that the backtrace you get has symbols?
> >=20
> > Dave
> >=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
