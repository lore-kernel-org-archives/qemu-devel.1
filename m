Received: from eggs.gnu.org ([2001:4830:134:3::10]:57320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dgAaA-0001XK-Mo
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:06:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dgAa8-0003IB-1T
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:06:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50856)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dgAa7-0003GE-Ru
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:06:31 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 11 Aug 2017 16:06:26 +0200
Message-Id: <20170811140627.22421-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL for-2.10 0/1] bugfix for boot-serial-test and no
 tcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, thuth@redhat.com, pbonzini@redhat.com, berrange@redhat.com, Cornelia Huck <cohuck@redhat.com>

The following changes since commit 473a321122fd3c2c327a5a5d01a9a41f26f1734c:

  Merge remote-tracking branch 'remotes/gkurz/tags/for-upstream' into staging (2017-08-10 17:50:55 +0100)

are available in the git repository at:

  git://github.com/cohuck/qemu tags/boot-serial-no-tcg-20170811

for you to fetch changes up to 480bc11e61693796debd3a9566be0ca1795bb7b7:

  boot-serial-test: fallback to kvm accelerator (2017-08-11 15:44:05 +0200)

----------------------------------------------------------------
Fix the boot-serial test to work with the new --disable-tcg.

----------------------------------------------------------------

Cornelia Huck (1):
  boot-serial-test: fallback to kvm accelerator

 tests/boot-serial-test.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
2.13.4
