Return-Path: <SRS0=DeAR=WO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E64CEC3A589
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2019 23:23:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9DCC21852
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2019 23:23:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9DCC21852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzUWi-0001XO-Uj
	for qemu-devel@archiver.kernel.org; Sun, 18 Aug 2019 19:23:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50906)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1hzURj-0003C3-Ld
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 19:18:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hzURi-0000jD-Hr
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 19:18:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48688)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hzURi-0000iW-Ca
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 19:18:46 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id ABD7083F3F;
 Sun, 18 Aug 2019 23:18:45 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-33.brq.redhat.com [10.40.204.33])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 016E658C8A;
 Sun, 18 Aug 2019 23:18:43 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 19 Aug 2019 01:18:27 +0200
Message-Id: <20190818231827.27573-5-philmd@redhat.com>
In-Reply-To: <20190818231827.27573-1-philmd@redhat.com>
References: <20190818231827.27573-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Sun, 18 Aug 2019 23:18:45 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 4/4] tests/docker: Use Travis-CI default
 environment variables
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Update to environment variables of our Docker image to closely
reproduce the builds run by the Travis-CI service.

Default variables from:
https://docs.travis-ci.com/user/environment-variables/#default-environmen=
t-variables

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/docker/dockerfiles/travis.docker | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tests/docker/dockerfiles/travis.docker b/tests/docker/docker=
files/travis.docker
index b5c5036534..a0e8152317 100644
--- a/tests/docker/dockerfiles/travis.docker
+++ b/tests/docker/dockerfiles/travis.docker
@@ -1,7 +1,11 @@
 FROM travisci/ci-sardonyx:packer-1546978056-2c98a19
-ENV DEBIAN_FRONTEND noninteractive
-ENV LANG en_US.UTF-8
-ENV LC_ALL en_US.UTF-8
+ENV CI=3Dtrue \
+    TRAVIS=3Dtrue \
+    CONTINUOUS_INTEGRATION=3Dtrue \
+    DEBIAN_FRONTEND=3Dnoninteractive \
+    LANG=3Den_US.UTF-8 \
+    LC_ALL=3Den_US.UTF-8 \
+    TRAVIS_OS_NAME=3Dlinux
 RUN sed -i "s/# deb-src/deb-src/" /etc/apt/sources.list
 RUN apt-get update
 RUN apt-get -y build-dep qemu
--=20
2.20.1


