Received: from eggs.gnu.org ([2001:4830:134:3::10]:57442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dQ55b-0002bu-UT
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 01:00:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dQ55X-0004ik-5t
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 01:00:32 -0400
Received: from mail-yw0-x242.google.com ([2607:f8b0:4002:c05::242]:35936)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1dQ55X-0004iA-2L
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 01:00:27 -0400
Received: by mail-yw0-x242.google.com with SMTP id l21so1554943ywb.3
	for <qemu-devel@nongnu.org>; Tue, 27 Jun 2017 22:00:24 -0700 (PDT)
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Wed, 28 Jun 2017 01:00:01 -0400
Message-Id: <20170628050003.1809-1-bobby.prani@gmail.com>
Subject: [Qemu-devel] [TEST PATCH 0/2] Instrumentation and TLB stats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net

The following two patches are what I use to instrument guest code and
collect TLB hit/miss information. These patches are for informational
and discussion purposes only.

Pranith Kumar (2):
  [TEST] aarch64: Use pmuserenr_el0 register for instrumentation
  [TEST] Collect TLB stats along with victim TLB

 accel/tcg/cputlb.c        | 12 ++++++++++++
 cpus.c                    | 26 ++++++++++++++++++++++++++
 include/exec/cpu-defs.h   |  4 ++++
 include/sysemu/cpus.h     |  2 ++
 target/arm/helper.c       | 23 +++++++++++++++++++++--
 tcg/i386/tcg-target.inc.c | 16 ++++++++++++++--
 vl.c                      |  3 +++
 7 files changed, 82 insertions(+), 4 deletions(-)

-- 
2.13.0
