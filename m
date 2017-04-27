Received: from eggs.gnu.org ([2001:4830:134:3::10]:45898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <daniel@daynix.com>) id 1d3jMC-0004Aj-85
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 09:21:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <daniel@daynix.com>) id 1d3jM8-0001b4-QZ
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 09:21:16 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:34280)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <daniel@daynix.com>) id 1d3jM8-0001az-Jp
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 09:21:12 -0400
Received: by mail-wr0-x231.google.com with SMTP id l9so17086270wre.1
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 06:21:12 -0700 (PDT)
From: Daniel Rempel <daniel@daynix.com>
Date: Thu, 27 Apr 2017 16:21:03 +0300
Message-Id: <1493299264-10669-1-git-send-email-daniel@daynix.com>
Subject: [Qemu-devel] [PATCH v2 0/1] qga-win: fix installation on localized
 Windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, Dmitry Fleytman <dmitry@daynix.com>, Yan Vugenfirer <yan@daynix.com>

Second version of the patch. Cleaned the code a bit.

Daniel Rempel (1):
  qga-win: fix installation on localized windows

 qga/vss-win32/install.cpp | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

-- 
2.9.3
