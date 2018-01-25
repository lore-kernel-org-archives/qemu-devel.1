Received: from eggs.gnu.org ([2001:4830:134:3::10]:51155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eedwN-00034D-Ja
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 04:35:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eedwJ-0001Av-La
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 04:35:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41238)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eedwJ-0001Af-Dk
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 04:35:23 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B3491A452E
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 09:35:22 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 25 Jan 2018 10:34:54 +0100
Message-Id: <20180125093455.6356-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 0/1] Vga 20180125 patches
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

The following changes since commit 834a336eb911db8a8ca00e760ee6a85faca19414:

  Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2018-01-24 19:24:26 +0000)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/vga-20180125-pull-request

for you to fetch changes up to 191f59dc17396bb5a8da50f8c59b6e0a430711a4:

  vga: check the validation of memory addr when draw text (2018-01-25 10:18:39 +0100)

----------------------------------------------------------------
vga: fix for CVE-2018-5683

----------------------------------------------------------------

linzhecheng (1):
  vga: check the validation of memory addr when draw text

 hw/display/vga.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.9.3
