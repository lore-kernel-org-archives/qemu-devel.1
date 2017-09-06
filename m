Received: from eggs.gnu.org ([2001:4830:134:3::10]:36054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dpTpV-0006Fq-Q3
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 02:28:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dpTpS-00006U-Mp
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 02:28:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33614)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dpTpS-00006D-Gt
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 02:28:50 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <CAO6-N=a7WwhsDqZsm=wppXWMunGub=RH17FBk5w_tK0vu-8=cQ@mail.gmail.com>
Date: Wed, 06 Sep 2017 08:28:44 +0200
In-Reply-To: <CAO6-N=a7WwhsDqZsm=wppXWMunGub=RH17FBk5w_tK0vu-8=cQ@mail.gmail.com>
	(Taimoor Mirza's message of "Mon, 21 Aug 2017 18:02:07 +0500")
Message-ID: <87tw0ge3xf.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] stack smash while using SDL 1.2.5 with QEMU 2.9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Taimoor Mirza <taimoor.mrza@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

Gerd, any ideas?

Taimoor Mirza <taimoor.mrza@gmail.com> writes:

> Hi Guys,
>
> I have been using QEMU 1.5 earlier with SDL version 1.2.5. Now we have
> decided to move to new version of QEMU. I have built QEMU binaries with SDL
> support using SDL 1.2.5 that we were using earlier. Windows binaries work
> fine but I get stack smash in sdl.c on Linux. Below are stack traces that I
> have got from GDB:
>
> Program received signal SIGABRT, Aborted.
> 0x00007ffff6e74c37 in __GI_raise (sig=sig@entry=6) at
> ../nptl/sysdeps/unix/sysv/linux/raise.c:56
> 56    ../nptl/sysdeps/unix/sysv/linux/raise.c: No such file or directory.
> (gdb) bt
> #0  0x00007ffff6e74c37 in __GI_raise (sig=sig@entry=6) at
> ../nptl/sysdeps/unix/sysv/linux/raise.c:56
> #1  0x00007ffff6e78028 in __GI_abort () at abort.c:89
> #2  0x00007ffff6eb12a4 in __libc_message (do_abort=do_abort@entry=1,
> fmt=fmt@entry=0x7ffff6fc0d70 "*** %s ***: %s terminated\n") at
> ../sysdeps/posix/libc_fatal.c:175
> #3  0x00007ffff6f4c83c in __GI___fortify_fail (msg=<optimized out>,
> msg@entry=0x7ffff6fc0d58 "stack smashing detected") at fortify_fail.c:38
> #4  0x00007ffff6f4c7e0 in __stack_chk_fail () at stack_chk_fail.c:28
> #5  0x0000555555a66909 in sdl_display_init (ds=<optimized out>,
> full_screen=0, no_frame=<optimized out>) at
> /scratch/tmirza/builds/qemu_build/obj/qemu-src-master-999999-arm-linux-gnueabi-x86_64-linux-gnu/ui/sdl.c:1054
> #6  0x0000000006e00002 in ?? ()
> #7  0x0000000006e00003 in ?? ()
> #8  0x0000555556feca30 in ?? ()
> #9  0x0000555555c784e1 in ?? ()
> #10 0x0000000000000000 in ?? ()
>
> I want to know whether it is a known issue and Is QEMU 2.9 compatible with
> SDL 1.2.5?
>
> Thanks,
> Taimoor Mirza
