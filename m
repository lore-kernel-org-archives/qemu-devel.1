Return-Path: <SRS0=hUdw=VK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F231C71142
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jul 2019 16:36:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 327052064A
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jul 2019 16:36:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 327052064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmL0j-0004d9-5C
	for qemu-devel@archiver.kernel.org; Sat, 13 Jul 2019 12:36:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52852)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hmL0M-0003Nz-4o
 for qemu-devel@nongnu.org; Sat, 13 Jul 2019 12:36:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hmL0L-0004th-21
 for qemu-devel@nongnu.org; Sat, 13 Jul 2019 12:36:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51434)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hmL0K-0004t3-Qs
 for qemu-devel@nongnu.org; Sat, 13 Jul 2019 12:36:09 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 288C33086262;
 Sat, 13 Jul 2019 16:36:08 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-24.brq.redhat.com [10.40.204.24])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 454985D9D6;
 Sat, 13 Jul 2019 16:36:06 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Sat, 13 Jul 2019 18:35:56 +0200
Message-Id: <20190713163558.13204-2-philmd@redhat.com>
In-Reply-To: <20190713163558.13204-1-philmd@redhat.com>
References: <20190713163558.13204-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Sat, 13 Jul 2019 16:36:08 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 1/3] tests/docker: Install Sphinx in the Debian
 images
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
Cc: Fam Zheng <fam@euphon.net>, Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since commit 5f71eac06e the Sphinx tool is required
to build the rST documentation.

This fixes:

 $ ./configure --enable-docs

 ERROR: User requested feature docs
        configure was not able to find it.
        Install texinfo, Perl/perl-podlators and python-sphinx

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/docker/dockerfiles/debian-sid.docker          | 1 +
 tests/docker/dockerfiles/debian-xtensa-cross.docker | 3 ++-
 tests/docker/dockerfiles/debian10.docker            | 1 +
 tests/docker/dockerfiles/debian9-mxe.docker         | 1 +
 tests/docker/dockerfiles/debian9.docker             | 1 +
 5 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/docker/dockerfiles/debian-sid.docker b/tests/docker/do=
ckerfiles/debian-sid.docker
index 676941cb32..9d65c15916 100644
--- a/tests/docker/dockerfiles/debian-sid.docker
+++ b/tests/docker/dockerfiles/debian-sid.docker
@@ -38,4 +38,5 @@ RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
         pkg-config \
         psmisc \
         python \
+        python3-sphinx \
         texinfo || { echo "Failed to build - see debian-sid.docker notes=
"; exit 1; }
diff --git a/tests/docker/dockerfiles/debian-xtensa-cross.docker b/tests/=
docker/dockerfiles/debian-xtensa-cross.docker
index afd2ab9163..3022940e64 100644
--- a/tests/docker/dockerfiles/debian-xtensa-cross.docker
+++ b/tests/docker/dockerfiles/debian-xtensa-cross.docker
@@ -18,7 +18,8 @@ RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
         flex \
         gettext \
         git \
-        python-minimal
+        python-minimal \
+        python3-sphinx
=20
 ENV CPU_LIST csp dc232b dc233c
 ENV TOOLCHAIN_RELEASE 2018.02
diff --git a/tests/docker/dockerfiles/debian10.docker b/tests/docker/dock=
erfiles/debian10.docker
index aeeb151b52..cf57d8218f 100644
--- a/tests/docker/dockerfiles/debian10.docker
+++ b/tests/docker/dockerfiles/debian10.docker
@@ -27,5 +27,6 @@ RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
         pkg-config \
         psmisc \
         python \
+        python3-sphinx \
         texinfo \
         $(apt-get -s build-dep qemu | egrep ^Inst | fgrep '[all]' | cut =
-d\  -f2)
diff --git a/tests/docker/dockerfiles/debian9-mxe.docker b/tests/docker/d=
ockerfiles/debian9-mxe.docker
index 5bc8a6d5c3..497c198731 100644
--- a/tests/docker/dockerfiles/debian9-mxe.docker
+++ b/tests/docker/dockerfiles/debian9-mxe.docker
@@ -17,6 +17,7 @@ RUN apt-get update
 RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
     apt-get install -y --no-install-recommends \
         libpython2.7-stdlib \
+        python3-sphinx \
         $(apt-get -s install -y --no-install-recommends gw32.shared-ming=
w-w64 | egrep "^Inst mxe-x86-64-unknown-" | cut -d\  -f2)
=20
 ENV PATH $PATH:/usr/lib/mxe/usr/bin/=20
diff --git a/tests/docker/dockerfiles/debian9.docker b/tests/docker/docke=
rfiles/debian9.docker
index 5f23a35404..52c589a7d6 100644
--- a/tests/docker/dockerfiles/debian9.docker
+++ b/tests/docker/dockerfiles/debian9.docker
@@ -27,5 +27,6 @@ RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
         pkg-config \
         psmisc \
         python \
+        python3-sphinx \
         texinfo \
         $(apt-get -s build-dep qemu | egrep ^Inst | fgrep '[all]' | cut =
-d\  -f2)
--=20
2.20.1


