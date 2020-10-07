Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB7BC4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 08:05:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E6532076C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 08:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aqjqt1eW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E6532076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ4SH-0003k9-GG
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 04:05:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41752)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQ4Qu-0002N3-BF
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 04:04:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46429)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQ4Qq-0006Na-Pl
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 04:04:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602057856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7q0Ah9KSZZ/kpRn+4tLfiJdP3mhaU0uL1D4E1MRABcM=;
 b=Aqjqt1eWtsUCfS/4tzb1fR3//iQLoB3rM117HZGH09HIXgdTDFCrpJTfGRB1EmbO+oXXdT
 Jyp+ozveN0MSHcElvNpMbxhg3oeUXpZX8hudf7Fmtq9gn5ToyE1JGYFL38uamvGWryxPw3
 wUDPCMlXIhfBbqLE1lvY7i5yffDQuxc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-Qet8eC-IOOe9tBJJd1Tkfg-1; Wed, 07 Oct 2020 04:04:14 -0400
X-MC-Unique: Qet8eC-IOOe9tBJJd1Tkfg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A2D718FE884
 for <qemu-devel@nongnu.org>; Wed,  7 Oct 2020 08:03:13 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 51DBC55797
 for <qemu-devel@nongnu.org>; Wed,  7 Oct 2020 08:03:13 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] docs/devel: update instruction on how to add new unit
 tests
Date: Wed,  7 Oct 2020 04:03:12 -0400
Message-Id: <20201007080312.566464-3-pbonzini@redhat.com>
In-Reply-To: <20201007080312.566464-1-pbonzini@redhat.com>
References: <20201007080312.566464-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:54:30
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The instructions for adding new unit tests were not in
build-system.rst and therefore I missed them in the Meson
conversion.  Just like with the Makefile code there are
some magic variables to be aware of, so document them.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/qtest.rst   | 30 +++++++++++++++++++++---------
 docs/devel/testing.rst | 19 ++++++++++---------
 2 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/docs/devel/qtest.rst b/docs/devel/qtest.rst
index 075fe5f7d5..97c5a75626 100644
--- a/docs/devel/qtest.rst
+++ b/docs/devel/qtest.rst
@@ -33,15 +33,27 @@ Steps to add a new QTest case are:
 2. Write the test code with the glib and libqtest/libqos API. See also existing
    tests and the library headers for reference.
 
-3. Register the new test in ``tests/qtest/Makefile.include``. Add the test
-   executable name to an appropriate ``check-qtest-*-y`` variable. For example:
-
-   ``check-qtest-generic-y = tests/qtest/foo-test$(EXESUF)``
-
-4. Add object dependencies of the executable in the Makefile, including the
-   test source file(s) and other interesting objects. For example:
-
-   ``tests/qtest/foo-test$(EXESUF): tests/qtest/foo-test.o $(libqos-obj-y)``
+3. Register the new test in ``tests/qtest/meson.build``. Add the test
+   executable name to an appropriate ``qtests_*`` variable. There is
+   one variable per architecture, plus ``qtests_generic`` for tests
+   that can be run for all architectures.  For example::
+
+     qtests_generic = [
+       ...
+       'foo-test',
+       ...
+     ]
+
+4. If the test has more than one source file or needs to be linked with any
+   dependency other than ``qemuutil`` and ``qos``, list them in the ``qtests``
+   dictionary.  For example a test that needs to use the ``QIO`` library
+   will have an entry like::
+
+     {
+       ...
+       'foo-test': [io],
+       ...
+     }
 
 Debugging a QTest failure is slightly harder than the unit test because the
 tests look up QEMU program names in the environment variables, such as
diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index a171494b4e..cecee6eaa1 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -41,15 +41,16 @@ add a new unit test:
    test. The test code should be organized with the glib testing framework.
    Copying and modifying an existing test is usually a good idea.
 
-3. Add the test to ``tests/Makefile.include``. First, name the unit test
-   program and add it to ``$(check-unit-y)``; then add a rule to build the
-   executable.  For example:
-
-.. code::
-
-  check-unit-y += tests/foo-test$(EXESUF)
-  tests/foo-test$(EXESUF): tests/foo-test.o $(test-util-obj-y)
-  ...
+3. Add the test to ``tests/meson.build``. The unit tests are listed in a
+   dictionary called ``tests``.  The values are any additional sources and
+   dependencies to be linked with the test.  For a simple test whose source
+   is in ``tests/foo-test.c``, it is enough to add an entry like::
+
+     {
+       ...
+       'foo-test': [],
+       ...
+     }
 
 Since unit tests don't require environment variables, the simplest way to debug
 a unit test failure is often directly invoking it or even running it under
-- 
2.26.2


