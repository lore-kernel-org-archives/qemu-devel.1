Received: from eggs.gnu.org ([2001:4830:134:3::10]:42930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cTYkb-0000IH-UJ
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 13:44:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cTYkY-0001Uo-Se
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 13:44:57 -0500
Received: from indium.canonical.com ([91.189.90.7]:45724)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cTYkY-0001Tv-NI
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 13:44:54 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cTYkV-00070U-Dl
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 18:44:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 54E782E80BF
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 18:44:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Jan 2017 18:34:33 -0000
From: Thomas Huth <1590336@bugs.launchpad.net>
Reply-To: Bug 1590336 <1590336@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160608091217.11737.9975.malonedeb@wampee.canonical.com>
Message-Id: <20170117183435.14534.55092.launchpad@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1590336] Re: qemu-arm does not reject vrintz on
 non-v8 cpu
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
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1590336

Title:
  qemu-arm does not reject vrintz on non-v8 cpu

Status in QEMU:
  Fix Released

Bug description:
  Hello,

  It seems that qemu-arm does not reject some v8-only instructions as it
  should, but executes them "correctly".

  For instance, while compiling/running some of the GCC ARM instrinsics tes=
ts, we noticed that
  vrintz should be rejected on cortex-a9 for instance, while it is executed=
 as if the instruction was supported.

  objdump says:
     1074c:       f3fa05a0        vrintz.f32      d16, d16
  and qemu -d in_asm says:
  0x0001074c:  f3fa05a0      vabal.u<illegal width 64>    q8, d26, d16

  The problem is still present in qemu-2.6.0

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1590336/+subscriptions
