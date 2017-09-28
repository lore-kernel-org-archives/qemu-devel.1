Received: from eggs.gnu.org ([2001:4830:134:3::10]:51573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dxY2b-0004mW-4j
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 08:35:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dxY2X-00034y-8A
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 08:35:45 -0400
Received: from indium.canonical.com ([91.189.90.7]:46542)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dxY2X-00034h-1w
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 08:35:41 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1dxY2U-0008EG-MN
	for <qemu-devel@nongnu.org>; Thu, 28 Sep 2017 12:35:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 6CC072E849C
	for <qemu-devel@nongnu.org>; Thu, 28 Sep 2017 12:35:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 Sep 2017 12:20:34 -0000
From: Daniel Berrange <1583784@bugs.launchpad.net>
Reply-To: Bug 1583784 <1583784@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160519202600.8755.25116.malonedeb@gac.canonical.com>
Message-Id: <150660123576.5593.10717541064815910295.launchpad@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1583784] Re: qio_task_free segfault websocket
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

*** This bug is a duplicate of bug 1589923 ***
    https://bugs.launchpad.net/bugs/1589923

** This bug has been marked a duplicate of bug 1589923
   https websockets not working in 2.5 or 2.6

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1583784

Title:
  qio_task_free segfault websocket

Status in QEMU:
  New

Bug description:
  When connecting with websocket and tls to a vnc-ws port I get segfault

  =3D=3D15252=3D=3D Process terminating with default action of signal 11 (S=
IGSEGV): dumping core
  =3D=3D15252=3D=3D  Access not within mapped region at address 0x0
  =3D=3D15252=3D=3D    at 0x1: ???
  =3D=3D15252=3D=3D    by 0x56E1E2: qio_task_free (task.c:58)
  =3D=3D15252=3D=3D    by 0x56E42B: qio_task_complete (task.c:145)
  =3D=3D15252=3D=3D    by 0x56DBB8: qio_channel_websock_handshake_send (cha=
nnel-websock.c:289)
  =3D=3D15252=3D=3D    by 0x7B3F689: g_main_dispatch (gmain.c:3154)
  =3D=3D15252=3D=3D    by 0x7B3F689: g_main_context_dispatch (gmain.c:3769)
  =3D=3D15252=3D=3D    by 0x50D42A: glib_pollfds_poll (main-loop.c:213)
  =3D=3D15252=3D=3D    by 0x50D42A: os_host_main_loop_wait (main-loop.c:258)
  =3D=3D15252=3D=3D    by 0x50D42A: main_loop_wait (main-loop.c:506)
  =3D=3D15252=3D=3D    by 0x28A8D1: main_loop (vl.c:1934)
  =3D=3D15252=3D=3D    by 0x28A8D1: main (vl.c:4656)

  qemu 2.6.0
  linux x64

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1583784/+subscriptions
