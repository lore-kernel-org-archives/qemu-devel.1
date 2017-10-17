Received: from eggs.gnu.org ([2001:4830:134:3::10]:59447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e4NBY-0002cv-QO
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 04:25:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e4NBV-000613-Uv
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 04:25:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47496)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e4NBV-0005zr-Po
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 04:25:09 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D5468914E6
	for <qemu-devel@nongnu.org>; Tue, 17 Oct 2017 08:25:08 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 17 Oct 2017 10:24:58 +0200
Message-Id: <20171017082502.7885-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 0/4] Vga 20171017 patches
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

The following changes since commit c5bbcaa4b7c0f8a322bebe9ec563560178a68b55:

  Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2017-10-16 17:29:16 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/vga-20171017-pull-request

for you to fetch changes up to eb38e1bc3740725ca29a535351de94107ec58d51:

  cirrus: fix oob access in mode4and5 write functions (2017-10-17 09:59:00 +0200)

----------------------------------------------------------------
cirrus: bugfixes, with some vga cleanups.

----------------------------------------------------------------

Gerd Hoffmann (4):
  vga: drop line_offset variable
  vga: handle cirrus vbe mode wraparounds.
  vga: add ram_addr_t cast
  cirrus: fix oob access in mode4and5 write functions

 hw/display/cirrus_vga.c |  6 ++----
 hw/display/vga.c        | 33 +++++++++++++++++++++++----------
 2 files changed, 25 insertions(+), 14 deletions(-)

-- 
2.9.3
