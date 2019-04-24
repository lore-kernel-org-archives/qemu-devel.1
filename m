Received: from eggs.gnu.org ([209.51.188.92]:46587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJJ54-0001xm-KF
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:41:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJJ53-0007ZD-E9
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:41:02 -0400
Received: from indium.canonical.com ([91.189.90.7]:48490)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hJJ53-0007WQ-89
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:41:01 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hJJ51-0000PU-6O
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 14:40:59 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 2E4682E80CC
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 14:40:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Apr 2019 14:27:49 -0000
From: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <1825311@bugs.launchpad.net>
Reply-To: Bug 1825311 <1825311@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <155557460746.17507.17649109204793492383.malonedeb@soybean.canonical.com>
Message-Id: <155611606929.16667.9991624747781417286.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1825311] Re: mips_cpu_handle_mmu_fault renders
 all accessed pages executable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Patch posted on the list:
https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg03711.html

** Changed in: qemu
       Status: Fix Committed =3D> In Progress

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1825311

Title:
  mips_cpu_handle_mmu_fault renders all accessed pages executable

Status in QEMU:
  In Progress

Bug description:
  On MIPS, data accesses to pages mapped in the TLB result in
  mips_cpu_handle_mmu_fault() marking the page unconditionally
  executable, even if the TLB entry has the XI bit set. Later on, when
  there is an attempt to execute this page, no exception is generated,
  even though TLBXI is expected.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1825311/+subscriptions
