Received: from eggs.gnu.org ([2001:4830:134:3::10]:35323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eCkMD-0006lC-9N
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 05:46:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eCkM9-0004DZ-9Q
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 05:46:49 -0500
Received: from indium.canonical.com ([91.189.90.7]:35482)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eCkM9-0004DK-2q
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 05:46:45 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eCkM6-0001kf-NI
	for <qemu-devel@nongnu.org>; Thu, 09 Nov 2017 10:46:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4594A2E80CD
	for <qemu-devel@nongnu.org>; Thu,  9 Nov 2017 10:46:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Nov 2017 10:35:10 -0000
From: Daniel Berrange <1726910@bugs.launchpad.net>
Reply-To: Bug 1726910 <1726910@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150885852349.17651.9958840122130941388.malonedeb@wampee.canonical.com>
Message-Id: <151022371074.3019.6875294017061081105.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1726910] Re: UI request: add a function key
 toolbar (f1-f12)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Adding a toolbar with function keys consumes alot of screen real estate
for something that is going to be rarely used in practice.

The more usual approach to this problem is for the application to grab
the keyboard and block all local window system accelerators, so that Fn
goes straight to the guest OS when the console window has focus. This is
done by GNOME Boxes, virt-viewer, virt-manager, and I though QEMU's
frontends did it by default too.

Recently though, there has been a regression in this area. With the
switch to Wayland instead of Xorg, the standard GTK APIs for doing this
keyboard grabbing / accel blocking no longer work correctly. Instead
apps need to add custom code to talk to the Wayland compositor IIRC.
There's work underway to address this but its a way off.

Some key combinations are hard to deal with, even with the above
approach. For that reason virt-viewer/virt-manager, etc typically have a
"Send key" menu item, populated with a set of special  sequences.
Typically this covers Ctrl+Alt+fn sequences, and Ctrl+Alt+Delete and a
couple more.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1726910

Title:
  UI request: add a function key toolbar (f1-f12)

Status in QEMU:
  New

Bug description:
  I run old DOS programs under FreeDOS using QEMU.

  It's common when running/testing DOS applications to use the function
  keys. Some of these (such as F10) are intercepted by the window
  system. For example, some DOS program installers use F10 to install
  the software, but F10 is intecepted by the window system.

  The standard solution is to jump to the QEMU console and use sendkey
  to send a specific function key to the QEMU guest (often needed for
  'sendkey f10'). But this does not seem to be very user friendly for
  new users. Nor is it very fast if you need to this often.

  I propose QEMU add a toolbar with the function keys.

  I've attached a mockup of one possible design, with a simple toolbar
  for F1-F12. A possible modification would be to add "modifier" buttons
  for Ctrl and Shift and Alt to make it easier for users to enter
  combinations like Ctrl-F12 or Alt-F10 or Shift-F1.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1726910/+subscriptions
