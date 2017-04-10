Received: from eggs.gnu.org ([2001:4830:134:3::10]:53419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cxYqr-0002UB-RZ
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 08:55:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cxYqo-000377-3T
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 08:55:25 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:33019)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cxYqn-000360-U6
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 08:55:22 -0400
Received: by mail-wm0-x230.google.com with SMTP id y18so8558745wmh.0
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 05:55:20 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 10 Apr 2017 13:55:15 +0100
Message-Id: <20170410125524.21008-3-alex.bennee@linaro.org>
In-Reply-To: <20170410125524.21008-1-alex.bennee@linaro.org>
References: <20170410125524.21008-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 02/11] cpus: fix wrong define name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

While the configure script generates TARGET_SUPPORTS_MTTCG define, one
of the define is cpus.c is checking wrong name: TARGET_SUPPORT_MTTCG

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/cpus.c b/cpus.c
index 68fdbc40b9..58d90aa2b9 100644
--- a/cpus.c
+++ b/cpus.c
@@ -202,7 +202,7 @@ void qemu_tcg_configure(QemuOpts *opts, Error **errp)
             } else if (use_icount) {
                 error_setg(errp, "No MTTCG when icount is enabled");
             } else {
-#ifndef TARGET_SUPPORT_MTTCG
+#ifndef TARGET_SUPPORTS_MTTCG
                 error_report("Guest not yet converted to MTTCG - "
                              "you may get unexpected results");
 #endif
-- 
2.11.0
