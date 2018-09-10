Received: from eggs.gnu.org ([2001:4830:134:3::10]:40046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzVjm-0003QR-UP
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 19:37:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzVbU-0005Ka-0v
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 19:28:25 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:47235)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fzVbT-0005IR-SM
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 19:28:23 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon, 10 Sep 2018 19:27:46 -0400
Message-Id: <20180910232752.31565-7-cota@braap.org>
In-Reply-To: <20180910232752.31565-1-cota@braap.org>
References: <20180910232752.31565-1-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 06/12] atomic: fix comment s/x64_64/x86_64/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Murilo Opsfelder Araujo <muriloo@linux.ibm.com>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/qemu/atomic.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/qemu/atomic.h b/include/qemu/atomic.h
index c34c2f78c4..f6993a8fb1 100644
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
