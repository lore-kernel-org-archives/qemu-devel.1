Received: from eggs.gnu.org ([2001:4830:134:3::10]:34247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fwsUp-00059Q-GM
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 13:18:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fwsUm-00076y-MW
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 13:18:39 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:41209)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fwsUm-00075l-Fa
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 13:18:36 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon,  3 Sep 2018 13:18:28 -0400
Message-Id: <20180903171831.15446-4-cota@braap.org>
In-Reply-To: <20180903171831.15446-1-cota@braap.org>
References: <20180903171831.15446-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH 3/6] atomic: fix comment s/x64_64/x86_64/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/qemu/atomic.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/qemu/atomic.h b/include/qemu/atomic.h
index 9ed39effd3..de3e36f400 100644
--- a/include/qemu/atomic.h
+++ b/include/qemu/atomic.h
@@ -98,7 +98,7 @@
  * We'd prefer not want to pull in everything else TCG related, so handle
  * those few cases by hand.
  *
- * Note that x32 is fully detected with __x64_64__ + _ILP32, and that for
+ * Note that x32 is fully detected with __x86_64__ + _ILP32, and that for
  * Sparc we always force the use of sparcv9 in configure.
  */
 #if defined(__x86_64__) || defined(__sparc__)
-- 
2.17.1
