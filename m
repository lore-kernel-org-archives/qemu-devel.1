Received: from eggs.gnu.org ([2001:4830:134:3::10]:43740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cwUCK-0003cc-30
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:45:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cwUCF-0001ct-6Z
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:45:08 -0400
Received: from indium.canonical.com ([91.189.90.7]:39308)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cwUCF-0001cL-10
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:45:03 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cwUCD-0008Uj-Dr
	for <qemu-devel@nongnu.org>; Fri, 07 Apr 2017 13:45:01 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 0104C2E80DE
	for <qemu-devel@nongnu.org>; Fri,  7 Apr 2017 13:45:01 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Apr 2017 13:33:17 -0000
From: Thomas Huth <1020309@bugs.launchpad.net>
Reply-To: Bug 1020309 <1020309@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120702214947.7655.69447.malonedeb@gac.canonical.com>
Message-Id: <20170407133317.1846.44536.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1020309] Re: qemu-system-ppc: no keyboard after
 savevm/loadvm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets ... can you still reproduce this issue with the
latest version of QEMU (version 2.9)?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1020309

Title:
  qemu-system-ppc: no keyboard after savevm/loadvm

Status in QEMU:
  Incomplete

Bug description:
  Here the steps to reproduce:

  1. qemu-img create -f qcow2 test.qcow2 100M
  2. qemu-system-ppc -m 1024 -hda test.qcow2
  3. change to the console via Ctrl-Alt-2 and save a snapshot: "savevm test"
  4. quit
  5. start again and go to the console
  6. load the snapshot via "loadvm test"
  7. change back to the guest display (Ctrl-Alt-1)
  8. try to type something =3D> no keyboard
  9. the same via console, e.g. "sendkey 1" has no effect

  I tried the following branches from git:
  master, stable-1.0, stable-0.15 =

  =3D> all behave the same

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1020309/+subscriptions
