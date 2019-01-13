Received: from eggs.gnu.org ([209.51.188.92]:33737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <basil@daynix.com>) id 1giceJ-0005lp-41
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 05:05:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <basil@daynix.com>) id 1giceI-0003TV-6t
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 05:05:46 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45700)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <basil@daynix.com>) id 1giceH-0003Qx-O1
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 05:05:46 -0500
Received: by mail-wr1-x444.google.com with SMTP id t6so19542986wrr.12
	for <qemu-devel@nongnu.org>; Sun, 13 Jan 2019 02:05:45 -0800 (PST)
From: Basil Salman <basil@daynix.com>
Date: Sun, 13 Jan 2019 12:05:27 +0200
Message-Id: <20190113100531.1346024-1-basil@daynix.com>
Subject: [Qemu-devel] [PATCH v2 0/4] QGA - Win fixes
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
 qga/vss-win32/install.cpp | 11 +++++++++++
 4 files changed, 32 insertions(+), 2 deletions(-)

-- 
2.17.2
