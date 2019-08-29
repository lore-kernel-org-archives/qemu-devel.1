Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB63C3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 01:14:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AE2A22CED
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 01:14:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AE2A22CED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3911-0007zK-5A
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 21:14:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45088)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1i38zY-0006yN-FM
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 21:12:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1i38zX-0000Ot-GZ
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 21:12:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46672)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1i38zX-0000Oi-Bt
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 21:12:47 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A1C80190C01B;
 Thu, 29 Aug 2019 01:12:46 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-123-242.rdu2.redhat.com
 [10.10.123.242])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 78DFC5D784;
 Thu, 29 Aug 2019 01:12:45 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 21:12:37 -0400
Message-Id: <20190829011237.29954-2-crosa@redhat.com>
In-Reply-To: <20190829011237.29954-1-crosa@redhat.com>
References: <20190829011237.29954-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Thu, 29 Aug 2019 01:12:46 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 5/5] VNC Acceptance test: simplify test names
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The test name is composed of the class name and method name, so it
looks like there's some redundancy here that we can eliminate.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20190607152223.9467-7-crosa@redhat.com>
Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/acceptance/vnc.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/acceptance/vnc.py b/tests/acceptance/vnc.py
index 064ceabcc1..3f40bc2be1 100644
--- a/tests/acceptance/vnc.py
+++ b/tests/acceptance/vnc.py
@@ -34,7 +34,7 @@ class Vnc(Test):
         self.assertEqual(set_password_response['error']['desc'],
                          'Could not set password')
=20
-    def test_vnc_change_password_requires_a_password(self):
+    def test_change_password_requires_a_password(self):
         self.vm.add_args('-nodefaults', '-S', '-vnc', ':0')
         self.vm.launch()
         self.assertTrue(self.vm.qmp('query-vnc')['return']['enabled'])
@@ -48,7 +48,7 @@ class Vnc(Test):
         self.assertEqual(set_password_response['error']['desc'],
                          'Could not set password')
=20
-    def test_vnc_change_password(self):
+    def test_change_password(self):
         self.vm.add_args('-nodefaults', '-S', '-vnc', ':0,password')
         self.vm.launch()
         self.assertTrue(self.vm.qmp('query-vnc')['return']['enabled'])
--=20
2.21.0


