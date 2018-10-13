Received: from eggs.gnu.org ([2001:4830:134:3::10]:57432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gBGc0-0002hj-Pt
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 05:53:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gBGbx-00014e-JJ
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 05:53:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54456)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gBGbx-00014S-Dp
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 05:53:29 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 25E423091D52
	for <qemu-devel@nongnu.org>; Sat, 13 Oct 2018 09:53:28 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 13 Oct 2018 11:53:21 +0200
Message-Id: <1539424403-2884-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] scsi-disk: fix bugs in rerror/werror
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com

The first was reported on the mailing list, the second was found by
inspection.

Paolo Bonzini (2):
  scsi-disk: fix double completion of failing passthrough requests
  scsi-disk: fix rerror/werror=ignore

 hw/scsi/scsi-disk.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

-- 
1.8.3.1
