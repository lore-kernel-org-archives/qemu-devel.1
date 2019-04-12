Received: from eggs.gnu.org ([209.51.188.92]:60892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hEqUQ-0005U9-0w
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 03:20:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hEqUO-0005GY-3Q
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 03:20:45 -0400
Received: from indium.canonical.com ([91.189.90.7]:36640)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hEqUM-0005EN-9r
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 03:20:42 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hEqUK-0001pj-Au
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 07:20:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 371C82E80C8
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 07:20:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Apr 2019 07:06:30 -0000
From: Thomas Huth <1486278@bugs.launchpad.net>
Reply-To: Bug 1486278 <1486278@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150818230718.18792.42543.malonedeb@wampee.canonical.com>
Message-Id: <155505279030.7989.9154643681286899467.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1486278] Re: 'info vnc' monitor command does not
 show websocket information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I think this has been fixed in QEMU v2.10.0 with this commit here:
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D0a9667ecdb6d7da90a2ef=
64

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1486278

Title:
  'info vnc' monitor command does not show websocket information

Status in QEMU:
  Fix Released
Status in qemu package in Ubuntu:
  Confirmed

Bug description:
  Steps to reproduce^
  1. run
   qemu-system-x86_64  -vnc  0.0.0.0:1,websocket=3D5701 -nographic -monitor=
 stdio

  2. then type =

   (qemu) info vnc
  3.  see
       address: 0.0.0.0:5901
          auth: none
  Client: none

  There is no information about websocket parameters, but 'netstat -nltp' s=
hows me:
   ...
  tcp        0      0 0.0.0.0:5701            0.0.0.0:*               LISTE=
N      27073/qemu-system-x
  ....

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1486278/+subscriptions
