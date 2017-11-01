Received: from eggs.gnu.org ([2001:4830:134:3::10]:50798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e9mzS-0001yA-E0
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 02:59:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e9mzR-00008v-TF
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 02:59:06 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed,  1 Nov 2017 07:58:54 +0100
Message-Id: <1509519537-6964-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] hw/arm: Mark the "fsl,
 imx" devices with user_creatable = false
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org

These devices can not be used by the user directly and cause QEMU
to abort() if the user tried it anyway. So simply mark the devices
with user_creatable = false to avoid that the users can run into
this unpleasant situation.

Thomas Huth (3):
  hw/arm: Mark the "fsl,imx6" device with user_creatable = false
  hw/arm: Mark the "fsl,imx25" device with user_creatable = false
  hw/arm: Mark the "fsl,imx31" device with user_creatable = false

 hw/arm/fsl-imx25.c | 6 +++++-
 hw/arm/fsl-imx31.c | 6 +++++-
 hw/arm/fsl-imx6.c  | 3 ++-
 3 files changed, 12 insertions(+), 3 deletions(-)

-- 
1.8.3.1
