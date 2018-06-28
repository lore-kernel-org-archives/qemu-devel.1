Received: from eggs.gnu.org ([2001:4830:134:3::10]:52541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYa4t-0007Oy-2C
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:47:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYa4q-0004ZO-17
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:47:27 -0400
Received: from mail-qk0-x236.google.com ([2607:f8b0:400d:c09::236]:34141)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYa4p-0004YH-T2
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:47:23 -0400
Received: by mail-qk0-x236.google.com with SMTP id b66-v6so3350313qkj.1
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 09:47:23 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 28 Jun 2018 13:46:39 -0300
Message-Id: <20180628164643.9668-5-f4bug@amsat.org>
In-Reply-To: <20180628164643.9668-1-f4bug@amsat.org>
References: <20180628164643.9668-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 4/8] docker: Add packages required to build
 a Linux kernel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Cleber Rosa <crosa@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

Being able to also cross build Linux kernels with our docker cross
images allow us to add more complex qemu-system acceptance tests.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
This is not required to build QEMU, so I might resend it in the
acceptance-test series which actually requires this patch.

 tests/docker/dockerfiles/debian-sid.docker | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tests/docker/dockerfiles/debian-sid.docker b/tests/docker/dockerfiles/debian-sid.docker
index 9a3d168705..846021b032 100644
--- a/tests/docker/dockerfiles/debian-sid.docker
+++ b/tests/docker/dockerfiles/debian-sid.docker
@@ -22,11 +22,15 @@ RUN DEBIAN_FRONTEND=noninteractive apt install -yy eatmydata
 RUN DEBIAN_FRONTEND=noninteractive eatmydata \
     apt install -y --no-install-recommends \
         bison \
+        binutils-multiarch \
         build-essential \
         ca-certificates \
+        curl \
         flex \
+        gettext \
         git \
+        gnupg \
         pkg-config \
         psmisc \
-        python \
+        python-minimal \
         texinfo || { echo "Failed to build - see debian-sid.docker notes"; exit 1; }
-- 
2.18.0
