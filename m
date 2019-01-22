Received: from eggs.gnu.org ([209.51.188.92]:60951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gm3wQ-0007Sr-LS
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 16:50:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gm3wP-0008Fo-KK
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 16:50:42 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38101)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gm3wP-0007s8-Bk
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 16:50:41 -0500
Received: by mail-wm1-x343.google.com with SMTP id m22so81307wml.3
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 13:50:24 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 22 Jan 2019 21:50:11 +0000
Message-Id: <20190122215016.18697-7-alex.bennee@linaro.org>
In-Reply-To: <20190122215016.18697-1-alex.bennee@linaro.org>
References: <20190122215016.18697-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 06/11] tests/fp/platform.h: include
 config-host.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Emilio G. Cota" <cota@braap.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>

From: "Emilio G. Cota" <cota@braap.org>

We get HOST_WORDS_BIGENDIAN from config-host.h, but the include
is missing. Fix it.

This fixes `make check-softfloat' on big endian hosts.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/fp/platform.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/fp/platform.h b/tests/fp/platform.h
index f8c423dde3..c20ba70baa 100644
--- a/tests/fp/platform.h
+++ b/tests/fp/platform.h
@@ -29,6 +29,7 @@
  * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
+#include "config-host.h"
 
 #ifndef HOST_WORDS_BIGENDIAN
 #define LITTLEENDIAN 1
-- 
2.17.1
