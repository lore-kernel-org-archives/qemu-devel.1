Received: from eggs.gnu.org ([2001:4830:134:3::10]:59989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fbQaV-0003B2-5k
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 09:15:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fbQaS-0003BI-1M
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 09:15:51 -0400
Received: from indium.canonical.com ([91.189.90.7]:38338)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fbQaR-0003Ak-RP
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 09:15:47 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fbQaQ-0003Jy-9O
	for <qemu-devel@nongnu.org>; Fri, 06 Jul 2018 13:15:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 45F1C2E819D
	for <qemu-devel@nongnu.org>; Fri,  6 Jul 2018 13:15:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Jul 2018 13:04:33 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1774677 <1774677@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152787131775.31828.3557775502793493947.malonedeb@soybean.canonical.com>
Message-Id: <153088227346.17935.14094674972674838552.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1774677] Re: -icount increases boot time by >10x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

...ah, that's the bug fixed by this patch:
https://patchwork.ozlabs.org/patch/940058/

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1774677

Title:
  -icount increases boot time by >10x

Status in QEMU:
  Confirmed

Bug description:
  When I specify the -icount option, some guest operations such as
  booting a Linux kernel take more than 10 times longer than otherwise.
  For example, the following will boot Aboriginal Linux to the login
  prompt about 6 seconds on my system (using TCG, not KVM):

  wget http://landley.net/aboriginal/downloads/old/binaries/1.4.5/system-im=
age-i686.tar.gz
  gunzip <system-image-i686.tar.gz | tar xfv -
  cd system-image-i686
  sh run-emulator.sh

  If I replace the last line with

  QEMU_EXTRA=3D"-icount shift=3Dauto" sh run-emulator.sh

  booting to the login prompt takes about 1 minute 20 seconds.

  I have tried different values for "shift" other than the "auto" used
  above, but have not been able to find one that gives reasonable
  performance.  Specifying "sleep=3Doff" also did not help.

  During the slow boots, qemu appears to spend most of its time
  sleeping, not using the host CPU.

  I see this with multiple versions of qemu, including current git
  sources (c181ddaa176856b3cd2dfd12bbcf25fa9c884a97), and on multiple
  host OSes, including Debian 9 on x86_64.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1774677/+subscriptions
