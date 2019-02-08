Received: from eggs.gnu.org ([209.51.188.92]:53912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gs65q-0002Q7-A5
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 08:21:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gs65o-0002XR-7c
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 08:21:22 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36556)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gs65m-0002V6-Lf
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 08:21:19 -0500
Received: by mail-wr1-x442.google.com with SMTP id z3so3576226wrv.3
	for <qemu-devel@nongnu.org>; Fri, 08 Feb 2019 05:21:16 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  8 Feb 2019 13:21:12 +0000
Message-Id: <20190208132112.31493-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] configure: Make -Waddress-of-packed-member
 warnings be errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org

We have now managed to eradicate all the places in the codebase
that triggered clang's -Waddress-of-packed-member warning. Remove
the compiler flag that exempted it from our usual -Werror policy.
This will prevent any new problematic code being added in future.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 configure | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configure b/configure
index fbd0825488c..50ac5d90f2e 100755
--- a/configure
+++ b/configure
@@ -1881,7 +1881,6 @@ gcc_flags="-Wno-missing-include-dirs -Wempty-body -Wnested-externs $gcc_flags"
 gcc_flags="-Wendif-labels -Wno-shift-negative-value $gcc_flags"
 gcc_flags="-Wno-initializer-overrides -Wexpansion-to-defined $gcc_flags"
 gcc_flags="-Wno-string-plus-int $gcc_flags"
-gcc_flags="-Wno-error=address-of-packed-member $gcc_flags"
 # Note that we do not add -Werror to gcc_flags here, because that would
 # enable it for all configure tests. If a configure test failed due
 # to -Werror this would just silently disable some features,
-- 
2.20.1
