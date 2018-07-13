Received: from eggs.gnu.org ([2001:4830:134:3::10]:57210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fdx19-0004lS-K9
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 08:17:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fdx18-0003d2-JZ
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 08:17:47 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46461)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fdx18-0003bl-Ck
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 08:17:46 -0400
Received: by mail-wr1-x443.google.com with SMTP id s11-v6so24912478wra.13
	for <qemu-devel@nongnu.org>; Fri, 13 Jul 2018 05:17:46 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 13 Jul 2018 13:17:28 +0100
Message-Id: <20180713121741.19262-4-alex.bennee@linaro.org>
In-Reply-To: <20180713121741.19262-1-alex.bennee@linaro.org>
References: <20180713121741.19262-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 for 3.0 03/16] shippable: Build the TriCore
 docker image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .shippable.yml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.shippable.yml b/.shippable.yml
index f74a3de3ff..9670b13f8e 100644
--- a/.shippable.yml
+++ b/.shippable.yml
@@ -25,6 +25,8 @@ env:
       TARGET_LIST=mips64el-softmmu,mips64el-linux-user
     - IMAGE=debian-ppc64el-cross
       TARGET_LIST=ppc64-softmmu,ppc64-linux-user,ppc64abi32-linux-user
+    - IMAGE=debian-tricore-cross
+      TARGET_LIST=
 build:
   pre_ci:
     - make docker-image-${IMAGE} V=1
-- 
2.17.1
