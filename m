Received: from eggs.gnu.org ([2001:4830:134:3::10]:55394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ffjKa-00038V-OE
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 06:05:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ffjKW-00010H-EN
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 06:05:12 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41683)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ffjKW-0000zl-7l
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 06:05:08 -0400
Received: by mail-wr1-x442.google.com with SMTP id j5-v6so4038581wrr.8
	for <qemu-devel@nongnu.org>; Wed, 18 Jul 2018 03:05:08 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 18 Jul 2018 11:04:56 +0100
Message-Id: <20180718100505.7546-2-alex.bennee@linaro.org>
In-Reply-To: <20180718100505.7546-1-alex.bennee@linaro.org>
References: <20180718100505.7546-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH RFC 01/10] docker: rename docker-amd64 to
 docker-host
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

When building on non-x86 systems the base system will be correct so if
we avoid too many x86'isms in the install we can still use the image.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .../dockerfiles/{debian-amd64.docker => debian-host.docker}   | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
 rename tests/docker/dockerfiles/{debian-amd64.docker => debian-host.docker} (91%)

diff --git a/tests/docker/dockerfiles/debian-amd64.docker b/tests/docker/dockerfiles/debian-host.docker
similarity index 91%
rename from tests/docker/dockerfiles/debian-amd64.docker
rename to tests/docker/dockerfiles/debian-host.docker
index eb13f06ed1..3605cc4658 100644
--- a/tests/docker/dockerfiles/debian-amd64.docker
+++ b/tests/docker/dockerfiles/debian-host.docker
@@ -30,9 +30,9 @@ RUN cd /usr/src/virglrenderer && ./autogen.sh && ./configure --with-glx --disabl
 # netmap
 RUN DEBIAN_FRONTEND=noninteractive eatmydata \
     apt-get install -y --no-install-recommends \
-        linux-headers-amd64
+        linux-headers-$(dpkg --print-architecture)
 RUN git clone https://github.com/luigirizzo/netmap.git /usr/src/netmap
-RUN cd /usr/src/netmap/LINUX && ./configure --no-drivers --no-apps --kernel-dir=$(ls -d /usr/src/linux-headers-*-amd64) && make install
+RUN cd /usr/src/netmap/LINUX && ./configure --no-drivers --no-apps --kernel-dir=$(ls -d /usr/src/linux-headers-*) && make install
 ENV QEMU_CONFIGURE_OPTS --enable-netmap
 
 # gcrypt
-- 
2.17.1
