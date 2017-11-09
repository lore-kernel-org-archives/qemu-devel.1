Received: from eggs.gnu.org ([2001:4830:134:3::10]:46312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eCooR-0005DW-Ct
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 10:32:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eCooL-00032a-LT
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 10:32:15 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu,  9 Nov 2017 16:32:02 +0100
Message-Id: <20171109153204.26436-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL for-2.11 0/2] s390x changes for 2.11-rc1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

The following changes since commit b0fbe46ad82982b289a44ee2495b59b0bad8a842:

  Update version for v2.11.0-rc0 release (2017-11-07 16:05:28 +0000)

are available in the git repository at:

  git://github.com/cohuck/qemu tags/s390x-20171109

for you to fetch changes up to fdaae351435147b9be6161d0f136ca7c40308059:

  target/s390x: Finish implementing RISBGN (2017-11-09 10:36:06 +0100)

----------------------------------------------------------------
s390x changes: let pci devices start out in a usable state, and make
RISBGN work in tcg.

----------------------------------------------------------------

Christian Borntraeger (1):
  s390x/pci: let pci devices start in configured mode

Richard Henderson (1):
  target/s390x: Finish implementing RISBGN

 hw/s390x/s390-pci-bus.c  | 2 +-
 target/s390x/translate.c | 9 +++------
 2 files changed, 4 insertions(+), 7 deletions(-)

-- 
2.13.6
