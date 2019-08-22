Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F2CC3A5A3
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 13:51:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7F53233FC
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 13:51:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7F53233FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0nV5-00005T-9N
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 09:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44869)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1i0nRK-0006UL-O2
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 09:47:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1i0nRJ-00061Z-Po
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 09:47:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60896)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1i0nRJ-000616-K1
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 09:47:45 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E854611A06;
 Thu, 22 Aug 2019 13:47:44 +0000 (UTC)
Received: from localhost (ovpn-116-85.phx2.redhat.com [10.3.116.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2EAE060605;
 Thu, 22 Aug 2019 13:47:35 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 22 Aug 2019 17:47:20 +0400
Message-Id: <20190822134725.32479-2-marcandre.lureau@redhat.com>
In-Reply-To: <20190822134725.32479-1-marcandre.lureau@redhat.com>
References: <20190822134725.32479-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Thu, 22 Aug 2019 13:47:45 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 1/6] docker.py: add --run-as-current-user
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
Cc: Fam Zheng <fam@euphon.net>, peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 alex.bennee@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

(podman will need further tweaks)

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 tests/docker/Makefile.include | 2 +-
 tests/docker/docker.py        | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.includ=
e
index dbd58e548c..582846a587 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -212,7 +212,7 @@ docker-run: docker-qemu-src
 			"  COPYING $(EXECUTABLE) to $(IMAGE)"))
 	$(call quiet-command,						\
 		$(DOCKER_SCRIPT) run 					\
-			$(if $(NOUSER),,-u $(shell id -u)) 		\
+			$(if $(NOUSER),,--run-as-current-user) 		\
 			--security-opt seccomp=3Dunconfined		\
 			$(if $V,,--rm) 					\
 			$(if $(DEBUG),-ti,)				\
diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 53a8c9c801..f15545aeea 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -333,8 +333,13 @@ class RunCommand(SubCommand):
     def args(self, parser):
         parser.add_argument("--keep", action=3D"store_true",
                             help=3D"Don't remove image when command comp=
letes")
+        parser.add_argument("--run-as-current-user", action=3D"store_tru=
e",
+                            help=3D"Run container using the current user=
's uid")
=20
     def run(self, args, argv):
+        if args.run_as_current_user:
+            uid =3D os.getuid()
+            argv =3D [ "-u", str(uid) ] + argv
         return Docker().run(argv, args.keep, quiet=3Dargs.quiet)
=20
=20
--=20
2.23.0


