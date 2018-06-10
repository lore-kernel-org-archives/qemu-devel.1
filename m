Received: from eggs.gnu.org ([2001:4830:134:3::10]:44849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fRyvl-0005Eq-Gy
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 07:54:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fRyvi-00044d-DQ
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 07:54:45 -0400
Received: from indium.canonical.com ([91.189.90.7]:53646)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fRyvi-000445-74
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 07:54:42 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fRyvg-0006zK-Ns
	for <qemu-devel@nongnu.org>; Sun, 10 Jun 2018 11:54:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 901FB2E88DB
	for <qemu-devel@nongnu.org>; Sun, 10 Jun 2018 11:54:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 10 Jun 2018 11:37:04 -0000
From: md_5 <1341032@bugs.launchpad.net>
Reply-To: Bug 1341032 <1341032@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140712005838.2545.38128.malonedeb@gac.canonical.com>
Message-Id: <152863062518.19920.12575546699704170452.launchpad@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1341032] Re: no-shutdown does not fire SHUTDOWN
 event for some guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu
       Status: New =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1341032

Title:
  no-shutdown does not fire SHUTDOWN event for some guests

Status in QEMU:
  Invalid

Bug description:
  Currently using: qemu-x86_64 version 2.0.0
  Steps to reproduce: Create virtual machine with the arguments -no-shutdow=
n, such as used by libvirt. Attach to the json event system. Load a guest s=
uch as Ubuntu 14.04 and run the 'halt' command. Guest ceases to execute, qe=
mu freezes CPUs however no SHUTDOWN event is fired to the monitor.

  Now load a guest such as finnix or Debian 7. Run the same sequence of
  steps and note that the SHUTDOWN event is fired to the monitor.

  This seems like a qemu bug as the execution of the guest has ceased.

  Thanks
  Michael

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1341032/+subscriptions
