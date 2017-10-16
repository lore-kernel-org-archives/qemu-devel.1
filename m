Received: from eggs.gnu.org ([2001:4830:134:3::10]:46507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mgamal@redhat.com>) id 1e41Mc-0001cB-Ro
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 05:07:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mgamal@redhat.com>) id 1e41MX-0000HN-D3
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 05:07:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52424)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mgamal@redhat.com>) id 1e41MX-0000H3-70
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 05:07:05 -0400
From: Mohammed Gamal <mgamal@redhat.com>
Date: Mon, 16 Oct 2017 11:06:21 +0200
Message-Id: <1508144783-18792-1-git-send-email-mgamal@redhat.com>
Subject: [Qemu-devel] [PATCH RESEND 0/2] x86_iommu: Fix segfault when
 starting on non-PCI machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, ehabkost@redhat.com, peterx@redhat.com, pbonzini@redhat.com, mst@redhat.com, mjt@tls.msk.ru, Mohammed Gamal <mgamal@redhat.com>

Starting qemu with
qemu-system-x86_64 -S -M isapc -device {amd|intel}-iommu
leads to a segfault. The code assume PCI bus is present and
tries to access the bus structure without checking.

The patch series moves the error checks from vtd_realize()
and amdvi_realize() to the generic x86_iommu_realize() and
adds a check for PCI bus presence.


Mohammed Gamal (2):
  x86_iommu: Move machine check to x86_iommu_realize()
  x86_iommu: check if machine has PCI bus

 hw/i386/amd_iommu.c   | 13 ++-----------
 hw/i386/intel_iommu.c | 13 ++-----------
 hw/i386/x86-iommu.c   | 13 +++++++++++++
 3 files changed, 17 insertions(+), 22 deletions(-)

-- 
1.8.3.1
