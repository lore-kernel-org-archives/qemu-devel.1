Received: from eggs.gnu.org ([208.118.235.92]:34409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <basil@daynix.com>) id 1gf22C-0005FX-F9
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 07:23:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <basil@daynix.com>) id 1gf229-0004CQ-8t
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 07:23:36 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:56124)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <basil@daynix.com>) id 1gf228-0004AL-Q1
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 07:23:33 -0500
Received: by mail-wm1-x330.google.com with SMTP id y139so28958202wmc.5
	for <qemu-devel@nongnu.org>; Thu, 03 Jan 2019 04:23:30 -0800 (PST)
From: Basil Salman <basil@daynix.com>
Date: Thu,  3 Jan 2019 14:23:19 +0200
Message-Id: <20190103122323.1273034-1-basil@daynix.com>
Subject: [Qemu-devel] [PATCH 0/4] QGA - Win fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Yan Vugenfirer <yan@daynix.com>, Bishara AbuHattoum <bishara@daynix.com>

This patch series addresses serveral issues with qga-win please review
them and share your thoughts.

Basil Salman (3):
  qga-win: prevent crash when executing guest-file-read with large count
  qga: fix send_response error handling
  qga: Installer: Wait for installation to finish

Sameeh Jubran (1):
  qga-win: Handle VSS_E_PROVIDER_ALREADY_REGISTERED error

 qga/commands-win32.c      |  8 +++++++-
 qga/installer/qemu-ga.wxs |  2 +-
 qga/main.c                | 13 +++++++++++++
 qga/vss-win32/install.cpp | 10 ++++++++++
 4 files changed, 31 insertions(+), 2 deletions(-)

-- 
2.17.2
