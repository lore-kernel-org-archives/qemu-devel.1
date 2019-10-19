Return-Path: <SRS0=HPkn=YN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B8CCA9EAC
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2019 00:00:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EB3321925
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2019 00:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHIT9ZPO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EB3321925
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLyeP-0000Zl-RJ
	for qemu-devel@archiver.kernel.org; Sat, 19 Oct 2019 20:00:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34739)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLyRm-0000aq-Cm
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 19:47:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLyRl-0005iD-7F
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 19:47:46 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:56110)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLyRl-0005hf-1O; Sat, 19 Oct 2019 19:47:45 -0400
Received: by mail-wm1-x341.google.com with SMTP id g24so376098wmh.5;
 Sat, 19 Oct 2019 16:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sDpiMGEUPQUF/TV44CGVPcZd/e7Sj4qme0DvnCotwpc=;
 b=bHIT9ZPOmznRUfoWaH671prkuZ3TyavtCuD+zujvrT3wUiMjdvalUWu8kMv5szr7T3
 fL4Hn0gBiDKjRyYoqGR58yvT9C8ekSLKxOLF4NuX1ixATEDq0qPnY+4xLMzMpNZLcN1h
 Vo++HuZCdBaOTQ3Q9s974+73NWFpz4KcMY3xlFeyglAnrV0+EdCQn9wcGSZWmMiyfVeH
 EbTXbqWcfMGZ1Z4RNhhZoWOsPGOzlDsom+FXq2JhI1E0X0QZ5lc16KHXV+/HAizh5W+h
 9jaGJD7V+mo69tATxfSHq4EMewuxi4I23RbwlwYknt0XRME/+tIW6JTmbKboO4tYp2OW
 wCHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=sDpiMGEUPQUF/TV44CGVPcZd/e7Sj4qme0DvnCotwpc=;
 b=YsnG+aJD42aLA01mDDKjgi7AEgEtX2S9u3ZaFWqZEuvE9mBoYJ9czMFGbJilfv97EV
 vdHQPh05vfWnqy9ta+fAfCqJQpVoGzP261TVpsnos6f4YjifYotMgofTtz7YaRSytVsG
 oZSV4vjx4Z87RIBAG2wDRnwYviWIIvkBwRUHfMf0YsF2r+JsTpbdxb4r06Cq3BZCyirP
 pMaFCX4cKgS1FJJemCYfYU13ZGZKvWO6j5oge0IdCmovQIpQA97Hvz/faW+J+HGgzLWr
 WocdePhccWwuVDQbAlQvf3eFz6Zq/MYaPXd8sfAzmpZjBksKlpLiRnY6NvCafy5QBnpH
 ojKw==
X-Gm-Message-State: APjAAAU25XzbmjZHg+IHNmT24N4opMK23OCyH7xKWPa4XBe/KkIVmtVo
 WRXLO9W8CdNmI38FS8+39duqDIhj
X-Google-Smtp-Source: APXvYqwDfG0U3ptzDATMLEzP27Ht6FTTvadMTeCt1yV+TwIA4oRNgobrRnxJk+d7hewkohdZYptc0Q==
X-Received: by 2002:a7b:ce89:: with SMTP id q9mr13124748wmj.2.1571528863895;
 Sat, 19 Oct 2019 16:47:43 -0700 (PDT)
Received: from x1w.redhat.com (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id u1sm10433763wrp.56.2019.10.19.16.47.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2019 16:47:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 15/16] python/qemu/machine: Allow to use other serial
 consoles than default
Date: Sun, 20 Oct 2019 01:47:14 +0200
Message-Id: <20191019234715.25750-16-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191019234715.25750-1-f4bug@amsat.org>
References: <20191019234715.25750-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
 Matthias Brugger <mbrugger@suse.com>, Rob Herring <robh@kernel.org>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, "Emilio G . Cota" <cota@braap.org>,
 Clement Deschamps <clement.deschamps@antfield.fr>, qemu-arm@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Laurent Bonnans <laurent.bonnans@here.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Pete Batard <pete@akeo.ie>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently the QEMU Python module limits the QEMUMachine class to
use the first serial console.

Some machines/guest might use another console than the first one as
the 'boot console'. For example the Raspberry Pi uses the second
(AUX) console.

To be able to use the Nth console as default, we simply need to
connect all the N - 1 consoles to the null chardev.

Add an index argument, so we can use a specific serial console as
default.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v2:
- renamed 'console_index', added docstring (Cleber)
- reworded description (pm215)
---
 python/qemu/machine.py | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index 128a3d1dc2..6fa68fa35a 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -235,6 +235,8 @@ class QEMUMachine(object):
                 '-display', 'none', '-vga', 'none']
         if self._machine is not None:
             args.extend(['-machine', self._machine])
+        for i in range(self._console_index):
+            args.extend(['-serial', 'null'])
         if self._console_set:
             self._console_address = os.path.join(self._temp_dir,
                                                  self._name + "-console.sock")
@@ -495,7 +497,7 @@ class QEMUMachine(object):
         """
         self._machine = machine_type
 
-    def set_console(self, device_type=None):
+    def set_console(self, device_type=None, console_index=0):
         """
         Sets the device type for a console device
 
@@ -516,9 +518,14 @@ class QEMUMachine(object):
                             chardev:console" command line argument will
                             be used instead, resorting to the machine's
                             default device type.
+        @param console_index: the index of the console device to use.
+                              If not zero, the command line will create
+                              'index - 1' consoles and connect them to
+                              the 'null' backing character device.
         """
         self._console_set = True
         self._console_device_type = device_type
+        self._console_index = console_index
 
     @property
     def console_socket(self):
-- 
2.21.0


