Received: from eggs.gnu.org ([2001:4830:134:3::10]:33063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1d2r3p-0006RQ-Hv
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 23:22:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1d2r3o-00068u-Rg
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 23:22:41 -0400
Received: from mail-io0-x244.google.com ([2607:f8b0:4001:c06::244]:36693)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1d2r3o-00068Z-M3
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 23:22:40 -0400
Received: by mail-io0-x244.google.com with SMTP id x86so52322258ioe.3
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 20:22:40 -0700 (PDT)
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <91290AE4-BAAF-44B1-AB1F-D8567D46A0AB@gmail.com>
Content-Transfer-Encoding: 7bit
From: G 3 <programmingkidx@gmail.com>
Date: Mon, 24 Apr 2017 23:22:37 -0400
Subject: [Qemu-devel] [PATCH 6/9] Add ppc support to configure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

Add ppc support to the configure script.

Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
---
  configure | 4 +++-
  1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 055e6d6..7881b18 100755
--- a/configure
+++ b/configure
@@ -56,6 +56,8 @@ guess_arch() {
          else
              ARCH="ppc64le"
          fi
+    elif check_define __ppc__ ; then
+        ARCH="ppc"
      else
          echo "This cpu is not supported by risu. Try -h. " >&2
          exit 1
@@ -92,7 +94,7 @@ Some influential environment variables:
                 prefixed with the given string.

    ARCH         force target architecture instead of trying to  
detect it.
-               Valid values=[arm|aarch64|ppc64|ppc64le|m68k]
+               Valid values=[arm|aarch64|ppc64|ppc64le|m68k|ppc]

    CC           C compiler command
    CFLAGS       C compiler flags
-- 
2.10.2
