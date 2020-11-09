Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9D9C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 08:09:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FB5F2084C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 08:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Soa+m8yK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FB5F2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc2Ea-0002S7-BF
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 03:09:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kc2DX-0001sp-Fo
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 03:07:59 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:55092)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kc2DU-0000bn-Q5
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 03:07:59 -0500
Received: by mail-wm1-x32c.google.com with SMTP id d142so7064714wmd.4
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 00:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5Qmiv1vB0rLo6Q5wpFrBp2Hy6UjwUdSRWDFefigrFgI=;
 b=Soa+m8yKItuxQO/0kf5Vea+SGf1d8QJLsDiEs7GpdBcjR3jIgrQVhuRdXi5N4DcFRU
 S60TGjF9TBETkE2BUcPZmZyU0V31wJxgjdERKfOAKr/UHxy4ilNvrJHOv43SWZEG/wYU
 MAquljMLbSRzGUemDhBTOvTzPPB1yxcNjXguH/Z+Q8ssWPLlcQ9eoRQs2BUJWsOSn6I2
 aDvqZP3/X6WOobA+HQ7xBK1vWYt5WOQ/wpcR8hthJS0zt3EIVhdAkoh/ehI3CnJmmM96
 fzlG71FT7VlHOttAFCCRCj0nMLuEd5WqZTGucuo3y5/jFlVFf+m8UREgg953phPYGKT3
 et1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=5Qmiv1vB0rLo6Q5wpFrBp2Hy6UjwUdSRWDFefigrFgI=;
 b=AdbQvyP4k8+GmbdfMwg714xl14zQCysDYndsMLznLkFNhG8oXL2IdaZY4Zqo7BolsA
 YeMmKttoCNL3wvYYjHGnXZQFTOmmnHmxgM3wUCTmHYNEANgaPZ/LWfkKlzH7G70C73er
 u1qe42PXATISEnTGCXRBHjmPjPy+VvMCFsMLwKD1VhZTQTz/81eidqacd+1HZsWj0IZG
 HocedxvK9/9KzL0Rczy89UTDq/fO/UCkdZuWdehZjuAyDA2oqj0nbTfNgW/+9UMd12e2
 LVey3OiadwfjephRfb5ft6dF75r3rtipJCSOX2IRUz65CDKy7E9rwZOL2vnTZXrkQfGH
 ISVg==
X-Gm-Message-State: AOAM5333RZp+Ty9PNOHoyFEprBSH+4h/la2GhjVmfWmA9IKVxahC8sYG
 Nf2UllBl0CpvGf9PWxFGak5NHFKv94M=
X-Google-Smtp-Source: ABdhPJyFpmy+LqpbKtJI53B4v8dE8a82ib7L0VrhkItmGa9PSgvAJ3sHKCwuz88z+xFfDJlP5D6Nyw==
X-Received: by 2002:a1c:7902:: with SMTP id l2mr6623263wme.117.1604909269606; 
 Mon, 09 Nov 2020 00:07:49 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id l3sm13308012wmf.0.2020.11.09.00.07.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2020 00:07:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH-for-5.2] tests/acceptance: Disable Spartan-3A DSP 1800A
 test
Date: Mon,  9 Nov 2020 09:07:47 +0100
Message-Id: <20201109080747.2408489-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x32c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Cleber Rosa <crosa@redhat.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This test is regularly failing on CI :( Do not run it automatically.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/acceptance/boot_linux_console.py | 1 +
 tests/acceptance/replay_kernel.py      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 8f433a67f84..010e8790c0f 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -1025,6 +1025,7 @@ def test_m68k_mcf5208evb(self):
         tar_hash = 'ac688fd00561a2b6ce1359f9ff6aa2b98c9a570c'
         self.do_test_advcal_2018('07', tar_hash, 'sanity-clause.elf')
 
+    @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
     def test_microblaze_s3adsp1800(self):
         """
         :avocado: tags=arch:microblaze
diff --git a/tests/acceptance/replay_kernel.py b/tests/acceptance/replay_kernel.py
index 00c228382bd..c1f5fa4de71 100644
--- a/tests/acceptance/replay_kernel.py
+++ b/tests/acceptance/replay_kernel.py
@@ -280,6 +280,7 @@ def test_m68k_mcf5208evb(self):
         file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
         self.do_test_advcal_2018(file_path, 'sanity-clause.elf')
 
+    @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
     def test_microblaze_s3adsp1800(self):
         """
         :avocado: tags=arch:microblaze
-- 
2.26.2


