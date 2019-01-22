Received: from eggs.gnu.org ([209.51.188.92]:60107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gm2O2-0007eQ-2p
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 15:11:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gm2O0-0005yQ-2M
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 15:11:06 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:35379)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gm2Nz-0005qH-Eg
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 15:11:03 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 22 Jan 2019 15:10:42 -0500
Message-Id: <20190122201042.26394-5-cota@braap.org>
In-Reply-To: <20190122201042.26394-1-cota@braap.org>
References: <20190122201042.26394-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH 4/4] tests/fp/platform.h: include config-host.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

We get HOST_WORDS_BIGENDIAN from config-host.h, but the include
is missing. Fix it.

This fixes `make check-softfloat' on big endian hosts.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
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
