Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBEBEC43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 16:18:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDC352081C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 16:18:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDC352081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54056 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMEPY-0008Ri-0k
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 12:18:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hMEKu-00048I-0V
	for qemu-devel@nongnu.org; Thu, 02 May 2019 12:13:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hMEKt-0002JP-5V
	for qemu-devel@nongnu.org; Thu, 02 May 2019 12:13:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42520)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hMEKt-0002JD-02
	for qemu-devel@nongnu.org; Thu, 02 May 2019 12:13:27 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 45C233151C40;
	Thu,  2 May 2019 16:13:26 +0000 (UTC)
Received: from thuth.com (ovpn-116-131.ams2.redhat.com [10.36.116.131])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7B55E17D58;
	Thu,  2 May 2019 16:13:24 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Date: Thu,  2 May 2019 18:13:03 +0200
Message-Id: <20190502161310.15624-2-thuth@redhat.com>
In-Reply-To: <20190502161310.15624-1-thuth@redhat.com>
References: <20190502161310.15624-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Thu, 02 May 2019 16:13:26 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 1/8] gitlab-ci.yml: Test the TCG interpreter in
 a CI pipeline
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
Cc: Eduardo Otubo <otubo@redhat.com>, Helge Deller <deller@gmx.de>,
	Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190502161303.XEsWKxWzkLVbS331d7KOH34HgAqsTdv8olEvfE7UFyg@z>

So far we do not have any test coverage for TCI (the TCG interpreter) yet=
.
Thus let's add a CI pipeline that runs at least some basic TCG tests with
a TCI build, to make sure that there are no further regressions.

Message-Id: <20190410123550.2362-1-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
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


