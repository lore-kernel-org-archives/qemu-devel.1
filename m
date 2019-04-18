Received: from eggs.gnu.org ([209.51.188.92]:42321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hH28E-00044s-75
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 04:10:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hH28C-0008Fi-9m
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 04:10:54 -0400
Received: from indium.canonical.com ([91.189.90.7]:52606)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hH28A-0008EW-Pw
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 04:10:52 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hH289-0001tZ-0t
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 08:10:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 0014B2E80C7
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 08:10:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Apr 2019 08:03:27 -0000
From: Jakub Jermar <1825311@bugs.launchpad.net>
Reply-To: Bug 1825311 <1825311@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <155557460746.17507.17649109204793492383.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1825311] [NEW] mips_cpu_handle_mmu_fault renders
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

Public bug reported:

On MIPS, data accesses to pages mapped in the TLB result in
mips_cpu_handle_mmu_fault() marking the page unconditionally executable,
even if the TLB entry has the XI bit set. Later on, when there is an
attempt to execute this page, no exception is generated, even though
TLBXI is expected.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1825311

Title:
  mips_cpu_handle_mmu_fault renders all accessed pages executable

Status in QEMU:
  New

Bug description:
  On MIPS, data accesses to pages mapped in the TLB result in
  mips_cpu_handle_mmu_fault() marking the page unconditionally
  executable, even if the TLB entry has the XI bit set. Later on, when
  there is an attempt to execute this page, no exception is generated,
  even though TLBXI is expected.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1825311/+subscriptions
