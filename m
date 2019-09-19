Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A04DC3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 16:15:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2F3C21907
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 16:15:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2F3C21907
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAz5x-0006x3-Gd
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 12:15:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41295)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iAz4I-00065m-Dt
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 12:14:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iAz4G-0000ac-9T
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 12:14:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57770)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1iAz4F-0000aR-Ua
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 12:14:04 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DDF6D18CB8E7
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 16:14:02 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-123-8.rdu2.redhat.com
 [10.10.123.8])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D4C55D9CC;
 Thu, 19 Sep 2019 16:14:01 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] Acceptance test machine_m68k_nextcube.py: relax the error
 code pattern
Date: Thu, 19 Sep 2019 12:14:00 -0400
Message-Id: <20190919161400.26399-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Thu, 19 Sep 2019 16:14:03 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Willian Rampazzo <wrampazz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of looking for a specific error, let's relax the pattern
because different errors have been seen (I'm consistenly getting 52)
and the real goal of this test is to validate the framebuffer
operation, and not to reproduce one specific error.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/acceptance/machine_m68k_nextcube.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/acceptance/machine_m68k_nextcube.py b/tests/acceptance=
/machine_m68k_nextcube.py
index e09cab9f20..fcd2c58ee7 100644
--- a/tests/acceptance/machine_m68k_nextcube.py
+++ b/tests/acceptance/machine_m68k_nextcube.py
@@ -116,6 +116,6 @@ class NextCubeMachine(Test):
             if len(line):
                 console_logger.debug(line)
         self.assertIn('Testing the FPU, SCC', text)
-        self.assertIn('System test failed. Error code 51', text)
+        self.assertIn('System test failed. Error code', text)
         self.assertIn('Boot command', text)
         self.assertIn('Next>', text)
--=20
2.21.0


