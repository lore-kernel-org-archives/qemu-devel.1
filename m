Received: from eggs.gnu.org ([2001:4830:134:3::10]:59433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dF8Os-0000NH-DB
	for qemu-devel@nongnu.org; Sun, 28 May 2017 20:19:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dF8Op-0006NZ-4Z
	for qemu-devel@nongnu.org; Sun, 28 May 2017 20:19:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53856)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dF8Oo-0006NN-UY
	for qemu-devel@nongnu.org; Sun, 28 May 2017 20:19:07 -0400
Date: Mon, 29 May 2017 03:19:05 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1496017081-24032-14-git-send-email-mst@redhat.com>
References: <1496017081-24032-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1496017081-24032-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 13/13] acpi-test: update expected files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

commit 1a8d61ddbf ("pc: ACPI BIOS: use highest NUMA node for hotplug mem
hole SRAT entry") changed generated SRAT tables, update expected files
accordingly.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/acpi-test-data/pc/SRAT.memhp  | Bin 264 -> 264 bytes
 tests/acpi-test-data/q35/SRAT.memhp | Bin 264 -> 264 bytes
 2 files changed, 0 insertions(+), 0 deletions(-)

diff --git a/tests/acpi-test-data/pc/SRAT.memhp b/tests/acpi-test-data/pc/SRAT.memhp
index a7dddf7760698193819e60a3a96f2a57cf367522..e508b4ae3cd9e3000209a4f9597913faa4206ec1 100644
GIT binary patch
delta 23
ecmeBR>R{pu4ss0PU}RumTr`pE1|#Fd$EpB8iv|+_

delta 24
gcmeBR>R{pu4ss0PU}RumTs)EM#>8D*6W_=H08BjxX8-^I

diff --git a/tests/acpi-test-data/q35/SRAT.memhp b/tests/acpi-test-data/q35/SRAT.memhp
index a7dddf7760698193819e60a3a96f2a57cf367522..e508b4ae3cd9e3000209a4f9597913faa4206ec1 100644
GIT binary patch
delta 23
ecmeBR>R{pu4ss0PU}RumTr`pE1|#Fd$EpB8iv|+_

delta 24
gcmeBR>R{pu4ss0PU}RumTs)EM#>8D*6W_=H08BjxX8-^I

-- 
MST
