Received: from eggs.gnu.org ([2001:4830:134:3::10]:55659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eM5jI-0000Fw-3H
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 00:25:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eM5jH-0004ug-Ae
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 00:25:16 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  5 Dec 2017 16:25:00 +1100
Message-Id: <20171205052501.13414-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 0/1] ppc-for-2.11 queue 20171205
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

The following changes since commit 2a4c7e839101a52f7bf9ba4dd64e466518565352:

  Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2017-12-04 17:19:04 +0000)

are available in the Git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-2.11-20171205

for you to fetch changes up to 044897ef4a22af89aecb8df509477beba0a2e0ce:

  target/ppc: Fix system lockups caused by interrupt_request state corruption (2017-12-05 12:28:42 +1100)

----------------------------------------------------------------
ppc patch queue 2017-12-05

Alas, this is yet another fix for ppc that I think it's worth
squeezing into 2.11.  It's a really ugly fix for some pretty ugly
code, but it does seem to address a real problem.  It's also a problem
that's appeared relatively recently, since it was either created by,
or made much easier to trigger by, by the merge of MTTCG.

----------------------------------------------------------------
Richard Purdie (1):
      target/ppc: Fix system lockups caused by interrupt_request state corruption

 target/ppc/excp_helper.c |  7 +++----
 target/ppc/helper_regs.h | 17 +++++++++++++++--
 2 files changed, 18 insertions(+), 6 deletions(-)
