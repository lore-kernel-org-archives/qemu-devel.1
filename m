Received: from eggs.gnu.org ([2001:4830:134:3::10]:45094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gZj72-0002uc-9E
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 16:10:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gZj6y-0006Bw-Sa
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 16:10:40 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:50379 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gZj6y-00066B-IP
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 16:10:36 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed, 19 Dec 2018 22:10:21 +0100
Message-Id: <20181219211022.5379-3-aleksandar.markovic@rt-rk.com>
In-Reply-To: <20181219211022.5379-1-aleksandar.markovic@rt-rk.com>
References: <20181219211022.5379-1-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 2/3] MAINTAINERS: target/mips: Add filter
 for mips in email subjects
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, smarkovic@wavecomp.com, amarkovic@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Add ability to redirect mails (sent to qemu-devel) containing
"mips" in the subject line to MIPS maintainers and reviewers.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c052523373..05bf140824 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -219,6 +219,7 @@ F: tests/tcg/mips/
 F: disas/mips.c
 F: disas/nanomips.h
 F: disas/nanomips.cpp
+K: ^Subject:.*(?i)mips
=20
 Moxie
 M: Anthony Green <green@moxielogic.com>
--=20
2.17.1
