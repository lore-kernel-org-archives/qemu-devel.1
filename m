Received: from eggs.gnu.org ([2001:4830:134:3::10]:36151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dD7JG-0008OC-Ad
	for qemu-devel@nongnu.org; Tue, 23 May 2017 06:45:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dD7JC-0006Mg-0O
	for qemu-devel@nongnu.org; Tue, 23 May 2017 06:45:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53740)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dD7JB-0006MI-RU
	for qemu-devel@nongnu.org; Tue, 23 May 2017 06:44:57 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 23 May 2017 07:44:53 -0300
Message-Id: <20170523104454.31309-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 0/1] Silence "make check" warnings on NUMA test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org

The following changes since commit 56821559f0ba682fe6b367815572e6f974d329ab:

  Merge remote-tracking branch 'dgilbert/tags/pull-hmp-20170517' into staging (2017-05-18 13:36:15 +0100)

are available in the git repository at:

  git://github.com/ehabkost/qemu.git tags/numa-pull-request

for you to fetch changes up to c6ff347c8078bb86f75d38955641cb73e9d5b309:

  numa: Silence incomplete mapping warning under qtest (2017-05-22 14:24:52 -0300)

----------------------------------------------------------------
Silence "make check" warnings on NUMA test

----------------------------------------------------------------

Igor Mammedov (1):
  numa: Silence incomplete mapping warning under qtest

 hw/core/machine.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.11.0.259.g40922b1
