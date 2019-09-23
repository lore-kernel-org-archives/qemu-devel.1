Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9932BC4CEC4
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 18:13:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75B7420856
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 18:13:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75B7420856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCSpg-0001sj-3K
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 14:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47365)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1iCSoR-0000ts-8P
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 14:11:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1iCSoP-0000mp-MT
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 14:11:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34814)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1iCSoP-0000lI-EM
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 14:11:49 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A74FF3004E5B;
 Mon, 23 Sep 2019 18:11:48 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-231.bos.redhat.com [10.18.17.231])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 107671001938;
 Mon, 23 Sep 2019 18:11:47 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 3/6] docker: remove 'deprecated' image definitions
Date: Mon, 23 Sep 2019 14:11:37 -0400
Message-Id: <20190923181140.7235-4-jsnow@redhat.com>
In-Reply-To: <20190923181140.7235-1-jsnow@redhat.com>
References: <20190923181140.7235-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Mon, 23 Sep 2019 18:11:48 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There isn't a debian.dockerfile anymore,
so perform some ghost-busting.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/docker/Makefile.include | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.includ=
e
index b20a810016..983224ad96 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -4,11 +4,10 @@
=20
 DOCKER_SUFFIX :=3D .docker
 DOCKER_FILES_DIR :=3D $(SRC_PATH)/tests/docker/dockerfiles
-DOCKER_DEPRECATED_IMAGES :=3D debian
 # we don't run tests on intermediate images (used as base by another ima=
ge)
-DOCKER_PARTIAL_IMAGES :=3D debian debian9 debian10 debian-sid
+DOCKER_PARTIAL_IMAGES :=3D debian9 debian10 debian-sid
 DOCKER_PARTIAL_IMAGES +=3D debian9-mxe debian-ports debian-bootstrap
-DOCKER_IMAGES :=3D $(filter-out $(DOCKER_DEPRECATED_IMAGES),$(sort $(not=
dir $(basename $(wildcard $(DOCKER_FILES_DIR)/*.docker)))))
+DOCKER_IMAGES :=3D $(sort $(notdir $(basename $(wildcard $(DOCKER_FILES_=
DIR)/*.docker))))
 DOCKER_TARGETS :=3D $(patsubst %,docker-image-%,$(DOCKER_IMAGES))
 # Use a global constant ccache directory to speed up repetitive builds
 DOCKER_CCACHE_DIR :=3D $$HOME/.cache/qemu-docker-ccache
@@ -159,7 +158,7 @@ docker-image-debian-powerpc-user-cross: docker-binfmt=
-image-debian-powerpc-user
 DOCKER_USER_IMAGES +=3D debian-powerpc-user
=20
 # Expand all the pre-requistes for each docker image and test combinatio=
n
-$(foreach i,$(filter-out $(DOCKER_PARTIAL_IMAGES),$(DOCKER_IMAGES) $(DOC=
KER_DEPRECATED_IMAGES)), \
+$(foreach i,$(filter-out $(DOCKER_PARTIAL_IMAGES),$(DOCKER_IMAGES)), \
 	$(foreach t,$(DOCKER_TESTS) $(DOCKER_TOOLS), \
 		$(eval .PHONY: docker-$t@$i) \
 		$(eval docker-$t@$i: docker-image-$i docker-run-$t@$i) \
--=20
2.21.0


