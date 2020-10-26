Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26311C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:38:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EECF20791
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QoiMBOjh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EECF20791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWztY-0001MP-30
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 06:38:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kWzPU-0003LX-QP
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:07:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35412)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kWzPS-0006qG-UD
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:07:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603706845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eYu3EUAAaV9viSHuaicHSt5ZTnVbdYj7opK/cMyTMLQ=;
 b=QoiMBOjhizDOGbk1fokwVXpdhywk8w5s3W0QgNtOAxuNvE5R/LUk/ILyvW3vTsCd8UDoCF
 6u1kEo/4BcM9S0QVEVPV5LNcx7ZX+eQZiJiknRlNlCRQQHkj/BNFIEDzzGhRJnNoo4flm4
 dcR1ngVdZIIMB9PwLZSoD33FnD24BWc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-MUsGFFKqP0ahGQ9ucqvyGw-1; Mon, 26 Oct 2020 06:07:23 -0400
X-MC-Unique: MUsGFFKqP0ahGQ9ucqvyGw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B271910E2185;
 Mon, 26 Oct 2020 10:07:22 +0000 (UTC)
Received: from thuth.com (ovpn-112-104.ams2.redhat.com [10.36.112.104])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A5FF78B840;
 Mon, 26 Oct 2020 10:07:21 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 31/31] tests/acceptance: Use .ppm extention for Portable PixMap
 files
Date: Mon, 26 Oct 2020 11:06:32 +0100
Message-Id: <20201026100632.212530-32-thuth@redhat.com>
In-Reply-To: <20201026100632.212530-1-thuth@redhat.com>
References: <20201026100632.212530-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Alexander Bulekov <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

The HMP 'screendump' command generates Portable PixMap files.
Make it obvious by using the .ppm file extention.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20201021105035.2477784-3-f4bug@amsat.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/acceptance/machine_m68k_nextcube.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/acceptance/machine_m68k_nextcube.py b/tests/acceptance/machine_m68k_nextcube.py
index 9d289f2fab..2baba5fdc2 100644
--- a/tests/acceptance/machine_m68k_nextcube.py
+++ b/tests/acceptance/machine_m68k_nextcube.py
@@ -69,7 +69,7 @@ class NextCubeMachine(Test):
 
     @skipUnless(PIL_AVAILABLE, 'Python PIL not installed')
     def test_bootrom_framebuffer_size(self):
-        screenshot_path = os.path.join(self.workdir, "dump.png")
+        screenshot_path = os.path.join(self.workdir, "dump.ppm")
         self.check_bootrom_framebuffer(screenshot_path)
 
         width, height = Image.open(screenshot_path).size
@@ -78,7 +78,7 @@ class NextCubeMachine(Test):
 
     @skipUnless(tesseract_available(3), 'tesseract v3 OCR tool not available')
     def test_bootrom_framebuffer_ocr_with_tesseract_v3(self):
-        screenshot_path = os.path.join(self.workdir, "dump.png")
+        screenshot_path = os.path.join(self.workdir, "dump.ppm")
         self.check_bootrom_framebuffer(screenshot_path)
 
         console_logger = logging.getLogger('console')
@@ -94,7 +94,7 @@ class NextCubeMachine(Test):
     # that it is still alpha-level software.
     @skipUnless(tesseract_available(4), 'tesseract v4 OCR tool not available')
     def test_bootrom_framebuffer_ocr_with_tesseract_v4(self):
-        screenshot_path = os.path.join(self.workdir, "dump.png")
+        screenshot_path = os.path.join(self.workdir, "dump.ppm")
         self.check_bootrom_framebuffer(screenshot_path)
 
         console_logger = logging.getLogger('console')
-- 
2.18.2


