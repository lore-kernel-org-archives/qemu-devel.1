Received: from eggs.gnu.org ([2001:4830:134:3::10]:55705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fryJa-0002CD-AJ
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 00:30:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fryJX-0006bH-3G
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 00:30:46 -0400
Received: from indium.canonical.com ([91.189.90.7]:35826)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fryJW-0006al-Tf
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 00:30:43 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fryJV-000375-Qg
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 04:30:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C7D382E8041
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 04:30:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Aug 2018 04:17:28 -0000
From: Launchpad Bug Tracker <1472083@bugs.launchpad.net>
Reply-To: Bug 1472083 <1472083@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150707053638.9337.88545.malonedeb@gac.canonical.com>
Message-Id: <153482504829.29888.5182195854780072535.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1472083] Re: Qemu 2.1.2 hang when stop command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1472083

Title:
  Qemu 2.1.2 hang when stop command

Status in QEMU:
  Expired

Bug description:
  Qemu 2.1.2, Linux kernel 3.13.6, this is the stack.

  #0  in ppoll () from /lib/x86_64-linux-gnu/libc.so.6
  #1  in qemu_poll_ns (fds=3D0x7fa82a8de380, nfds=3D1, timeout=3D-1) at qem=
u-timer.c:314
  #2  in aio_poll (ctx=3D0x7fa82a8b5000, blocking=3Dtrue) at aio-posix.c:250
  #3  in bdrv_drain_all () at block.c:1924
  #4  in do_vm_stop (state=3DRUN_STATE_PAUSED) at /qemu-2.1.2/cpus.c:544
  #5  in vm_stop (state=3DRUN_STATE_PAUSED) at /qemu-2.1.2/cpus.c:1227
  #6  in qmp_stop (errp=3D0x7ffffb6dcaf8) at qmp.c:98
  #7  in qmp_marshal_input_stop (mon=3D0x7fa82a8e0970, qdict=3D0x7fa8302950=
20, ret=3D0x7ffffb6dcb48) at qmp-marshal.c:2806
  #8  in qmp_call_cmd (mon=3D0x7fa82a8e0970, cmd=3D0x7fa8290558a0, params=
=3D0x7fa830295020)  at /qemu-2.1.2/monitor.c:5038
  #9  in handle_qmp_command (parser=3D0x7fa82a8e0a28, tokens=3D0x7fa82a8d9b=
50) at /qemu-2.1.2/monitor.c:5104
  #10 in json_message_process_token (lexer=3D0x7fa82a8e0a30, token=3D0x7fa8=
30122b60, type=3DJSON_OPERATOR, x=3D39, y=3D17865) at qobject/json-streamer=
.c:87
  #11 in json_lexer_feed_char (lexer=3D0x7fa82a8e0a30, ch=3D125 '}', flush=
=3Dfalse) at qobject/json-lexer.c:303
  #12 in json_lexer_feed (lexer=3D0x7fa82a8e0a30, buffer=3D0x7ffffb6dcdb0 "=
}\315m\373\377\177", size=3D1) at qobject/json-lexer.c:356
  #13 in json_message_parser_feed (parser=3D0x7fa82a8e0a28, buffer=3D0x7fff=
fb6dcdb0 "}\315m\373\377\177", size=3D1) at qobject/json-streamer.c:111
  #14 in monitor_control_read (opaque=3D0x7fa82a8e0970, buf=3D0x7ffffb6dcdb=
0 "}\315m\373\377\177", size=3D1) at /qemu-2.1.2/monitor.c:5125
  #15 in qemu_chr_be_write (s=3D0x7fa82a8c2020, buf=3D0x7ffffb6dcdb0 "}\315=
m\373\377\177", len=3D1) at qemu-char.c:213
  #16 in tcp_chr_read (chan=3D0x7fa82a8c4ba0, cond=3DG_IO_IN, opaque=3D0x7f=
a82a8c2020) at qemu-char.c:2729
  #17 in g_main_context_dispatch () from /lib/x86_64-linux-gnu/libglib-2.0.=
so.0
  #18 in glib_pollfds_poll () at main-loop.c:190
  #19 in os_host_main_loop_wait (timeout=3D24000000) at main-loop.c:235
  #20 in main_loop_wait (nonblocking=3D0) at main-loop.c:484
  #21 in main_loop () at vl.c:2034
  #22 in main (argc=3D55, argv=3D0x7ffffb6de338, envp=3D0x7ffffb6de4f8) at =
vl.c:4583

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1472083/+subscriptions
