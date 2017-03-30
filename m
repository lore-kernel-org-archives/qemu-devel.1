Received: from eggs.gnu.org ([2001:4830:134:3::10]:52834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ztong@vt.edu>) id 1ctUwh-0005vH-Aj
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 03:56:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ztong@vt.edu>) id 1ctUwe-0005Ob-Bh
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 03:56:39 -0400
Received: from omr1.cc.ipv6.vt.edu ([2607:b400:92:8300:0:c6:2117:b0e]:37956
	helo=omr1.cc.vt.edu)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ztong@vt.edu>) id 1ctUwe-0005Nn-6D
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 03:56:36 -0400
Received: from mr5.cc.vt.edu (mr5.cc.vt.edu
	[IPv6:2607:b400:92:8400:0:72:232:758b])
	by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id v2U6JVro002830
	for <qemu-devel@nongnu.org>; Thu, 30 Mar 2017 02:19:31 -0400
Received: from mail-qk0-f199.google.com (mail-qk0-f199.google.com
	[209.85.220.199])
	by mr5.cc.vt.edu (8.14.7/8.14.7) with ESMTP id v2U6JQ3k012711
	for <qemu-devel@nongnu.org>; Thu, 30 Mar 2017 02:19:31 -0400
Received: by mail-qk0-f199.google.com with SMTP id 10so13924526qkh.1
	for <qemu-devel@nongnu.org>; Wed, 29 Mar 2017 23:19:31 -0700 (PDT)
From: Tong Zhang <ztong@vt.edu>
Date: Thu, 30 Mar 2017 02:18:29 -0400
Message-Id: <20170330061830.25028-1-ztong@vt.edu>
Subject: [Qemu-devel] [PATCH] applesmc: add error mem region handling for
 MacOS 10.12.4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tong Zhang <ztong@vt.edu>
Cc: qemu-devel <qemu-devel@nongnu.org>

This patch fixes a problem in applesmc emulation which prevent recent
MacOS(10.12.4) from booing.


Zhang Tong (1):
  applesmc: add error mem region handling for MacOS 10.12.4

 hw/misc/applesmc.c | 152 +++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 130 insertions(+), 22 deletions(-)

-- 
2.10.2
