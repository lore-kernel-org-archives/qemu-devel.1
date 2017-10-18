Received: from eggs.gnu.org ([2001:4830:134:3::10]:49886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e4iVW-00040i-P9
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 03:11:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e4iVT-0007a9-K1
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 03:11:14 -0400
Received: from indium.canonical.com ([91.189.90.7]:54842)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e4iVT-0007ZD-DG
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 03:11:11 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e4iVS-0007Kr-0R
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 07:11:10 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id E66CC2E80CB
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 07:11:09 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Oct 2017 07:05:04 -0000
From: Bug <kewlubuntu@mailinator.com>
Reply-To: Bug 1723984 <1723984@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150816671920.14146.15870333277151125380.malonedeb@chaenomeles.canonical.com>
Message-Id: <150831030476.16886.7030297420113802450.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1723984] Re: ID_MMFR0 has an invalid value on
 aarch64 cpu (A57, A53)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I see your point. Thank you for the advice. I'm doing some low-level
check to be sure to be on a known platform, so this midr based code is
very localized. For the "core" of the kernel, I'm mostly using (1) as
access to MMU registers are localized in armv7/armv8 specialized sub-
directories.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1723984

Title:
  ID_MMFR0 has an invalid value on aarch64 cpu (A57, A53)

Status in QEMU:
  New

Bug description:
  The ID_MMFR0 register, accessed from aarch64 state as an invalid value:
  - ARM ARM v8 documentation (D7.2 General system control registers) descri=
bed bits AuxReg[23:20] to be
    "In ARMv8-A the only permitted value is 0010"
  - Cortex A53 and Cortex A57 TRM describe the value to be 0x10201105, so A=
uxReg[23:20] is 0010 too
  - in QEMU target/arm/cpu64.c, the relevant value is
    cpu->id_mmfr0 =3D 0x10101105;

  The 1 should be changed to 2.

  Spotted & Tested on the following qemu revision:

  commit 48ae1f60d8c9a770e6da64407984d84e25253c69
  Merge: 78b62d3 b867eaa
  Author: Peter Maydell <peter.maydell@linaro.org>
  Date:   Mon Oct 16 14:28:13 2017 +0100

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1723984/+subscriptions
