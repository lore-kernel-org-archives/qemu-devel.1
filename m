Received: from eggs.gnu.org ([2001:4830:134:3::10]:43458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cuyum-0008Hh-8s
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 06:08:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cuyuj-0003vw-0U
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 06:08:48 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon,  3 Apr 2017 20:08:31 +1000
Message-Id: <20170403100832.24088-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 0/1] ppc-for-2.9 queue 20170403
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, imammedo@redhat.com, bharata@linux.vnet.ibm.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

The following changes since commit 95b31d709ba343ad237c3630047ee7438bac4065:

  Merge remote-tracking branch 'remotes/awilliam/tags/vfio-updates-20170331.0' into staging (2017-03-31 18:06:13 +0100)

are available in the git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-2.9-20170403

for you to fetch changes up to 8149e2992f7811355cc34721b79d69d1a3a667dd:

  pseries: Enforce homogeneous threads-per-core (2017-04-03 13:46:18 +1000)

----------------------------------------------------------------
ppc patch queue 2017-04-03

A single bugfix in this pull request, for an ugly assert() failure, if
the user ignores the information in query-hotpluggable-cpus and tries
to hot add CPUs to pseries with bad parameters.

----------------------------------------------------------------
David Gibson (1):
      pseries: Enforce homogeneous threads-per-core

 hw/ppc/spapr.c | 6 ++++++
 1 file changed, 6 insertions(+)
