Received: from eggs.gnu.org ([2001:4830:134:3::10]:38442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fWMnN-00064m-0T
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:12:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fWMnK-000666-2Z
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:12:12 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:38167)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fWMnJ-00065S-SU
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:12:10 -0400
Received: by mail-wm0-x235.google.com with SMTP id 69-v6so2783152wmf.3
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 07:12:09 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 22 Jun 2018 15:11:46 +0100
Message-Id: <20180622141205.16306-4-alex.bennee@linaro.org>
In-Reply-To: <20180622141205.16306-1-alex.bennee@linaro.org>
References: <20180622141205.16306-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH v4 03/22] build-all-arches: expand the
 range of docker images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, richard.henderson@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

We won't actually want power, we want ppc64el for the 64 bit version.
Also we will soon have m68k so include that as well.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 build-all-archs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/build-all-archs b/build-all-archs
index fa2ac90..a2f5cff 100755
--- a/build-all-archs
+++ b/build-all-archs
@@ -39,7 +39,7 @@ while [[ "$1" = -* ]]; do
             ;;
         --use-docker)
             if [ -z "$arg" ]; then
-                default_tags=$(docker images qemu --format "{{.Repository}}:{{.Tag}}" | grep "\(arm\|power\).*cross$")
+                default_tags=$(docker images qemu --format "{{.Repository}}:{{.Tag}}" | grep "\(arm\|ppc64el\|m68k\).*cross$")
                 docker_tags=$(echo $default_tags | sed 's/\n/\s/g' )
             else
                 docker_tags="$arg"
-- 
2.17.1
