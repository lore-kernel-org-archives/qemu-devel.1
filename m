Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B02C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:27:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DA24206D3
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qtv41et/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DA24206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igoXN-00066A-73
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 06:27:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51172)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1igoFs-00083y-UU
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1igoFr-000083-Ip
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:36 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43135)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1igoFr-00006T-CA
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:35 -0500
Received: by mail-wr1-x441.google.com with SMTP id d16so6712516wre.10
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 03:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=ACmqU9kc4pH2AFemnhFozmUJPmfCe2y1E2GEg4ME7dE=;
 b=Qtv41et/cAnVAjr9sEMIwdJhL+pjKHlCpFIjd9AFEhnEGk2EGzeW9XHbpWNYBF0LBY
 uqdSCXdbsvLbL7QkrD3Zi24rB/cBwqBXbAwOo2Y214VmM7umK4UOWlALq7Fzixr/IQKG
 KqvG+hJwJOLFCXQek/jEgQAJECT6JbVJpklD9/D4IFKHUn0ocKq+noxv51U6Im2YxLm/
 ua7qCqLqQRgGEwAtZTihcH8iSf3YZnEmvMXDwtL4pD2NjoBDDB3JAAVo8NVGMeOgiiMN
 8p1GYjLpCAfHIejfMmsUtBVWQcxFFRLmZYw+ztiNFLoYIupAoQvHL/iV7kUQk8CCpPBK
 DfRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ACmqU9kc4pH2AFemnhFozmUJPmfCe2y1E2GEg4ME7dE=;
 b=W8cCMyqssVZmm35+26J7wXj8HVyfo2kT8uHqr4V5i81WDSN9HTi8MFeW2CnUuBBRuR
 q2J/TXOKJUuDAPuIeAJLtgFRam982XfjCSINJI5KqtgFzL7aZKXJCTvpbWc3lQ7EB90M
 XAeIbFuxVPfueOLsRt9Q3ul9Xis2ZLjp4Qb9vATWQ2dZHOLm4u7SCfN28lvsKmCLCL0/
 j+fch9ksNAr9K5LbDlbgJcfc1xxrLT1B2OuZZbY1fl5XxhmqGIrG1D9g9lMBcib+xckf
 EXsVzHKtpYd3KogM1cVT1yOL9hEv17b/QGRJDnwuq71RHJpek/TeyozEEXVT83EF4yLJ
 D4DA==
X-Gm-Message-State: APjAAAVxjhA2jRFF998rPFflRaDS/G5uhllMD4xwTAhqI74MiLO0zVWg
 scqVFEoBfsG8LXQS7hyjOWDLf2VREFt8/g==
X-Google-Smtp-Source: APXvYqwbBo40wpngpRa9J+nQzLqTWgW1Uf+sTs8bhVdZZNjdJNR2RIpMgkWHi5IJy4GobWyChvflFQ==
X-Received: by 2002:adf:f1d0:: with SMTP id z16mr28468734wro.209.1576494574226; 
 Mon, 16 Dec 2019 03:09:34 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id x10sm20976131wrp.58.2019.12.16.03.09.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 03:09:33 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/34] arm/arm-powerctl: set NSACR.{CP11,
 CP10} bits in arm_set_cpu_on()
Date: Mon, 16 Dec 2019 11:08:55 +0000
Message-Id: <20191216110904.30815-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216110904.30815-1-peter.maydell@linaro.org>
References: <20191216110904.30815-1-peter.maydell@linaro.org>
MIME-Version: 1.0
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Niek Linnenbank <nieklinnenbank@gmail.com>

This change ensures that the FPU can be accessed in Non-Secure mode
when the CPU core is reset using the arm_set_cpu_on() function call.
The NSACR.{CP11,CP10} bits define the exception level required to
access the FPU in Non-Secure mode. Without these bits set, the CPU
will give an undefined exception trap on the first FPU access for the
secondary cores under Linux.

This is necessary because in this power-control codepath QEMU
is effectively emulating a bit of EL3 firmware, and has to set
the CPU up as the EL3 firmware would.

Fixes: fc1120a7f5
Cc: qemu-stable@nongnu.org
Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
[PMM: added clarifying para to commit message]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/arm-powerctl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/arm-powerctl.c b/target/arm/arm-powerctl.c
index f77a950db67..b064513d44a 100644
--- a/target/arm/arm-powerctl.c
+++ b/target/arm/arm-powerctl.c
@@ -104,6 +104,9 @@ static void arm_set_cpu_on_async_work(CPUState *target_cpu_state,
         /* Processor is not in secure mode */
         target_cpu->env.cp15.scr_el3 |= SCR_NS;
 
+        /* Set NSACR.{CP11,CP10} so NS can access the FPU */
+        target_cpu->env.cp15.nsacr |= 3 << 10;
+
         /*
          * If QEMU is providing the equivalent of EL3 firmware, then we need
          * to make sure a CPU targeting EL2 comes out of reset with a
-- 
2.20.1


