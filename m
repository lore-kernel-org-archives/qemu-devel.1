Received: from eggs.gnu.org ([2001:4830:134:3::10]:40651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eCLTX-0005vw-5i
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 03:12:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eCLTU-0000RR-1i
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 03:12:43 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  8 Nov 2017 19:12:29 +1100
Message-Id: <20171108081232.28322-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 0/3] ppc-for-2.11 queue 20171108
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, groug@kaod.org, thuth@redhat.com, lvivier@redhat.com, David Gibson <david@gibson.dropbear.id.au>

The following changes since commit b0fbe46ad82982b289a44ee2495b59b0bad8a842:

  Update version for v2.11.0-rc0 release (2017-11-07 16:05:28 +0000)

are available in the git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-2.11-20171108

for you to fetch changes up to c91c187f715aded9e1ac28412bba41fd3cbaf010:

  e500: ppce500_init_mpic() return device instead of IRQ array (2017-11-08 13:21:37 +1100)

----------------------------------------------------------------
ppc patch queue 2017-11-08

Here's the current set of accumulated ppc patches for qemu-2.11.
Since we're now in hard freeze these are all bugfixes (although some
fix a bug by way of a cleanup).

----------------------------------------------------------------
Greg Kurz (1):
      ppc: fix setting of compat mode

Michael Davidsaver (1):
      e500: ppce500_init_mpic() return device instead of IRQ array

Thomas Huth (1):
      hw/display/sm501: Fix comment in sm501_sysbus_class_init()

 hw/display/sm501.c  |  2 +-
 hw/ppc/e500.c       | 32 +++++++++++++-------------------
 target/ppc/compat.c |  2 +-
 3 files changed, 15 insertions(+), 21 deletions(-)
