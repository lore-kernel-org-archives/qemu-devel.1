Received: from eggs.gnu.org ([2001:4830:134:3::10]:44334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a175818323@gmail.com>) id 1gZadb-0002CD-2a
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 07:07:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a175818323@gmail.com>) id 1gZada-0007yV-4O
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 07:07:43 -0500
MIME-Version: 1.0
References: <CAMxP3BRZ1hZ0_DZBG3Wpn4=n101qCF-vF+4nzC5ERg9aGZHR=A@mail.gmail.com>
In-Reply-To: <CAMxP3BRZ1hZ0_DZBG3Wpn4=n101qCF-vF+4nzC5ERg9aGZHR=A@mail.gmail.com>
From: Bob Chen <a175818323@gmail.com>
Date: Wed, 19 Dec 2018 20:07:30 +0800
Message-ID: <CAMxP3BT7AnGfcvw7Af+6RB_Av+KDxnBr5-ReU8MvsH2o_ucECQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] QEMU crashed when reconnecting over iscsi protocol
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>

BTW, the iscsi server I used is scsi-target-utils (
https://github.com/fujita/tgt).


Bob Chen <a175818323@gmail.com> =E4=BA=8E2018=E5=B9=B412=E6=9C=8819=E6=97=
=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=887:34=E5=86=99=E9=81=93=EF=BC=9A

> I looked into the source code, and found some reconnect method from
> libiscsi. Are they able to work?
>
> QEMU: 2.12.1
> libiscsi: 1.18.0  (https://github.com/sahlberg/libiscsi)
>
>
> (gdb) f
> #0  0x00007fcd956933bd in iscsi_reconnect (iscsi=3D0x7fcd97f206d0) at
> connect.c:461
> 461 memcpy(tmp_iscsi->old_iscsi, iscsi, sizeof(struct iscsi_context));
> (gdb) bt
> #0  0x00007fcd956933bd in iscsi_reconnect (iscsi=3D0x7fcd97f206d0) at
> connect.c:461
> #1  0x00007fcd956a4ccd in iscsi_service_reconnect_if_loggedin
> (iscsi=3D0x7fcd97f206d0) at socket.c:879
> #2  0x00007fcd956a50d2 in iscsi_tcp_service (iscsi=3D0x7fcd97f206d0,
> revents=3D<value optimized out>) at socket.c:989
> #3  0x00007fcd9674b737 in iscsi_process_read (arg=3D0x7fcd97f1e680) at
> block/iscsi.c:371
> #4  0x00007fcd967e5b47 in aio_dispatch_handlers (ctx=3D0x7fcd97ee48d0) at
> util/aio-posix.c:406
> #5  0x00007fcd967e5ce9 in aio_dispatch (ctx=3D0x7fcd97ee48d0) at
> util/aio-posix.c:437
> #6  0x00007fcd967e038c in aio_ctx_dispatch (source=3D0x7fcd97ee48d0,
> callback=3D0, user_data=3D0x0) at util/async.c:261
> #7  0x00007fcd93b1135e in g_main_context_dispatch () from
> /usr/lib64/libglib-2.0.so.0
> #8  0x00007fcd967e424e in glib_pollfds_poll () at util/main-loop.c:215
> #9  0x00007fcd967e4368 in os_host_main_loop_wait (timeout=3D987000000) at
> util/main-loop.c:263
> #10 0x00007fcd967e4438 in main_loop_wait (nonblocking=3D0) at
> util/main-loop.c:522
> #11 0x00007fcd963c4b29 in main_loop () at vl.c:1943
> #12 0x00007fcd963cca8d in main (argc=3D62, argv=3D0x7ffff89f4208,
> envp=3D0x7ffff89f4400) at vl.c:4734
>
