Received: from eggs.gnu.org ([2001:4830:134:3::10]:58969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dqttZ-0003i0-Cn
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 00:30:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dqttT-0003Mc-RN
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 00:30:57 -0400
Received: from indium.canonical.com ([91.189.90.7]:42740)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dqttT-0003MG-Ka
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 00:30:51 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dqttR-0000tv-I3
	for <qemu-devel@nongnu.org>; Sun, 10 Sep 2017 04:30:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 397C12E8494
	for <qemu-devel@nongnu.org>; Sun, 10 Sep 2017 04:30:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 10 Sep 2017 04:17:52 -0000
From: Launchpad Bug Tracker <1099403@bugs.launchpad.net>
Reply-To: Bug 1099403 <1099403@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130114135118.22973.66577.malonedeb@gac.canonical.com>
Message-Id: <150501707257.27827.9334315543592403387.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1099403] Re: High CPU utilization in vnc mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1099403

Title:
  High CPU utilization in vnc mode

Status in QEMU:
  Expired

Bug description:
  We start a gentoo guest using ./x86-64-softmmu/qemu-x86-64 -hda
  <disk>.qcow2 -vnc :6.

  Then we start a vncviewer session to this guest from a remote
  computer. In this session, we start a video. After starting the video,
  the CPU utilization of the guest (the qemu-x86-64 process) increases
  to about 90%. The high CPU utilization persists even after closing the
  vncviewer session.

  However, the CPU usage while running a video inside a gentoo guest
  (without a remote computer connecting via vncviewer) is only 20-30%.
  So we suspect the high CPU usage to be due to the vncserver code
  running inside QEMU which has to do a lot of work to send the
  framebuffer updates to the client.

  My question is why does the usage not decrease when the remote
  vncviewer is disconnected? On simple computers (no virtual guests),
  the CPU usage of vncserver decreases drastically when the vncviewer
  client is disconnected. Why does this not happen in the vncserver
  provided by QEMU (through -vnc :6).

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1099403/+subscriptions
