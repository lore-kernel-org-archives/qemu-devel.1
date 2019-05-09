Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11436C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 08:24:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB41C208C3
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 08:24:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB41C208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50290 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOeLl-0006y4-2k
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 04:24:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hOeHT-00024T-Qr
	for qemu-devel@nongnu.org; Thu, 09 May 2019 04:19:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hOeHS-0000OF-Ta
	for qemu-devel@nongnu.org; Thu, 09 May 2019 04:19:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39858)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hOeHS-0000Ns-OE
	for qemu-devel@nongnu.org; Thu, 09 May 2019 04:19:54 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 16EAD3058951;
	Thu,  9 May 2019 08:19:54 +0000 (UTC)
Received: from thuth.com (ovpn-116-115.ams2.redhat.com [10.36.116.115])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 08C145B680;
	Thu,  9 May 2019 08:19:52 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Date: Thu,  9 May 2019 10:19:24 +0200
Message-Id: <20190509081930.19081-9-thuth@redhat.com>
In-Reply-To: <20190509081930.19081-1-thuth@redhat.com>
References: <20190509081930.19081-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Thu, 09 May 2019 08:19:54 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 08/14] tests/Makefile: Remove unused test-obj-y
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
Cc: ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I recently noticed that test-obj-y contains a file called
tests/check-block-qtest.o which simply does not belong to any .c
file and thus wondered why this is not causing any trouble. It is
only used to add -Itests to the command line (which refers to the
build directory). However, it is not needed because "-iquote $(@D)"
already sets this up in rules.mak. Thus we can simply remove this
variable.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20190508075527.32164-1-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/Makefile.include | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index af88ab6f8b..60de085ee1 100644
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


