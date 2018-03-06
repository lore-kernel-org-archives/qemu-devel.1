Received: from eggs.gnu.org ([2001:4830:134:3::10]:42891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1et87K-0005cY-2E
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 03:38:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1et87H-0003iB-L9
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 03:38:38 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55426 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1et87H-0003hx-GL
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 03:38:35 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1054A404084A
	for <qemu-devel@nongnu.org>; Tue,  6 Mar 2018 08:38:35 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  6 Mar 2018 09:38:29 +0100
Message-Id: <20180306083832.8144-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/3] spice: add support for dmabufs
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

v2: rebase, fix codestyle issues.

Gerd Hoffmann (3):
  spice: drop dprint() debug logging
  spice: add scanout_dmabuf support
  spice: add cursor_dmabuf support

 include/ui/spice-display.h |   9 +++
 ui/spice-display.c         | 194 ++++++++++++++++++++++++++++++++-------------
 ui/trace-events            |  12 +++
 3 files changed, 162 insertions(+), 53 deletions(-)

-- 
2.9.3
