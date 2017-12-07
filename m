Received: from eggs.gnu.org ([2001:4830:134:3::10]:44913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1eN3kT-0005Yi-Kc
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:30:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1eN3kS-0001xb-OQ
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:30:29 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:42363)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1eN3kS-0001x4-I8
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:30:28 -0500
Received: by mail-pg0-x244.google.com with SMTP id e14so5358402pgr.9
	for <qemu-devel@nongnu.org>; Thu, 07 Dec 2017 13:30:28 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Thu,  7 Dec 2017 15:30:13 -0600
Message-Id: <1512682213-4354-9-git-send-email-minyard@acm.org>
In-Reply-To: <1512682213-4354-1-git-send-email-minyard@acm.org>
References: <1512682213-4354-1-git-send-email-minyard@acm.org>
Subject: [Qemu-devel] [PATCH 8/8] Add maintainer for the IPMI code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0255113..6483f79 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -924,6 +924,15 @@ F: tests/ahci-test.c
 F: tests/libqos/ahci*
 T: git git://github.com/jnsnow/qemu.git ide
 
+IPMI
+M: Corey Minyard <minyard@acm.org>
+S: Maintained
+F: include/hw/ipmi/*
+F: hw/ipmi/*
+F: hw/smbios/smbios_type_38.c
+F: tests/ipmi*
+T: git git://github.com/cminyard/qemu.git master-ipmi-rebase
+
 Floppy
 M: John Snow <jsnow@redhat.com>
 L: qemu-block@nongnu.org
-- 
2.7.4
