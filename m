Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A9EECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 17:40:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9E9120820
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 17:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUwtdt6j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9E9120820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL9lf-00062k-RK
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 13:40:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42677)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iL91K-0001MX-87
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:53:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iL91I-0006fK-VN
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:53:02 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44911)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iL91I-0006ex-PT; Thu, 17 Oct 2019 12:53:00 -0400
Received: by mail-wr1-x441.google.com with SMTP id z9so3150437wrl.11;
 Thu, 17 Oct 2019 09:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=W3lDbtSLeZg4TWsSDmT9Hq865HvTVpc0V+8V7NXclu8=;
 b=OUwtdt6j7N5beDeBxn3dccdXtqfseu8bSnVJeEmqiXZVeSi3weIas7Wy3fsHyv69W7
 3Z3gc3odMDkgRTmsVgx45P0HXeH2PR0NDh0BdHEbmjPTOCajM5/1J3L+qwKCdzgANy2A
 JEe30xShhXbagJqq9AKJRyunVypDzYYjnQasqARhZucPis3oMggzYAZoE+gLOcFbcvDc
 OQo3EqfepzUPYEa687XGmwH5T8Sv0Y4dnLe6q/N9+xKtOAFJY+cK1Xg0dDFLtAWoiYbW
 WAVSOXi3wi4pZIAdarxDgbPyibm9Oq7x66qtQQAUQnOt5cff058oR6rR8Sv0vXSdFCF8
 qkhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=W3lDbtSLeZg4TWsSDmT9Hq865HvTVpc0V+8V7NXclu8=;
 b=dFp2f82+qrdB+eFfrFYfGeSPupuqzz/FJsECeH3YZyUE+XWbKumuTpGdIDfTpDxVIn
 3ALCINJtgLz2ktxmtNoKZgE72Kj3m0Ya7HWlbdSHqxnm7XXoYSmwi4XfTU+poFlCYhMv
 5ffnfaJ+dTw86MX8iYVEu/0tahWRA3ajCauaMqcrg08F9MS5hdT5Yo2TDI98HvaM507h
 7jeiftCeWQRZlBhJHTAXWEXkEr4IK0di7abxXqhQL5FNTRn25jFQGsLJoPrl+mAUWhRQ
 khCJ5YcOouJ7mO7qY1QWzTyMsWrSy2bZByJZP8dhSaBAwRR4QycEu5OiSjTplOdzBGKa
 rtdw==
X-Gm-Message-State: APjAAAVnTyaWKuHG63rj/o6oi7uthuzcYZ2KbNzbrDjP2USecLAJxwHi
 J7DY2vHgFGjEAz48GG+euZHrHcjWFrc=
X-Google-Smtp-Source: APXvYqw9LGShEM8pAGmIsW1ahlKrMkjI1Tv9QpM4UtZVNngiTjqcSM14rJ8b2SO2PFIavsu6r1ALSw==
X-Received: by 2002:a5d:44c6:: with SMTP id z6mr3806851wrr.313.1571331179651; 
 Thu, 17 Oct 2019 09:52:59 -0700 (PDT)
Received: from x1w.redhat.com (243.red-88-26-246.staticip.rima-tde.net.
 [88.26.246.243])
 by smtp.gmail.com with ESMTPSA id w22sm2557363wmc.16.2019.10.17.09.52.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 09:52:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 7/9] tests/acceptance: Test OpenBIOS on the PReP/40p
Date: Thu, 17 Oct 2019 18:52:37 +0200
Message-Id: <20191017165239.30159-8-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191017165239.30159-1-f4bug@amsat.org>
References: <20191017165239.30159-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Kamil Rytarowski <kamil@netbsd.org>, qemu-ppc@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

User case from:
https://mail.coreboot.org/pipermail/openbios/2018-May/010360.html

Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v3:
- use avocado_qemu.wait_for_console_pattern (Cleber)
- use MD5 hash
---
 tests/acceptance/ppc_prep_40p.py | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tests/acceptance/ppc_prep_40p.py b/tests/acceptance/ppc_prep_40p.py
index 7b8d0e55a9..0ebedd16c8 100644
--- a/tests/acceptance/ppc_prep_40p.py
+++ b/tests/acceptance/ppc_prep_40p.py
@@ -62,3 +62,35 @@ class IbmPrep40pMachine(Test):
         wait_for_console_pattern(self, fw_banner)
         prompt_msg = 'Type any key to interrupt automatic startup'
         wait_for_console_pattern(self, prompt_msg)
+
+    def test_openbios_192m(self):
+        """
+        :avocado: tags=arch:ppc
+        :avocado: tags=machine:40p
+        """
+        self.vm.set_machine('40p')
+        self.vm.set_console()
+        self.vm.add_args('-m', '192') # test fw_cfg
+
+        self.vm.launch()
+        wait_for_console_pattern(self, '>> OpenBIOS')
+        wait_for_console_pattern(self, '>> Memory: 192M')
+        wait_for_console_pattern(self, '>> CPU type PowerPC,604')
+
+    def test_openbios_and_netbsd(self):
+        """
+        :avocado: tags=arch:ppc
+        :avocado: tags=machine:40p
+        """
+        drive_url = ('https://ftp.netbsd.org/pub/NetBSD/iso/7.1.2/'
+                     'NetBSD-7.1.2-prep.iso')
+        drive_hash = 'ac6fa2707d888b36d6fa64de6e7fe48e'
+        drive_path = self.fetch_asset(drive_url, asset_hash=drive_hash,
+                                      algorithm='md5')
+        self.vm.set_machine('40p')
+        self.vm.set_console()
+        self.vm.add_args('-cdrom', drive_path,
+                         '-boot', 'd')
+
+        self.vm.launch()
+        wait_for_console_pattern(self, 'NetBSD/prep BOOT, Revision 1.9')
-- 
2.21.0


