Received: from eggs.gnu.org ([2001:4830:134:3::10]:42638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gPmMB-00038g-JI
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 05:37:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gPmM8-0004MU-Cu
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 05:37:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52026)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gPmM8-0004IR-6b
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 05:37:08 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu, 22 Nov 2018 11:29:32 +0100
Message-Id: <1542882574-109418-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] acpi: RSDP: fix checksum calculations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: sameo@linux.intel.com, mst@redhat.com, drjones@redhat.com, peter.maydell@linaro.org

 * arm/virt is broken but it looks like linux doesn't care, lets fix it anyways
 * x86, got lucky since we didn't use extended fields,
   fix it so that it will calculate checksum using correct length
   so that it would be easier to unify arm/x86 into one impl.


Igor Mammedov (2):
  pc: acpi: use correct RSDT length for checksum
  arm/virt: acpi: fix incorrect checksums in RSDP

 hw/arm/virt-acpi-build.c | 7 ++++++-
 hw/i386/acpi-build.c     | 2 +-
 2 files changed, 7 insertions(+), 2 deletions(-)

-- 
2.7.4
