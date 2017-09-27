Received: from eggs.gnu.org ([2001:4830:134:3::10]:58339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dx8mG-0000qW-TB
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 05:37:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dx8mC-00050n-KY
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 05:37:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33878)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dx8mC-0004yu-FN
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 05:37:08 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed, 27 Sep 2017 11:36:59 +0200
Message-Id: <20170927093700.6058-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL URGENT 0/1] another s390x compat fix
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

The following changes since commit 31bc1d8481af414cfa2857f905e40f7d8e6d5b2e:

  Merge remote-tracking branch 'remotes/mjt/tags/trivial-patches-fetch' into staging (2017-09-26 19:49:08 +0100)

are available in the git repository at:

  git://github.com/cohuck/qemu tags/s390x-20170927

for you to fetch changes up to 9dacc908462693719d84ec594e839434959cf6f1:

  s390x/cpumodel: remove ais from z14 default model-> also for 2.10.1 (2017-09-27 11:13:32 +0200)

----------------------------------------------------------------
Another s390x compat fix that should make it into 2.10.1.

----------------------------------------------------------------

Christian Borntraeger (1):
  s390x/cpumodel: remove ais from z14 default model-> also for 2.10.1

 target/s390x/gen-features.c | 1 -
 1 file changed, 1 deletion(-)

-- 
2.13.5
