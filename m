Received: from eggs.gnu.org ([2001:4830:134:3::10]:44093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cdiwl-0005gA-7w
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 14:39:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cdiwi-0003iz-JN
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 14:39:31 -0500
Received: from indium.canonical.com ([91.189.90.7]:38945)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cdiwi-0003ia-DF
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 14:39:28 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cdiwg-0005gI-5R
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 19:39:26 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id ACA3D2E80D8
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 19:39:25 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Feb 2017 19:29:39 -0000
From: Thomas Huth <760956@bugs.launchpad.net>
Reply-To: Bug 760956 <760956@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20110414174912.2655.81452.malonedeb@gandwana.canonical.com>
Message-Id: <20170214192939.29967.60832.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 760956] Re: Open Solaris 2009 Doesn't Boot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The URLs don't work any more, and according to Stefan's comment, this
was likely not a bug, so I'm closing this ticket now (feel free to open
it again if you don't agree).

** Changed in: qemu
       Status: New =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/760956

Title:
  Open Solaris 2009 Doesn't Boot

Status in QEMU:
  Invalid

Bug description:
  The latest git version of qemu (commit
  420b6c317de87890e06225de6e2f8af7bf714df0) fails to boot the
  OpenSolaris image from
  http://dlc.sun.com/osol/opensolaris/2009/06/osol-0906-ai-sparc.iso.

  qemu-img create opensolaris 3G
  qemu-system-sparc -hda opensolaris -cdrom osol-0906-ai-sparc.iso -boot d =
-redir tcp:2232::22 -k en-us -m 192

  gives:

  ...
  Trying cdrom:d
  File not found
  Trying cdrom...
  Not a bootable ELF image
  Not a bootable a.out image
  No valid state has been set by load or init_program

  Host: Linux/x86_64
  gcc4.5
  ./configure --enable-linux-aio --enable-io-thread --enable-kvm

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/760956/+subscriptions
