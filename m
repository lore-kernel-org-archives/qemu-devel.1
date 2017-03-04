Received: from eggs.gnu.org ([2001:4830:134:3::10]:57749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ckEqz-0005va-DE
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 13:56:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ckEqy-0007cX-Pp
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 13:56:29 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:32911)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ckEqy-0007c1-Lf
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 13:56:28 -0500
Received: by mail-qk0-x244.google.com with SMTP id j127so16932753qke.0
	for <qemu-devel@nongnu.org>; Sat, 04 Mar 2017 10:56:28 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sat,  4 Mar 2017 15:55:32 -0300
Message-Id: <20170304185533.10618-3-f4bug@amsat.org>
In-Reply-To: <20170304185533.10618-1-f4bug@amsat.org>
References: <20170304185533.10618-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 2/3] device_tree: fix compiler warnings (clang
 5)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alexander Graf <agraf@suse.de>, Gerd Hoffmann <kraxel@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

static code analyzer complain:

device_tree.c:155:18: warning: Null pointer passed as an argument to a 'nonnull' parameter
    while ((de = readdir(d)) != NULL) {
                 ^~~~~~~~~~

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 device_tree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/device_tree.c b/device_tree.c
index 6e06320830..a24ddff02b 100644
--- a/device_tree.c
+++ b/device_tree.c
@@ -148,6 +148,7 @@ static void read_fstree(void *fdt, const char *dirname)
     d = opendir(dirname);
     if (!d) {
         error_setg(&error_fatal, "%s cannot open %s", __func__, dirname);
+        return;
     }
 
     while ((de = readdir(d)) != NULL) {
-- 
2.11.0
