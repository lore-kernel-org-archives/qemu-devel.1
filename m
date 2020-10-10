Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91385C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 08:04:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31D56207CD
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 08:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ASdlEzLP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31D56207CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kR9rz-0004PA-Ai
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 04:04:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kR9lJ-00045B-5M
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 03:57:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26933)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kR9lF-0006gS-Qe
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 03:57:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602316669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3lqNTXOaQxr2pFa/d900G8RiBNMQcy/fBz5WEaqc9co=;
 b=ASdlEzLPy12Ng4PrZnEG/mui2sa3Lx4ZhRY6Cqsq27o8Zv/mU1s5kte1bUbaWruWSynFEf
 huEyItKewv7t0xuq6NfejnubjFSWSMCMQhLOMsd65pRvSyTqwUyhROth8Opi5xO4ztPilG
 34ruBocBnWWkt2g3kmVWIbArQMeBMUY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-520-HgKSAX4JNZWx9WAfbizDmg-1; Sat, 10 Oct 2020 03:57:47 -0400
X-MC-Unique: HgKSAX4JNZWx9WAfbizDmg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B5151005E61
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2020 07:57:46 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EF3466EF6E;
 Sat, 10 Oct 2020 07:57:45 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 15/39] docs: Move QTest documentation to its own document
Date: Sat, 10 Oct 2020 03:57:15 -0400
Message-Id: <20201010075739.951385-16-pbonzini@redhat.com>
In-Reply-To: <20201010075739.951385-1-pbonzini@redhat.com>
References: <20201010075739.951385-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/10 03:36:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eduardo Habkost <ehabkost@redhat.com>

The qtest and libqtest doc comments will be parsed to generate
API documentation, so move QTest documentation to its own
document where the API and format documentation and will be
included.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Acked-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20201005205228.697463-2-ehabkost@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/index.rst   |  1 +
 docs/devel/qtest.rst   | 58 ++++++++++++++++++++++++++++++++++++++++++
 docs/devel/testing.rst | 47 ++--------------------------------
 3 files changed, 61 insertions(+), 45 deletions(-)
 create mode 100644 docs/devel/qtest.rst

diff --git a/docs/devel/index.rst b/docs/devel/index.rst
index 5fda2d3509..77baae5c77 100644
--- a/docs/devel/index.rst
+++ b/docs/devel/index.rst
@@ -21,6 +21,7 @@ Contents:
    atomics
    stable-process
    testing
+   qtest
    decodetree
    secure-coding-practices
    tcg
diff --git a/docs/devel/qtest.rst b/docs/devel/qtest.rst
new file mode 100644
index 0000000000..86dec84a0b
--- /dev/null
+++ b/docs/devel/qtest.rst
@@ -0,0 +1,58 @@
+========================================
+QTest Device Emulation Testing Framework
+========================================
+
+QTest is a device emulation testing framework.  It can be very useful to test
+device models; it could also control certain aspects of QEMU (such as virtual
+clock stepping), with a special purpose "qtest" protocol.  Refer to the
+documentation in ``qtest.c`` for more details of the protocol.
+
+QTest cases can be executed with
+
+.. code::
+
+   make check-qtest
+
+The QTest library is implemented by ``tests/qtest/libqtest.c`` and the API is
+defined in ``tests/qtest/libqtest.h``.
+
+Consider adding a new QTest case when you are introducing a new virtual
+hardware, or extending one if you are adding functionalities to an existing
+virtual device.
+
+On top of libqtest, a higher level library, ``libqos``, was created to
+encapsulate common tasks of device drivers, such as memory management and
+communicating with system buses or devices. Many virtual device tests use
+libqos instead of directly calling into libqtest.
+
+Steps to add a new QTest case are:
+
+1. Create a new source file for the test. (More than one file can be added as
+   necessary.) For example, ``tests/qtest/foo-test.c``.
+
+2. Write the test code with the glib and libqtest/libqos API. See also existing
+   tests and the library headers for reference.
+
+3. Register the new test in ``tests/qtest/Makefile.include``. Add the test
+   executable name to an appropriate ``check-qtest-*-y`` variable. For example:
+
+   ``check-qtest-generic-y = tests/qtest/foo-test$(EXESUF)``
+
+4. Add object dependencies of the executable in the Makefile, including the
+   test source file(s) and other interesting objects. For example:
+
+   ``tests/qtest/foo-test$(EXESUF): tests/qtest/foo-test.o $(libqos-obj-y)``
+
+Debugging a QTest failure is slightly harder than the unit test because the
+tests look up QEMU program names in the environment variables, such as
+``QTEST_QEMU_BINARY`` and ``QTEST_QEMU_IMG``, and also because it is not easy
+to attach gdb to the QEMU process spawned from the test. But manual invoking
+and using gdb on the test is still simple to do: find out the actual command
+from the output of
+
+.. code::
+
+  make check-qtest V=1
+
+which you can run manually.
+
diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index bd64c1bdcd..a171494b4e 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -70,8 +70,8 @@ QTest
 
 QTest is a device emulation testing framework.  It can be very useful to test
 device models; it could also control certain aspects of QEMU (such as virtual
-clock stepping), with a special purpose "qtest" protocol.  Refer to the
-documentation in ``qtest.c`` for more details of the protocol.
+clock stepping), with a special purpose "qtest" protocol.  Refer to
+:doc:`qtest` for more details.
 
 QTest cases can be executed with
 
@@ -79,49 +79,6 @@ QTest cases can be executed with
 
    make check-qtest
 
-The QTest library is implemented by ``tests/qtest/libqtest.c`` and the API is
-defined in ``tests/qtest/libqtest.h``.
-
-Consider adding a new QTest case when you are introducing a new virtual
-hardware, or extending one if you are adding functionalities to an existing
-virtual device.
-
-On top of libqtest, a higher level library, ``libqos``, was created to
-encapsulate common tasks of device drivers, such as memory management and
-communicating with system buses or devices. Many virtual device tests use
-libqos instead of directly calling into libqtest.
-
-Steps to add a new QTest case are:
-
-1. Create a new source file for the test. (More than one file can be added as
-   necessary.) For example, ``tests/qtest/foo-test.c``.
-
-2. Write the test code with the glib and libqtest/libqos API. See also existing
-   tests and the library headers for reference.
-
-3. Register the new test in ``tests/qtest/Makefile.include``. Add the test
-   executable name to an appropriate ``check-qtest-*-y`` variable. For example:
-
-   ``check-qtest-generic-y = tests/qtest/foo-test$(EXESUF)``
-
-4. Add object dependencies of the executable in the Makefile, including the
-   test source file(s) and other interesting objects. For example:
-
-   ``tests/qtest/foo-test$(EXESUF): tests/qtest/foo-test.o $(libqos-obj-y)``
-
-Debugging a QTest failure is slightly harder than the unit test because the
-tests look up QEMU program names in the environment variables, such as
-``QTEST_QEMU_BINARY`` and ``QTEST_QEMU_IMG``, and also because it is not easy
-to attach gdb to the QEMU process spawned from the test. But manual invoking
-and using gdb on the test is still simple to do: find out the actual command
-from the output of
-
-.. code::
-
-  make check-qtest V=1
-
-which you can run manually.
-
 QAPI schema tests
 -----------------
 
-- 
2.26.2



