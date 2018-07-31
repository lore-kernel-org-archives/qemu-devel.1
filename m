Received: from eggs.gnu.org ([2001:4830:134:3::10]:47739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fkOUs-000749-Aw
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 02:51:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fkOUp-0003ol-8s
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 02:51:06 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 31 Jul 2018 08:50:56 +0200
Message-Id: <20180731065057.23710-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL for-3.0 0/1] s390x fix for -rc3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>

The following changes since commit 18a398f6a39df4b08ff86ac0d38384193ca5f4cc:

  Update version for v3.0.0-rc2 release (2018-07-24 22:06:31 +0100)

are available in the Git repository at:

  git://github.com/cohuck/qemu tags/s390x-20180731

for you to fetch changes up to 408e5ace517ff18c9c7cd918fc93358162e6e26d:

  s390x/sclp: fix maxram calculation (2018-07-30 17:41:52 +0200)

----------------------------------------------------------------
fix large guests on s390x

----------------------------------------------------------------

Christian Borntraeger (1):
  s390x/sclp: fix maxram calculation

 hw/s390x/sclp.c | 1 +
 1 file changed, 1 insertion(+)

-- 
2.14.4
