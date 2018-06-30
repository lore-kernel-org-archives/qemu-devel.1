Received: from eggs.gnu.org ([2001:4830:134:3::10]:37751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fZ95u-0003yV-OA
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:10:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fZ95t-0001hl-QW
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:10:50 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:34931)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fZ95t-0001gC-Gx
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:10:49 -0400
Received: by mail-wm0-x243.google.com with SMTP id z137-v6so3958213wmc.0
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 23:10:49 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 30 Jun 2018 08:09:59 +0200
Message-Id: <20180630061040.6018-7-pbonzini@redhat.com>
In-Reply-To: <20180630061040.6018-1-pbonzini@redhat.com>
References: <20180630061040.6018-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 06/47] checkpatch: Recognize IEC binary prefix
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Do not match the IEC binary prefix as camelcase typedefs.

This fixes:

    ERROR: "foo * bar" should be "foo *bar"
    #310: FILE: hw/ppc/ppc440_uc.c:564:
    +        size = 8 * MiB * sh;
    total: 1 errors, 0 warnings, 433 lines checked

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20180625124238.25339-5-f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/checkpatch.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index e3d8c2c..223681b 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -242,6 +242,7 @@ our $UTF8	= qr{
 # There are still some false positives, but this catches most
 # common cases.
 our $typeTypedefs = qr{(?x:
+        (?![KMGTPE]iB)                      # IEC binary prefix (do not match)
         [A-Z][A-Z\d_]*[a-z][A-Za-z\d_]*     # camelcase
         | [A-Z][A-Z\d_]*AIOCB               # all uppercase
         | [A-Z][A-Z\d_]*CPU                 # all uppercase
-- 
1.8.3.1
