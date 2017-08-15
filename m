Received: from eggs.gnu.org ([2001:4830:134:3::10]:35016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dhWKQ-0001Kq-20
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 03:31:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dhWKM-0004yp-TU
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 03:31:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53006)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dhWKM-0004wI-Nq
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 03:31:50 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 15 Aug 2017 09:31:45 +0200
Message-Id: <20170815073146.11726-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL for-2.10 0/1] bugfix for s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.de, thuth@redhat.com, Cornelia Huck <cohuck@redhat.com>

The following changes since commit 83c3a1f61673ef554facf4d6d29ed56c5a219f9d:

  xlnx-qspi: add a property for mmio-execution (2017-08-14 14:17:18 +0100)

are available in the git repository at:

  git://github.com/cohuck/qemu tags/s390x-20170815

for you to fetch changes up to 88b3739acdec0b8ccdbb65425b0d31235e2c7ca3:

  pc-bios/s390-ccw: Use rm command during make clean (2017-08-15 09:06:01 +0200)

----------------------------------------------------------------
Regression fix for 'make clean' on s390x.

----------------------------------------------------------------

Eric Farman (1):
  pc-bios/s390-ccw: Use rm command during make clean

 pc-bios/s390-ccw/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.13.5
