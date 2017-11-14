Received: from eggs.gnu.org ([2001:4830:134:3::10]:55734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eEb91-0004qG-9C
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 08:20:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eEb8y-0002TJ-1u
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 08:20:51 -0500
Received: from indium.canonical.com ([91.189.90.7]:33222)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eEb8x-0002Sm-SF
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 08:20:47 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eEb8w-0006Qc-DG
	for <qemu-devel@nongnu.org>; Tue, 14 Nov 2017 13:20:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 5D2902E8059
	for <qemu-devel@nongnu.org>; Tue, 14 Nov 2017 13:20:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Nov 2017 13:06:27 -0000
From: Googulator <1732177@bugs.launchpad.net>
Reply-To: Bug 1732177 <1732177@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <151066478781.7464.15116659457637721936.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1732177] [NEW] SBSA ACS test freezes inside
 qemu-system-aarch64
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

In an effort to get Windows 10 for ARM64 (which is supposed to boot on
SBSA/SBBR-compliant platforms) to boot inside qemu, I tried to run the
SBSA ACS test suite. I used the UEFI image from the latest Linaro
snapshot, and built the SBSA ACS UEFI application from
https://github.com/ARM-software/sbsa-acs myself using a Linaro aarch64
compiler.

Test #8 causes an infinite exception loop, as the exception vectors
themselves somehow become inaccessible, and accessing them triggers
another exception to be handled by the same vector. (With some older
Linaro UEFI images, the hard lockup is avoided, and the SBSA UEFI app
crashes instead.) If I disable that test, the testsuite locks up in
other tests in very similar ways. We aren't even able to get a pass/fail
score from the app because of this.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1732177

Title:
  SBSA ACS test freezes inside qemu-system-aarch64

Status in QEMU:
  New

Bug description:
  In an effort to get Windows 10 for ARM64 (which is supposed to boot on
  SBSA/SBBR-compliant platforms) to boot inside qemu, I tried to run the
  SBSA ACS test suite. I used the UEFI image from the latest Linaro
  snapshot, and built the SBSA ACS UEFI application from
  https://github.com/ARM-software/sbsa-acs myself using a Linaro aarch64
  compiler.

  Test #8 causes an infinite exception loop, as the exception vectors
  themselves somehow become inaccessible, and accessing them triggers
  another exception to be handled by the same vector. (With some older
  Linaro UEFI images, the hard lockup is avoided, and the SBSA UEFI app
  crashes instead.) If I disable that test, the testsuite locks up in
  other tests in very similar ways. We aren't even able to get a
  pass/fail score from the app because of this.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1732177/+subscriptions
