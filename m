Received: from eggs.gnu.org ([2001:4830:134:3::10]:38584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fZwUd-0003cH-L8
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 06:55:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fZwUa-0003cd-FK
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 06:55:39 -0400
Received: from indium.canonical.com ([91.189.90.7]:40584)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fZwUa-0003bi-8d
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 06:55:36 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fZwUY-0003Lh-KG
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 10:55:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 92F802E8005
	for <qemu-devel@nongnu.org>; Mon,  2 Jul 2018 10:55:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Jul 2018 10:48:26 -0000
From: Bastien Orivel <1779649@bugs.launchpad.net>
Reply-To: Bug 1779649 <1779649@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <153052850673.18330.5658352940583128817.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1779649] [NEW] Suspending a domain works with a
 3.16 gues kernel but not with a 4.16 one
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

Suspending a domain with `systemctl suspend` works with a guest 3.16 kernel=
 (jessie), the domain goes into `pmsuspend` in libvirt but doesn't work any=
more with a 4.16 one (sid) where:
 - With a QXL card: the spice display just goes black and the domain stays =
`running` in libvirt but is "dead"
 - With a VGA card: the screen goes black and comes back immediately, the d=
omain stays fine

Qemu: Master, 281bd281222776229d5dbf84d1a5c6d8d9d2a34b

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1779649

Title:
  Suspending a domain works with a 3.16 gues kernel but not with a 4.16
  one

Status in QEMU:
  New

Bug description:
  Suspending a domain with `systemctl suspend` works with a guest 3.16 kern=
el (jessie), the domain goes into `pmsuspend` in libvirt but doesn't work a=
nymore with a 4.16 one (sid) where:
   - With a QXL card: the spice display just goes black and the domain stay=
s `running` in libvirt but is "dead"
   - With a VGA card: the screen goes black and comes back immediately, the=
 domain stays fine

  Qemu: Master, 281bd281222776229d5dbf84d1a5c6d8d9d2a34b

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1779649/+subscriptions
