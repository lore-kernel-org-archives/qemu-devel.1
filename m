Received: from eggs.gnu.org ([2001:4830:134:3::10]:36381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cwFca-0003vt-2l
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 18:11:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cwFcW-0003JG-2X
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 18:11:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41720)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1cwFcV-0003HX-S8
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 18:11:11 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0749061B8D
	for <qemu-devel@nongnu.org>; Thu,  6 Apr 2017 22:11:10 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Thu, 06 Apr 2017 16:11:07 -0600
Message-ID: <20170406220934.6155.13106.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PULL for-2.9 0/1] VFIO fixes 2017-04-06
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 54d689988c847271d87b3eb113712147129fb811:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into
staging (2017-04-06 09:27:49 +0100)

are available in the git repository at:


  git://github.com/awilliam/qemu-vfio.git tags/vfio-updates-20170406.0

for you to fetch changes up to 8f419c5b43b988df4ef11315aeb8524e50c99687:

  vfio/pci-quirks: Exclude non-ioport BAR from NVIDIA quirk (2017-04-06
16:03:26 -0600)

----------------------------------------------------------------
VFIO fixes 2017-04-06

 - Extra test for NVIDIA BAR5 quirk to avoid segfault (Alex Williamson)

----------------------------------------------------------------
Alex Williamson (1):
      vfio/pci-quirks: Exclude non-ioport BAR from NVIDIA quirk

 hw/vfio/pci-quirks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
