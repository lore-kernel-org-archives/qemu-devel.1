Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24985C35240
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 01:01:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E35FE2071E
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 01:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvuGH/EI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E35FE2071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iunLl-0004ci-14
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 20:01:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44468)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iunCo-0002Nt-7t
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 19:52:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iunCn-0005RI-4I
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 19:52:14 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:46972)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iunCm-0005PL-U4; Thu, 23 Jan 2020 19:52:13 -0500
Received: by mail-wr1-x42c.google.com with SMTP id z7so43247wrl.13;
 Thu, 23 Jan 2020 16:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=snGPMGGzDkx/q5i5nbwiSLKBDBMSQiGmJwzb4+cKa74=;
 b=lvuGH/EIK0s4j4G97CjjfF/PJOh29VX7HpEjT3a2UEoSlrykF9i/SN5A1rCe/q9X1q
 3NHlMaAHOuamk6M8MsbSsX3tgPEkpQvzuokD8Xw0FSUNL2lfEh9x/PzLVKsIu5TFnuCF
 vNj0Tt9XF0a2ELtxNDWsK5+1PeSchAQMhXY0jp8D8CApwRqyhK4CnBvmacQwEZmYQzEJ
 yRWXBGvbUoJD3cvqgYK5Y4mb/NgDcCWpeM5OVugr8NlTas2PXNKVwHug0hNKa2s59VVD
 Jv2/L5qEQ9HoLD7TqFpqkDiF6X+23UgO0pe32Mes5SrqDfyIgEaJGteS0uoEOoJ0JBw9
 ADbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=snGPMGGzDkx/q5i5nbwiSLKBDBMSQiGmJwzb4+cKa74=;
 b=XnioTcWxmD7tt2w0OOIjp2sRuy0D1qn9CYgUD5JXXl87PzD6Gk0g5l8sQDJttMO05a
 Kf5o1ZP98cy2rAKmoznCX/yHoR3vTcSM0IEzB0j4oPX/cDVBFyhOzz7NXKKU7uVRtbNw
 PvmreNVzrpkenbLmBYvaHEvZUqDl7y94w5fWBRdTglrN5opO1ZfO9FNX6i27i1WG8mhj
 0GvTst8UFJAx78FBwyCrLMI3MtC2Ye/fEDMK/vukhjpi3l8NqPFSujzc7tmUGZuA1Dfh
 xCHxnBNDtyBWD3L7x26L1BchuBoEHTlJQibSBwieLatt0p2m+qCCWuatGWZFMwfw6MiA
 +TWg==
X-Gm-Message-State: APjAAAXvLukIWpy8SuuatrYgxwovtrB6XK4NxNfe5rVO3oXPRCHgqmq2
 KhvXqbLrJ4/AdAL+6xSUbuJkfEjW
X-Google-Smtp-Source: APXvYqxNkCwWPhWQjsnZ1XbG513q0walLkyxOXnIfjtWkE9PnIZZoGwDD4nUJNoQ1Qz0P2qsgkDYEA==
X-Received: by 2002:adf:e290:: with SMTP id v16mr922311wri.16.1579827131714;
 Thu, 23 Jan 2020 16:52:11 -0800 (PST)
Received: from x1w.redhat.com (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id s139sm4598271wme.35.2020.01.23.16.52.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2020 16:52:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org, mrolnik@gmail.com, richard.henderson@linaro.org,
 me@xcancerberox.com.ar
Subject: [PATCH rc2 16/25] target/avr: Add machine none test
Date: Fri, 24 Jan 2020 01:51:22 +0100
Message-Id: <20200124005131.16276-17-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200124005131.16276-1-f4bug@amsat.org>
References: <20200124005131.16276-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
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
Cc: Laurent Vivier <lvivier@redhat.com>, Fam Zheng <fam@euphon.net>,
 S.E.Harris@kent.ac.uk, qemu-riscv@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, dovgaluk@ispras.ru,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, thuth@redhat.com,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, imammedo@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Michael Rolnik <mrolnik@gmail.com>

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Message-Id: <20200118191416.19934-18-mrolnik@gmail.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/qtest/machine-none-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/machine-none-test.c b/tests/qtest/machine-none-test.c
index 5953d31755..3e5c74e73e 100644
--- a/tests/qtest/machine-none-test.c
+++ b/tests/qtest/machine-none-test.c
@@ -27,6 +27,7 @@ static struct arch2cpu cpus_map[] = {
     /* tested targets list */
     { "arm", "cortex-a15" },
     { "aarch64", "cortex-a57" },
+    { "avr", "avr6-avr-cpu" },
     { "x86_64", "qemu64,apic-id=0" },
     { "i386", "qemu32,apic-id=0" },
     { "alpha", "ev67" },
-- 
2.21.1


