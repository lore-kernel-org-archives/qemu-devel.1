Received: from eggs.gnu.org ([2001:4830:134:3::10]:40640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fcXyk-0000rV-43
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 11:21:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fcXyj-0005YT-3u
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 11:21:30 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:35288)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fcXyi-0005Y8-Ss
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 11:21:29 -0400
Received: by mail-wm0-x22f.google.com with SMTP id v3-v6so17577213wmh.0
	for <qemu-devel@nongnu.org>; Mon, 09 Jul 2018 08:21:28 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon,  9 Jul 2018 16:21:17 +0100
Message-Id: <20180709152117.21585-11-alex.bennee@linaro.org>
In-Reply-To: <20180709152117.21585-1-alex.bennee@linaro.org>
References: <20180709152117.21585-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for 3.0 10/10] docker: add expansion for
 docker-test-FOO to Makefile.include
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

This allows us to run a particular test on all docker images. For
example:

  make docker-test-unit

Will run the unit tests on every supported image.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/Makefile.include | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index fe63aacf69..765b2c36f2 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -152,6 +152,7 @@ $(foreach i,$(filter-out $(DOCKER_PARTIAL_IMAGES),$(DOCKER_IMAGES) $(DOCKER_DEPR
 	) \
 	$(foreach t,$(DOCKER_TESTS), \
 		$(eval docker-test: docker-$t@$i) \
+		$(eval docker-$t: docker-$t@$i) \
 	) \
 )
 
@@ -162,6 +163,7 @@ docker:
 	@echo
 	@echo '    docker:              Print this help.'
 	@echo '    docker-test:         Run all image/test combinations.'
+	@echo '    docker-TEST:         Run TEST on all image combinations.'
 	@echo '    docker-clean:        Kill and remove residual docker testing containers.'
 	@echo '    docker-TEST@IMAGE:   Run "TEST" in container "IMAGE".'
 	@echo '                         Note: "TEST" is one of the listed test name,'
-- 
2.17.1
