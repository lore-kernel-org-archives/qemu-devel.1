Received: from eggs.gnu.org ([2001:4830:134:3::10]:52075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1coobx-0002pk-8S
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 05:55:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1coobt-0006YV-DY
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 05:55:53 -0400
Received: from indium.canonical.com ([91.189.90.7]:48012)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1coobt-0006YH-7e
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 05:55:49 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1coobr-0004EJ-1B
	for <qemu-devel@nongnu.org>; Fri, 17 Mar 2017 09:55:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 023792E80C8
	for <qemu-devel@nongnu.org>; Fri, 17 Mar 2017 09:55:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Mar 2017 09:47:14 -0000
From: Julien Duponchelle <noplay@noplay.net>
Reply-To: Bug 1673722 <1673722@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <20170317094714.32220.9387.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1673722] [NEW] Reading register at offset. It is
 not fully implemented warning make VM impossible to use
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

Hi,

Since this commit:
https://github.com/qemu/qemu/commit/bc0f0674f037a01f2ce0870ad6270a356a7a8347

We can no longer use the IOSvL2 image from Cisco. The problem is we got a l=
ot of warning message saying:
e1000: Reading register at offset: 0x00002410. It is not fully implemented. =


User got so much of this warning that they can't use the VM.

Thanks for the help

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: e1000

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1673722

Title:
  Reading register at offset. It is not fully implemented warning make
  VM impossible to use

Status in QEMU:
  New

Bug description:
  Hi,

  Since this commit:
  https://github.com/qemu/qemu/commit/bc0f0674f037a01f2ce0870ad6270a356a7a8=
347

  We can no longer use the IOSvL2 image from Cisco. The problem is we got a=
 lot of warning message saying:
  e1000: Reading register at offset: 0x00002410. It is not fully implemente=
d. =


  User got so much of this warning that they can't use the VM.

  Thanks for the help

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1673722/+subscriptions
