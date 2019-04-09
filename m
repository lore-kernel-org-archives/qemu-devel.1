Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94870C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 23:08:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6659720830
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 23:08:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6659720830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50289 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDzqr-0002oz-IC
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 19:08:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hDzk4-0005tM-Vl
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 19:01:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hDzk3-0001gR-Ub
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 19:01:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40808)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hDzk3-0001ed-Kh
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 19:01:23 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 512F8C059B9F;
	Tue,  9 Apr 2019 23:01:22 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-120-114.rdu2.redhat.com
	[10.10.120.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B93081001DC0;
	Tue,  9 Apr 2019 23:01:17 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: berrange@redhat.com, eblake@redhat.com, f4bug@amsat.org,
	imammedo@redhat.com, kraxel@redhat.com, mprivozn@redhat.com,
	mst@redhat.com, peter.maydell@linaro.org, philmd@redhat.com,
	qemu-devel@nongnu.org
Date: Wed, 10 Apr 2019 01:00:20 +0200
Message-Id: <20190409230022.6462-11-lersek@redhat.com>
In-Reply-To: <20190409230022.6462-1-lersek@redhat.com>
References: <20190409230022.6462-1-lersek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Tue, 09 Apr 2019 23:01:22 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH for-4.1 v4 10/12] tests: add missing dependency
 to build QTEST_QEMU_BINARY, round 2
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
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190409230020.Rvmno7AVVC5a-8SdXr8UhsWlr8QD_lRU0YAl8QlwZZM@z>

In commit b94b330e2333 ("tests: add missing dependency to build
QTEST_QEMU_BINARY", 2017-07-31), Phil fixed the dependency list of make
target "check-qtest-%". Namely, the recipe would set QTEST_QEMU_BINARY to
the softmmu emulator for the emulation target, but the prerequisites
didn't include the emulator.

The same issue affects the "check-report-qtest-%.tap" make target, which
is the other make target whose recipe sets QTEST_QEMU_BINARY:

> $ make -j4 check-report-qtest-aarch64.tap
>   TAP     check-report-qtest-aarch64.tap
> sh: /.../aarch64-softmmu/qemu-system-aarch64: No such file or directory

Apply Phil's fix to this make target too.

Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Michal Privoznik <mprivozn@redhat.com>
Tested-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---

Notes:
    v4:
   =20
    - no change
   =20
    v3:
   =20
    - pick up Michal's R-b
   =20
    - pick up Igor's T-b
   =20
    - pick up Michael's R-b
   =20
    v2:
   =20
    - new patch, relied upon by the next patch

 tests/Makefile.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 36fc73fef55a..e2432d5e7712 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -912,7 +912,7 @@ check-speed: $(check-speed-y)
=20
 # gtester tests with TAP output
=20
-$(patsubst %, check-report-qtest-%.tap, $(QTEST_TARGETS)): check-report-=
qtest-%.tap: $(check-qtest-y)
+$(patsubst %, check-report-qtest-%.tap, $(QTEST_TARGETS)): check-report-=
qtest-%.tap: subdir-%-softmmu $(check-qtest-y)
 	$(call do_test_tap, $(check-qtest-$*-y) $(check-qtest-generic-y), \
 	  QTEST_QEMU_BINARY=3D$*-softmmu/qemu-system-$* \
 	  QTEST_QEMU_IMG=3Dqemu-img$(EXESUF))
--=20
2.19.1.3.g30247aa5d201



