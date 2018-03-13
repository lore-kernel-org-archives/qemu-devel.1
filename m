Received: from eggs.gnu.org ([2001:4830:134:3::10]:58421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evsiU-00068p-1U
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evsiS-0003xV-Da
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:22 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:38148)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evsiS-0003wn-6W
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:20 -0400
Received: by mail-wm0-x244.google.com with SMTP id z9so879748wmb.3
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 15:48:20 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 23:46:56 +0100
Message-Id: <20180313224719.4954-47-pbonzini@redhat.com>
In-Reply-To: <20180313224719.4954-1-pbonzini@redhat.com>
References: <20180313224719.4954-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 46/69] MAINTAINERS: Add entries for the
 VT82C686B Super I/O
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

So far, it is only used by the MIPS Fulong 2E mini PC.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20180308223946.26784-21-f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9f7b8e79c4..07684a1f2d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -700,6 +700,8 @@ Fulong 2E
 M: Yongbok Kim <yongbok.kim@mips.com>
 S: Odd Fixes
 F: hw/mips/mips_fulong2e.c
+F: hw/isa/vt82c686.c
+F: include/hw/isa/vt82c686.h
 
 Boston
 M: Paul Burton <paul.burton@mips.com>
-- 
2.14.3
