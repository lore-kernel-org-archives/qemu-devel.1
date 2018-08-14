Received: from eggs.gnu.org ([2001:4830:134:3::10]:33906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fpOHm-0006H5-Q1
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 21:38:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fpOHj-0002GH-Jf
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 21:38:14 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:52151)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fpOHj-0002Fx-Da
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 21:38:11 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon, 13 Aug 2018 21:37:59 -0400
Message-Id: <20180814013801.26036-3-cota@braap.org>
In-Reply-To: <20180814013801.26036-1-cota@braap.org>
References: <20180814013801.26036-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH 2/4] cpus: assert that the BQL is held in
 cpu_get_ticks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 cpus.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/cpus.c b/cpus.c
index b5844b7103..b23bf6fef7 100644
--- a/cpus.c
+++ b/cpus.c
@@ -308,6 +308,8 @@ int64_t cpu_get_ticks(void)
 {
     int64_t ticks;
 
+    g_assert(qemu_mutex_iothread_locked());
+
     if (use_icount) {
         return cpu_get_icount();
     }
-- 
2.17.1
