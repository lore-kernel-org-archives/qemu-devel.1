Received: from eggs.gnu.org ([2001:4830:134:3::10]:35773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <taimoor.mrza@gmail.com>) id 1djmLU-00086e-VB
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 09:02:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <taimoor.mrza@gmail.com>) id 1djmLN-0001kU-UI
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 09:02:18 -0400
Received: from mail-lf0-x231.google.com ([2a00:1450:4010:c07::231]:33653)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <taimoor.mrza@gmail.com>)
	id 1djmLN-0001kB-ME
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 09:02:13 -0400
Received: by mail-lf0-x231.google.com with SMTP id d17so66457388lfe.0
	for <qemu-devel@nongnu.org>; Mon, 21 Aug 2017 06:02:09 -0700 (PDT)
MIME-Version: 1.0
From: Taimoor Mirza <taimoor.mrza@gmail.com>
Date: Mon, 21 Aug 2017 18:02:07 +0500
Message-ID: <CAO6-N=a7WwhsDqZsm=wppXWMunGub=RH17FBk5w_tK0vu-8=cQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] stack smash while using SDL 1.2.5 with QEMU 2.9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>

Hi Guys,

I have been using QEMU 1.5 earlier with SDL version 1.2.5. Now we have
decided to move to new version of QEMU. I have built QEMU binaries with SDL
support using SDL 1.2.5 that we were using earlier. Windows binaries work
fine but I get stack smash in sdl.c on Linux. Below are stack traces that I
have got from GDB:

Program received signal SIGABRT, Aborted.
0x00007ffff6e74c37 in __GI_raise (sig=sig@entry=6) at
../nptl/sysdeps/unix/sysv/linux/raise.c:56
56    ../nptl/sysdeps/unix/sysv/linux/raise.c: No such file or directory.
(gdb) bt
#0  0x00007ffff6e74c37 in __GI_raise (sig=sig@entry=6) at
../nptl/sysdeps/unix/sysv/linux/raise.c:56
#1  0x00007ffff6e78028 in __GI_abort () at abort.c:89
#2  0x00007ffff6eb12a4 in __libc_message (do_abort=do_abort@entry=1,
fmt=fmt@entry=0x7ffff6fc0d70 "*** %s ***: %s terminated\n") at
../sysdeps/posix/libc_fatal.c:175
#3  0x00007ffff6f4c83c in __GI___fortify_fail (msg=<optimized out>,
msg@entry=0x7ffff6fc0d58 "stack smashing detected") at fortify_fail.c:38
#4  0x00007ffff6f4c7e0 in __stack_chk_fail () at stack_chk_fail.c:28
#5  0x0000555555a66909 in sdl_display_init (ds=<optimized out>,
full_screen=0, no_frame=<optimized out>) at
/scratch/tmirza/builds/qemu_build/obj/qemu-src-master-999999-arm-linux-gnueabi-x86_64-linux-gnu/ui/sdl.c:1054
#6  0x0000000006e00002 in ?? ()
#7  0x0000000006e00003 in ?? ()
#8  0x0000555556feca30 in ?? ()
#9  0x0000555555c784e1 in ?? ()
#10 0x0000000000000000 in ?? ()

I want to know whether it is a known issue and Is QEMU 2.9 compatible with
SDL 1.2.5?

Thanks,
Taimoor Mirza
