Received: from eggs.gnu.org ([2001:4830:134:3::10]:34400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ciiX0-0000Bx-Uk
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 09:13:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ciiWz-0005FP-W5
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 09:13:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37104)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1ciiWz-0005FD-Qc
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 09:13:33 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D92B2A24D2
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 14:13:33 +0000 (UTC)
From: Marcel Apfelbaum <marcel@redhat.com>
Date: Tue, 28 Feb 2017 16:13:27 +0200
Message-Id: <1488291209-29430-1-git-send-email-marcel@redhat.com>
Subject: [Qemu-devel] [PATCH V4 0/2] hw/pxb-pcie: fix PCI Express hotplug
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, marcel@redhat.com

Note to maintainer:
 Please update ACPI test files.

V3 -> V4:
      - Added patch to simplify _OSC (Michael)

V2 -> V3:
      - Modified comment (Igor)

V1 -> V2:
    Addressed Michael S. Tsirkin's comments:
      - Added documentation to q35 osc function
      - Made _osc serialized. I did not add compat property
        since it seems guest OSs do not care anyway about the OSC
        being serialized.
      - Kept the SUPP field even if is not used and also
        left both SUPP and CTRL out of the _osc because all
        systems I checked and the ACPI spec keep them that way,
        maybe is some kind of documentation contract.

Add the missing osc method for pxb-pcie devices as APCI spec recommends

Thanks,
Marcel

Marcel Apfelbaum (1):
  hw/pxb-pcie: fix PCI Express hotplug support

Michael S. Tsirkin (1):
  acpi: simplify _OSC

 dtc                  | 2 +-
 hw/i386/acpi-build.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.5.5
