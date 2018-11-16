Received: from eggs.gnu.org ([2001:4830:134:3::10]:43896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gNeBo-0001eJ-Pv
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 08:29:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gNeBl-0002ev-0e
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 08:29:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58780)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gNeBk-0002eP-QR
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 08:29:36 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A12125D605
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 13:29:35 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 16 Nov 2018 14:29:28 +0100
Message-Id: <20181116132931.8737-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 0/3] Fixes 31 20181116 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>

The following changes since commit cb968d275c145467c8b385a3618a207ec111eab1:

  Update version for v3.1.0-rc1 release (2018-11-13 18:16:14 +0000)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/fixes-31-20181116-pull-request

for you to fetch changes up to 144aaa990e0d54d08865c4d98ba2138a89689530:

  help: Provide help for egl-headless (2018-11-16 11:44:22 +0100)

----------------------------------------------------------------
ui: add rendernode arg for egl-headless (fixes permission issues with libvirt)

----------------------------------------------------------------

Erik Skultety (3):
  qapi: Add "rendernode" display option for egl-headless
  ui: Allow specifying 'rendernode' display option for egl-headless
  help: Provide help for egl-headless

 ui/egl-headless.c |  2 +-
 qapi/ui.json      | 17 ++++++++++++++++-
 qemu-options.hx   |  6 +++++-
 3 files changed, 22 insertions(+), 3 deletions(-)

-- 
2.9.3
