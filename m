Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC8FC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 17:32:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1123C20737
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 17:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P+AsQ5gh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1123C20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKQAj-0001hg-3s
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 13:32:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50725)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jKQ8j-0008Dd-DK
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 13:29:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jKQ8h-0006tZ-VU
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 13:29:57 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34879
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jKQ8h-0006sz-RU
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 13:29:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585934995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7zxFWSnwEr7wQyiJn7le/YzMjxHi5h5bPrTAJxUsH48=;
 b=P+AsQ5gh0BrBNlsxlUxQBH1PLdJc26Wmw0buIigHYeNvZcN8Br850j9Kgx6ta8ikRCDYJI
 JQSwGNCjG2+AtrILCyllCjepvxposBkQIdlKWeyEflvheEiZM2lbzkbDuTsXldH4xy9UYl
 JwL2ecUgtoBh0VeRRkmlDo1XlF0fNOU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-nMDsObwwMQuGJmS41vk0Vg-1; Fri, 03 Apr 2020 13:29:50 -0400
X-MC-Unique: nMDsObwwMQuGJmS41vk0Vg-1
Received: by mail-ed1-f69.google.com with SMTP id f19so6091097edt.5
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 10:29:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=haUYeeLGAxNBF8H7XOXC1rR3I734Y2RfSUCB+A+SRMc=;
 b=k1/AarvLZEDPySgX5n1A2fA66l+aSyUbR3NXKFdKK+lTJKQB/5t2CX9TT6OG6EBF0F
 s8BAxuCLVD3NjzOjwnkWxkt4A8PsMTrHwJb47IW+j4s3uzrj0NtPuw2wBDDOmzHNhGWF
 VRTrkCeT/NfGlzwXnn11tZnHsVwjux5bIQ2+3b9Mb5ydmgZ2qAuS6hW1nhxkufZsLgiz
 RnRDvJUWIr1y8ennnmHDklfEtMVVLrljmTLvWyI66rygy/2M8ZTXqdQr6yDzpI8CptLf
 2jN8eDbbLMVMCejItd/UZuBZhkutvnWk2N4kl4el0Ha7/wAtax9j4D8H7YRhOGZQC9R4
 d9+A==
X-Gm-Message-State: AGi0PuYoVHAePDDUGqfJhrR6eqgaVAAann8kSuhDRXBTYffmunHY1b1V
 ScTayDbb01F9qVP+ly5relbGeAcBYj0Zg113osmRq6jPabNAsQIOPnJaj5V7hjLOY9Nz/H7MdIn
 OQx+UHPCRUkiY7Wk=
X-Received: by 2002:a17:906:7694:: with SMTP id
 o20mr9499382ejm.253.1585934989109; 
 Fri, 03 Apr 2020 10:29:49 -0700 (PDT)
X-Google-Smtp-Source: APiQypLjc+KGkyt13eeSs9fySD3mnrhWzyX+ZoYtNVWkHigVGQG1AP2F03AWz32VUzyfdHhFPvuPyA==
X-Received: by 2002:a17:906:7694:: with SMTP id
 o20mr9499362ejm.253.1585934988827; 
 Fri, 03 Apr 2020 10:29:48 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id y27sm1768387ejr.37.2020.04.03.10.29.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2020 10:29:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 4/8] tests/acceptance/machine_sparc_leon3: Disable
 HelenOS test
Date: Fri,  3 Apr 2020 19:29:15 +0200
Message-Id: <20200403172919.24621-5-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200403172919.24621-1-philmd@redhat.com>
References: <20200403172919.24621-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 Richard Henderson <richard.henderson@linaro.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Fabien Chouteau <chouteau@adacore.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Kamil Rytarowski <kamil@netbsd.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

This test was written/tested around beginning of 2019, but was
extracted from a bigger series and posted end of June 2019 [*].
Unfortunately I did not notice commit 162abf1a8 was merged by
then, which implements the AHB and APB plug and play devices.

HelenOS 0.6 is expecting the PnP registers to be not implemented
by QEMU, then forces the discovered AMBA devices (see [2]).

Before 162abf1a8, the console was displaying:

  HelenOS bootloader, release 0.6.0 (Elastic Horse)
  Built on 2014-12-21 20:17:42 for sparc32
  Copyright (c) 2001-2014 HelenOS project
   0x4000bf20|0x4000bf20: kernel image (496640/128466 bytes)
   0x4002b4f2|0x4002b4f2: ns image (154195/66444 bytes)
   0x4003b87e|0x4003b87e: loader image (153182/66437 bytes)
   0x4004bc03|0x4004bc03: init image (155339/66834 bytes)
   0x4005c115|0x4005c115: locsrv image (162063/70267 bytes)
   0x4006d390|0x4006d390: rd image (152678/65889 bytes)
   0x4007d4f1|0x4007d4f1: vfs image (168480/73394 bytes)
   0x4008f3a3|0x4008f3a3: logger image (158034/68368 bytes)
   0x4009feb3|0x4009feb3: ext4fs image (234510/100301 bytes)
   0x400b8680|0x400b8680: initrd image (8388608/1668901 bytes)
  ABMA devices:
  <1:00c> at 0x80000100 irq 3
  <1:00d> at 0x80000200
  <1:011> at 0x80000300 irq 8
  Memory size: 64 MB

As of this commit, it is now confused:

  ABMA devices:
  <1:3000> at 0x00000000 irq 0
  <1:3000> at 0x00000000 irq 0
  <1:3000> at 0x00000000 irq 0
  <1:3000> at 0x00000000 irq 0
  <1:3000> at 0x00000000 irq 0
  <1:3000> at 0x00000000 irq 0
  <1:3000> at 0x00000000 irq 0
  ...

As this test is not working as expected, simply disable it (by
skipping it) for now.

[1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg627094.html
[2] https://github.com/HelenOS/helenos/blob/0.6.0/boot/arch/sparc32/src/amb=
app.c#L75

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20200331105048.27989-2-f4bug@amsat.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/acceptance/machine_sparc_leon3.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/acceptance/machine_sparc_leon3.py b/tests/acceptance/mac=
hine_sparc_leon3.py
index f77e210ccb..2405cd7a0d 100644
--- a/tests/acceptance/machine_sparc_leon3.py
+++ b/tests/acceptance/machine_sparc_leon3.py
@@ -7,12 +7,16 @@
=20
 from avocado_qemu import Test
 from avocado_qemu import wait_for_console_pattern
+from avocado import skip
=20
=20
 class Leon3Machine(Test):
=20
     timeout =3D 60
=20
+    @skip("Test currently broken")
+    # A Window Underflow exception occurs before booting the kernel,
+    # and QEMU exit calling cpu_abort(), which makes this test to fail.
     def test_leon3_helenos_uimage(self):
         """
         :avocado: tags=3Darch:sparc
--=20
2.21.1


