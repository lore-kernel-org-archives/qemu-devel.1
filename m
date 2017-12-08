Received: from eggs.gnu.org ([2001:4830:134:3::10]:33799)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1eNHBi-0003Wx-Tu
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 06:51:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1eNHBg-0006cy-2l
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 06:51:30 -0500
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:48252 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1eNHBf-0006bR-PO
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 06:51:28 -0500
From: Peter Lieven <pl@kamp.de>
Date: Fri,  8 Dec 2017 12:51:06 +0100
Message-Id: <1512733868-9009-1-git-send-email-pl@kamp.de>
Subject: [Qemu-devel] [PATCH 0/2] iscsi fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, ronniesahlberg@gmail.com, pbonzini@redhat.com, Peter Lieven <pl@kamp.de>

fix a bug leaving the allocmap in a wrong state if an UNMAP fails and
improve the logging of iscsi failures.

Peter Lieven (2):
  block/iscsi: dont leave allocmap in an invalid state on UNMAP failure
  block/iscsi: only report an iSCSI Failure if we don't handle it
    gracefully

 block/iscsi.c | 51 ++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 15 deletions(-)

-- 
1.9.1
