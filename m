Received: from eggs.gnu.org ([2001:4830:134:3::10]:57740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fLAoa-0004sb-Ed
	for qemu-devel@nongnu.org; Tue, 22 May 2018 13:11:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fLAoV-0007PY-G4
	for qemu-devel@nongnu.org; Tue, 22 May 2018 13:11:12 -0400
Received: from indium.canonical.com ([91.189.90.7]:44752)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fLAoV-0007Ov-AB
	for qemu-devel@nongnu.org; Tue, 22 May 2018 13:11:07 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fLAoO-00053A-VK
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 17:11:01 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 833232E8F68
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 17:10:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 May 2018 17:00:52 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1771948 <1771948@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152662586393.8948.4447581734098771947.malonedeb@chaenomeles.canonical.com>
Message-Id: <152700845251.16304.10440634003527247551.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1771948] Re: aarch64 msr CNTFRQ_EL0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Mmm, that's not really supposed to happen. Do you have a test guest
binary you can attach that I can reproduce with?

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1771948

Title:
  aarch64 msr CNTFRQ_EL0

Status in QEMU:
  New

Bug description:
  Hello,

  I'm running qemu 2.12 on a raspberry pi 3 with the command:

  qemu-system-aarch64 -M raspi3 -serial stdio -kernel executable.bin

  On my start file (right in the beginning with the highest EL), the
  following instructions:

  ldr x0 , =3D19200000
  msr CNTFRQ_EL0, x0

  =

  and qemu halts on the "msr CNTFRQ_EL0, x0" instruction.

  I believe this is not a normal behavior.

  Thank you

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1771948/+subscriptions
