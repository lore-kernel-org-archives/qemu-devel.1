Received: from eggs.gnu.org ([2001:4830:134:3::10]:36142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eb16g-0007hW-BW
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 04:31:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eb16a-0003UD-Ns
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 04:31:06 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 15 Jan 2018 10:30:53 +0100
Message-Id: <1516008655-31732-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] Clean up the ppc default configs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

ppc64-softmmu is a superset of ppc-softmmu which in turn is a superset
of ppcemb-softmmu. But since the config files are currently independent
from each other, we missed to define some CONFIG switches in the super-
sets: CONFIG_SUNGEM is missing from the ppc64-softmmu config, and the
CONFIG_IDE_SII3112 switch is only defined in ppcemb-softmmu.

Let's fix this by including the subsets instead of duplicating all the
switches all over the place.

(off-topic question: Do we still need a separate ppcemb-softmmu nowadays?
It seemed to be useful 10 years ago when everybody was doing KVM on
embedded PPC, but these days seem to be pretty much over now, so IMHO
just using ppc-softmmu for embedded should be enough nowadays? We could
save quite some compilation- and "make check"-time if we could finally get
rid of ppcemb-softmmu again...)

Thomas Huth (2):
  default-configs/ppc64-softmmu: Include 32-bit configs instead of
    copying them
  default-configs/ppc-softmmu: Restructure the switches according to the
    machines

 default-configs/ppc-softmmu.mak   | 59 +++++++++++++++----------------------
 default-configs/ppc64-softmmu.mak | 61 +++++----------------------------------
 2 files changed, 32 insertions(+), 88 deletions(-)

-- 
1.8.3.1
