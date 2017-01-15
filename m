Received: from eggs.gnu.org ([2001:4830:134:3::10]:51176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cSu6R-0007qN-MX
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 18:20:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cSu6M-0004SU-PJ
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 18:20:47 -0500
Received: from indium.canonical.com ([91.189.90.7]:38238)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cSu6M-0004SN-GK
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 18:20:42 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cSu6L-0007NM-9W
	for <qemu-devel@nongnu.org>; Sun, 15 Jan 2017 23:20:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 38A152E80C0
	for <qemu-devel@nongnu.org>; Sun, 15 Jan 2017 23:20:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Jan 2017 23:15:00 -0000
From: Josh Triplett <josh@joshtriplett.org>
Reply-To: Bug 1656711 <1656711@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <20170115231500.27272.80762.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1656711] [NEW] GTK3 interface doesn't zoom-to-fit
 by default
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

The SDL interface automatically scales the video output to
match the window size.  The GTK3 interface has an off-by-default option
"Zoom To Fit" for that.  As far as I can tell, no command-line option
exists to turn that option on.  That makes it harder to quickly zoom a
freshly launched VM; instead of just hitting a maximize-window hotkey, I
also have to navigate through the menu to select "Zoom To Fit".

Given that VMs typically start out running in a much lower-resolution
video mode than the host (and VMs not running a full graphical
environment often stay that way), this seriously impacts the usability
of qemu-system.

(Observed in QEMU 2.8)

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1656711

Title:
  GTK3 interface doesn't zoom-to-fit by default

Status in QEMU:
  New

Bug description:
  The SDL interface automatically scales the video output to
  match the window size.  The GTK3 interface has an off-by-default option
  "Zoom To Fit" for that.  As far as I can tell, no command-line option
  exists to turn that option on.  That makes it harder to quickly zoom a
  freshly launched VM; instead of just hitting a maximize-window hotkey, I
  also have to navigate through the menu to select "Zoom To Fit".

  Given that VMs typically start out running in a much lower-resolution
  video mode than the host (and VMs not running a full graphical
  environment often stay that way), this seriously impacts the usability
  of qemu-system.

  (Observed in QEMU 2.8)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1656711/+subscriptions
