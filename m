Received: from eggs.gnu.org ([2001:4830:134:3::10]:48626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dCHZw-0001hv-Gw
	for qemu-devel@nongnu.org; Sat, 20 May 2017 23:30:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dCHZu-0007OZ-1d
	for qemu-devel@nongnu.org; Sat, 20 May 2017 23:30:48 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun, 21 May 2017 00:29:52 -0300
Message-Id: <20170521032956.27446-21-f4bug@amsat.org>
In-Reply-To: <20170521032956.27446-1-f4bug@amsat.org>
References: <20170521032956.27446-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 20/24] shippable: add armeb-linux-user target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .shippable.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.shippable.yml b/.shippable.yml
index fe360f85cb..2070c4d827 100644
--- a/.shippable.yml
+++ b/.shippable.yml
@@ -6,7 +6,7 @@ env:
     - LC_ALL=C
   matrix:
     - IMAGE=debian-armhf-cross
-      TARGET_LIST=arm-softmmu,arm-linux-user
+      TARGET_LIST=arm-softmmu,arm-linux-user,armeb-linux-user
     - IMAGE=debian-arm64-cross
       TARGET_LIST=aarch64-softmmu,aarch64-linux-user
     - IMAGE=debian-s390x-cross
-- 
2.11.0
