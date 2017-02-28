Received: from eggs.gnu.org ([2001:4830:134:3::10]:40960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cih9O-0003Yk-8J
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:45:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cih9N-0001D1-Im
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:45:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cih9N-0001Ck-DO
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:45:05 -0500
From: Fam Zheng <famz@redhat.com>
Date: Tue, 28 Feb 2017 20:44:58 +0800
Message-Id: <20170228124458.31307-3-famz@redhat.com>
In-Reply-To: <20170228124458.31307-1-famz@redhat.com>
References: <20170228124458.31307-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/2] .shippable: add s390x-cross target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

From: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Use the new debian-s390x-cross.docker target to cross compile for
s390.

Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Message-Id: <20170227143028.16428-3-alex.bennee@linaro.org>
Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 .shippable.yml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.shippable.yml b/.shippable.yml
index 1a1fd7a..653bd75 100644
--- a/.shippable.yml
+++ b/.shippable.yml
@@ -5,6 +5,8 @@ env:
       TARGET_LIST=3Darm-softmmu,arm-linux-user
     - IMAGE=3Ddebian-arm64-cross
       TARGET_LIST=3Daarch64-softmmu,aarch64-linux-user
+    - IMAGE=3Ddebian-s390x-cross
+      TARGET_LIST=3Ds390x-softmmu,s390x-linux-user
 build:
   pre_ci:
     - make docker-image-${IMAGE}
--=20
2.9.3
