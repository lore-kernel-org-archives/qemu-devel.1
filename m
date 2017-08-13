Received: from eggs.gnu.org ([2001:4830:134:3::10]:40061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1dgvIA-0000QS-IV
	for qemu-devel@nongnu.org; Sun, 13 Aug 2017 11:59:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1dgvI5-0003kE-Jv
	for qemu-devel@nongnu.org; Sun, 13 Aug 2017 11:59:06 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:34815)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1dgvI5-0003ip-CH
	for qemu-devel@nongnu.org; Sun, 13 Aug 2017 11:59:01 -0400
Received: by mail-wm0-x244.google.com with SMTP id x64so11895377wmg.1
	for <qemu-devel@nongnu.org>; Sun, 13 Aug 2017 08:58:58 -0700 (PDT)
From: Sameeh Jubran <sameeh@daynix.com>
Date: Sun, 13 Aug 2017 18:58:46 +0300
Message-Id: <20170813155849.11368-1-sameeh@daynix.com>
Subject: [Qemu-devel] [PATCH 0/3]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com
Cc: yan@daynix.com

From: Sameeh Jubran <sjubran@redhat.com>

This series fixes qemu-ga's behaviour upon facing a missing serial/serial
driver by listening to the serial device's events.

For more info on why this series is needed checkout the commit message
of the third patch and the following bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=990629.

Sameeh Jubran (3):
  qga: Channel: Add functions for checking serial status
  qga: main: make qga config and socket activation global
  qga: Prevent qemu-ga exit if serial doesn't exist

 Makefile            |   4 +
 qga/channel-posix.c |  54 ++++++++++
 qga/channel-win32.c |  60 +++++++++++
 qga/channel.h       |   9 ++
 qga/main.c          | 284 ++++++++++++++++++++++++++++++++++++++++++++++------
 qga/service-win32.h |   4 +
 6 files changed, 385 insertions(+), 30 deletions(-)

-- 
2.9.4
