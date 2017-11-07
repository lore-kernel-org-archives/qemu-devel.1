Received: from eggs.gnu.org ([2001:4830:134:3::10]:34819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eC5SK-0005qP-JE
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:06:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eC5SC-0008VJ-NL
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:06:24 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:49964)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eC5SC-0008Ul-Ga
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:06:16 -0500
Received: by mail-wm0-x243.google.com with SMTP id b189so4338881wmd.4
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 07:06:16 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  7 Nov 2017 15:05:51 +0000
Message-Id: <20171107150558.22131-4-alex.bennee@linaro.org>
In-Reply-To: <20171107150558.22131-1-alex.bennee@linaro.org>
References: <20171107150558.22131-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH 03/10] risu.c: add missing --trace longopt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: Dave.Martin@arm.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

This got missed when trace support was added.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 risu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/risu.c b/risu.c
index a5d155d..616fc33 100644
--- a/risu.c
+++ b/risu.c
@@ -289,6 +289,7 @@ struct option * setup_options(char **short_opts)
         {"master", no_argument, &ismaster, 1},
         {"host", required_argument, 0, 'h'},
         {"port", required_argument, 0, 'p'},
+        {"trace", required_argument, 0, 't'},
         {"test-fp-exc", no_argument, &test_fp_exc, 1},
         {0, 0, 0, 0}
     };
-- 
2.14.2
