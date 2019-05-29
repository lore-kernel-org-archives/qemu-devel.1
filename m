Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85AC2C28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 15:11:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B7C423B8C
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 15:11:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B7C423B8C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56027 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hW0Eo-0000Tl-LX
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 11:11:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hW0CJ-00075v-U5
	for qemu-devel@nongnu.org; Wed, 29 May 2019 11:09:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hW0CI-0001tv-L7
	for qemu-devel@nongnu.org; Wed, 29 May 2019 11:08:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57066)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hW0CI-0001ta-FL
	for qemu-devel@nongnu.org; Wed, 29 May 2019 11:08:58 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5EED73179B53
	for <qemu-devel@nongnu.org>; Wed, 29 May 2019 15:08:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-250.ams2.redhat.com
	[10.36.117.250])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2DFA32BE68
	for <qemu-devel@nongnu.org>; Wed, 29 May 2019 15:08:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 9BBDF11384AA; Wed, 29 May 2019 17:08:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 29 May 2019 17:08:51 +0200
Message-Id: <20190529150853.9772-2-armbru@redhat.com>
In-Reply-To: <20190529150853.9772-1-armbru@redhat.com>
References: <20190529150853.9772-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Wed, 29 May 2019 15:08:57 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 1/3] MAINTAINERS: Drop redundant L:
 qemu-devel@nongnu.org
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Redundant since commit c9a19d5b95 "MAINTAINERS: add all-match entry
for qemu-devel@".

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 MAINTAINERS | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1f5f8b7a2c..edc260e503 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -109,7 +109,6 @@ L: qemu-s390x@nongnu.org
 Guest CPU cores (TCG):
 ----------------------
 Overall
-L: qemu-devel@nongnu.org
 M: Richard Henderson <rth@twiddle.net>
 R: Paolo Bonzini <pbonzini@redhat.com>
 S: Maintained
@@ -444,19 +443,16 @@ F: util/*posix*.c
 F: include/qemu/*posix*.h
=20
 NETBSD
-L: qemu-devel@nongnu.org
 M: Kamil Rytarowski <kamil@netbsd.org>
 S: Maintained
 K: ^Subject:.*(?i)NetBSD
=20
 OPENBSD
-L: qemu-devel@nongnu.org
 M: Brad Smith <brad@comstyle.com>
 S: Maintained
 K: ^Subject:.*(?i)OpenBSD
=20
 W32, W64
-L: qemu-devel@nongnu.org
 M: Stefan Weil <sw@weilnetz.de>
 S: Maintained
 F: *win32*
@@ -565,7 +561,6 @@ F: include/hw/*/digic*
 Gumstix
 M: Peter Maydell <peter.maydell@linaro.org>
 R: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
-L: qemu-devel@nongnu.org
 L: qemu-arm@nongnu.org
 S: Odd Fixes
 F: hw/arm/gumstix.c
@@ -1044,7 +1039,6 @@ F: pc-bios/qemu_vga.ndrv
=20
 PReP
 M: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
-L: qemu-devel@nongnu.org
 L: qemu-ppc@nongnu.org
 S: Maintained
 F: hw/ppc/prep.c
@@ -1831,7 +1825,6 @@ S: Supported
 F: scripts/coverity-model.c
=20
 CPU
-L: qemu-devel@nongnu.org
 S: Supported
 F: qom/cpu.c
 F: include/qom/cpu.h
@@ -2566,7 +2559,6 @@ F: qapi/rdma.json
=20
 Semihosting
 M: Alex Benn=C3=A9e <alex.bennee@linaro.org>
-L: qemu-devel@nongnu.org
 S: Maintained
 F: hw/semihosting/
 F: include/hw/semihosting/
@@ -2577,7 +2569,6 @@ Build and test automation
 M: Alex Benn=C3=A9e <alex.bennee@linaro.org>
 M: Fam Zheng <fam@euphon.net>
 R: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
-L: qemu-devel@nongnu.org
 S: Maintained
 F: .travis.yml
 F: scripts/travis/
@@ -2592,7 +2583,6 @@ W: http://patchew.org/QEMU/
 FreeBSD Hosted Continuous Integration
 M: Ed Maste <emaste@freebsd.org>
 M: Li-Wen Hsu <lwhsu@freebsd.org>
-L: qemu-devel@nongnu.org
 S: Maintained
 F: .cirrus.yml
 W: https://cirrus-ci.com/github/qemu/qemu
@@ -2608,7 +2598,6 @@ R: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
 S: Maintained
 F: tests/tcg/Makefile
 F: tests/tcg/Makefile.include
-L: qemu-devel@nongnu.org
=20
 Documentation
 -------------
--=20
2.17.2


