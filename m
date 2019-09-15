Return-Path: <SRS0=GetT=XK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70AFEC4CEC7
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 21:22:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A7BC2067D
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 21:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YS9kei0b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A7BC2067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9byn-0005Z3-Vf
	for qemu-devel@archiver.kernel.org; Sun, 15 Sep 2019 17:22:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51323)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i9bw0-0003GU-Vd
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 17:19:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i9bvz-0000kr-C0
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 17:19:52 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:32820)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i9bvx-0000if-1S; Sun, 15 Sep 2019 17:19:49 -0400
Received: by mail-wm1-x344.google.com with SMTP id r17so5898959wme.0;
 Sun, 15 Sep 2019 14:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8IBywZXkQNnx0L71ILHAIGyPxwnwRKwuHd+1ukGBNdg=;
 b=YS9kei0bP7wBfvRHfAHZPgKxvJt5bWUzBdkAGgRdA7W/wRgdDsTYMUFci2F2AR8KPe
 MdmteF0KRdA1pj0LVvIQu9wqtx4fgPmtbQlXeysZtBxncPe7/R+1GygcFWZtuq3XaaDl
 kASfsHyaLHke5mSLEdpgqhZ9ikiq6OHClEce3Fp5UG8KQKYeLDzQPkaxVR6lIZvdJ3ZO
 FkvltamulKty6sErObsUK5Uka8Z4tq2tfip7yQQ7hd9KjNObAeGAwR0kRmIcZphMk+bw
 sYI1LGcj1fM677V6FD9E1RxsZvRFg4s7X+sw4IQcX0oNaFPAbuDb7frNRyj8FsW4LTAS
 BR4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=8IBywZXkQNnx0L71ILHAIGyPxwnwRKwuHd+1ukGBNdg=;
 b=k/CRC4bp4d2xGm8niVyfjqRdQRuci0WqGEMkOR/UOjfMcGGOgn/Fn/x5aVNAZTMuOu
 ioGg1V4fNY46/IbYKy4djdbBuLUmvqgbwUaoAyFJhOjtzm8E6sBgaZD0nV0zY5/PDfUc
 ifBI0lpkoKTsjkbX+4QplTzxeuWj6KPFrPdfPuMwE/I1Ej0vc2b3J9/R6nWoeAMVfLlP
 Du0F8q7G9vGl2c/R5pn1mIxihqRQB7Dqrvgh49LlCntxBQXXZVxHf4kKZYeH532A2fG9
 annlll2p5pvq95StLR2kYROsRKWUOPuf6gIMKtPMW4Rmt3aFrdX5bd7uAs2feeJNHBPl
 4uWg==
X-Gm-Message-State: APjAAAVIAUAorerdmE9Z1HrQaWtL96KbJPiB1dbmuVxtQwCNPAo+nNew
 y9xNUSMDXgg8QHd9tm/kvzWeAB0J
X-Google-Smtp-Source: APXvYqytrS9DYCeMEOkgTVNgCmMt58qtMZFEASlDGSY87gen3r2Dx5pRZNnHXGHXPfaREgQXYO0Ucw==
X-Received: by 2002:a7b:cb8b:: with SMTP id m11mr4020474wmi.145.1568582387895; 
 Sun, 15 Sep 2019 14:19:47 -0700 (PDT)
Received: from localhost.localdomain (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id s1sm50271021wrg.80.2019.09.15.14.19.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Sep 2019 14:19:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org
Date: Sun, 15 Sep 2019 23:19:36 +0200
Message-Id: <20190915211940.30427-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190915211940.30427-1-f4bug@amsat.org>
References: <20190915211940.30427-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH v2 2/6] tests/acceptance: Test Open Firmware on
 the PReP/40p
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
 Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Kamil Rytarowski <kamil@netbsd.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

User case from:
https://tyom.blogspot.com/2019/04/aixprep-under-qemu-how-to.html

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/acceptance/ppc_prep_40p.py | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tests/acceptance/ppc_prep_40p.py b/tests/acceptance/ppc_prep_40p.py
index 53f2d2ecf0..a0eac40d9f 100644
--- a/tests/acceptance/ppc_prep_40p.py
+++ b/tests/acceptance/ppc_prep_40p.py
@@ -61,3 +61,24 @@ class IbmPrep40pMachine(Test):
         os_banner = 'NetBSD 4.0 (GENERIC) #0: Sun Dec 16 00:49:40 PST 2007'
         self.wait_for_console_pattern(os_banner)
         self.wait_for_console_pattern('Model: IBM PPS Model 6015')
+
+    def test_openfirmware(self):
+        """
+        :avocado: tags=arch:ppc
+        :avocado: tags=machine:40p
+        """
+        bios_url = ('https://github.com/artyom-tarasenko/openfirmware/'
+                    'releases/download/40p-20190413/q40pofw-serial.rom')
+        bios_hash = '880c80172ea5b2247c0ac2a8bf36bbe385192c72'
+        bios_path = self.fetch_asset(bios_url, asset_hash=bios_hash)
+
+        self.vm.set_machine('40p')
+        self.vm.set_console()
+        self.vm.add_args('-bios', bios_path)
+
+        self.vm.launch()
+        self.wait_for_console_pattern('QEMU PReP/40p')
+        fw_banner = 'Open Firmware, built  April 13, 2019 09:29:23'
+        self.wait_for_console_pattern(fw_banner)
+        prompt_msg = 'Type any key to interrupt automatic startup'
+        self.wait_for_console_pattern(prompt_msg)
-- 
2.20.1


