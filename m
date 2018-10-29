Received: from eggs.gnu.org ([2001:4830:134:3::10]:33640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gHBRE-0002qM-Vr
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 13:34:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gHBR8-0001By-AF
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 13:34:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gHBR8-00011k-0w
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 13:34:46 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 29 Oct 2018 18:34:33 +0100
Message-Id: <20181029173437.32559-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 0/4] scsi-generic: fixes for Block Limits
 emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mreitz@redhat.com, Daniel Henrique Barboza <danielhb413@gmail.com>

scsi-generic (pass through) devices are able to inject an artificial Block
Limits VPD page in order to communicate host HBA limits to the guest.
However, Max Reitz found a few issues with the implementation of this
feature; this series should fix them all.

Paolo

Paolo Bonzini (4):
  scsi-generic: keep VPD page list sorted
  scsi-generic: avoid out-of-bounds access to VPD page list
  scsi-generic: avoid invalid access to struct when emulating block
    limits
  scsi-generic: do not do VPD emulation for sense other than
    ILLEGAL_REQUEST

 hw/scsi/Makefile.objs       |  2 +-
 hw/scsi/emulation.c         | 42 +++++++++++++++++
 hw/scsi/scsi-disk.c         | 92 ++++++++-----------------------------
 hw/scsi/scsi-generic.c      | 51 +++++++++++++++-----
 include/hw/scsi/emulation.h | 16 +++++++
 include/hw/scsi/scsi.h      |  1 -
 6 files changed, 119 insertions(+), 85 deletions(-)
 create mode 100644 hw/scsi/emulation.c
 create mode 100644 include/hw/scsi/emulation.h

-- 
2.17.1
