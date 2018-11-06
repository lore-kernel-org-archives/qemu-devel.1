Received: from eggs.gnu.org ([2001:4830:134:3::10]:42650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gK9Cm-0005UT-Ii
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 16:48:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gK93X-0001UE-Rx
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 16:38:43 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40401)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gK93W-00006C-60
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 16:38:39 -0500
Received: by mail-wr1-x443.google.com with SMTP id i17-v6so15202135wre.7
	for <qemu-devel@nongnu.org>; Tue, 06 Nov 2018 13:38:12 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  6 Nov 2018 22:37:51 +0100
Message-Id: <1541540283-45699-6-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1541540283-45699-1-git-send-email-pbonzini@redhat.com>
References: <1541540283-45699-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 05/17] MAINTAINERS: remove or downgrade myself
 to reviewer from some subsystems
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Other people are doing a much better work than myself at handling some
subsystems.  For those files it is better if I downgrade myself to
reviewer or recognize that I am not actually doing any work there.

Cc: Daniel P. Berrange <berrange@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Eric Blake <eblake@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8ec2281..d411521 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -105,9 +105,9 @@ Guest CPU cores (TCG):
 ----------------------
 Overall
 L: qemu-devel@nongnu.org
-M: Paolo Bonzini <pbonzini@redhat.com>
 M: Peter Crosthwaite <crosthwaite.peter@gmail.com>
 M: Richard Henderson <rth@twiddle.net>
+R: Paolo Bonzini <pbonzini@redhat.com>
 S: Maintained
 F: cpus.c
 F: exec.c
@@ -1139,7 +1139,8 @@ F: hw/pci-host/ppce500.c
 F: hw/net/fsl_etsec/
 
 Character devices
-M: Paolo Bonzini <pbonzini@redhat.com>
+M: Marc-André Lureau <marcandre.lureau@redhat.com>
+R: Paolo Bonzini <pbonzini@redhat.com>
 S: Odd Fixes
 F: hw/char/
 
@@ -1526,8 +1527,8 @@ T: git git://github.com/famz/qemu.git bitmaps
 T: git git://github.com/jnsnow/qemu.git bitmaps
 
 Character device backends
-M: Paolo Bonzini <pbonzini@redhat.com>
 M: Marc-André Lureau <marcandre.lureau@redhat.com>
+R: Paolo Bonzini <pbonzini@redhat.com>
 S: Maintained
 F: chardev/
 F: include/chardev/
@@ -1760,9 +1761,9 @@ F: tests/qmp-cmd-test.c
 T: git git://repo.or.cz/qemu/armbru.git qapi-next
 
 qtest
-M: Paolo Bonzini <pbonzini@redhat.com>
 M: Thomas Huth <thuth@redhat.com>
 M: Laurent Vivier <lvivier@redhat.com>
+R: Paolo Bonzini <pbonzini@redhat.com>
 S: Maintained
 F: qtest.c
 F: tests/libqtest.*
@@ -1869,7 +1870,6 @@ F: tests/test-io-*
 Sockets
 M: Daniel P. Berrange <berrange@redhat.com>
 M: Gerd Hoffmann <kraxel@redhat.com>
-M: Paolo Bonzini <pbonzini@redhat.com>
 S: Maintained
 F: include/qemu/sockets.h
 F: util/qemu-sockets.c
@@ -2056,13 +2056,12 @@ M: Ronnie Sahlberg <ronniesahlberg@gmail.com>
 M: Paolo Bonzini <pbonzini@redhat.com>
 M: Peter Lieven <pl@kamp.de>
 L: qemu-block@nongnu.org
-S: Supported
+S: Odd Fixes
 F: block/iscsi.c
 F: block/iscsi-opts.c
 
 Network Block Device (NBD)
 M: Eric Blake <eblake@redhat.com>
-M: Paolo Bonzini <pbonzini@redhat.com>
 L: qemu-block@nongnu.org
 S: Maintained
 F: block/nbd*
-- 
1.8.3.1
