Received: from eggs.gnu.org ([2001:4830:134:3::10]:40142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dGrlE-0002OB-Ee
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 14:57:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dGrlD-0006Vx-LT
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 14:57:24 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:33791)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dGrlD-0006Vf-Gc
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 14:57:23 -0400
Received: by mail-oi0-x242.google.com with SMTP id h4so13125120oib.0
	for <qemu-devel@nongnu.org>; Fri, 02 Jun 2017 11:57:23 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  2 Jun 2017 15:56:25 -0300
Message-Id: <20170602185630.5059-20-f4bug@amsat.org>
In-Reply-To: <20170602185630.5059-1-f4bug@amsat.org>
References: <20170602185630.5059-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 19/24] shippable: be verbose while building
 docker images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 .shippable.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.shippable.yml b/.shippable.yml
index 46adfa030f..fe360f85cb 100644
--- a/.shippable.yml
+++ b/.shippable.yml
@@ -13,7 +13,7 @@ env:
       TARGET_LIST=s390x-softmmu,s390x-linux-user
 build:
   pre_ci:
-    - make docker-image-${IMAGE}
+    - make docker-image-${IMAGE} V=1
   pre_ci_boot:
     image_name: qemu
     image_tag: ${IMAGE}
-- 
2.11.0
