Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D52AC3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 18:25:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18C1B20842
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 18:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i5kW+EUJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18C1B20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8pkr-0004Z5-9F
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 13:25:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43606)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j8pfD-0002XT-Lq
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 13:19:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j8pfC-0001Dz-Cp
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 13:19:35 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45683)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j8pfC-0001Ah-6d
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 13:19:34 -0500
Received: by mail-wr1-x444.google.com with SMTP id v2so916510wrp.12
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 10:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tYnjdVHVbzSLgWR2JAiiP7YknzWJrfOPrv/6EnTLir4=;
 b=i5kW+EUJgOTiBbQbUeH3wwjnVrkhYBxzK4gUOoZ2Bi7QEyZptXomYMbqBjuqWkt3Qz
 gypOzGRh7kTK1RPmpRzeAmoroqMYvwLKKUbsXpniDf5mjO7NNFU0cN/HI5Me82oGEQHm
 OD9rMZ7f3PeB8cvz2u7s4fFpite/jJSZRrj8tfzf5jPZ15rhfsNT5XR86QYzJHWgqD5z
 N6ckz7i+x6tGyYEkrK4PdZ/GDvpfqRwSSAMZdYhd18dk6BNRandEf5NyUR1TqeZmq17L
 CbtALWeO4JpjgA/wKn2KwNKj9bD1i5oyxTAYsaVxjcgRuiQGSgOkICwYH5uVxTH6Uqnr
 E7uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tYnjdVHVbzSLgWR2JAiiP7YknzWJrfOPrv/6EnTLir4=;
 b=TLnHLl+uFS/M6BCi2A+O6WzVRW6CUeGyc7m8IzC+tsqMJ0AXANP1yV9yrQ5X0JxPyD
 hHR4h9Vq67of8dv+h+No+xo49+E4lYZ9TU1RX5X4si/uCqD37KjFHUHa6NrgtFeWo94F
 BxKWB2wL1ImA1aqMXGIUetPHVPCQrYT0ZmpAs0xQ6vWnRxwRIY1NznqMJTAMlsXH7Wmt
 SHGySY5Kob3pNbC4P7BTRd/E3w0pbizRfdqDV4JciXqv/OG3je//cp56bpyBU4YV/o7X
 Tkz2fATtuOgxTKGeZWiKNn1Dgy0d/hSMzXEZiPEYp4yqDGHxahUVAawGnJxF9tgnA0xY
 CS3A==
X-Gm-Message-State: ANhLgQ2NF5BowkDDDQqaJ1AQyW3W4CTEE4vc4CnYWEjdB8UBQOVJD8Ur
 O2WVNeXGfDigi2R2VDPyunhQqXEPcYA=
X-Google-Smtp-Source: ADFU+vszmxHWGLvohyZW6T+YGInT28RFUZhT7l/v9TNkBkY3KiPiPXNBa4HDVJ+76NJr2N5DW0w1Nw==
X-Received: by 2002:adf:ee4c:: with SMTP id w12mr799274wro.310.1583173159163; 
 Mon, 02 Mar 2020 10:19:19 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u1sm10876701wrt.78.2020.03.02.10.19.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 10:19:15 -0800 (PST)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 53B2F1FF99;
 Mon,  2 Mar 2020 18:19:08 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 09/10] tests/acceptance: move @skipUnless decoration to
 test itself
Date: Mon,  2 Mar 2020 18:19:06 +0000
Message-Id: <20200302181907.32110-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200302181907.32110-1-alex.bennee@linaro.org>
References: <20200302181907.32110-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It appears ignore the decoration if just applied to the class.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/acceptance/machine_mips_malta.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/acceptance/machine_mips_malta.py b/tests/acceptance/machine_mips_malta.py
index 92b4f28a112..b8fac2a44d5 100644
--- a/tests/acceptance/machine_mips_malta.py
+++ b/tests/acceptance/machine_mips_malta.py
@@ -30,14 +30,14 @@ except ImportError:
     CV2_AVAILABLE = False
 
 
-@skipUnless(NUMPY_AVAILABLE, 'Python NumPy not installed')
-@skipUnless(CV2_AVAILABLE, 'Python OpenCV not installed')
 class MaltaMachineFramebuffer(Test):
 
     timeout = 30
 
     KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
 
+    @skipUnless(NUMPY_AVAILABLE, 'Python NumPy not installed')
+    @skipUnless(CV2_AVAILABLE, 'Python OpenCV not installed')
     def do_test_i6400_framebuffer_logo(self, cpu_cores_count):
         """
         Boot Linux kernel and check Tux logo is displayed on the framebuffer.
-- 
2.20.1


