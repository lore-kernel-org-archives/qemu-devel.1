Received: from eggs.gnu.org ([2001:4830:134:3::10]:58117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fk8zn-00010u-KY
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 10:18:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fk8zm-0002MU-Pl
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 10:17:59 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43820)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fk8zm-00029y-JB
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 10:17:58 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fk8zi-0004HJ-8O
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 15:17:54 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Jul 2018 15:17:48 +0100
Message-Id: <20180730141748.430-7-peter.maydell@linaro.org>
In-Reply-To: <20180730141748.430-1-peter.maydell@linaro.org>
References: <20180730141748.430-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 6/6] target/arm: Remove duplicate 'host' entry
 in '-cpu ?' output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Since 86f0a186d6f the TYPE_ARM_HOST_CPU is only compiled when CONFIG_KVM
is enabled.

Remove the now redundant special-case introduced in a96c0514ab7, to avoid:

  $ qemu-system-aarch64 -machine virt -cpu \? | fgrep host
  host
  host (only available in KVM mode)

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20180727132311.2777-1-f4bug@amsat.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 22d812240af..66afb08ee0f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5591,12 +5591,6 @@ void arm_cpu_list(FILE *f, fprintf_function cpu_fprintf)
     (*cpu_fprintf)(f, "Available CPUs:\n");
     g_slist_foreach(list, arm_cpu_list_entry, &s);
     g_slist_free(list);
-#ifdef CONFIG_KVM
-    /* The 'host' CPU type is dynamically registered only if KVM is
-     * enabled, so we have to special-case it here:
-     */
-    (*cpu_fprintf)(f, "  host (only available in KVM mode)\n");
-#endif
 }
 
 static void arm_cpu_add_definition(gpointer data, gpointer user_data)
-- 
2.17.1
