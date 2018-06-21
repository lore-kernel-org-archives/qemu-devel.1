Received: from eggs.gnu.org ([2001:4830:134:3::10]:51517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fW1Sp-00069A-0a
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 11:25:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fW1Sl-0002HF-Uc
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 11:25:34 -0400
Received: from indium.canonical.com ([91.189.90.7]:35188)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fW1Sl-0002Gl-Ix
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 11:25:31 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fW1Sk-0005hQ-Qu
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 15:25:30 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C693E2E80C7
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 15:25:30 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 Jun 2018 15:14:11 -0000
From: Thomas Huth <1314293@bugs.launchpad.net>
Reply-To: Bug 1314293 <1314293@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140429170902.18822.11244.malonedeb@chaenomeles.canonical.com>
Message-Id: <152959405203.26761.4578698554682216966.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1314293] Re: screendump with qxl + spice shows
 stale data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Looking through old bug tickets... can you still reproduce this issue
with the latest version of QEMU? Or could we close this ticket nowadays?


** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1314293

Title:
  screendump with qxl + spice shows stale data

Status in QEMU:
  Incomplete

Bug description:
  The monitor 'screendump' command returns stale data for VMs using qxl
  + spice. If you perform multiple screendumps, screendump #N will show
  roughly the display from the time screendump #N-1 was taken. This
  affects 'virsh screenshot' and libvirt screenshot APIs by association.

  Gerd explains that new monitor commands/infrastructure is likely
  required to handle this correctly:

  https://lists.gnu.org/archive/html/qemu-devel/2014-04/msg03840.html

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1314293/+subscriptions
