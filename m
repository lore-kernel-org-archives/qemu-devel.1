Received: from eggs.gnu.org ([2001:4830:134:3::10]:59558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1ebFZu-0007s5-8s
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 19:58:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1ebFZr-0000kF-63
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 19:58:14 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:33987)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1ebFZr-0000hi-1W
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 19:58:11 -0500
Received: by mail-ot0-x241.google.com with SMTP id p16so12206616otf.1
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 16:58:09 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Mon, 15 Jan 2018 18:57:53 -0600
Message-Id: <1516064279-14816-2-git-send-email-minyard@acm.org>
In-Reply-To: <1516064279-14816-1-git-send-email-minyard@acm.org>
References: <1516064279-14816-1-git-send-email-minyard@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/7] Add maintainer for the IPMI code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Eric Blake <eblake@redhat.com>, Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 73a5555..66a258b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -932,6 +932,15 @@ F: tests/ahci-test.c
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
