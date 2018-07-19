Received: from eggs.gnu.org ([2001:4830:134:3::10]:52529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fg7K3-0001t5-A8
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 07:42:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fg7Jy-0002XU-Ty
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 07:42:15 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu, 19 Jul 2018 13:42:03 +0200
Message-Id: <20180719114204.13036-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL for-3.0 0/1] s390x bugfix for rc2
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

The following changes since commit ea6abffa8a08d832feb759d359d5b935e3087cf7:

  Update version for v3.0.0-rc1 release (2018-07-17 18:15:19 +0100)

are available in the Git repository at:

  git://github.com/cohuck/qemu tags/s390x-20180719

for you to fetch changes up to 677ff32db12bcd1bca3a3df733d2478896d6df96:

  s390x/cpumodel: fix segmentation fault when baselining models (2018-07-18 14:20:02 +0200)

----------------------------------------------------------------
don't segfault when trying to baseline an odd cpu model

----------------------------------------------------------------

David Hildenbrand (1):
  s390x/cpumodel: fix segmentation fault when baselining models

 target/s390x/cpu_models.c | 8 ++++++++
 1 file changed, 8 insertions(+)

-- 
2.14.4
