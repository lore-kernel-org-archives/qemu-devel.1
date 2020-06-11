Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28251C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 11:46:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E976A207ED
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 11:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bs5j9Qhw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E976A207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjLex-0005Tx-73
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 07:46:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jjLcO-0001ti-EZ; Thu, 11 Jun 2020 07:43:36 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41506)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jjLcN-0001q5-N4; Thu, 11 Jun 2020 07:43:36 -0400
Received: by mail-wr1-x441.google.com with SMTP id j10so5806656wrw.8;
 Thu, 11 Jun 2020 04:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sm1O72gHLNjrXfcoGbVFW0OVY22y9Ts8wW5TaWWep7I=;
 b=bs5j9QhwY3llV2EA11BnJ4xIJxEHOGHvhfpY/wPdlioOI+DtRelUcarSR3nSeiriZN
 fVkHEiUDSpSyiupfqccVZLZGFIKqLGg3azxMkdpAsDCcleVepzcM1nx5/FVIL4Fxd3MM
 VBhRHoIytQHZwenDuCdN6QXLzdZkE4fMwd3y+jyg2jfE+P/iKMDOR5wD75KdyShhDV7S
 EVDREYfVyvD3WDzaDyFv6OlyfUIIoyWq7BvkC36Lj5OlfcTG5yEFwfTVK8FpDDkQCHc5
 ZUXbL2E7vpRZsU5MzMljV0Q0U6WhK336+7hF/AtwR1hgIqJxySID6q548uB4Bv3Wm0C2
 O9QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=sm1O72gHLNjrXfcoGbVFW0OVY22y9Ts8wW5TaWWep7I=;
 b=sizyhuQ/sLXlcAbo5ipd3ftJMvflK8LNJQfbAt50hsAHEmWXXEqYD66i2teFC3rcW3
 00VuZw2qHumlFEDeLaBirBtNM0fTipyCIR/oBPgv0s14Xost9lb4J+6Fo064BTAiJPP5
 lpQeOhBc4wtMA9D641H0OwOyfS8qskx9JMhwqeQcJ33/d8F50drZEO1uaGwdU5i4AnRn
 Z4Et3zXpEuHdgDXQp4/l+iTf+4JDNUwNP+0x7faPIgOY/BlDRpXAGpJReEmB5k48O+Bb
 fH+YKNsl8q6rpllskm3LZZiS327NJV6zK/gjj5o/zx5yqEy2gzKoxQ/e/6nlg7YMMokJ
 CACQ==
X-Gm-Message-State: AOAM530zUPoxaWjOjDgqJY9WEk8lBPFGoXomSyuEzdLjpIsnPYJ9pbcX
 bYDiplVfom53LLE4qr0HeC3NdtHr
X-Google-Smtp-Source: ABdhPJzRHe4udQwxSw0p6ZmpS7VSFtUjXQNjgbqiISfvXgE7MVR8csanstCD2Z7QgOAUjyfnzqHrUQ==
X-Received: by 2002:a5d:44cf:: with SMTP id z15mr9650488wrr.164.1591875803666; 
 Thu, 11 Jun 2020 04:43:23 -0700 (PDT)
Received: from x1w.redhat.com (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id h29sm4832863wrc.78.2020.06.11.04.43.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2020 04:43:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 2/7] MAINTAINERS: Add an entry for common Renesas
 peripherals
Date: Thu, 11 Jun 2020 13:43:12 +0200
Message-Id: <20200611114317.13044-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200611114317.13044-1-f4bug@amsat.org>
References: <20200611114317.13044-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 qemu-trivial@nongnu.org, Magnus Damm <magnus.damm@gmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Renesas peripherals are common to SH4/RX based MCUs. Their
datasheets share common sections. It makes sense to maintain
them altogether.
Add the uncovered UART SCI peripheral.
The current names are misleading (see the 'sh_' prefix).
In another series we will remove these peripherals with
the 'renesas_' prefix. Out of the scope of this change in
MAINTAINERS.

Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 MAINTAINERS | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 87ceca7ff1..4792509673 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1256,7 +1256,6 @@ R: Magnus Damm <magnus.damm@gmail.com>
 S: Maintained
 F: hw/sh4/r2d.c
 F: hw/intc/sh_intc.c
-F: hw/timer/sh_timer.c
 F: include/hw/sh4/sh_intc.h
 
 Shix
@@ -1958,6 +1957,14 @@ F: hw/*/*xive*
 F: include/hw/*/*xive*
 F: docs/*/*xive*
 
+Renesas peripherals
+M: Yoshinori Sato <ysato@users.sourceforge.jp>
+R: Magnus Damm <magnus.damm@gmail.com>
+S: Maintained
+F: hw/char/sh_serial.c
+F: hw/timer/sh_timer.c
+F: include/hw/sh4/sh.h
+
 Subsystems
 ----------
 Audio
-- 
2.21.3


