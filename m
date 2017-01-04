Received: from eggs.gnu.org ([2001:4830:134:3::10]:37949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cOmUo-0005gv-V6
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 09:24:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cOmUj-0007o8-U9
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 09:24:54 -0500
Received: from indium.canonical.com ([91.189.90.7]:39490)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cOmUj-0007nz-Nj
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 09:24:49 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cOmUi-0000Tk-KT
	for <qemu-devel@nongnu.org>; Wed, 04 Jan 2017 14:24:48 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 95C022E80C3
	for <qemu-devel@nongnu.org>; Wed,  4 Jan 2017 14:24:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Jan 2017 14:08:35 -0000
From: Daniel Berrange <1455912@bugs.launchpad.net>
Reply-To: Bug 1455912 <1455912@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150517130746.26692.51704.malonedeb@gac.canonical.com>
Message-Id: <20170104140835.14375.24209.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1455912] Re: vnc websocket option not properly
 parsed when running on commandline
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This is an accidental regression caused by

      commit 4db14629c38611061fc19ec6927405923de84f08
      Author: Gerd Hoffmann <kraxel@redhat.com>
      Date:   Tue Sep 16 12:33:03 2014 +0200
    =

        vnc: switch to QemuOpts, allow multiple servers


** Changed in: qemu
     Assignee: (unassigned) =3D> Daniel Berrange (berrange)

** Changed in: qemu
       Status: New =3D> Confirmed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1455912

Title:
  vnc websocket option not properly parsed when running on commandline

Status in QEMU:
  Confirmed

Bug description:
  All of my vms are started with a simple script on the command line.  =

  Starting with Qemu 2.3.0, the option "-vnc host:port,websocket" is no lon=
ger working.

  Previously if I said listen on Tor:17,websocket it would function
  correctly.  Now it's kicking an error:

  =

  qemu-system-x86_64: -vnc tor:17,websocket: Failed to start VNC server on =
`(null)': address resolution failed for tor:on: Servname not supported for =
ai_socktype

  The error leads me to believe it's not parsing the command line
  options for the "vnc" option correctly.  If I leave off ",websocket"
  it works correctly.  I've even tried, replacing the hostname with an
  IP address, and using the alternate form " -display
  vnc=3Dtor:17,webscoket". It reports the same error.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1455912/+subscriptions
