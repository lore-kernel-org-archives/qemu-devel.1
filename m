Received: from eggs.gnu.org ([2001:4830:134:3::10]:37762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gSgil-00057m-4V
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 06:12:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gSgih-0006ma-PK
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 06:12:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40478)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gSgih-0006m4-Ig
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 06:12:27 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C3E17DC8FE
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 11:12:26 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 30 Nov 2018 12:12:20 +0100
Message-Id: <20181130111222.25386-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH for-3.1 0/2] usb-mtp: two bugfixes (one
 security fix).
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>



Gerd Hoffmann (2):
  usb-mtp: fix utf16_to_str
  usb-mtp: outlaw slashes in filenames

 hw/usb/dev-mtp.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

-- 
2.9.3
