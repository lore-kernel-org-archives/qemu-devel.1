Received: from eggs.gnu.org ([2001:4830:134:3::10]:55420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gDoRw-0001EW-2i
	for qemu-devel@nongnu.org; Sat, 20 Oct 2018 06:25:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gDoRq-00073Y-Qo
	for qemu-devel@nongnu.org; Sat, 20 Oct 2018 06:25:39 -0400
Received: from indium.canonical.com ([91.189.90.7]:50692)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gDoRq-00070i-Kb
	for qemu-devel@nongnu.org; Sat, 20 Oct 2018 06:25:34 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gDoRo-0006yU-Lk
	for <qemu-devel@nongnu.org>; Sat, 20 Oct 2018 10:25:32 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 82AA32E800F
	for <qemu-devel@nongnu.org>; Sat, 20 Oct 2018 10:25:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Oct 2018 10:20:20 -0000
From: Roman Bolshakov <1798451@bugs.launchpad.net>
Reply-To: Bug 1798451 <1798451@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153980387714.3465.12419240219281347614.malonedeb@soybean.canonical.com>
Message-Id: <154003082092.28926.13318534964866486840.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1798451] Re: HVF linux on OSX hangs 2nd time
 started after adding socket
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I've had issues with multiple vcpus previously.

But I've tried that recently and it worked fine with the fix:
https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg03864.html.

And I've checked your command, no issues.

Could you please try to install qemu from my tap and check if it's gone?

brew tap roolebo/virt
brew install roolebo/virt/qemu --HEAD

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1798451

Title:
  HVF linux on OSX hangs 2nd time started after adding socket

Status in QEMU:
  New

Bug description:
  =

  Robs-MacBook-Pro-2:~ robmaskell$ qemu-system-x86_64 --version
  QEMU emulator version 3.0.0

  Host: MacOS - 10.13.6
    Model Name:	MacBook Pro
    Model Identifier:	MacBookPro14,3
    Processor Name:	Intel Core i7
    Processor Speed:	2.8 GHz
    Number of Processors:	1
    Total Number of Cores:	4
    L2 Cache (per Core):	256 KB
    L3 Cache:	6 MB
    Memory:	16 GB

  Guest OS: Elementary Linux Loki 0.4.1, patched up to date

  Command used to start QEMU:

  qemu-system-x86_64 \
    -name ElementaryLokiDev \
    -machine pc,accel=3Dhvf \
    -cpu max \
    -smp cpus=3D2,sockets=3D2,cores=3D1,threads=3D1,maxcpus=3D2 \
    -numa node,nodeid=3D0 \
    -numa cpu,node-id=3D0,socket-id=3D0 -numa cpu,node-id=3D0,socket-id=3D1=
 \
    -m 8G \
    -vga vmware \
    -hda e4.qcow2

  Symptoms: Started without the -smp / -numa commands to install the OS,
  then added -smp / -numa and the machine boots and lscpu reports extra
  cpu as expected. Restart VM and it hangs on startup. Remove -smp /
  -numa and machine starts again.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1798451/+subscriptions
