Received: from eggs.gnu.org ([2001:4830:134:3::10]:48481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1csp0T-0004I5-Ff
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 07:09:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1csp0S-00039M-Bd
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 07:09:45 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:34549)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1csp0S-00038S-5C
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 07:09:44 -0400
Received: by mail-wr0-x233.google.com with SMTP id l43so98995837wre.1
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 04:09:44 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 28 Mar 2017 12:09:36 +0100
Message-Id: <20170328110936.24806-7-alex.bennee@linaro.org>
In-Reply-To: <20170328110936.24806-1-alex.bennee@linaro.org>
References: <20170328110936.24806-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 6/6] replay/replay.c: bump REPLAY_VERSION
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

A previous commit (3d4d16f4) added support for audio record/playback.
However this breaks the logfile ABI due to the re-ordering of the
ReplayEvents enum. The REPLAY_VERSION check is meant to prevent you
from using old log files in newer QEMUs but this is currently broken.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 replay/replay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/replay/replay.c b/replay/replay.c
index 78e2a7e570..9e0724e756 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -22,7 +22,7 @@
 
 /* Current version of the replay mechanism.
    Increase it when file format changes. */
-#define REPLAY_VERSION              0xe02005
+#define REPLAY_VERSION              0xe02006
 /* Size of replay log header */
 #define HEADER_SIZE                 (sizeof(uint32_t) + sizeof(uint64_t))
 
-- 
2.11.0
