Received: from eggs.gnu.org ([2001:4830:134:3::10]:54507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1flesO-0000Tn-0l
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 14:32:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1flesN-0005AL-3I
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 14:32:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49660 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1flesM-00059x-UQ
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 14:32:35 -0400
Date: Fri, 3 Aug 2018 21:32:32 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180803182100.874220-3-mst@redhat.com>
References: <20180803182100.874220-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180803182100.874220-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL alternative 2/2] tests/acpi: update tables after
 memory hotplug changes
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

Previous patch changes acpi tables, update expected
files accordingly.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/acpi-test-data/pc/SRAT.dimmpxm  | Bin 472 -> 472 bytes
 tests/acpi-test-data/pc/SRAT.memhp    | Bin 264 -> 264 bytes
 tests/acpi-test-data/q35/SRAT.dimmpxm | Bin 472 -> 472 bytes
 tests/acpi-test-data/q35/SRAT.memhp   | Bin 264 -> 264 bytes
 4 files changed, 0 insertions(+), 0 deletions(-)

diff --git a/tests/acpi-test-data/pc/SRAT.dimmpxm b/tests/acpi-test-data/pc/SRAT.dimmpxm
index 3b10a607d5bba6cebb97d9174c2a54a577bba9a8..5aa6f693ef9819b3d30cbd76cafb0ee8b5fc5534 100644
GIT binary patch
delta 52
qcmcb?e1n-QILI;N1|tIl<F1Wd>lhXO|Ns9T$YTIu7+{7mfHVMsX$lem

delta 52
scmcb?e1n-QILI;N1|tIl<MxeQ>lhUn7#IYAJP>#Rp%@sLVGJM*038_z5&!@I

diff --git a/tests/acpi-test-data/pc/SRAT.memhp b/tests/acpi-test-data/pc/SRAT.memhp
index e508b4ae3cd9e3000209a4f9597913faa4206ec1..5de8a100a4adf968b79a7b154a7f98123d583474 100644
GIT binary patch
delta 51
pcmeBR>R{pu4ss0PU}RumTso2Kp2GkC|Gxt{3?K{x%rFL!1^_r@2$}!@

delta 51
pcmeBR>R{pu4ss0PU}RumTr`pEo&p09068G=141z{FvA!?8UWLX1)2Z=

diff --git a/tests/acpi-test-data/q35/SRAT.dimmpxm b/tests/acpi-test-data/q35/SRAT.dimmpxm
index 3b10a607d5bba6cebb97d9174c2a54a577bba9a8..5aa6f693ef9819b3d30cbd76cafb0ee8b5fc5534 100644
GIT binary patch
delta 52
qcmcb?e1n-QILI;N1|tIl<F1Wd>lhXO|Ns9T$YTIu7+{7mfHVMsX$lem

delta 52
scmcb?e1n-QILI;N1|tIl<MxeQ>lhUn7#IYAJP>#Rp%@sLVGJM*038_z5&!@I

diff --git a/tests/acpi-test-data/q35/SRAT.memhp b/tests/acpi-test-data/q35/SRAT.memhp
index e508b4ae3cd9e3000209a4f9597913faa4206ec1..5de8a100a4adf968b79a7b154a7f98123d583474 100644
GIT binary patch
delta 51
pcmeBR>R{pu4ss0PU}RumTso2Kp2GkC|Gxt{3?K{x%rFL!1^_r@2$}!@

delta 51
pcmeBR>R{pu4ss0PU}RumTr`pEo&p09068G=141z{FvA!?8UWLX1)2Z=

-- 
MST
