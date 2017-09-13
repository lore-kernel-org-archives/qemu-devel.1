Received: from eggs.gnu.org ([2001:4830:134:3::10]:46730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ds2XW-0000Zt-Fd
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:56:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ds2XT-00064s-HV
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:56:54 -0400
Received: from indium.canonical.com ([91.189.90.7]:43875)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ds2XT-00063a-Aw
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:56:51 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1ds2XQ-00049F-Cj
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 07:56:48 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 81C452E84A7
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 07:56:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 Sep 2017 07:40:28 -0000
From: Thomas Huth <899961@bugs.launchpad.net>
Reply-To: Bug 899961 <899961@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20111204161619.13512.72277.malonedeb@soybean.canonical.com>
Message-Id: <150528842825.13201.18194450576031486557.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 899961] Re: qemu/kvm locks up when run 32bit
 userspace with 64bit kernel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Since the debian bug has been marked as fixed and there wasn't any
response to the question in my last comment, I assume this has been
fixed in upstream QEMU, too. So closing this ticket accordingly...

** Changed in: qemu
       Status: Incomplete =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/899961

Title:
  qemu/kvm locks up when run 32bit userspace with 64bit kernel

Status in QEMU:
  Fix Released
Status in qemu-kvm package in Debian:
  Fix Released

Bug description:
  Only applies to qemu-kvm 1.0, and only when kernel is 64bit and
  userspace is 32bit, on x86.  Did not happen with previous released
  versions, such as 0.15.  Not all guests triggers this issue - so far,
  only (32bit) windows 7 guest shows it, but does that quite reliable:
  first boot of an old guest with new qemu-kvm, windows finds a new CPU
  and suggests rebooting - hit "Reboot" and in a few seconds it will be
  locked up (including the monitor), with no CPU usage whatsoever.
  Killable only with -9.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/899961/+subscriptions
