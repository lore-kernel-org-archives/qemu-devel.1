Received: from eggs.gnu.org ([2001:4830:134:3::10]:34216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1csmcB-0008GZ-29
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 04:36:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1csmcA-00016L-A6
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 04:36:31 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:34786)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1csmcA-00015x-4i
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 04:36:30 -0400
Received: by mail-wr0-x22b.google.com with SMTP id l43so92602680wre.1
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 01:36:30 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 28 Mar 2017 09:36:22 +0100
Message-Id: <20170328083623.10396-6-alex.bennee@linaro.org>
In-Reply-To: <20170328083623.10396-1-alex.bennee@linaro.org>
References: <20170328083623.10396-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 5/6] tcg: Add a new line after
 incompatibility warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, rth@twiddle.net, pbonzini@redhat.com, kraxel@redhat.com
Cc: qemu-devel@nongnu.org, mttcg@listserver.greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

From: Pranith Kumar <bobby.prani@gmail.com>

Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
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
