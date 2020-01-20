Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B48C32771
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 22:06:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADEFB217F4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 22:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnGw5uhw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADEFB217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itfCE-0007wq-AG
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 17:06:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50987)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itf6n-0001XN-3g
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 17:01:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itf6i-0005nC-Pc
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 17:01:20 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:56021)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itf6i-0005mY-5P
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 17:01:16 -0500
Received: by mail-wm1-x344.google.com with SMTP id q9so891230wmj.5
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 14:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PkfCQHlpqeDlUpgK51cDzilsCf35iQgQS4GdrZ/sDcM=;
 b=HnGw5uhwZEGZQgJLY+V0QAK9fz9/nIczneCMjPVrit+tJNyHXkR6DMEGRxLsd5uAoz
 6niY3bNlqc6RL4/TDoCiE63VvAQhU7h3QjqgN25FKWvgOwT0qMDN1wiXcSrJBh0tDidz
 iuWkGWXLssDpKAWjO+5DqpUbQ6f+LqAY7dJFcSppGvZcMj1QZ0duUTfDN0dEsMIRKcQ1
 QFfUnOMuHDM+ZyBaT/xMzfMfTv6tAT1UD4sGyraiuKe/MjY5anybjUp20Wq2qVEtBLKp
 I0FmAc/Ps7wSj53CrE5A4yk1gDKGYaIPChQL4TsJz0I+55E9oBfgrNNlQsVVytymrWF3
 BtyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=PkfCQHlpqeDlUpgK51cDzilsCf35iQgQS4GdrZ/sDcM=;
 b=FEYu/Jr44ZwkFC+H/SJ+EXmNpPxgPp6zi2+/CMrt0qTLa6eytccpV4qukPuW4Pqjhs
 kSTXdEgUiP4UwwhxgLETPPYm8w82BszLJeg4mwKfroDxc/5e+BmjklelYghDG2Z/kqbq
 JXYFh2iRUbe6DWqPLF4BwJxnwF9B1BD0srkMi4205pXAuEo2llz63CbGcAkoBKWTj+bg
 A0noYg0Y3n+XeS2lkotHkR/uNfZp3WqQ+rclmXa6d40XZiBqItvBLW8hqN/CG+iNpWWv
 P2txTqTrMfF+0LIA0xo/S//nNEy0nAHoR85KiOXUQHkv8pvtdhLvir3eso5+ybEC3iis
 DQLA==
X-Gm-Message-State: APjAAAWXqAV8z1faqCbFkAC6DfqMgLcCO6DXSqqG4pWBwHs8e4C2Du8M
 jwrCHRs47mJSQd/I7zIT+HgqzmCO
X-Google-Smtp-Source: APXvYqyrENP9GLcyaOoN+D2tdMlp1pRm1Sz4ePLfYg9C8HcA1c+B9TkInYzYuprSIAVCscjRUs6Y8Q==
X-Received: by 2002:a05:600c:cd:: with SMTP id u13mr853134wmm.24.1579557674755; 
 Mon, 20 Jan 2020 14:01:14 -0800 (PST)
Received: from x1w.redhat.com (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id f1sm904341wmc.45.2020.01.20.14.01.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 14:01:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 04/18] tests/acceptance: Keep multilines comment consistent
 with other tests
Date: Mon, 20 Jan 2020 23:00:53 +0100
Message-Id: <20200120220107.17825-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200120220107.17825-1-f4bug@amsat.org>
References: <20200120220107.17825-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>, Michael Rolnik <mrolnik@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
note to maintainer: squash before merge?
---
 tests/acceptance/machine_avr6.py | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tests/acceptance/machine_avr6.py b/tests/acceptance/machine_avr6.py
index 784c287d0b..611f6a62a4 100644
--- a/tests/acceptance/machine_avr6.py
+++ b/tests/acceptance/machine_avr6.py
@@ -33,11 +33,9 @@ class AVR6Machine(Test):
         https://github.com/seharris/qemu-avr-tests/raw/master/free-rtos/Demo/AVR_ATMega2560_GCC/demo.elf
         constantly prints out 'ABCDEFGHIJKLMNOPQRSTUVWXABCDEFGHIJKLMNOPQRSTUVWX'
         """
-        rom_url = 'https://github.com/seharris/qemu-avr-tests'
-        rom_sha1= '36c3e67b8755dcf37e06af6730ef5d477b8ed16d'
-        rom_url += '/raw/'
-        rom_url += rom_sha1
-        rom_url += '/free-rtos/Demo/AVR_ATMega2560_GCC/demo.elf'
+        rom_url = ('https://github.com/seharris/qemu-avr-tests'
+                   '/raw/36c3e67b8755dcf/free-rtos/Demo'
+                   '/AVR_ATMega2560_GCC/demo.elf')
         rom_hash = '7eb521f511ca8f2622e0a3c5e8dd686efbb911d4'
         rom_path = self.fetch_asset(rom_url, asset_hash=rom_hash)
 
-- 
2.21.1


