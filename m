Received: from eggs.gnu.org ([2001:4830:134:3::10]:37355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fNywb-0008PC-Nn
	for qemu-devel@nongnu.org; Wed, 30 May 2018 07:07:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fNywa-0001zo-TQ
	for qemu-devel@nongnu.org; Wed, 30 May 2018 07:07:05 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:45071)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fNywa-0001zU-MJ
	for qemu-devel@nongnu.org; Wed, 30 May 2018 07:07:04 -0400
Received: by mail-wr0-x241.google.com with SMTP id w3-v6so29076616wrl.12
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 04:07:04 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 30 May 2018 12:06:53 +0100
Message-Id: <20180530110655.22022-7-alex.bennee@linaro.org>
In-Reply-To: <20180530110655.22022-1-alex.bennee@linaro.org>
References: <20180530110655.22022-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 6/8] .travis.yml: make current setup explicit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, pbonzini@redhat.com, stefanha@redhat.com, stefanb@linux.vnet.ibm.com, marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Add some commentary and make the selection of Container based Trusty
build explicit. We will need to add VM builds later when using docker.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .travis.yml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index 85ee2a1edb..e99af6f357 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -1,4 +1,8 @@
+# The current Travis default is a container based 14.04 Trust on EC2
+# Additional builds with specific requirements for a full VM need to
+# be added as additional matrix: entries later on
 sudo: false
+dist: trusty
 language: c
 python:
   - "2.6"
-- 
2.17.0
