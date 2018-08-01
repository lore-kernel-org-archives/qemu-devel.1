Received: from eggs.gnu.org ([2001:4830:134:3::10]:55065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fksmf-0005c5-Lf
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 11:11:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fksma-0001N6-NA
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 11:11:29 -0400
Received: from indium.canonical.com ([91.189.90.7]:49346)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fksma-0001Mc-D7
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 11:11:24 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fksmY-0000pj-4m
	for <qemu-devel@nongnu.org>; Wed, 01 Aug 2018 15:11:22 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 232FA2E8083
	for <qemu-devel@nongnu.org>; Wed,  1 Aug 2018 15:11:22 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Aug 2018 14:56:10 -0000
From: Bastien Orivel <1776224@bugs.launchpad.net>
Reply-To: Bug 1776224 <1776224@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152872026835.25608.863999795714640483.malonedeb@soybean.canonical.com>
Message-Id: <153313537018.28998.4497352326345920727.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1776224] Re: QEMU's SPICE server not getting leds
 callback when sending capslock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This is in fact https://bugs.launchpad.net/ubuntu/+source/console-setup/+bu=
g/425704
Sorry for the noise

** Changed in: qemu
       Status: New =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1776224

Title:
  QEMU's SPICE server not getting leds callback when sending capslock

Status in QEMU:
  Invalid

Bug description:
  I'm having troubles using the QEMU's SPICE server for remote views. When
  trying to sync leds from my SPICE client to QEMU, I can see that the
  caps lock keycodes are sent but the server state never gets updated
  (which leads in funny behaviours like caps lock "blinking" in the guest
  if the clients resyncs its state often).

  That behaviour doesn't happen at all with the numlock led which does the
  same thing but with different keycodes.

  Here is an example of what's happening when the client tries to resync
  with a capslock difference:

  > Spice received: 58
  > ps2_put_keycode: 88
  >
  > Spice received: 186
  > ps2_put_keycode: 240
  > ps2_put_keycode: 88
  > ps2_queue: 186

  And with numlock:

  > Spice received: 69
  > ps2_put_keycode: 119
  >
  > Spice received: 197
  > ps2_put_keycode: 240
  > ps2_put_keycode: 119
  > ps2_queue: 197
  > ps2_set_ledstate: 0
  > Spice new ledstate: 0

  =

  This behaviour is consistent across SPICE clients and only appears in a l=
inux TTY (it works fine if I start an X server and on windows). It still ha=
ppens on QEMU latest commit at the time (0d2fa03dae4fbe185a082f361342b1e30a=
ed4582)

  Spice registers a callback for leds via qemu_add_led_event_handler but
  it's never called for capslock. Is that a normal behaviour ? Is there
  any reasons for the capslock led not to be updated ?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1776224/+subscriptions
