Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F03C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 20:54:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 697882078E
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 20:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BJlP9S7E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 697882078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPXV8-0003Cj-IJ
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 16:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40594)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kPXTL-0001Uz-AQ
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 16:52:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48133)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kPXTJ-0005pM-EP
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 16:52:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601931156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FWkmw4jnNLa7e3WcK8lioDh1h4GLfEcOUGIGYwjsRmI=;
 b=BJlP9S7EEXqEdnwpRYNIHK7TPh7J67LrVSjKcK2GLYo3x8FnjnmrlL/bkMIj0qx4MQ+Gxc
 7x5tvlRPh2FSHyZ85Llmyzw9PecOYNagYDA2845KP6QA1kNZN9RpBW32O8zkm7yGAJV5Ev
 YHoSVrltJ9t5co4itnfA5B1QH4uph5w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-SkYGjG08NJyxM9AGBmVDNg-1; Mon, 05 Oct 2020 16:52:34 -0400
X-MC-Unique: SkYGjG08NJyxM9AGBmVDNg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B0A28801AE2
 for <qemu-devel@nongnu.org>; Mon,  5 Oct 2020 20:52:33 +0000 (UTC)
Received: from localhost (ovpn-119-102.rdu2.redhat.com [10.10.119.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4664678800;
 Mon,  5 Oct 2020 20:52:33 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] docs: Move QTest documentation to its own document
Date: Mon,  5 Oct 2020 16:52:26 -0400
Message-Id: <20201005205228.697463-2-ehabkost@redhat.com>
In-Reply-To: <20201005205228.697463-1-ehabkost@redhat.com>
References: <20201005205228.697463-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 02:11:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The qtest and libqtest doc comments will be parsed to generate
API documentation, so move QTest documentation to its own
document where the API and format documentation and will be
included.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 docs/devel/index.rst   |  1 +
 docs/devel/qtest.rst   | 58 ++++++++++++++++++++++++++++++++++++++++++
 docs/devel/testing.rst | 47 ++--------------------------------
 3 files changed, 61 insertions(+), 45 deletions(-)
 create mode 100644 docs/devel/qtest.rst

diff --git a/docs/devel/index.rst b/docs/devel/index.rst
index c34b43ec28e..d147b900a98 100644
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
index 00000000000..86dec84a0ba
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
index bd64c1bdcdd..a171494b4e5 100644
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


