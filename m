Received: from eggs.gnu.org ([2001:4830:134:3::10]:36386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1ehJz0-0003GH-Uy
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 13:53:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1ehJyx-00005B-2n
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 13:53:15 -0500
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:39371)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1ehJyw-0008WF-TZ
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 13:53:11 -0500
Received: by mail-oi0-x242.google.com with SMTP id j188so12763872oib.6
	for <qemu-devel@nongnu.org>; Thu, 01 Feb 2018 10:53:10 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Thu,  1 Feb 2018 12:52:56 -0600
Message-Id: <1517511182-9944-2-git-send-email-minyard@acm.org>
In-Reply-To: <1517511182-9944-1-git-send-email-minyard@acm.org>
References: <1517511182-9944-1-git-send-email-minyard@acm.org>
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
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fe39b30..192d8b8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -940,6 +940,15 @@ F: tests/ahci-test.c
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
