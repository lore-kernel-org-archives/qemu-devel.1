Received: from eggs.gnu.org ([2001:4830:134:3::10]:35945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cVigv-0001Jp-Np
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 12:46:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cVigq-00037g-RB
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 12:46:05 -0500
Received: from indium.canonical.com ([91.189.90.7]:49602)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cVigq-00037a-LQ
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 12:46:00 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cVigo-00086P-Q4
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 17:45:58 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 364322E80CB
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 17:45:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Jan 2017 17:26:40 -0000
From: Thomas Huth <1217339@bugs.launchpad.net>
Reply-To: Bug 1217339 <1217339@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130827122907.17435.24292.malonedeb@gac.canonical.com>
Message-Id: <20170123172642.14567.51778.launchpad@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1217339] Re: SIGQUIT to send ACPI-shutdown to
 Guest
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
   Importance: Undecided =3D> Wishlist

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1217339

Title:
  SIGQUIT to send ACPI-shutdown to Guest

Status in QEMU:
  New

Bug description:
  When qemu receives SIGQUIT, it should first try to run
  system_powerdown (giving the guest an ACPI signal to begin the
  shutdown process), before ending the whole qemu process.

  At this point there is no way to do a graceful shutdown if you do not
  have access to the monitor and you do not use any wrapper like
  libvirt.

  If, for some reason SIGQUIT would not be accepted as the signal, take
  any free to use signal, like SIGUSR1. There should be a way to get
  ACPI shutdown sent to the guest.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1217339/+subscriptions
