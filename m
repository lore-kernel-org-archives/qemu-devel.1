Received: from eggs.gnu.org ([2001:4830:134:3::10]:44598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drWKt-00010b-Vh
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 17:33:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drWKs-0006lb-Vh
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 17:33:44 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:33727)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drWKs-0006l1-RJ
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 17:33:42 -0400
Received: by mail-qt0-x244.google.com with SMTP id b1so3988852qtc.0
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 14:33:42 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 11 Sep 2017 18:33:24 -0300
Message-Id: <20170911213328.9701-2-f4bug@amsat.org>
In-Reply-To: <20170911213328.9701-1-f4bug@amsat.org>
References: <20170911213328.9701-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 1/5] tcg: Move softmmu_template.h to the
 accel/tcg/ folder
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Thomas Huth <thuth@redhat.com>

The header is only used by accel/tcg/cputlb.c so we can
move it to the accel/tcg/ folder, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
[PMD: reword commit title to match series]
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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
index 36eeb42d19..a6b7e1c19f 100644
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
2.14.1
