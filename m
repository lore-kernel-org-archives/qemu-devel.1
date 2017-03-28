Received: from eggs.gnu.org ([2001:4830:134:3::10]:48429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1csp0S-0004HB-Aa
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 07:09:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1csp0R-00038F-6q
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 07:09:44 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:35827)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1csp0R-00037s-0V
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 07:09:43 -0400
Received: by mail-wr0-x234.google.com with SMTP id u1so99371046wra.2
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 04:09:42 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 28 Mar 2017 12:09:35 +0100
Message-Id: <20170328110936.24806-6-alex.bennee@linaro.org>
In-Reply-To: <20170328110936.24806-1-alex.bennee@linaro.org>
References: <20170328110936.24806-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 5/6] tcg: Add a new line after incompatibility
 warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, Pranith Kumar <bobby.prani@gmail.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

From: Pranith Kumar <bobby.prani@gmail.com>

Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 cpus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cpus.c b/cpus.c
index 167d9615e1..68fdbc40b9 100644
--- a/cpus.c
+++ b/cpus.c
@@ -209,7 +209,7 @@ void qemu_tcg_configure(QemuOpts *opts, Error **errp)
                 if (!check_tcg_memory_orders_compatible()) {
                     error_report("Guest expects a stronger memory ordering "
                                  "than the host provides");
-                    error_printf("This may cause strange/hard to debug errors");
+                    error_printf("This may cause strange/hard to debug errors\n");
                 }
                 mttcg_enabled = true;
             }
-- 
2.11.0
