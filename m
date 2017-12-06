Received: from eggs.gnu.org ([2001:4830:134:3::10]:42237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eMSus-0000FA-3w
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 01:10:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eMSuo-0000PQ-Ll
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 01:10:46 -0500
Received: from indium.canonical.com ([91.189.90.7]:60118)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eMSuo-0000PA-Es
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 01:10:42 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eMSun-0006HB-Kv
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 06:10:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 92BB02E804B
	for <qemu-devel@nongnu.org>; Wed,  6 Dec 2017 06:10:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 Dec 2017 05:57:15 -0000
From: Patrick Schweiger <1736655@bugs.launchpad.net>
Reply-To: Bug 1736655 <1736655@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <151253983521.3178.4021889730911467554.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1736655] [NEW] 2k3/xp guests w/virtio-net
 randomly DHCP fail on boot
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

Host:
Debian GNU/Linux 9 with Linux 4.13.0-0.bpo.1-amd64
QEMU 2.10.1

Guest:
Windows 2003 Standard SP2 (x64)
Windows XP SP3 (i386)

QEMU command line:
http://cfp.vim-cn.com/cbdF3

Description:
After upgrading from QEMU 2.8 to 2.10.1, my Windows 2003 x64 and Windows XP=
 guests with "virtio-net-pci" NIC would randomly fail to aquire DHCP addres=
s on boot. When it fails, cycle disable/enable the connection in Control Pa=
nel could make it connect successfully. As an immediate workaround, I switc=
hed to the RTL8139 NIC which works fine. Further investigation showed that =
manually reverting commit '4a3f03ba8dbf53fce36d0c1dd5d0cc0f340fe5f3' on top=
 of 2.10.1 "fixed" the problem.

Here are the bisect test results:
git branch 97cd965: 17 boots, 5 failures  (Feb 18)
git branch 77424a4: 27 boots, 0 failure   (Jan 09)
git branch c25d97c: 7 boots, 2 failures   (Feb 01)
git branch 4a3f03b: 25 boots, 8 failures  (Jan 19)
git branch 39f099e: 60 boots, 0 failure   (Jan 18)
2.10.1 with revert: 194 boots, 0 failure
2.10.1 without revert: 30 boots, 4 failures

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1736655

Title:
  2k3/xp guests w/virtio-net randomly DHCP fail on boot

Status in QEMU:
  New

Bug description:
  Host:
  Debian GNU/Linux 9 with Linux 4.13.0-0.bpo.1-amd64
  QEMU 2.10.1

  Guest:
  Windows 2003 Standard SP2 (x64)
  Windows XP SP3 (i386)

  QEMU command line:
  http://cfp.vim-cn.com/cbdF3

  Description:
  After upgrading from QEMU 2.8 to 2.10.1, my Windows 2003 x64 and Windows =
XP guests with "virtio-net-pci" NIC would randomly fail to aquire DHCP addr=
ess on boot. When it fails, cycle disable/enable the connection in Control =
Panel could make it connect successfully. As an immediate workaround, I swi=
tched to the RTL8139 NIC which works fine. Further investigation showed tha=
t manually reverting commit '4a3f03ba8dbf53fce36d0c1dd5d0cc0f340fe5f3' on t=
op of 2.10.1 "fixed" the problem.

  Here are the bisect test results:
  git branch 97cd965: 17 boots, 5 failures  (Feb 18)
  git branch 77424a4: 27 boots, 0 failure   (Jan 09)
  git branch c25d97c: 7 boots, 2 failures   (Feb 01)
  git branch 4a3f03b: 25 boots, 8 failures  (Jan 19)
  git branch 39f099e: 60 boots, 0 failure   (Jan 18)
  2.10.1 with revert: 194 boots, 0 failure
  2.10.1 without revert: 30 boots, 4 failures

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1736655/+subscriptions
