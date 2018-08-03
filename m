Received: from eggs.gnu.org ([2001:4830:134:3::10]:57301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1flWNR-0003yh-94
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 05:28:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1flWNQ-0002BY-Hx
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 05:28:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59608 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1flWNQ-0002Aw-CM
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 05:28:04 -0400
Date: Fri, 3 Aug 2018 12:28:02 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180803083830.775669-4-mst@redhat.com>
References: <20180803083830.775669-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180803083830.775669-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL 3/5] tests/acpi-test: update ACPI tables test
 blobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Dou Liyang <douly.fnst@cn.fujitsu.com>

From: Dou Liyang <douly.fnst@cn.fujitsu.com>

Now, QEmu adds a new check for memory-less NUMA nodes in build_srat().

It effects the ACPI test.

So, Update ACPI tables test blobs.

Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/acpi-test-data/pc/SRAT.numamem  | Bin 224 -> 224 bytes
 tests/acpi-test-data/q35/SRAT.numamem | Bin 224 -> 224 bytes
 2 files changed, 0 insertions(+), 0 deletions(-)

diff --git a/tests/acpi-test-data/pc/SRAT.numamem b/tests/acpi-test-data/pc/SRAT.numamem
index dbc595d9cb85d3fcb5a4243153f42bb431c9de8f..119922f4973f621602047d1dc160519f810922a3 100644
GIT binary patch
delta 24
gcmaFB_<)fsILI;N0RsaA<JXB?78A3|ChpJx0A~{jk^lez

delta 24
gcmaFB_<)fsILI;N0RsaA<ClqC787?#O*Cl%0A_s%T>t<8

diff --git a/tests/acpi-test-data/q35/SRAT.numamem b/tests/acpi-test-data/q35/SRAT.numamem
index dbc595d9cb85d3fcb5a4243153f42bb431c9de8f..119922f4973f621602047d1dc160519f810922a3 100644
GIT binary patch
delta 24
gcmaFB_<)fsILI;N0RsaA<JXB?78A3|ChpJx0A~{jk^lez

delta 24
gcmaFB_<)fsILI;N0RsaA<ClqC787?#O*Cl%0A_s%T>t<8

-- 
MST
