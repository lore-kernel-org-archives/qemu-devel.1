Received: from eggs.gnu.org ([2001:4830:134:3::10]:48369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f47g3-0002Sx-Ki
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 12:23:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f47fz-0002K9-LA
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 12:23:55 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:35499)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1f47fz-0002Jk-EZ
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 12:23:51 -0400
Received: by mail-wm0-x230.google.com with SMTP id r82so8914680wme.0
	for <qemu-devel@nongnu.org>; Thu, 05 Apr 2018 09:23:51 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  5 Apr 2018 18:23:45 +0200
Message-Id: <20180405162347.5623-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH v4 0/2] hw/scsi: support SCSI-2 passthrough
 without PI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, danielhb@linux.vnet.ibm.com

This is my version of Daniel's patch.  In order to keep the
RD/WRPROTECT check for emulated SCSI disks, I've added a new property
to scsi-disk/hd/cd devices as well.  The property, similar to the
earlier versions posted by Daniel, is available to the user, but for
scsi-disk/hd/cd it affects the INQUIRY value returned by the emulated
INQUIRY command.

Daniel, can you please test it?

Thanks,

Paolo

Daniel Henrique Barboza (1):
  hw/scsi: support SCSI-2 passthrough without PI

Paolo Bonzini (1):
  scsi-disk: allow customizing the SCSI version

 hw/scsi/scsi-disk.c    | 29 ++++++++++++++++++++++++-----
 hw/scsi/scsi-generic.c | 48 +++++++++++++++++++++++++++++++++++++-----------
 include/hw/scsi/scsi.h |  2 ++
 3 files changed, 63 insertions(+), 16 deletions(-)

-- 
2.16.2
