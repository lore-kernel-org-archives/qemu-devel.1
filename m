Received: from eggs.gnu.org ([2001:4830:134:3::10]:36884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7qza-0000PL-7q
	for qemu-devel@nongnu.org; Mon, 08 May 2017 18:18:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7qzZ-0007B6-EG
	for qemu-devel@nongnu.org; Mon, 08 May 2017 18:18:58 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  8 May 2017 19:17:56 -0300
Message-Id: <20170508221759.15616-19-f4bug@amsat.org>
In-Reply-To: <20170508221759.15616-1-f4bug@amsat.org>
References: <20170508221759.15616-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 18/21] shippable: add powerpc target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .shippable.yml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.shippable.yml b/.shippable.yml
index 2070c4d827..aad66ec5ec 100644
--- a/.shippable.yml
+++ b/.shippable.yml
@@ -11,6 +11,8 @@ env:
       TARGET_LIST=aarch64-softmmu,aarch64-linux-user
     - IMAGE=debian-s390x-cross
       TARGET_LIST=s390x-softmmu,s390x-linux-user
+    - IMAGE=debian-powerpc-cross
+      TARGET_LIST=ppc-softmmu,ppcemb-softmmu,ppc-linux-user
 build:
   pre_ci:
     - make docker-image-${IMAGE} V=1
-- 
2.11.0
