Received: from eggs.gnu.org ([2001:4830:134:3::10]:51245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dlxbO-0000GX-95
	for qemu-devel@nongnu.org; Sun, 27 Aug 2017 09:27:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dlxbJ-0005N9-CK
	for qemu-devel@nongnu.org; Sun, 27 Aug 2017 09:27:46 -0400
Received: from indium.canonical.com ([91.189.90.7]:49582)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dlxbJ-0005MZ-61
	for qemu-devel@nongnu.org; Sun, 27 Aug 2017 09:27:41 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dlxbG-0007cS-9j
	for <qemu-devel@nongnu.org>; Sun, 27 Aug 2017 13:27:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 9B8F22E8198
	for <qemu-devel@nongnu.org>; Sun, 27 Aug 2017 13:20:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Aug 2017 13:11:16 -0000
From: Dario Niedermann <1713328@bugs.launchpad.net>
Reply-To: Bug 1713328 <1713328@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <150383947649.18943.3208257948754280909.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1713328] [NEW] Unable to C-a in -nographic if
 -serial telnet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

qemu-system-i386 (version 2.6.1, running on Linux/x86_64) started with:

qemu-system-i386 -m 64M -machine type=3Dpc -rtc base=3Dlocaltime,clock=3Dho=
st
-nographic -serial telnet:127.0.0.1:1234,server,nowait -net
nic,model=3Dne2k_pci -net user,hostfwd=3Dtcp:127.0.0.1:2200-:22,tftp=3D/

does not accept the escape key (C-a) to perform functions such as
switching from monitor to console. Verified both in GNU screen and in
the Linux console.

If '-serial telnet:127.0.0.1:1234,server,nowait' is removed from the
command line, the escape key is accepted (and Qemu doesn't enter the
monitor immediately).

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1713328

Title:
  Unable to C-a in -nographic if -serial telnet

Status in QEMU:
  New

Bug description:
  qemu-system-i386 (version 2.6.1, running on Linux/x86_64) started
  with:

  qemu-system-i386 -m 64M -machine type=3Dpc -rtc
  base=3Dlocaltime,clock=3Dhost -nographic -serial
  telnet:127.0.0.1:1234,server,nowait -net nic,model=3Dne2k_pci -net
  user,hostfwd=3Dtcp:127.0.0.1:2200-:22,tftp=3D/

  does not accept the escape key (C-a) to perform functions such as
  switching from monitor to console. Verified both in GNU screen and in
  the Linux console.

  If '-serial telnet:127.0.0.1:1234,server,nowait' is removed from the
  command line, the escape key is accepted (and Qemu doesn't enter the
  monitor immediately).

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1713328/+subscriptions
