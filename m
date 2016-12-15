Received: from eggs.gnu.org ([2001:4830:134:3::10]:54736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cHcHF-0007GP-0K
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 15:05:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cHcHB-0001Z4-Rn
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 15:05:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49896)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cHcHB-0001YO-Mu
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 15:05:13 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu, 15 Dec 2016 20:05:07 +0000
Message-Id: <20161215200509.2239-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] Vmxnet3 VMStatification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, dmitry@daynix.com
Cc: quintela@redhat.com, amit.shah@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Hi,
  This patchset converts most of vmxnet3 to VMState; the
only bit remaining is the msix section (which is what I'm
actually interested in cleaning up since it's one of the
last few users of register_savevm - but it'll have to wait).

Note a migration test with this on completes, but isn't
passing traffic; but neither is a world without this change.

Dave

Dr. David Alan Gilbert (2):
  vmxnet3: Convert ring values to uint32_t's
  vmxnet3: VMStatify rx/tx q_descr and int_state

 hw/net/vmxnet3.c | 284 +++++++++++++++++++------------------------------------
 1 file changed, 96 insertions(+), 188 deletions(-)

-- 
2.9.3
