Received: from eggs.gnu.org ([208.118.235.92]:57129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gdz0y-0005T3-J1
	for qemu-devel@nongnu.org; Mon, 31 Dec 2018 09:58:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gdz0x-0003r3-CY
	for qemu-devel@nongnu.org; Mon, 31 Dec 2018 09:58:00 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:57116 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gdz0x-0002SU-1Q
	for qemu-devel@nongnu.org; Mon, 31 Dec 2018 09:57:59 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 31 Dec 2018 15:55:58 +0100
Message-Id: <1546268200-26966-3-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1546268200-26966-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1546268200-26966-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 02/44] MAINTAINERS: target/mips: Add filter
 for mips in email subjects
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Add ability to redirect mails (sent to qemu-devel) containing
"mips" in the subject line to MIPS maintainers and reviewers.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 374e4c2..bf82eb3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -221,6 +221,7 @@ F: tests/tcg/mips/
 F: disas/mips.c
 F: disas/nanomips.h
 F: disas/nanomips.cpp
+K: ^Subject:.*(?i)mips
=20
 Moxie
 M: Anthony Green <green@moxielogic.com>
--=20
2.7.4
