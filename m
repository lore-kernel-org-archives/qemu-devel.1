Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1A4C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 20:47:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44EDC2074F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 20:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="asd9TYr8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44EDC2074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS4jR-0004vD-CE
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 16:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38210)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kS4WK-0002o3-5c
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 16:34:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59265)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kS4WG-0002gi-Hl
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 16:34:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602534846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=To/RlZTdSWB81QtAACloeGypq7cNBP6LP2iZrPTnSVQ=;
 b=asd9TYr87txI66JnSIyhxkVKHds3Z2SPlPx9ItUqmC+Fq/VTBbtkXXOR0QG4/cIZYPfLlV
 7s5ILOP+x02kxraL73SZ7RtFthclZ8lzrZ4aW5cHZYus/zhiRnV3uHTO4fkKKCNiJ63YXm
 J5F4vkAQgdG2c3ISo+Ww3aJ2D73Y+rs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-j-2Aioi0PkOftmdlANL1WA-1; Mon, 12 Oct 2020 16:34:03 -0400
X-MC-Unique: j-2Aioi0PkOftmdlANL1WA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F33C68030CB
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 20:33:52 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C02015D9CD
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 20:33:52 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 18/38] docs/devel: update instruction on how to add new unit
 tests
Date: Mon, 12 Oct 2020 16:33:23 -0400
Message-Id: <20201012203343.1105018-19-pbonzini@redhat.com>
In-Reply-To: <20201012203343.1105018-1-pbonzini@redhat.com>
References: <20201012203343.1105018-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 16:33:53
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
index e58389b29f..0c3e79d31c 100644
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



