Received: from eggs.gnu.org ([2001:4830:134:3::10]:47508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ddKPT-0000Vd-LZ
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 13:59:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ddKPP-0004ve-HZ
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 13:59:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35090)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ddKPP-0004ul-BR
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 13:59:43 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu,  3 Aug 2017 14:59:36 -0300
Message-Id: <20170803175937.22225-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 0/1] cpu: crash fix for -rc2 (don't allow
 negative core id)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>

The following changes since commit aaaec6acad7cf97372d48c1b09126a09697519c8:

  Update version for v2.10.0-rc1 release (2017-08-02 16:36:32 +0100)

are available in the git repository at:

  git://github.com/ehabkost/qemu.git tags/machine-pull-request

for you to fetch changes up to be2960baae07e5257cde8c814cbd91647e235147:

  cpu: don't allow negative core id (2017-08-02 18:30:13 -0300)

----------------------------------------------------------------
cpu: crash fix (don't allow negative core id)

----------------------------------------------------------------

Laurent Vivier (1):
  cpu: don't allow negative core id

 hw/cpu/core.c | 5 +++++
 1 file changed, 5 insertions(+)

-- 
2.9.4
