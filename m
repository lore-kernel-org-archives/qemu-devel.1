Received: from eggs.gnu.org ([209.51.188.92]:59972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJ4PF-0003BX-LP
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 19:00:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJ4K7-0005y6-Hj
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:55:36 -0400
Received: from indium.canonical.com ([91.189.90.7]:48664)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hJ4K7-0005vL-Br
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:55:35 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hJ4K4-0006lV-Jk
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 22:55:32 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 93D542E80CB
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 22:55:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Apr 2019 22:46:16 -0000
From: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <1825311@bugs.launchpad.net>
Reply-To: Bug 1825311 <1825311@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <155557460746.17507.17649109204793492383.malonedeb@soybean.canonical.com>
Message-Id: <155605957771.16667.5018804673096710349.launchpad@soybean.canonical.com>
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

** Changed in: qemu
       Status: New =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1825311

Title:
  mips_cpu_handle_mmu_fault renders all accessed pages executable

Status in QEMU:
  Fix Committed

Bug description:
  On MIPS, data accesses to pages mapped in the TLB result in
  mips_cpu_handle_mmu_fault() marking the page unconditionally
  executable, even if the TLB entry has the XI bit set. Later on, when
  there is an attempt to execute this page, no exception is generated,
  even though TLBXI is expected.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1825311/+subscriptions
