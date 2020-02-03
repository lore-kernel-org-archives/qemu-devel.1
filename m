Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831C5C33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 12:41:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47DAA20721
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 12:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iZ2T02JM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47DAA20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyb2R-0000UI-EV
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 07:41:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56400)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iyazh-0004Af-DL
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:38:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iyazg-0005tR-6d
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:38:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46617
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iyazg-0005tG-2j
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:38:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580733503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JBL9YxUk9otLkAzIzzLN7sC1OctGE8a3LO68IHZ9IY8=;
 b=iZ2T02JMVAvGQLBMednB3k8qyM9QNwwMWM+s1rd57x9qDahgE7gSwIfFOk3AJHR8VjjU9r
 KJuxrNOGyNbUWv7UXjvoYEPhI1KTtnnagHWzpcdAiipikqtPCiK6FnaoSiqfAJQxUucUma
 PEHeN/U2JYzin/GIcvPSoPePaB1rNiI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-JBz9lyIfNWm7GlCUmGKF1g-1; Mon, 03 Feb 2020 07:38:21 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B256C1800D41;
 Mon,  3 Feb 2020 12:38:20 +0000 (UTC)
Received: from thuth.com (ovpn-116-129.ams2.redhat.com [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BEC0E61070;
 Mon,  3 Feb 2020 12:38:19 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 03/13] docs/devel: Fix qtest paths and info about check-block
 in testing.rst
Date: Mon,  3 Feb 2020 13:38:01 +0100
Message-Id: <20200203123811.8651-4-thuth@redhat.com>
In-Reply-To: <20200203123811.8651-1-thuth@redhat.com>
References: <20200203123811.8651-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: JBz9lyIfNWm7GlCUmGKF1g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The qtests have recently been moved to a separate subdirectory, so
the paths that are mentioned in the documentation have to be adjusted
accordingly. And some of the iotests are now always run as part of
"make check", so this information has to be adjusted here, too.

Message-Id: <20200122134511.23806-1-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/devel/testing.rst | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index ab5be0c729..770a987ea4 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -16,8 +16,8 @@ The usual way to run these tests is:
=20
   make check
=20
-which includes QAPI schema tests, unit tests, and QTests. Different sub-ty=
pes
-of "make check" tests will be explained below.
+which includes QAPI schema tests, unit tests, QTests and some iotests.
+Different sub-types of "make check" tests will be explained below.
=20
 Before running tests, it is best to build QEMU programs first. Some tests
 expect the executables to exist and will fail with obscure messages if the=
y
@@ -79,8 +79,8 @@ QTest cases can be executed with
=20
    make check-qtest
=20
-The QTest library is implemented by ``tests/libqtest.c`` and the API is de=
fined
-in ``tests/libqtest.h``.
+The QTest library is implemented by ``tests/qtest/libqtest.c`` and the API=
 is
+defined in ``tests/qtest/libqtest.h``.
=20
 Consider adding a new QTest case when you are introducing a new virtual
 hardware, or extending one if you are adding functionalities to an existin=
g
@@ -94,20 +94,20 @@ libqos instead of directly calling into libqtest.
 Steps to add a new QTest case are:
=20
 1. Create a new source file for the test. (More than one file can be added=
 as
-   necessary.) For example, ``tests/test-foo-device.c``.
+   necessary.) For example, ``tests/qtest/foo-test.c``.
=20
 2. Write the test code with the glib and libqtest/libqos API. See also exi=
sting
    tests and the library headers for reference.
=20
-3. Register the new test in ``tests/Makefile.include``. Add the test execu=
table
-   name to an appropriate ``check-qtest-*-y`` variable. For example:
+3. Register the new test in ``tests/qtest/Makefile.include``. Add the test
+   executable name to an appropriate ``check-qtest-*-y`` variable. For exa=
mple:
=20
-   ``check-qtest-generic-y =3D tests/test-foo-device$(EXESUF)``
+   ``check-qtest-generic-y =3D tests/qtest/foo-test$(EXESUF)``
=20
 4. Add object dependencies of the executable in the Makefile, including th=
e
    test source file(s) and other interesting objects. For example:
=20
-   ``tests/test-foo-device$(EXESUF): tests/test-foo-device.o $(libqos-obj-=
y)``
+   ``tests/qtest/foo-test$(EXESUF): tests/qtest/foo-test.o $(libqos-obj-y)=
``
=20
 Debugging a QTest failure is slightly harder than the unit test because th=
e
 tests look up QEMU program names in the environment variables, such as
@@ -152,8 +152,9 @@ parser (either fixing a bug or extending/modifying the =
syntax). To do this:
 check-block
 -----------
=20
-``make check-block`` is a legacy command to invoke block layer iotests and=
 is
-rarely used. See "QEMU iotests" section below for more information.
+``make check-block`` runs a subset of the block layer iotests (the tests t=
hat
+are in the "auto" group in ``tests/qemu-iotests/group``).
+See the "QEMU iotests" section below for more information.
=20
 GCC gcov support
 ----------------
--=20
2.18.1


