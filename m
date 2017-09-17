Received: from eggs.gnu.org ([2001:4830:134:3::10]:52423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dtb8q-0007ym-5q
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 11:05:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dtb8l-00087m-8h
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 11:05:52 -0400
Received: from mail-oi0-x236.google.com ([2607:f8b0:4003:c06::236]:51293)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dtb8l-00087O-3p
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 11:05:47 -0400
Received: by mail-oi0-x236.google.com with SMTP id i6so3680142oih.8
	for <qemu-devel@nongnu.org>; Sun, 17 Sep 2017 08:05:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sun, 17 Sep 2017 08:05:20 -0700
Message-Id: <20170917150535.8284-3-richard.henderson@linaro.org>
In-Reply-To: <20170917150535.8284-1-richard.henderson@linaro.org>
References: <20170917150535.8284-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 02/17] accel/tcg: move softmmu_template.h to
 accel/tcg/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Thomas Huth <thuth@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Thomas Huth <thuth@redhat.com>

The header is only used by accel/tcg/cputlb.c so we can
move it to the accel/tcg/ folder, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
[PMD: reword commit title to match series]
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20170911213328.9701-2-f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 softmmu_template.h => accel/tcg/softmmu_template.h | 0
 MAINTAINERS                                        | 1 -
 2 files changed, 1 deletion(-)
 rename softmmu_template.h => accel/tcg/softmmu_template.h (100%)

diff --git a/softmmu_template.h b/accel/tcg/softmmu_template.h
similarity index 100%
rename from softmmu_template.h
rename to accel/tcg/softmmu_template.h
diff --git a/MAINTAINERS b/MAINTAINERS
index 2c333aba21..2127bb241a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -86,7 +86,6 @@ M: Richard Henderson <rth@twiddle.net>
 S: Maintained
 F: cpus.c
 F: exec.c
-F: softmmu_template.h
 F: accel/tcg/
 F: include/exec/cpu*.h
 F: include/exec/exec-all.h
-- 
2.13.5
