Received: from eggs.gnu.org ([2001:4830:134:3::10]:35089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dvITy-00034f-Gd
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:34:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dvITv-0001p6-DD
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:34:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60492)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dvITv-0001o1-7s
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:34:39 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 22 Sep 2017 09:34:31 +0200
Message-Id: <20170922073432.2811-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 0/1] s390x bugfix (needed for stable)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, mdroth@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, Cornelia Huck <cohuck@redhat.com>

The following changes since commit 0a8066f0c068f1e318a1aacd7864fc00e455a37b:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20170921' into staging (2017-09-21 17:42:27 +0100)

are available in the git repository at:

  git://github.com/cohuck/qemu tags/s390x-20170922

for you to fetch changes up to 3f2d07b3b01ea61126b382633ab4006320923048:

  s390x/ais: for 2.10 stable: disable ais facility (2017-09-22 09:25:21 +0200)

----------------------------------------------------------------
Fix an s390x migration breakage up for 2.10 stable.
This will be fixed properly for 2.11.

----------------------------------------------------------------

Christian Borntraeger (1):
  s390x/ais: for 2.10 stable: disable ais facility

 target/s390x/kvm.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

-- 
2.13.5
