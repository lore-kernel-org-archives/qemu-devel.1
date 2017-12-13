Received: from eggs.gnu.org ([2001:4830:134:3::10]:59219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eP40E-0008DY-UH
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 05:11:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eP40B-0003Ye-SF
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 05:11:02 -0500
Received: from indium.canonical.com ([91.189.90.7]:48966)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eP40B-0003YP-Li
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 05:10:59 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eP409-0007Bk-CO
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 10:10:57 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 5C1122E80CD
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 10:10:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 Dec 2017 09:59:47 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1737882 <1737882@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151314690941.20315.1169334879966429401.malonedeb@chaenomeles.canonical.com>
Message-Id: <151315918771.3331.11265722931310678909.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1737882] Re: QEMU Zaurus cannot boot 2.4.x kernels
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Thanks for the bug report. Unfortunately the akita and spitz models are
pretty much unmaintained these days, so if this is important to you
you'll need to investigate the cause of the problem yourself, especially
given that more recent kernels work.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1737882

Title:
  QEMU Zaurus cannot boot 2.4.x kernels

Status in QEMU:
  New

Bug description:
  I tried akita and spitz machines.
  4.x, 3.x and 2.6.x kernels boot OK, but when I try to pass any 2.4.x, qem=
u crashes with "Trying to execute code outside RAM or ROM at 0x00800000".

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1737882/+subscriptions
