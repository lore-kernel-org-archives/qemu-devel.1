Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D430EC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 17:36:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FF6222461
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 17:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGd4lNF/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FF6222461
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRIng-0004TY-KN
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 13:36:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRIdz-0000ib-Oi
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 13:26:55 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51511)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRIdu-0003sn-Hl
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 13:26:53 -0400
Received: by mail-wm1-x341.google.com with SMTP id d81so12887208wmc.1
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2020 10:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fgZXf1AO3a8DivRJPhe6TxsSwXBBGYh+JMLoIUTG0d4=;
 b=EGd4lNF/KpmfPrGyVCHMr+mpveFNL1Yt22slAVadkyjHRo1G0Aa4bc8H8QRbnhdgpU
 6B3JDC80Ci1SiGRsNghB24VJ+0aU5K8zoN1vF5LTn7Npb6LWGKtxgU/7QvbEPPIQBf4O
 ZQI2f0yfPn6AYfw/qjCELOXrJwB3hI4ciXghMS1iaC/rKhTFSspAdYCKYvv/1lRb3RU8
 99wE7nUWzME18k2UDQuI54pLwfocVtkZ/U+/ue/lHzhDlLFf/CPCw+hSLgUOFhH0Z8Pi
 XdIoYh/cAgatSrH5yre5m6y/ed4f8vVOjaRI20pvzkPyWzMlVwOsqJQGN4Jvxx4V7vmn
 5UMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=fgZXf1AO3a8DivRJPhe6TxsSwXBBGYh+JMLoIUTG0d4=;
 b=MOmvsAG+VL77pcXHRd+wKkbpkr9m/Vnq2doxUzqSm8xF6IpbNPQXsk2JjSqxz3jq/Q
 6eb+YT1lv0NFOz6ROIwPdRaeumUeMokVHesa72UJy91b8exTbnSOxmBKvYNrz7fUpG7t
 lTzjMerQtSdJt7mrkN3tNRNd6x3fcpRGgU31Z9UYN6zVwxTe1m+222Osu1IuKFMedCTa
 65wKBG7iwO9r2xdK13uuAspLdOPfIzQFIpHtfllr8+X6ramVDA7bAmQpBsFSp8oOWP5v
 bzX3JRe5GjyfEV8qk8zejDzEp/W/T26Ips9WgKB1CIXvoCJx/Coe3hbAsdg6nToMNmuP
 cCHQ==
X-Gm-Message-State: AOAM533jD+W31vV3GIMI9rFwF3Y4ixPQmRIiElPB7oFpKZfVgx+ML9CM
 TEHoHYFkvr/m2k4fAjHX8QU682ThUrs=
X-Google-Smtp-Source: ABdhPJzzNiQ/s6w5qvGsEb3o6kbK74SPUB/U1duMhWbJLmyvI5wZw8wca8CtPLSG5Eia1rkjCpeFoA==
X-Received: by 2002:a7b:cb4a:: with SMTP id v10mr3380280wmj.87.1602350805273; 
 Sat, 10 Oct 2020 10:26:45 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id i11sm16786068wre.32.2020.10.10.10.26.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2020 10:26:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 19/20] hw/mips/cps: Do not allow use without input clock
Date: Sat, 10 Oct 2020 19:26:16 +0200
Message-Id: <20201010172617.3079633-20-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201010172617.3079633-1-f4bug@amsat.org>
References: <20201010172617.3079633-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, Luc Michel <luc@lmichel.fr>,
 Paul Burton <paulburton@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now than all QOM users provides the input clock, do not allow
using a CPS without input clock connected.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/mips/cps.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/mips/cps.c b/hw/mips/cps.c
index c332609f7b3..f044e500b8c 100644
--- a/hw/mips/cps.c
+++ b/hw/mips/cps.c
@@ -74,6 +74,11 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
     bool itu_present = false;
     bool saar_present = false;
 
+    if (!clock_get(s->clock)) {
+        error_setg(errp, "CPS input clock is not connected to an output clock");
+        return;
+    }
+
     for (i = 0; i < s->num_vp; i++) {
         cpu = MIPS_CPU(object_new(s->cpu_type));
 
-- 
2.26.2


