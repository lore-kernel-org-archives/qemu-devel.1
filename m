Received: from eggs.gnu.org ([2001:4830:134:3::10]:48320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dwVsu-0005Wo-T9
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 12:05:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dwVsq-0000W2-Vz
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 12:05:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53434)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dwVsq-0000VX-Qt
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 12:05:24 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CE16DA1F4C
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 16:05:23 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon, 25 Sep 2017 17:05:16 +0100
Message-Id: <20170925160517.681-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 0/1] VMState conversion for virtio-pci 'modern
 state'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, jasowang@redhat.com, mst@redhat.com
Cc: quintela@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

This is lightly tested migrating a:

./x86_64-softmmu/qemu-system-x86_64 -M pc,accel=kvm -m 1G -device virtio-net -monitor stdio -drive if=virtio,file=blah,cache=none

with and without the patch; the stream looks like it includes the
subsection.  Suggestions for better tests are welcome.

Dave

Dr. David Alan Gilbert (1):
  virtio/pci/migration: Convert to VMState

 hw/virtio/virtio-pci.c | 108 +++++++++++++------------------------------------
 1 file changed, 27 insertions(+), 81 deletions(-)

-- 
2.13.5
