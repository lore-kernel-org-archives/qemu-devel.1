Received: from eggs.gnu.org ([2001:4830:134:3::10]:55537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hare@suse.de>) id 1ddG9e-0006L0-Dh
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 09:27:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hare@suse.de>) id 1ddG9a-0007Ca-LJ
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 09:27:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:47244 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hare@suse.de>) id 1ddG9a-00075G-Ce
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 09:27:06 -0400
From: Hannes Reinecke <hare@suse.de>
Date: Thu,  3 Aug 2017 15:26:59 +0200
Message-Id: <1501766821-76419-1-git-send-email-hare@suse.de>
Subject: [Qemu-devel] [PATCH 0/2] scsi: enclosure support
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
to the SCSI emulation. The patch simply converts the current invisible
LUN0 into an enclosure device; existing setups using LUN0 as disks or
CD-ROMs will not be affected.

Hannes Reinecke (2):
  scsi: Make LUN 0 a simple enclosure
  scsi: use qemu_uuid to generate logical identifier for SES

 hw/scsi/scsi-bus.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 72 insertions(+), 1 deletion(-)

-- 
1.8.5.6
