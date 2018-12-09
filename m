Received: from eggs.gnu.org ([2001:4830:134:3::10]:33234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gW4u0-0000PS-OW
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:38:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gW4tv-0004wJ-Tq
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:38:08 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:33851)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gW4tv-0004rT-ID
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:38:03 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Sun,  9 Dec 2018 14:37:13 -0500
Message-Id: <20181209193749.12277-3-cota@braap.org>
In-Reply-To: <20181209193749.12277-1-cota@braap.org>
References: <20181209193749.12277-1-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC v2 02/38] tcg/README: fix typo
 s/afterwise/afterwards/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

Afterwise is "wise after the fact", as in "hindsight".
Here we meant "afterwards" (as in "subsequently"). Fix it.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 tcg/README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/README b/tcg/README
index d22ee084b8..3fa8a7059f 100644
--- a/tcg/README
+++ b/tcg/README
@@ -101,7 +101,7 @@ This can be overridden using the following function modifiers:
   canonical locations before calling the helper.
 - TCG_CALL_NO_WRITE_GLOBALS means that the helper does not modify any globals.
   They will only be saved to their canonical location before calling helpers,
-  but they won't be reloaded afterwise.
+  but they won't be reloaded afterwards.
 - TCG_CALL_NO_SIDE_EFFECTS means that the call to the function is removed if
   the return value is not used.
 
-- 
2.17.1
