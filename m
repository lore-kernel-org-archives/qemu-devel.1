Received: from eggs.gnu.org ([2001:4830:134:3::10]:60772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1chGAx-0005cj-Fu
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 08:44:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1chGAu-0001ek-Cj
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 08:44:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51024)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1chGAu-0001eZ-6X
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 08:44:44 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 32A60C04B93B
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 13:44:44 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 24 Feb 2017 14:44:36 +0100
Message-Id: <1487943877-17318-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL v2 0/1] cirrus: add blit_is_unsafe call to
 cirrus_bitblt_cputovideo (CVE-2017-2620)
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

v2, this time with qemu-stable Cc'ed.

please pull,
  Gerd

The following changes since commit 10f25e4844cb9b3f02fb032f88051dd5b65b4206:

  Merge remote-tracking branch 'remotes/yongbok/tags/mips-20170222' into staging (2017-02-23 09:59:40 +0000)

are available in the git repository at:


  git://git.kraxel.org/qemu tags/pull-cve-2017-2620-20170224-1

for you to fetch changes up to 92f2b88cea48c6aeba8de568a45f2ed958f3c298:

  cirrus: add blit_is_unsafe call to cirrus_bitblt_cputovideo (CVE-2017-2620) (2017-02-24 14:35:50 +0100)

----------------------------------------------------------------
cirrus: add blit_is_unsafe call to cirrus_bitblt_cputovideo (CVE-2017-2620)

----------------------------------------------------------------
Gerd Hoffmann (1):
      cirrus: add blit_is_unsafe call to cirrus_bitblt_cputovideo (CVE-2017-2620)

 hw/display/cirrus_vga.c | 8 ++++++++
 1 file changed, 8 insertions(+)
