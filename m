Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA63CC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 12:37:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD1162082E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 12:37:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD1162082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59112 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hECTw-00026y-1U
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 08:37:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hECSP-00011c-5O
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 08:36:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hECSO-0004jT-80
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 08:36:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37010)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hECSN-0004iA-WE
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 08:36:00 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 19787C0495BD;
	Wed, 10 Apr 2019 12:35:58 +0000 (UTC)
Received: from thuth.com (ovpn-116-114.ams2.redhat.com [10.36.116.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 92B8361994;
	Wed, 10 Apr 2019 12:35:53 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Stefan Weil <sw@weilnetz.de>,
	qemu-devel@nongnu.org
Date: Wed, 10 Apr 2019 14:35:50 +0200
Message-Id: <20190410123550.2362-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Wed, 10 Apr 2019 12:35:58 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH for-4.1] gitlab-ci.yml: Test the TCG
 interpreter in a CI pipeline
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, deller@gmx.de,
	philmd@redhat.com, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190410123550.TAjoJxUvXBCUxpjZ9C8W6SQ9wyazgFdD8-7_ub1xlpw@z>

So far we do not have any test coverage for TCI (the TCG interpreter) yet=
.
Thus let's add a CI pipeline that runs at least some basic TCG tests with
a TCI build, to make sure that there are no further regressions.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 NB: I did not include the sparc and sparc64 targets here since they are
 currently broken with TCI. Also "make check-tcg" does not work with
 x86_64-linux-user yet ... in case someone wants to fix that...

 .gitlab-ci.yml | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 79d02cf740..c63bf2f822 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -71,3 +71,18 @@ build-clang:
                      ppc-softmmu s390x-softmmu x86_64-softmmu arm-linux-=
user"
  - make -j2
  - make -j2 check
+
+build-tci:
+ script:
+ - TARGETS=3D"aarch64 alpha arm hppa m68k microblaze moxie ppc64 s390x x=
86_64"
+ - ./configure --enable-tcg-interpreter
+      --target-list=3D"$(for tg in $TARGETS; do echo -n ${tg}'-softmmu '=
; done)"
+ - make -j2
+ - make tests/boot-serial-test tests/cdrom-test tests/pxe-test
+ - for tg in $TARGETS ; do
+     export QTEST_QEMU_BINARY=3D"${tg}-softmmu/qemu-system-${tg}" ;
+     ./tests/boot-serial-test || exit 1 ;
+     ./tests/cdrom-test || exit 1 ;
+   done
+ - QTEST_QEMU_BINARY=3D"x86_64-softmmu/qemu-system-x86_64" ./tests/pxe-t=
est
+ - QTEST_QEMU_BINARY=3D"s390x-softmmu/qemu-system-s390x" ./tests/pxe-tes=
t -m slow
--=20
2.21.0


