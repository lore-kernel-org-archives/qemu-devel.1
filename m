Received: from eggs.gnu.org ([2001:4830:134:3::10]:34684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eC5SC-0005nE-R9
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:06:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eC5SA-0008Tb-Cn
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:06:16 -0500
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:56373)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eC5SA-0008Sk-60
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:06:14 -0500
Received: by mail-wm0-x234.google.com with SMTP id z3so4533799wme.5
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 07:06:14 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  7 Nov 2017 15:05:49 +0000
Message-Id: <20171107150558.22131-2-alex.bennee@linaro.org>
In-Reply-To: <20171107150558.22131-1-alex.bennee@linaro.org>
References: <20171107150558.22131-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH 01/10] build-all-arches: drop -t (for tty)
 from docker invocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: Dave.Martin@arm.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

This prevents gcc from going nuts with colorizing the compiler output
which looks particularly ugly when invoked via compilation-mode.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 build-all-archs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/build-all-archs b/build-all-archs
index 63918e5..fa2ac90 100755
--- a/build-all-archs
+++ b/build-all-archs
@@ -61,7 +61,7 @@ done
 # If docker is enabled we just brute force the various images until we
 # can set the one that has a workable cross compiler.
 
-DOCKER_RUN="docker run --rm -t -u $(id -u) -v $(pwd):$(pwd) -w $(pwd)"
+DOCKER_RUN="docker run --rm -u $(id -u) -v $(pwd):$(pwd) -w $(pwd)"
 
 program_exists() {
     if [ ! -z "$docker_tags" ]; then
-- 
2.14.2
