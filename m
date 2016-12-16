Received: from eggs.gnu.org ([2001:4830:134:3::10]:42729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cHogO-00066G-56
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 04:20:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cHogK-0005m2-WF
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 04:20:04 -0500
Received: from indium.canonical.com ([91.189.90.7]:39381)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cHogK-0005lI-Qx
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 04:20:00 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cHogJ-0001TK-NW
	for <qemu-devel@nongnu.org>; Fri, 16 Dec 2016 09:19:59 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id AE1062E80C7
	for <qemu-devel@nongnu.org>; Fri, 16 Dec 2016 09:19:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Dec 2016 09:06:38 -0000
From: Thomas Huth <1042561@bugs.launchpad.net>
Reply-To: Bug 1042561 <1042561@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120828062147.16130.99989.malonedeb@wampee.canonical.com>
Message-Id: <20161216090638.19642.72509.launchpad@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1042561] Re: Guest has no "xsave" feature with
 parameter "-cpu qemu64, +xsave" in qemu command line.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu
       Status: New =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1042561

Title:
  Guest has no "xsave" feature with parameter "-cpu qemu64,+xsave" in
  qemu command line.

Status in QEMU:
  Invalid

Bug description:
  Environment:
  ------------
  Host OS (ia32/ia32e/IA64):ia32e
  Guest OS (ia32/ia32e/IA64):ia32e
  Guest OS Type (Linux/Windows):Linux
  kvm.git Commit:1a577b72475d161b6677c05abe57301362023bb2
  qemu-kvm Commit:98f1f30a89901c416e51cc70c1a08d9dc15a2ad4
  Host Kernel Version:3.5.0-rc1
  Hardware:Romley-EP, Ivy-bridge

  =

  Bug detailed description:
  --------------------------
  Guest has no "xsave" feature when create guest with parameter "-cpu qemu6=
4,+xsave,+avx" in qemu command line, but the guest has avx feature.
  When starting a guest with parameter "-cpu host" in qemu command line, th=
e guest has 'avx' and 'xsave' features (as /proc/cpuinfo shows).

  This is not a recent regression; it exists for a long time.

  Reproduce steps:
  ----------------
  1. qemu-system-x86_64 -m 1024 -smp 2 -hda rhel6u3.img -cpu qemu64,+xsave
  2. cat /proc/cpuinfo | grep xsave     ( check guest's xsave feature)

  Current result:
  ----------------
  The guest has no xsave feature

  Expected result:
  ----------------
  The guest has xsave feature

  Basic root-causing log:

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1042561/+subscriptions
