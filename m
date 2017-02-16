Received: from eggs.gnu.org ([2001:4830:134:3::10]:57671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ceLsZ-0001kx-8R
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:13:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ceLsW-0000XU-23
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:13:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46646)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ceLsV-0000Wc-SN
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:13:43 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1AAF261B9A
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 13:13:44 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 16 Feb 2017 14:13:36 +0100
Message-Id: <1487250819-23764-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] usb-ccid: improve sanity checks
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

  Hi,

Small ccid series which improves the ccid_handle_bulk_out sanity checks.

cheers,
  Gerd

Gerd Hoffmann (3):
  usb-ccid: better bulk_out error handling
  usb-ccid: move header size check
  usb-ccid: add check message size checks

 hw/usb/dev-smartcard-reader.c | 140 +++++++++++++++++++++++-------------------
 1 file changed, 76 insertions(+), 64 deletions(-)

-- 
1.8.3.1
