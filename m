Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F66CC04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 21:36:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0B3B206BB
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 21:36:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0B3B206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43232 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZ03L-0003aF-3s
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 17:36:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51627)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <crosa@redhat.com>) id 1hYzu9-0005bq-BN
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 17:26:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1hYziU-00082g-Jh
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 17:14:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32972)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1hYziT-0007wy-5o
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 17:14:33 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A06FE3689B;
 Thu,  6 Jun 2019 21:14:27 +0000 (UTC)
Received: from dhcp-17-47.bos.redhat.com (dhcp-17-47.bos.redhat.com
 [10.18.17.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AEC371091EFD;
 Thu,  6 Jun 2019 21:14:26 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 17:14:11 -0400
Message-Id: <20190606211414.8681-5-crosa@redhat.com>
In-Reply-To: <20190606211414.8681-1-crosa@redhat.com>
References: <20190606211414.8681-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Thu, 06 Jun 2019 21:14:31 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v6 4/7] Acceptance tests: depend on qemu-img
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Samuel Ortiz <sameo@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Tests using the avocado.utils.vmimage library make use of qemu-img,
and because it makes sense to use the version matching the rest of the
source code, let's make sure it gets built.

Its selection, instead of a possible qemu-img binary installed system
wide, is already dealt with by the change that adds the build dir to
the PATH during the test execution.

This is based on the same work for qemu-iotests, and suggested by its
author:

  - https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg00951.html

CC: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Cleber Rosa <crosa@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/Makefile.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 991ad05aea..31fc6ec59c 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -1141,7 +1141,7 @@ $(TESTS_RESULTS_DIR):
=20
 check-venv: $(TESTS_VENV_DIR)
=20
-check-acceptance: check-venv $(TESTS_RESULTS_DIR)
+check-acceptance: check-venv $(TESTS_RESULTS_DIR) qemu-img$(EXESUF)
 	$(call quiet-command, \
             $(TESTS_VENV_DIR)/bin/python -m avocado \
             --show=3D$(AVOCADO_SHOW) run --job-results-dir=3D$(TESTS_RES=
ULTS_DIR) \
--=20
2.21.0


