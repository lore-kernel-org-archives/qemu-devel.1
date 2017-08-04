Received: from eggs.gnu.org ([2001:4830:134:3::10]:49396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hare@suse.de>) id 1ddY68-0005HL-5v
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 04:36:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hare@suse.de>) id 1ddY63-00067Z-Lb
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 04:36:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:50538 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hare@suse.de>) id 1ddY63-00065K-EB
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 04:36:39 -0400
From: Hannes Reinecke <hare@suse.de>
Date: Fri,  4 Aug 2017 10:36:31 +0200
Message-Id: <1501835795-92331-1-git-send-email-hare@suse.de>
Subject: [Qemu-devel] [PATCHv2 0/4] scsi: enclosure support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Hannes Reinecke <hare@suse.de>

Hi all,

due to a customer issue I've added simple subenclosure support
to the SCSI emulation. By setting the 'enclosure' option to a
SCSI device we will now present an enclosure device on LUN0
(if LUN0 is otherwise unassigned) or setting the 'EncServ' bit
in the inquiry data if LUN0 is assigned to a device.

Changes to v1:
- Add patch to clarify sense code responses
- Add 'enclosure' option for SCSI devices

Hannes Reinecke (4):
  scsi: Make LUN 0 a simple enclosure
  scsi: use qemu_uuid to generate logical identifier for SES
  scsi: clarify sense codes for LUN0 emulation
  scsi: Add 'enclosure' option for scsi devices

 hw/scsi/scsi-bus.c     | 85 ++++++++++++++++++++++++++++++++++++++++++++++++--
 hw/scsi/scsi-disk.c    |  4 ++-
 include/hw/scsi/scsi.h |  1 +
 3 files changed, 87 insertions(+), 3 deletions(-)

-- 
1.8.5.6
