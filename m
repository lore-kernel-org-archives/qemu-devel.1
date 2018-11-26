Received: from eggs.gnu.org ([2001:4830:134:3::10]:60573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gRP1T-0003hl-On
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 17:06:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gRP1N-0007NI-GK
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 17:06:31 -0500
Received: from indium.canonical.com ([91.189.90.7]:32834)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gRP1N-0007Mn-24
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 17:06:25 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gRP1M-0002Yo-57
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 22:06:24 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 22F832E80C7
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 22:06:24 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Nov 2018 21:53:26 -0000
From: tinywrkbee <1793859@bugs.launchpad.net>
Reply-To: Bug 1793859 <1793859@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153760092554.29759.17075669747500120723.malonedeb@soybean.canonical.com>
Message-Id: <154326920665.16551.16335857669051764938.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1793859] Re: GTK display and mouse input area
 scaling fails when using vfio-pci device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Chen, have you seen the following bug report? https://bugs.launchpad.net/qe=
mu/+bug/1592351
See my comment there, with recent git build of 3.1.0 I don't have a pointer=
 offset issue.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1793859

Title:
  GTK display and mouse input area scaling fails when using vfio-pci
  device

Status in QEMU:
  New

Bug description:
  Version qemu 3.0.0-1 running on Arch. Found on Windows 8.1 and Windows
  10 VM's when using Intel gvt-g device.

  While in fullscreen the GTK display is scaled larger than the x11
  screen or virtual machine resolution. Without choosing zoom-to-fit
  portions of the VM display are not shown on x11 screen regardless of
  the VM resolution. When zoom-to-fit is done the mouse that's shown on
  screen and actual input are off sync. The mouse can wander off screen
  when going left and down.

  This message is shown when changing from gxl-vga to vfio-pci in view menu=
. =

  (qemu-system-x86_64:6472): Gtk-WARNING **: 09:50:06.663: drawing failure =
for widget 'GtkDrawingArea': NULL pointer
  (qemu-system-x86_64:6472): Gtk-WARNING **: 09:50:06.664: drawing failure =
for widget 'GtkNotebook': NULL pointer
  (qemu-system-x86_64:6472): Gtk-WARNING **: 09:50:06.664: drawing failure =
for widget 'GtkBox': NULL pointer
  (qemu-system-x86_64:6472): Gtk-WARNING **: 09:50:06.664: drawing failure =
for widget 'GtkWindow': NULL pointer

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1793859/+subscriptions
