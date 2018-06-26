Received: from eggs.gnu.org ([2001:4830:134:3::10]:34312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fXq57-0008Nj-Cb
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 11:40:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fXq53-0005d8-C8
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 11:40:37 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:46093)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fXq53-0005ci-4I
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 11:40:33 -0400
Received: by mail-wr0-x242.google.com with SMTP id l14-v6so12668970wrq.13
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 08:40:32 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 26 Jun 2018 17:40:23 +0200
Message-Id: <20180626154028.11133-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 0/5] pr-manager/qemu-pr-helper patches for QEMU
 3.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mprivozn@redhat.com

The first three patches are more or less trivial bugfixes.  The
last two allow libvirt to know the status of the qemu-pr-helper
process that is attached to a running QEMU instance.

Michal, can you check that the interface in the last two patches
is good for you?

Thanks,

Paolo

Paolo Bonzini (5):
  pr-helper: fix --socket-path default in help
  pr-helper: fix assertion failure on failed multipath PERSISTENT
    RESERVE IN
  pr-manager-helper: avoid SIGSEGV when writing to the socket fail
  pr-manager: add query-pr-managers QMP command
  pr-manager-helper: report event on connection/disconnection

 include/scsi/pr-manager.h |  2 ++
 qapi/block.json           | 51 +++++++++++++++++++++++++++++++++++++++
 scsi/pr-manager-helper.c  | 39 +++++++++++++++++++++++++-----
 scsi/pr-manager.c         | 45 ++++++++++++++++++++++++++++++++++
 scsi/qemu-pr-helper.c     | 21 ++++++++++------
 5 files changed, 144 insertions(+), 14 deletions(-)

-- 
2.17.1
