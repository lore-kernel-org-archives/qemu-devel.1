Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 820DCC3F68F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 22:03:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FBDF22527
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 22:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XjM/qX/u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FBDF22527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itf93-0003SF-9V
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 17:03:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50936)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itf6f-0001Vk-QQ
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 17:01:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itf6e-0005je-Bg
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 17:01:13 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38094)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itf6e-0005id-3b
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 17:01:12 -0500
Received: by mail-wm1-x341.google.com with SMTP id u2so926737wmc.3
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 14:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IMzDWPOAlokC12hxHZKbBpZqQqABH6KMX9scWYox2oU=;
 b=XjM/qX/uwLzdgSiPulSdmfQT0f2AG9WLZp1DXSQHy0p5hDhwcYRi3TLxGTMfm80zJE
 2zT3MW9HSoQaTH9x2wh9SfaswV1JzsjeWEsJflASASfCdCaEG6EZJHvQq2jM6KDjG7w1
 2Oc1Gn7TMcG5Oiky78961vCSu5gkaHArdAn67ApqUvKnOpAujuVC2eQOxwkiD6vGBW9V
 6Tby6a5umh30puYrUVs+vMDocEZQy5xcPhDa9/uOoxHz91ZTQo5cA7x/36fS+OEsLULl
 8WQffE0bJKcX9BK3zz98vcfbjgwEcD96xnCuV/gbMRYZCkn0YDjyNT7pIFo090zp0OV8
 lIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=IMzDWPOAlokC12hxHZKbBpZqQqABH6KMX9scWYox2oU=;
 b=Jdn6G8S8kwDqf+3TDV5kFeGLhBbR7yVBPRgOFXq0ZCeOaZGsgUMCK5vhsABg6iJTMh
 i7gtk8thhRV+QoQnOYsLbJgBVa/fig3mBfKWcOGFuwqtJXbR71WpH3qJQrou2oJemaL6
 dNmG90Xn7Aak1zIU0ce04/fRJh4qIsbvL/KAGfBibgLT7WAMFwkf5NyAGZl54d0Qh+0i
 nIqjjKA0zdIakME/Js6fzjyR2UWrQYkwbzp2Mr/Plk41g2GPgQWglx+vW8kSTlFRSz6Z
 F8Fl3SRK7R3X52oRLFYis4p8yL5+Sxw5Bxcv46MUPs5ITHAe07u2RjjHd4PQ8UPc8cDG
 eTkw==
X-Gm-Message-State: APjAAAWCgYH3k+thvd5mFEF67T/n551Ur0W4gOPLKvdj3vhHlTY8wjX5
 1DjxzaZOszgB83sLuPa/BX4vHrsR
X-Google-Smtp-Source: APXvYqwyvVzMT5biFjw3cX9fB41a9AuXKX4Mv+BFjq6i+z4axl1htAgUX6LnLRADGUtbvxdWWD15TA==
X-Received: by 2002:a7b:c407:: with SMTP id k7mr888264wmi.46.1579557670640;
 Mon, 20 Jan 2020 14:01:10 -0800 (PST)
Received: from x1w.redhat.com (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id f1sm904341wmc.45.2020.01.20.14.01.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 14:01:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 01/18] MAINTAINERS: Move machine test to the machine
 section (not ARCH one)
Date: Mon, 20 Jan 2020 23:00:50 +0100
Message-Id: <20200120220107.17825-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200120220107.17825-1-f4bug@amsat.org>
References: <20200120220107.17825-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
!squash
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c70d77b1ae..3fbac64b31 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -168,7 +168,6 @@ M: Michael Rolnik <mrolnik@gmail.com>
 R: Sarah Harris <S.E.Harris@kent.ac.uk>
 S: Maintained
 F: target/avr/
-F: tests/acceptance/machine_avr6.py
 F: default-configs/avr-softmmu.mak
 F: gdb-xml/avr-cpu.xml
 
@@ -501,6 +500,7 @@ F: hw/timer/avr_timer16.c
 F: include/hw/timer/avr_timer16.h
 F: hw/misc/avr_mask.c
 F: include/hw/misc/avr_mask.h
+F: tests/acceptance/machine_avr6.py
 
 ARM PrimeCell and CMSDK devices
 M: Peter Maydell <peter.maydell@linaro.org>
-- 
2.21.1


