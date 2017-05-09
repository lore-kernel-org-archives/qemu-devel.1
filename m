Received: from eggs.gnu.org ([2001:4830:134:3::10]:51406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d82oL-0004c4-2L
	for qemu-devel@nongnu.org; Tue, 09 May 2017 06:56:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d82oH-0004RI-V8
	for qemu-devel@nongnu.org; Tue, 09 May 2017 06:56:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57334)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d82oH-0004R9-OM
	for qemu-devel@nongnu.org; Tue, 09 May 2017 06:56:05 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8DED037E67
	for <qemu-devel@nongnu.org>; Tue,  9 May 2017 10:56:04 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  9 May 2017 12:56:00 +0200
Message-Id: <1494327362-30727-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] scsi: Minor cleanups around scsi-disk
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, eblake@redhat.com

Markus Armbruster (2):
  block: Clarify documentation of BlockInfo member io-status
  virtio-scsi-test: Use scsi-hd instead of legacy scsi-disk

 qapi/block-core.json     | 3 ++-
 tests/virtio-scsi-test.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

-- 
2.7.4
