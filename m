Received: from eggs.gnu.org ([2001:4830:134:3::10]:50294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fT5Jn-0002Zo-TY
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 08:56:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fT5Jm-00050m-14
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 08:56:07 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:54230)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fT5Jl-0004zM-RM
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 08:56:05 -0400
Received: by mail-wm0-x229.google.com with SMTP id x6-v6so4524485wmc.3
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 05:56:05 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 13 Jun 2018 13:55:42 +0100
Message-Id: <20180613125601.14371-4-alex.bennee@linaro.org>
In-Reply-To: <20180613125601.14371-1-alex.bennee@linaro.org>
References: <20180613125601.14371-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH v3 03/22] build-all-arches: expand the
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
