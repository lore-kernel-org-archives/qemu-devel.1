Received: from eggs.gnu.org ([209.51.188.92]:42440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guoheyi@huawei.com>) id 1h2Rme-0000iJ-9j
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 21:32:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guoheyi@huawei.com>) id 1h2Rmd-0004vs-IK
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 21:32:20 -0500
From: Heyi Guo <guoheyi@huawei.com>
Date: Sat, 9 Mar 2019 10:30:47 +0800
Message-ID: <1552098649-28341-1-git-send-email-guoheyi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5 0/2] arm/acpi: simplify aml code and enable
 SHPC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: wanghaibin.wang@huawei.com, Heyi Guo <guoheyi@huawei.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>

After the introduction of generic PCIe root port and PCIe-PCI bridge, we will
also have SHPC controller on ARM, and we don't support ACPI hot plug, so just
enable SHPC native hot plug.

Igor also spotted the store operation outside of bit and/or is not necessary, so
simply the code at first.

v5:
- Refine commit message of patch 1/2

v4:
- Improve the code indention.

Cc: Shannon Zhao <shannon.zhaosl@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>



Heyi Guo (2):
  hw/arm/acpi: simplify AML bit and/or statement
  hw/arm/acpi: enable SHPC native hot plug

 hw/arm/virt-acpi-build.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

-- 
1.8.3.1
