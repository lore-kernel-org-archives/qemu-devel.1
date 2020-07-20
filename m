Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C0FC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 13:03:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4493207FC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 13:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y5GZAcoH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4493207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxVRt-0004ey-89
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 09:03:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxVLS-0002Ya-KA
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 08:56:38 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:45470)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxVLQ-0007Jj-Jl
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 08:56:38 -0400
Received: by mail-wr1-x42d.google.com with SMTP id s10so17690948wrw.12
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 05:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=P4gnsXwsGRcRiwGn2A5K5QHmrCzJUCvt2/Zcs5cjl3E=;
 b=y5GZAcoH9WrQmtqsoxmcJfVed8YL6npKSRyb+TheylAO9gPAMvVsV7cdNZokPaUlr1
 zg1zKvkmSJ2VbeMbNLAsXy2j6RUFHZs7ma3Uw4QdbcVUpHJaLk2CBonvxUvAOrLqCt5e
 XX+78Md4wLzDSGTPNyNZYZuBNwaEpxv7yugZ9mMaeyFvhQ7s78sOIWZHMlI9Y9wGDgyM
 JRyPSzv75AoYalZeHzwy81AtFDFh801PKCpNrN2THfyyWTPpRcxPGJS2JZ8aivSy9etd
 Ki9uBHBIC42TOD14+w5kgTB5vmmLBF2GImwuDrlrIsWD0bSIIb57EP8/TAgxiHtHhZhr
 Iu8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=P4gnsXwsGRcRiwGn2A5K5QHmrCzJUCvt2/Zcs5cjl3E=;
 b=Jg0D3BoBvVzX0pe0jX0Qbbd7lb0rM0e+vLf7NGYsLfIdL83SwHh4KbXHTflODeqiTT
 3/biD6In6JgOHnh5JTwlNvFq5qzb1eDc66cFbeOX6yadwpCpHV8mV+soTn2L1A6nZ0Sx
 8N8b8+eRZfP0tpARK80CygvePxvOgch2FrUJ5wQ0P6mSlbVOgH87sR5CU34fY1Pihdjm
 nO6XV7rTbe4NiKOdob1iw2gEOeO2zblVekjSH/9m3DSvBBbAviQ1dB9vsfN7YNrzogAg
 tpfON0t2Cl4s1/AFlnkY8wICKWsO4AKw4UQO0xYi7iROroyHCVwC1IqEa8JlLl/Mdx0k
 rhLw==
X-Gm-Message-State: AOAM530m0QFt51cQA82thm0HsPwguhqzKPF3d1OKlKdQad/h9CurtuXh
 5TLjxvyz3v0KA35vMewHRUNoSe9Wcswr5g==
X-Google-Smtp-Source: ABdhPJyeYNaCLPgLC+6x2xaL/bwYyH3rq354upXx1O1KQ7pa17YNhpEL55mZQXU0du2JhuhbYPWr5g==
X-Received: by 2002:a5d:69c8:: with SMTP id s8mr21757642wrw.405.1595249794899; 
 Mon, 20 Jul 2020 05:56:34 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p29sm34025403wmi.43.2020.07.20.05.56.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2020 05:56:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/12] docs/system: Briefly document canon-a1100 board
Date: Mon, 20 Jul 2020 13:56:18 +0100
Message-Id: <20200720125621.13460-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200720125621.13460-1-peter.maydell@linaro.org>
References: <20200720125621.13460-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add skeletal documentation of the canon-a1100 board.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20200713175746.5936-2-peter.maydell@linaro.org
---
 docs/system/arm/digic.rst  | 11 +++++++++++
 docs/system/target-arm.rst |  1 +
 MAINTAINERS                |  1 +
 3 files changed, 13 insertions(+)
 create mode 100644 docs/system/arm/digic.rst

diff --git a/docs/system/arm/digic.rst b/docs/system/arm/digic.rst
new file mode 100644
index 00000000000..2b3520ff5e1
--- /dev/null
+++ b/docs/system/arm/digic.rst
@@ -0,0 +1,11 @@
+Canon A1100 (``canon-a1100``)
+=============================
+
+This machine is a model of the Canon PowerShot A1100 camera, which
+uses the DIGIC SoC. This model is based on reverse engineering efforts
+by the contributors to the `CHDK <http://chdk.wikia.com/>`_ and
+`Magic Lantern <http://www.magiclantern.fm/>`_ projects.
+
+The emulation is incomplete. In particular it can't be used
+to run the original camera firmware, but it can successfully run
+an experimental version of the `barebox bootloader <http://www.barebox.org/>`_.
diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
index 1bd477a2936..8fa51a22817 100644
--- a/docs/system/target-arm.rst
+++ b/docs/system/target-arm.rst
@@ -82,6 +82,7 @@ undocumented; you can get a complete list by running
    arm/versatile
    arm/vexpress
    arm/aspeed
+   arm/digic
    arm/musicpal
    arm/nseries
    arm/orangepi
diff --git a/MAINTAINERS b/MAINTAINERS
index 5d9c56e441d..9ed36dcf736 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -636,6 +636,7 @@ F: include/hw/arm/digic.h
 F: hw/*/digic*
 F: include/hw/*/digic*
 F: tests/acceptance/machine_arm_canona1100.py
+F: docs/system/arm/digic.rst
 
 Goldfish RTC
 M: Anup Patel <anup.patel@wdc.com>
-- 
2.20.1


