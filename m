Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFAF1C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 18:07:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C44E21A4A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 18:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t7wXGZvq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C44E21A4A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDYB5-0007m2-Oq
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 14:07:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59113)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iDXgV-0004lz-9B
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 13:36:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iDXgU-00037J-4h
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 13:36:07 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33347)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iDXgT-00036d-V9; Thu, 26 Sep 2019 13:36:06 -0400
Received: by mail-wm1-f66.google.com with SMTP id r17so7136180wme.0;
 Thu, 26 Sep 2019 10:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Z54O11bD1AbofRei7LiG1f1sZB2nRqAkLzkY3rTTmZI=;
 b=t7wXGZvq12V5hEcgfvWVIZ+8SGse2gghokboAfHp0r+y6hhBb7A6uUVCAUdjhkDuOJ
 f2H0Zwf7hpMlRI7IyR4roEyhRs21f/LUXCd3wPGbFioe4Ii5uUe/t247FcsMbTMDJf9G
 wDEd9bgC7FXkFYJe5L+eYClcAcfxPH3DERjK4QelVCp24B+tQmg8/DeuK2FSwUuwoOGv
 LGv9NdF0hW0BjD/XdEgRn9EjN8GZ4yZ0MM/akgUq+Pu5k0FA/t7pOkYY/Ptqn17C6U1c
 unKCATtFbHK91Udn7J5rCbRMoLfKbfJvZkBNENokX1ZLDFz+MVqeuN51GanpmpYm8jXW
 p/mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Z54O11bD1AbofRei7LiG1f1sZB2nRqAkLzkY3rTTmZI=;
 b=cDVMv8GkPAcYxaG3dkZOnXUgS3UWa3q8ypfhT7tLWLxhwp8aUsIVPfzcoTugrfp+j3
 DZQrEIZgQPLJ1LnKCK2gfTJiYCDuYjQbVWgHgX5QqAMgUeO9jJYh2pNipCMRdg1FIkl9
 tVZ/NsndvX8OO8dGF8uwkxKWqr2d0R+PuJKP8T2I+HwUv3K2H8lfXkNCAsrE1sAS/tsx
 W1/0CX+/9wNl7csIDGOTiNWWwOnUen0md3edxna9dFEK194OafMjfPgg+9kwq25h6x+3
 F1dN1fpcx+adBLyzsMpyXStAjrgAglszD/2w+3fMqrO0FXHU16PqQPlJjaliUNllc6Rj
 TM6w==
X-Gm-Message-State: APjAAAXkkYAv/nvuV+3l6C+slXmAbuJ50VjQOoWtjPmfPk38Z7a797FR
 wr7uCMeXdGyve11N8yq9tSVjMqosV6U=
X-Google-Smtp-Source: APXvYqzyJvZSIbnP9uUtga136B5UFGxyORKIr07OuneVC0JWA5G6Wf2m+c89CBudBofQo57In7+BPg==
X-Received: by 2002:a1c:1981:: with SMTP id 123mr3901961wmz.88.1569519304847; 
 Thu, 26 Sep 2019 10:35:04 -0700 (PDT)
Received: from x1w.redhat.com (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id b186sm9918980wmd.16.2019.09.26.10.35.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2019 10:35:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 15/19] tests/boot_linux_console: Extract the gunzip() helper
Date: Thu, 26 Sep 2019 19:34:23 +0200
Message-Id: <20190926173428.10713-16-f4bug@amsat.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190926173428.10713-1-f4bug@amsat.org>
References: <20190926173428.10713-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
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
 =?UTF-8?q?Zolt=C3=A1n=20Baldaszti?= <bztemail@gmail.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Esteban Bosse <estebanbosse@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, Clement Deschamps <clement.deschamps@antfield.fr>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Guenter Roeck <linux@roeck-us.net>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are going to use the same pattern. Instead of keeping
copy/pasting this code, extract as a local function.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/acceptance/boot_linux_console.py | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 8a9a314ab4..079590f0c8 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -19,6 +19,11 @@ from avocado.utils import process
 from avocado.utils import archive
 
 
+def gunzip(in_pathname_gz, out_pathname):
+    with gzip.open(in_pathname_gz, 'rb') as f_in:
+        with open(out_pathname, 'wb') as f_out:
+            shutil.copyfileobj(f_in, f_out)
+
 class BootLinuxConsole(Test):
     """
     Boots a Linux kernel and checks that the console is operational and the
@@ -166,10 +171,7 @@ class BootLinuxConsole(Test):
         initrd_hash = 'bf806e17009360a866bf537f6de66590de349a99'
         initrd_path_gz = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
         initrd_path = self.workdir + "rootfs.cpio"
-
-        with gzip.open(initrd_path_gz, 'rb') as f_in:
-            with open(initrd_path, 'wb') as f_out:
-                shutil.copyfileobj(f_in, f_out)
+        gunzip(initrd_path_gz, initrd_path)
 
         self.vm.set_machine('malta')
         self.vm.set_console()
-- 
2.20.1


