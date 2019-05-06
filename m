Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633B7C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 05:19:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 311612082F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 05:19:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 311612082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50567 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNW20-0004TL-6J
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 01:19:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hNW17-00047T-Po
	for qemu-devel@nongnu.org; Mon, 06 May 2019 01:18:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hNW16-0000lk-S8
	for qemu-devel@nongnu.org; Mon, 06 May 2019 01:18:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37034)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>)
	id 1hNW16-0000kg-Mx; Mon, 06 May 2019 01:18:20 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 221343082E57;
	Mon,  6 May 2019 05:18:19 +0000 (UTC)
Received: from thuth.com (ovpn-116-74.ams2.redhat.com [10.36.116.74])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B357860C44;
	Mon,  6 May 2019 05:18:14 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  6 May 2019 07:18:10 +0200
Message-Id: <20190506051810.16493-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Mon, 06 May 2019 05:18:19 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] tests/Makefile: Remove unused test-obj-y
 variable
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I recently noticed that test-obj-y contains a file called
tests/check-block-qtest.o which simply does not belong to any .c
file and thus wondered why this is not causing any trouble.
Well, if I get the Makefile magic right, test-obj-y is not really
used for anything - and "make check" still works fine if we simply
remove it.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/Makefile.include | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 7c8b9c84b2..dfc4b7746f 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -482,25 +482,6 @@ GENERATED_FILES +=3D tests/test-qapi-types.h \
 	tests/test-qapi-events-sub-sub-module.h \
 	tests/test-qapi-introspect.h
=20
-test-obj-y =3D tests/check-qnum.o tests/check-qstring.o tests/check-qdic=
t.o \
-	tests/check-qlist.o tests/check-qnull.o tests/check-qobject.o \
-	tests/check-qjson.o tests/check-qlit.o \
-	tests/check-block-qtest.o \
-	tests/test-coroutine.o tests/test-string-output-visitor.o \
-	tests/test-string-input-visitor.o tests/test-qobject-output-visitor.o \
-	tests/test-clone-visitor.o \
-	tests/test-qobject-input-visitor.o \
-	tests/test-qmp-cmds.o tests/test-visitor-serialization.o \
-	tests/test-x86-cpuid.o tests/test-mul64.o tests/test-int128.o \
-	tests/test-opts-visitor.o tests/test-qmp-event.o \
-	tests/rcutorture.o tests/test-rcu-list.o \
-	tests/test-rcu-simpleq.o \
-	tests/test-rcu-tailq.o \
-	tests/test-qdist.o tests/test-shift128.o \
-	tests/test-qht.o tests/qht-bench.o tests/test-qht-par.o \
-	tests/atomic_add-bench.o tests/atomic64-bench.o
-
-$(test-obj-y): QEMU_INCLUDES +=3D -Itests
 QEMU_CFLAGS +=3D -I$(SRC_PATH)/tests
=20
=20
--=20
2.21.0


