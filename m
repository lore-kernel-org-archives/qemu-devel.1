Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED02EC32771
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 00:22:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1F2324673
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 00:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AeDRwnVI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1F2324673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuQGU-0004vB-Dc
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 19:22:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54778)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iuPzZ-0002F9-Rs
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 19:05:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iuPzR-0002GM-1M
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 19:05:00 -0500
Received: from mail-pf1-f176.google.com ([209.85.210.176]:45709)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iuPzQ-0002FR-Po
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 19:04:52 -0500
Received: by mail-pf1-f176.google.com with SMTP id 2so597813pfg.12
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 16:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SwL4bj5FyPVtbDbu1kSJciAaavdFuuCM9S3gjDN6Z6k=;
 b=AeDRwnVIv0ulImf6reL/yVqGxFj/1If6iiGxF/deGZ/enIXdSuzKDBrnHrdt5S2CnR
 AmibAmn+UuabFcI3Bcb3hFTTKvw5tndMydSLBX153B1Q7tSLefKtOUincCDHcT/W1Z9O
 /7/irvSZCMSEpZqXGl32UWoo0ibQKZYj2zNn7yXBHpTXrceLktC50MeEPJbUqQU5n7A2
 kjk/Q0youS27Li82tADKdIT+JwvGwcJajguqmRO55NeAaRjoYEXazA4NPO9Zyqlqcxlh
 HP5dD/BRZIW4LcJPYBhaVbIMCcRwCJLXByhwQmzVQliDIJWP8N77cPfRjAWsHXq7JWHy
 N+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SwL4bj5FyPVtbDbu1kSJciAaavdFuuCM9S3gjDN6Z6k=;
 b=gHJajbttmRxuoF6oP+00cE323Z82gBlHFKfZAxCDblnrRpsGFAFYeq64nmRXPGzqfN
 vcL61XOZijBWXoB/THXZwxj2y9HEyp1SkK+vC+BbwRzrNo38YphWkDbqoX9wN/VO6+Ts
 K3ZD/nVYaNEKxBdiSq217de3+puqJipNy0FY1GFQ9zH9Awf4FFl1pvvO/nXr3ZVBL/av
 Fnt9YJQUp7zfhQN+/+visjWD9sp9avF2ha3fHiGFdBt5Zbnxa5fVG5xj+xULusJbDKUA
 jd+4zHknMF7SBDe8CJZEDjtQGkovtSBLvZu1qZguZ+AMCEX7vqmh900LuZ6mAu/ZDYxJ
 cSAw==
X-Gm-Message-State: APjAAAVBlhel4eeZeXCFvd97b3Os2V475ZVkHUTnC8c5G2b65TPBuivI
 FitSpnpIfkrjWrH/TCY16MV7vQfxpeU=
X-Google-Smtp-Source: APXvYqz2+BsSLGxet0myOuXqpRmoSj4EnxUvcci69RPDzKVXv2ycZ+PX64qQmE8zW1dsopTIzdqmuw==
X-Received: by 2002:a65:680f:: with SMTP id l15mr940576pgt.307.1579737831348; 
 Wed, 22 Jan 2020 16:03:51 -0800 (PST)
Received: from localhost.localdomain (rrcs-173-198-77-92.west.biz.rr.com.
 [173.198.77.92])
 by smtp.gmail.com with ESMTPSA id b21sm84521pfp.0.2020.01.22.16.03.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2020 16:03:50 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH rc1 17/24] target/avr: Update MAINTAINERS file
Date: Wed, 22 Jan 2020 14:03:00 -1000
Message-Id: <20200123000307.11541-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200123000307.11541-1-richard.henderson@linaro.org>
References: <20200123000307.11541-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.176
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
Cc: thuth@redhat.com, me@xcancerberox.com.ar, S.E.Harris@kent.ac.uk,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 dovgaluk@ispras.ru, imammedo@redhat.com, mrolnik@gmail.com,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Michael Rolnik <mrolnik@gmail.com>

Include AVR maintaners in MAINTAINERS file

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Message-Id: <20200118191416.19934-22-mrolnik@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[rth: Squash ordering fixes from f4bug]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 MAINTAINERS | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2c768ed3d8..8caa94f782 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -163,6 +163,14 @@ S: Maintained
 F: hw/arm/smmu*
 F: include/hw/arm/smmu*
 
+AVR TCG CPUs
+M: Michael Rolnik <mrolnik@gmail.com>
+R: Sarah Harris <S.E.Harris@kent.ac.uk>
+S: Maintained
+F: target/avr/
+F: default-configs/avr-softmmu.mak
+F: gdb-xml/avr-cpu.xml
+
 CRIS TCG CPUs
 M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
 S: Maintained
@@ -880,6 +888,24 @@ F: include/hw/*/nrf51*.h
 F: include/hw/*/microbit*.h
 F: tests/qtest/microbit-test.c
 
+AVR Machines
+-------------
+
+Atmel MCU
+M: Michael Rolnik <mrolnik@gmail.com>
+R: Sarah Harris <S.E.Harris@kent.ac.uk>
+S: Maintained
+F: hw/avr/
+F: hw/char/atmel_usart.c
+F: include/hw/char/atmel_usart.h
+F: hw/timer/atmel_timer16.c
+F: include/hw/timer/atmel_timer16.h
+F: hw/misc/atmel_power.c
+F: include/hw/misc/atmel_power.h
+F: hw/misc/avr_mask.c
+F: include/hw/misc/avr_mask.h
+F: tests/acceptance/machine_avr6.py
+
 CRIS Machines
 -------------
 Axis Dev88
-- 
2.20.1


