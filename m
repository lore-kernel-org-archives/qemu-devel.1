Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC5AC43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 14:24:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81483208C3
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 14:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GqyZtszb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81483208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJHJJ-00044j-Ku
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 10:24:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60450)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kJHIj-0003du-M7
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 10:23:49 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:55556)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kJHIi-0001KP-1b
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 10:23:49 -0400
Received: by mail-wm1-x32a.google.com with SMTP id d4so5515287wmd.5
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 07:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PSbmsOkPnBP/KgOAMfMarhr/bQYk/9QviVhfdpcb1A8=;
 b=GqyZtszbH1VZWnaUzThaYcb1HHYpNkOSsKy98rxChY0WzwuHG5oGqRIQhdOSw7joLH
 qH2N1YlrMM3poT+3MdkfKXSSdamiqZRaetP9Yk6Qm/w3lOmcwSPra6ASnLeMNjBqfAZC
 5CVyMYjDSd7yVx++f8jtzETaw2DW4ssHRcaEniX85gbNX1iEmb1/ahjgQQLXCMSgMY3L
 utNbcL3x9+m3+8108qwXdbZN70WhZPgnZ7u02mDeXkWddfzN3do4yHiGawWtdqkGpQ/m
 bDy8LZZfuM4Z0FQCTGshR7c9vkKsZ/9FfLqXhsyiQqmS48EP24QT2du5uUbcxvdoyvD2
 scKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=PSbmsOkPnBP/KgOAMfMarhr/bQYk/9QviVhfdpcb1A8=;
 b=DF39wN0bAlnJXDqssKguU6wJO5LfxGddGFIqslwk3G2H6Iq9HHHZIzzwVku2hbfcCw
 M1tVAd3QpVfGarcUbFXoktVTowCq8gRjLYIoJs1UhNLC+sdu9T+n3g96jjxk9S6TIkXg
 IBP4voqa/te7iqetJc092bwwhDY/6l9SpXhaliiKgXDEJqfS6xM7aS8PtooB2RWeK/kw
 2Ul5kk1nQKyvmMW0MlIkr5kI5zB2OAbYzr/4kF8Y9I1bbmQfxVkmUjwfAaDRuFgkhykO
 miNeUVCQKACgpd/v/9p761Lbk49Hosk1AlIKzQhjCbS/z+8278NnV/VUNIY8fn8thBB2
 476w==
X-Gm-Message-State: AOAM533HMqQHB9xyRlwO94glMj3xto9T9JkeNXfxgBG0dTdeAM6lys2s
 TaxgZSPt6XnahP5JM5rZt+dGYQinIAA=
X-Google-Smtp-Source: ABdhPJxNeZxKW0qY3zv0FT341uTa76eOFFi82hXdQjE79sTAD9cEx5lh5I9lpj7OV4VBHrY04MauAA==
X-Received: by 2002:a05:600c:414b:: with SMTP id
 h11mr15975629wmm.20.1600439026356; 
 Fri, 18 Sep 2020 07:23:46 -0700 (PDT)
Received: from x1w.redhat.com (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id k8sm5854106wma.16.2020.09.18.07.23.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 07:23:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] tests/acceptance: Reduce quanta-gsj U-boot+Linux test time
Date: Fri, 18 Sep 2020 16:23:44 +0200
Message-Id: <20200918142344.150749-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x32a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Havard Skinnemoen <hskinnemoen@google.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The 'arm_quanta_gsj_initrd' test is timeouting on GitLab CI:
https://gitlab.com/philmd/qemu/-/jobs/745483978#L846

Use the same trick from the 'arm_quanta_gsj' test to reduce the
systemd services started and get quicker to the shell prompt.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/acceptance/boot_linux_console.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 4a366ce93e4..7748febbf54 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -638,6 +638,9 @@ def test_arm_quanta_gsj_initrd(self):
 
         self.vm.set_console()
         kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               'initcall_blacklist=npcm_i2c_bus_driver_init '
+                               'systemd.mask=systemd-random-seed.service '
+                               'systemd.mask=dropbearkey.service '
                                'console=ttyS0,115200n8 '
                                'earlycon=uart8250,mmio32,0xf0001000')
         self.vm.add_args('-kernel', kernel_path,
-- 
2.26.2


