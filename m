Received: from eggs.gnu.org ([2001:4830:134:3::10]:45922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hare@suse.de>) id 1ePVLc-00031m-Jn
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 10:22:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hare@suse.de>) id 1ePVLY-00032D-Ea
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 10:22:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:32863)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hare@suse.de>) id 1ePVLY-000312-7n
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 10:22:52 -0500
From: Hannes Reinecke <hare@suse.de>
Date: Thu, 14 Dec 2017 16:22:44 +0100
Message-Id: <20171214152246.17503-1-hare@suse.de>
Subject: [Qemu-devel] [PATCH 0/2] scsi: Simple ALUA support
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

qemu allows for a simple multipath emulation by just using the
same backing file for two distinct block devices.
This patchset adds a very basic ALUA support to properly report this
scenario go the guest.

As usual, comments and reviews are welcome.

Hannes Reinecke (2):
  block: implement shared block device count
  scsi: Implement multipath support

 block.c                   | 51 +++++++++++++++++++++++++++++++++
 hw/scsi/scsi-disk.c       | 72 +++++++++++++++++++++++++++++++++++++++++++++++
 include/block/block.h     |  3 ++
 include/block/block_int.h |  2 ++
 include/scsi/constants.h  |  5 ++++
 5 files changed, 133 insertions(+)

-- 
2.12.3
