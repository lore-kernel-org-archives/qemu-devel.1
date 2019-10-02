Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A99BC35280
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 14:23:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43A03215EA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 14:23:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43A03215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFfWx-0005Qs-AT
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 10:23:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37939)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iFfVv-0004O6-7H
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 10:22:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iFfVt-00057i-6f
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 10:21:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49724)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>)
 id 1iFfVp-00054m-Kn; Wed, 02 Oct 2019 10:21:53 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3182E4E924;
 Wed,  2 Oct 2019 14:21:52 +0000 (UTC)
Received: from thuth.com (ovpn-116-20.ams2.redhat.com [10.36.116.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B9EBF608A5;
 Wed,  2 Oct 2019 14:21:50 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Max Reitz <mreitz@redhat.com>,
	qemu-block@nongnu.org
Subject: [PATCH] iotests: Do not run the iotests during "make check" anymore
Date: Wed,  2 Oct 2019 16:21:46 +0200
Message-Id: <20191002142146.6124-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Wed, 02 Oct 2019 14:21:52 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Running the iotests during "make check" is causing more headaches than
benefits for the block layer maintainers, so let's disable the iotests
during "make check" again.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/Makefile.include   | 2 +-
 tests/qemu-iotests/group | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 3543451ed3..5d19f39ee7 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -1172,7 +1172,7 @@ check-acceptance: check-venv $(TESTS_RESULTS_DIR)
 check-qapi-schema: $(patsubst %,check-%, $(check-qapi-schema-y)) check-tests/qapi-schema/doc-good.texi
 check-qtest: $(patsubst %,check-qtest-%, $(QTEST_TARGETS))
 check-block: $(patsubst %,check-%, $(check-block-y))
-check: check-block check-qapi-schema check-unit check-softfloat check-qtest check-decodetree
+check: check-qapi-schema check-unit check-softfloat check-qtest check-decodetree
 check-clean:
 	rm -rf $(check-unit-y) tests/*.o $(QEMU_IOTESTS_HELPERS-y)
 	rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LIST), $(check-qtest-$(target)-y)) $(check-qtest-generic-y))
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 5d3da937e4..246cf9aa65 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -10,7 +10,7 @@
 #
 # - img : Tests in this group can be used to excercise the qemu-img tool.
 #
-# - auto : Tests in this group are used during "make check" and should be
+# - auto : Tests in this group are usable in all environments and should be
 #   runnable in any case. That means they should run with every QEMU binary
 #   (also non-x86), with every QEMU configuration (i.e. must not fail if
 #   an optional feature is not compiled in - but reporting a "skip" is ok),
-- 
2.18.1


