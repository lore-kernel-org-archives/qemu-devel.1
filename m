Return-Path: <SRS0=KIBN=2T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05037C2D0C0
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2019 22:50:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC202207FD
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2019 22:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0SWyQB9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC202207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilhNs-0006nw-Q0
	for qemu-devel@archiver.kernel.org; Sun, 29 Dec 2019 17:50:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52876)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ilhJG-0002TU-AK
 for qemu-devel@nongnu.org; Sun, 29 Dec 2019 17:45:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ilhJF-0001n1-9j
 for qemu-devel@nongnu.org; Sun, 29 Dec 2019 17:45:18 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34623)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ilhJF-0001kh-38
 for qemu-devel@nongnu.org; Sun, 29 Dec 2019 17:45:17 -0500
Received: by mail-wr1-x443.google.com with SMTP id t2so31282479wrr.1
 for <qemu-devel@nongnu.org>; Sun, 29 Dec 2019 14:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=khfObrraH+OQVE05FoSKKYYMBZ+cKKyCWdxbeBJAw0M=;
 b=f0SWyQB9LkycPHwMSyVjJe1VxyH3u3nLLzH9Pz44JzVBMBP8otqruQUxTHN6D21rVO
 QJGFee0wT/cwH4DHdqnb7mapBJb+RzKVJwfpofwgfZUyUZoUBtkazYENF5/cA8KD60zo
 qZ5jzbmEl1CW2yUnA5uwAVf3mbvFOEGo6WeKkqOssi79EMOfw+8sgJ+k8Uq4O5Gb7LWd
 vmcbCP9jUmzSt1j3K8CiFp2MDVnCN8HjcPjQvSi+euty2jopA4vQ8V7VeCX3ytHmq+tS
 gYQFXAP7Bm8bu3tM/LkX+mjmj95STnD7snrbkc64RsVQnZOM3Zs41b8rv1rAx4gMfRvp
 lPzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=khfObrraH+OQVE05FoSKKYYMBZ+cKKyCWdxbeBJAw0M=;
 b=jaoILgrUWMRRhj1orN/nT7ClbeWAU38qq06nFqXBvKHBCTJKIkCH7O39OoTgGUwTAi
 u8zAjj5yA/40Hj8jMyhT81U4hb0TXMFJ0BQGYySqJ4kLZL6aMMkB80JAnbqnBUsbgg6f
 NDOeqgesmsQZJgTwi1cDnPp6niAM82PAxs2C1c1LmUpWYMSYsh8sWO05/mgQ/PoFQGP/
 PQZ3lEqhowfumZiMyZFryVy1ayqMHNMvi0rL/WgjNcGWGGoBwGsKzbdjCDO2rfea+vUG
 M+0v8QLpqPhFN0OHV1LdSrsakR64wKskTOgYvyiT3WSVSMh+/rwWhbO+DmlzU/4y4CVb
 4ENA==
X-Gm-Message-State: APjAAAU7oAXr4UdQgpVYzHFddvbwU7CgtH1YYcpCVmEgCkMe8H73h9yg
 cpw6dUQfYCyCGLhTlSjz1VKxxYEWGqc=
X-Google-Smtp-Source: APXvYqyWllwznvjokjUgH7SVxyWuhX+mggOvOtS8wZ8YueJjNlFp5YLPqexx29gIWCdvwgtLbOb8iQ==
X-Received: by 2002:a5d:44ca:: with SMTP id z10mr67296584wrr.266.1577659515971; 
 Sun, 29 Dec 2019 14:45:15 -0800 (PST)
Received: from x1w.home ([2a01:cb18:8372:6b00:691b:aac5:8837:d4da])
 by smtp.gmail.com with ESMTPSA id x1sm42709188wru.50.2019.12.29.14.45.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Dec 2019 14:45:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 5/8] tests/boot-serial-test: Test some Arduino boards (AVR
 based)
Date: Sun, 29 Dec 2019 23:45:02 +0100
Message-Id: <20191229224505.24466-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191229224505.24466-1-f4bug@amsat.org>
References: <20191229224505.24466-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Sarah Harris <S.E.Harris@kent.ac.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Michael Rolnik <mrolnik@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Arduino Duemilanove is based on a AVR5 CPU, while the
Arduino MEGA2560 on a AVR6 CPU.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/boot-serial-test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
index e556f09db8..582a497963 100644
--- a/tests/boot-serial-test.c
+++ b/tests/boot-serial-test.c
@@ -113,6 +113,8 @@ typedef struct testdef {
 static testdef_t tests[] = {
     { "alpha", "clipper", "", "PCI:" },
     { "avr", "sample", "", "T", sizeof(bios_avr), NULL, bios_avr },
+    { "avr", "arduino-duemilanove", "", "T", sizeof(bios_avr), NULL, bios_avr },
+    { "avr", "arduino-mega-2560-v3", "", "T", sizeof(bios_avr), NULL, bios_avr},
     { "ppc", "ppce500", "", "U-Boot" },
     { "ppc", "40p", "-vga none -boot d", "Trying cd:," },
     { "ppc", "g3beige", "", "PowerPC,750" },
-- 
2.21.0


