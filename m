Received: from eggs.gnu.org ([2001:4830:134:3::10]:51904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gCqav-0005ID-Oq
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 14:30:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gCqaq-0006ZN-Ol
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 14:30:57 -0400
Received: from indium.canonical.com ([91.189.90.7]:45554)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gCqaq-0006Z6-Ih
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 14:30:52 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gCqan-0006lZ-UA
	for <qemu-devel@nongnu.org>; Wed, 17 Oct 2018 18:30:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 287232E80E3
	for <qemu-devel@nongnu.org>; Wed, 17 Oct 2018 18:30:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Oct 2018 18:21:08 -0000
From: Ryan Govostes <1798434@bugs.launchpad.net>
Reply-To: Bug 1798434 <1798434@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <153980046834.15506.5857548093711799323.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1798434] [NEW] [Feature Request] Automatic device
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

Public bug reported:

Would it be possible to have a script that enumerates the device tree of
a Linux host and generates a qemu command line that would recreate it
under emulation? The user would have to customize the arguments (for
instance to point to disk image files), but it would take a lot of the
guesswork out.

Similarly, there could be information that can be gleaned from the
kernel build config that would help with configuration.

** Affects: qemu
     Importance: Undecided
         Status: New

** Description changed:

  Would it be possible to have a script that enumerates the device tree of
  a Linux host and generates a qemu command line that would recreate it
  under emulation? The user would have to customize the arguments (for
  instance to point to disk image files), but it would take a lot of the
  guesswork out.
  =

- Similarly, is there information that can be gleaned from the kernel
- build config that would help with configuration?
+ Similarly, there could be information that can be gleaned from the
+ kernel build config that would help with configuration.

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
