Received: from eggs.gnu.org ([2001:4830:134:3::10]:37202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dXgi8-0005CI-R0
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:35:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dXgi7-0001og-Jo
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:35:44 -0400
Received: from indium.canonical.com ([91.189.90.7]:37887)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dXgi7-0001oI-Dd
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:35:43 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dXgi6-0003pk-FQ
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 04:35:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 7336D2E8078
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 04:35:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Jul 2017 04:17:50 -0000
From: Launchpad Bug Tracker <757702@bugs.launchpad.net>
Reply-To: Bug 757702 <757702@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20110411161233.16764.21820.malonedeb@soybean.canonical.com>
Message-Id: <150043787091.28289.2832179676767305484.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 757702] Re: ARM: singlestepping insn which UNDEFs
 should stop at UNDEF vector insn, not after it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/757702

Title:
  ARM: singlestepping insn which UNDEFs should stop at UNDEF vector
  insn, not after it

Status in QEMU:
  Expired

Bug description:
  ARMv7a has lot of undefined instruction from its instruction opcode
  space. This undefined instructions are very useful for replacing
  sensitive non-priviledged instructions of guest operating systems
  (virtualization). The undefined instruction exception executes at
  <exception_base> + 0x4, where <exception_base> can be 0x0 or
  0xfff00000. Currently, in qemu 0.14.0 undefined instruction fault at
  0x8 offset instead of 0x4. This was not a problem with qemu 0.13.0,
  seems like this is a new bug. As as example, if we try to execute
  value "0xec019800" in qemu 0.14.0 then it should cause undefined
  exception at <exception_base>+0x4 since "0xec019800" is an undefined
  instruction.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/757702/+subscriptions
