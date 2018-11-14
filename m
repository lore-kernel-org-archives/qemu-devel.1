Received: from eggs.gnu.org ([2001:4830:134:3::10]:52009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gMsDq-0005LN-0y
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 05:16:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gMsDm-0002ik-Pp
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 05:16:34 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed, 14 Nov 2018 11:16:09 +0100
Message-Id: <20181114101610.26854-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL for-3.1 0/1] bugfix for s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>

The following changes since commit 6ff144698935e8bdbc96d255cf49b1a7d54174ac:

  Merge remote-tracking branch 'remotes/mdroth/tags/qga-pull-2018-11-12-tag' into staging (2018-11-13 12:32:30 +0000)

are available in the Git repository at:

  https://github.com/cohuck/qemu tags/s390x-20181114

for you to fetch changes up to b6e67ecc7b6e8938982ab94820c079f24845f623:

  s390x/pci: properly fail if the zPCI device cannot be created (2018-11-13 16:46:55 +0100)

----------------------------------------------------------------
Fix error handling during zpci device creation.

----------------------------------------------------------------

David Hildenbrand (1):
  s390x/pci: properly fail if the zPCI device cannot be created

 hw/s390x/s390-pci-bus.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

-- 
2.17.2
