Received: from eggs.gnu.org ([2001:4830:134:3::10]:59862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bishara@daynix.com>) id 1gZXPd-0004pk-2E
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 03:41:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bishara@daynix.com>) id 1gZXPY-0005Oc-20
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 03:41:04 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39269)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bishara@daynix.com>) id 1gZXPX-0005NK-MF
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 03:40:59 -0500
Received: by mail-wm1-x341.google.com with SMTP id f81so5421250wmd.4
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 00:40:59 -0800 (PST)
From: Bishara AbuHattoum <bishara@daynix.com>
Date: Wed, 19 Dec 2018 10:40:50 +0200
Message-Id: <1545208851-6906-1-git-send-email-bishara@daynix.com>
Subject: [Qemu-devel] [PATCH] qga: Support for Windows Server 2019 in the
 get-osinfo command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Yan Vugenfirer <yan@daynix.com>, Samee Jubran <sameeh@daynix.com>

This patch of a one commit fixes a bug that has been reported in the bugzilla:
https://bugzilla.redhat.com/show_bug.cgi?id=1659071

In which the command get-osinfo doesnt work as expected when the ga is running
on a Windows Server 2019 guest.

Bishara AbuHattoum (1):
  qga-win: Adding support for Windows Server 2019 get-osinfo command

 qga/commands-win32.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

-- 
1.8.3.1
