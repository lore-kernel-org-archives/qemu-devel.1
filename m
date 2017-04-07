Received: from eggs.gnu.org ([2001:4830:134:3::10]:33591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cwUzS-0000cC-MY
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 10:35:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cwUzP-0003oW-67
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 10:35:54 -0400
Received: from indium.canonical.com ([91.189.90.7]:51286)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cwUzO-0003nf-SD
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 10:35:51 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cwUzN-0000V8-8U
	for <qemu-devel@nongnu.org>; Fri, 07 Apr 2017 14:35:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id B74562E818C
	for <qemu-devel@nongnu.org>; Fri,  7 Apr 2017 14:35:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Apr 2017 14:13:08 -0000
From: elmarco <marcandre.lureau@gmail.com>
Reply-To: Bug 1020484 <1020484@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120703094755.29916.21218.malonedeb@chaenomeles.canonical.com>
Message-Id: <20170407141308.31056.20733.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1020484] Re: RFE: Support spice via unix domain
 socket
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

you could pass sockets via QMP a while ago, but listening to unix socket
has been added there:

commit fe4831b1e7e7007ae15ae0470a06898660ab3877
Author: Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com>
Date:   Tue Jan 13 17:57:51 2015 +0100

    spice: add unix address support
    =

    Teach qemu to set up a Spice server with a UNIX socket using the
    following arguments -spice unix,addr=3Dpath.
    =

    Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>


** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1020484

Title:
  RFE: Support spice via unix domain socket

Status in QEMU:
  Fix Released

Bug description:
  According to the man page, spice can be only used via TCP/IP in
  opposite to VNC, which can also be configured to listen on a unix
  domain socket. To make it easy to use spice without exposing the
  interface, please support unix domain sockets as well. I can try  to
  provide a patch, if you can point me to the source code where TCP/IP
  socket is opened.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1020484/+subscriptions
