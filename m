Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F9E5C04AA9
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 00:43:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7D6A2070B
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 00:43:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7D6A2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60452 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMMIJ-0004bL-6v
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 20:43:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hMMGg-0003QF-3s
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:41:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hMMGf-0006fO-3n
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:41:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47546)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hMMGe-0006ea-UW
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:41:37 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 92FEF308FF14;
	Fri,  3 May 2019 00:41:34 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 22ADC1001E61;
	Fri,  3 May 2019 00:41:33 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
	Cleber Rosa <crosa@redhat.com>
Date: Thu,  2 May 2019 21:41:12 -0300
Message-Id: <20190503004130.8285-2-ehabkost@redhat.com>
In-Reply-To: <20190503004130.8285-1-ehabkost@redhat.com>
References: <20190503004130.8285-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Fri, 03 May 2019 00:41:34 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 01/19] tests/acceptance: show avocado test
 execution by default
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
Message-ID: <20190503004112.t__MfyEn4y1Qu-GmoIuePM1vlhFXApMm5b_HLiIS3Ug@z>

From: Cleber Rosa <crosa@redhat.com>

The current version of the "check-acceptance" target will only show
one line for execution of all tests.  That's probably OK if the tests
to be run are quick enough and they're always the same.

But, there's already one test alone that takes on average ~5 seconds
to run, we intend to adapt the list of tests to match the user's build
environment (among other choices).

Because of that, let's present the default Avocado UI by default.
Users can always choose a different output by setting the AVOCADO_SHOW
variable.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
Reviewed-by: Caio Carrara <ccarrara@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20190312171824.5134-2-crosa@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 .travis.yml            | 2 +-
 tests/Makefile.include | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 2e06aee9d0..e6f951e01a 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -224,7 +224,7 @@ matrix:
     # Acceptance (Functional) tests
     - env:
         - CONFIG=3D"--python=3D/usr/bin/python3 --target-list=3Dx86_64-s=
oftmmu"
-        - TEST_CMD=3D"make AVOCADO_SHOW=3Dapp check-acceptance"
+        - TEST_CMD=3D"make check-acceptance"
       addons:
         apt:
           packages:
diff --git a/tests/Makefile.include b/tests/Makefile.include
index e2432d5e77..445aa0bb12 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -1133,7 +1133,7 @@ TESTS_RESULTS_DIR=3D$(BUILD_DIR)/tests/results
 # Controls the output generated by Avocado when running tests.
 # Any number of command separated loggers are accepted.  For more
 # information please refer to "avocado --help".
-AVOCADO_SHOW=3Dnone
+AVOCADO_SHOW=3Dapp
=20
 ifneq ($(findstring v2,"v$(PYTHON_VERSION)"),v2)
 $(TESTS_VENV_DIR): $(TESTS_VENV_REQ)
--=20
2.18.0.rc1.1.g3f1ff2140


