Received: from eggs.gnu.org ([2001:4830:134:3::10]:58903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gCque-0005QA-JA
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 14:51:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gCqua-0001Gz-NB
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 14:51:20 -0400
Received: from indium.canonical.com ([91.189.90.7]:51788)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gCquU-0000rY-GU
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 14:51:10 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gCqu1-000146-0D
	for <qemu-devel@nongnu.org>; Wed, 17 Oct 2018 18:50:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 7CCB32E80D3
	for <qemu-devel@nongnu.org>; Wed, 17 Oct 2018 18:50:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Oct 2018 18:44:26 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1798434 <1798434@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153980046834.15506.5857548093711799323.malonedeb@gac.canonical.com>
Message-Id: <153980186693.4467.8915904504822533256.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1798434] Re: [Feature Request] Automatic device
 configuration discovery
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This is occasionally asked for but unfortunately not in the general case
possible. Device trees contain enough information for a guest OS to use
the hardware; they do not contain a full description of how the hardware
is actually configured and connected together, and they don't say
anything about parts of the hardware that are "discoverable" (ie
probeable, like PCI). So there isn't enough information to produce a
full board model, and the parts that correspond to QEMU command line
options (like pluggable devices such as ethernet cards) aren't usually
in the DT at all.

The expected workflow goes the other way around -- you start by picking
a machine type that QEMU models, and then configure the kernel and use
the device tree that is intended for it, in the same way you would if
you wanted to get Linux running on a real hardware board.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1798434

Title:
  [Feature Request] Automatic device configuration discovery

Status in QEMU:
  New

Bug description:
  Would it be possible to have a script that enumerates the device tree
  of a Linux host and generates a qemu command line that would recreate
  it under emulation? The user would have to customize the arguments
  (for instance to point to disk image files), but it would take a lot
  of the guesswork out.

  Similarly, there could be information that can be gleaned from the
  kernel build config that would help with configuration.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1798434/+subscriptions
