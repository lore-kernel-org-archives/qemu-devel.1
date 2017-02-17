Received: from eggs.gnu.org ([2001:4830:134:3::10]:48119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ceeAh-0002B6-Ss
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 03:45:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ceeAf-0004o0-41
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 03:45:43 -0500
Received: from indium.canonical.com ([91.189.90.7]:43697)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ceeAe-0004na-U3
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 03:45:41 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1ceeAd-0003PO-IZ
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 08:45:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 852212E80C6
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 08:45:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Feb 2017 08:28:25 -0000
From: Thomas Huth <946043@bugs.launchpad.net>
Reply-To: Bug 946043 <946043@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120304030417.15447.69091.malonedeb@gac.canonical.com>
Message-Id: <20170217082825.4213.96543.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 946043] Re: Serial Named Pipe Unrecognized
 Windows 7
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Which version of QEMU were you using? Can you still reproduce this issue
with the latest version of QEMU?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/946043

Title:
  Serial Named Pipe Unrecognized Windows 7

Status in QEMU:
  Incomplete

Bug description:
  I created a named pipe serial hardware and supplied '/tmp/debug' which
  I created using mkfifo

  This is the snippet from ps -aux
  -chardev pipe,id=3Dcharserial0,path=3D/tmp/debug -device isa-serial,chard=
ev=3Dcharserial0,id=3Dserial0

  failure@ubuntu1:~$ ls -al /tmp/debug*
  prwxrwxrwx 1 jgp jgp 0 2012-03-03 18:40 /tmp/debug
  prwxrwxrwx 1 jgp jgp 0 2012-03-03 18:40 /tmp/debug.in

  However inside the Windows 7 guest (even after a restart) nothing is
  recognized. Even after going through the add legacy hardware motions
  it's still not picked up.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/946043/+subscriptions
