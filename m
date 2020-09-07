Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B4AC433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 04:23:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01E0421775
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 04:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hXBQxoGR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01E0421775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kF8gP-0002zg-5l
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 00:23:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kF8dq-0006ta-As
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 00:20:33 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54319
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kF8do-0006yb-Mv
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 00:20:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599452427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IJ4slLay8b89rpTy43SAQf3zve8jR9BeHUD3qmKqNaw=;
 b=hXBQxoGR968zZsiGaGrcB9DGukHEPLxZIHL19J38dvYP8Si9UJ3z8aeTB32/cdZpVuECut
 H1uVOMO5DrIwPplNg4lASUiEs3xDwrsV6lYFAPRMoOtW34NPNqWJJcscC/zTBjT0UgnwTJ
 1BdbxPP0pS/NfsT7ZytiOcRCGI/Mfww=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-Bcf1S9CSN8CC9SzS1QLozw-1; Mon, 07 Sep 2020 00:20:19 -0400
X-MC-Unique: Bcf1S9CSN8CC9SzS1QLozw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0823180F040;
 Mon,  7 Sep 2020 04:20:17 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-120-166.rdu2.redhat.com
 [10.10.120.166])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A8621002D57;
 Mon,  7 Sep 2020 04:20:14 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/4] boot linux test: update arm bionic URL
Date: Mon,  7 Sep 2020 00:19:58 -0400
Message-Id: <20200907042000.415931-3-crosa@redhat.com>
In-Reply-To: <20200907042000.415931-1-crosa@redhat.com>
References: <20200907042000.415931-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/06 22:29:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sarah Harris <S.E.Harris@kent.ac.uk>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Thomas Huth <thuth@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Fabien Chouteau <chouteau@adacore.com>,
 qemu-arm@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Which uses an xz compressed file, which has builtin support for
decompression on avocado.utils.archive.  So the check for P7ZIP can be
dropped, and extraction logic simplified.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/acceptance/boot_linux_console.py | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 751b47b8fd..c75c512c8b 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -22,12 +22,6 @@ from avocado.utils import process
 from avocado.utils import archive
 from avocado.utils.path import find_command, CmdNotFoundError
 
-P7ZIP_AVAILABLE = True
-try:
-    find_command('7z')
-except CmdNotFoundError:
-    P7ZIP_AVAILABLE = False
-
 """
 Round up to next power of 2
 """
@@ -687,7 +681,6 @@ class BootLinuxConsole(LinuxKernelTest):
         self.vm.wait()
 
     @skipUnless(os.getenv('AVOCADO_ALLOW_LARGE_STORAGE'), 'storage limited')
-    @skipUnless(P7ZIP_AVAILABLE, '7z not installed')
     def test_arm_orangepi_bionic(self):
         """
         :avocado: tags=arch:arm
@@ -695,14 +688,13 @@ class BootLinuxConsole(LinuxKernelTest):
         :avocado: tags=device:sd
         """
 
-        # This test download a 196MB compressed image and expand it to 1GB
+        # This test download a 275MB compressed image and expand it to 1.1GB
         image_url = ('https://dl.armbian.com/orangepipc/archive/'
-                     'Armbian_19.11.3_Orangepipc_bionic_current_5.3.9.7z')
-        image_hash = '196a8ffb72b0123d92cea4a070894813d305c71e'
-        image_path_7z = self.fetch_asset(image_url, asset_hash=image_hash)
-        image_name = 'Armbian_19.11.3_Orangepipc_bionic_current_5.3.9.img'
-        image_path = os.path.join(self.workdir, image_name)
-        process.run("7z e -o%s %s" % (self.workdir, image_path_7z))
+                     'Armbian_20.08.1_Orangepipc_bionic_current_5.8.5.img.xz')
+        image_hash = 'b4d6775f5673486329e45a0586bf06b6dbe792199fd182ac6b9c7bb6c7d3e6dd'
+        image_path_xz = self.fetch_asset(image_url, asset_hash=image_hash,
+                                         algorithm='sha256')
+        image_path = archive.extract(image_path_xz, self.workdir)
         image_pow2ceil_expand(image_path)
 
         self.vm.set_console()
-- 
2.25.4


