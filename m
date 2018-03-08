Received: from eggs.gnu.org ([2001:4830:134:3::10]:56677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eu4DA-0007EA-08
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 17:40:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eu4D8-0004JO-UZ
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 17:40:31 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:50534)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eu4D8-0004Id-Ld
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 17:40:30 -0500
Received: by mail-wm0-x242.google.com with SMTP id w128so728150wmw.0
	for <qemu-devel@nongnu.org>; Thu, 08 Mar 2018 14:40:30 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu,  8 Mar 2018 23:39:41 +0100
Message-Id: <20180308223946.26784-21-f4bug@amsat.org>
In-Reply-To: <20180308223946.26784-1-f4bug@amsat.org>
References: <20180308223946.26784-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 20/25] MAINTAINERS: Add entries for the
 VT82C686B Super I/O
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Marcel Apfelbaum <marcel@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexey Kardashevskiy <aik@ozlabs.ru>, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Eduardo Habkost <ehabkost@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>

So far, it is only used by the MIPS Fulong 2E mini PC.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 98a8918c20..facdab44e1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -689,6 +689,8 @@ Fulong 2E
 M: Yongbok Kim <yongbok.kim@mips.com>
 S: Odd Fixes
 F: hw/mips/mips_fulong2e.c
+F: hw/isa/vt82c686.c
+F: include/hw/isa/vt82c686.h
 
 Boston
 M: Paul Burton <paul.burton@mips.com>
-- 
2.16.2
