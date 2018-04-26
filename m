Received: from eggs.gnu.org ([2001:4830:134:3::10]:53849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=647a3a28a=Ian.Jackson@citrix.com>)
	id 1fBkAC-0006jR-HY
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:54:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=647a3a28a=Ian.Jackson@citrix.com>)
	id 1fBkAA-0001Sr-6s
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:54:32 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:34804)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=647a3a28a=Ian.Jackson@citrix.com>)
	id 1fBkA9-0001Re-Ss
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:54:30 -0400
From: Ian Jackson <ian.jackson@eu.citrix.com>
Date: Thu, 26 Apr 2018 17:53:32 +0100
Message-ID: <1524761612-5307-8-git-send-email-ian.jackson@eu.citrix.com>
In-Reply-To: <1524761612-5307-1-git-send-email-ian.jackson@eu.citrix.com>
References: <1524761612-5307-1-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC PATCH 7/7] error reporting: HACKING: Say to use
 error_report_errno
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ian Jackson <ian.jackson@eu.citrix.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, Ian Jackson <Ian.Jackson@eu.citrix.com>

Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
---
 HACKING | 1 +
 1 file changed, 1 insertion(+)

diff --git a/HACKING b/HACKING
index 4125c97..95563a3 100644
--- a/HACKING
+++ b/HACKING
@@ -189,6 +189,7 @@ error_report() or error_vreport() from error-report.h.  This ensures the
 error is reported in the right place (current monitor or stderr), and in
 a uniform format.
 
+Use error_report_errno rather than open-coding calls to strerror().
 Use error_printf() & friends to print additional information.
 
 error_report() prints the current location.  In certain common cases
-- 
2.1.4
