Received: from eggs.gnu.org ([2001:4830:134:3::10]:39499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fBeQX-0002PQ-6s
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 06:47:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fBeQT-00017l-5H
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 06:47:01 -0400
Received: from indium.canonical.com ([91.189.90.7]:59656)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fBeQS-00016H-V5
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 06:46:57 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fBeQR-0003vP-N7
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 10:46:55 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id AE1252E8060
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 10:46:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Apr 2018 10:30:21 -0000
From: Thomas Huth <628082@bugs.launchpad.net>
Reply-To: Bug 628082 <628082@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20100901133500.26711.95342.malonedeb@wampee.canonical.com>
Message-Id: <152473862169.6712.16315240085633341145.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 628082] Re: nl-be keymap is wrong
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

There have been quite a lot of changes with regards to keyboard mapping
in QEMU recently, could you please try again with QEMU 2.12 to see
whether this has been fixed now?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/628082

Title:
  nl-be keymap is wrong

Status in QEMU:
  Incomplete

Bug description:
  As mentioned on
  https://bugs.launchpad.net/ubuntu/+source/kvm/+bug/429965 as well as
  the kvm mailinglist
  (http://thread.gmane.org/gmane.comp.emulators.kvm.devel/14413), the
  nl-be keymap does not work. The number keys above the regular keys
  (non-numeric keypad numbers) as well as vital keys such as slash,
  backslash, dash, ... are not working.

  The nl-be keymap that is presented in the above URLs (and also
  attached to this bug) does work properly.

  Would it be possible to include this keymap rather than the current
  one?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/628082/+subscriptions
