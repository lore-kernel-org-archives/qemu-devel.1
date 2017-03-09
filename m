Received: from eggs.gnu.org ([2001:4830:134:3::10]:59706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1clmDF-0004oH-Ml
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 19:45:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1clmDC-0006xJ-Kc
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 19:45:49 -0500
Received: from indium.canonical.com ([91.189.90.7]:59136)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1clmDC-0006ub-De
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 19:45:46 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1clmDA-0004yg-6Y
	for <qemu-devel@nongnu.org>; Thu, 09 Mar 2017 00:45:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C31602E80DD
	for <qemu-devel@nongnu.org>; Thu,  9 Mar 2017 00:45:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Mar 2017 00:36:34 -0000
From: Ubuntu Foundations Team Bug Bot <1670509@bugs.launchpad.net>
Reply-To: Bug 1670509 <1670509@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170306224936.27687.97076.malonedeb@gac.canonical.com>
Message-Id: <20170309003635.6466.69159.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1670509] Re: sgabios outputs incorrect video modes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The attachment "0001-SGABIOS-fix-wrong-video-attrs-for-int-10h-ah-
13h.patch" seems to be a patch.  If it isn't, please remove the "patch"
flag from the attachment, remove the "patch" tag, and if you are a
member of the ~ubuntu-reviewers, unsubscribe the team.

[This is an automated message performed by a Launchpad user owned by
~brian-murray, for any issues please contact him.]

** Tags added: patch

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1670509

Title:
  sgabios outputs incorrect video modes

Status in QEMU:
  New
Status in sgabios package in Ubuntu:
  New

Bug description:
  When run with a bootstrap loader that uses int 0x10 with 0x1301 in
  %ax, incorrect video modes are output to the serial port.  I believe
  the VGA image will be correct.  This might also affect the returned
  values for some interrupts.

  This is caused because the set_cursor_position routine fails to save
  and restore %bx.

  I'm working on a fix for this.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1670509/+subscriptions
