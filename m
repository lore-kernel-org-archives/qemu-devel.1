Received: from eggs.gnu.org ([2001:4830:134:3::10]:38060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ciMJw-000158-3v
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:30:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ciMJt-0007au-JG
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:30:36 -0500
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:34712)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ciMJt-0007aJ-Dr
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:30:33 -0500
Received: by mail-wr0-x232.google.com with SMTP id l37so9382498wrc.1
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 06:30:33 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 27 Feb 2017 14:30:28 +0000
Message-Id: <20170227143028.16428-3-alex.bennee@linaro.org>
In-Reply-To: <20170227143028.16428-1-alex.bennee@linaro.org>
References: <20170227143028.16428-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 2/2] .shippable: add s390x-cross target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: famz@redhat.com
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Use the new debian-s390x-cross.docker target to cross compile for
s390.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .shippable.yml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.shippable.yml b/.shippable.yml
index 1a1fd7a91d..653bd750fe 100644
--- a/.shippable.yml
+++ b/.shippable.yml
@@ -5,6 +5,8 @@ env:
       TARGET_LIST=arm-softmmu,arm-linux-user
     - IMAGE=debian-arm64-cross
       TARGET_LIST=aarch64-softmmu,aarch64-linux-user
+    - IMAGE=debian-s390x-cross
+      TARGET_LIST=s390x-softmmu,s390x-linux-user
 build:
   pre_ci:
     - make docker-image-${IMAGE}
-- 
2.11.0
