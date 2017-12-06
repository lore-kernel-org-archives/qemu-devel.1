Received: from eggs.gnu.org ([2001:4830:134:3::10]:33743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eMThZ-00081a-6k
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 02:01:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eMThU-00083z-Fz
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 02:01:05 -0500
Received: from indium.canonical.com ([91.189.90.7]:57112)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eMThU-00083T-9F
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 02:01:00 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eMThQ-0006t4-Rp
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 07:00:56 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C0F662E80D7
	for <qemu-devel@nongnu.org>; Wed,  6 Dec 2017 07:00:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 Dec 2017 06:47:56 -0000
From: ChristianEhrhardt <1736655@bugs.launchpad.net>
Reply-To: Bug 1736655 <1736655@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151253983521.3178.4021889730911467554.malonedeb@gac.canonical.com>
Message-Id: <151254287611.10784.2031964653947260440.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1736655] Re: 2k3/xp guests w/virtio-net randomly
 DHCP fail on boot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi Patrick,
thank you so much for the report and your help to make Ubuntu better.
Also for all the bisecting that is very helpful.

While backporting the change itself would be very trivial we need to
find what the final solution has to be first.

I checked latest upstream which is about to release 2.11 these days and the=
re was not related change.
- no revert to this commit
- no other major disabling/fixes for ioeventfd in these cases

That would imply that this is an issue unknown to upstream - and that means=
 that we need to make it known there to not end up carrying a Delta forever=
 and deriving more and more.
So we should bring it up there and find a solution for everyone.

First of all let me try if I can reproduce it over here, then we can decide=
 on next steps.
Very likely one of them would be to report it to upstream as well - which s=
ince you have a great bug description already they track Launchpad I can ea=
sily do for you by adding a bug Task.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1736655

Title:
  2k3/xp guests w/virtio-net randomly DHCP fail on boot

Status in QEMU:
  New
Status in qemu package in Ubuntu:
  Incomplete

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
