Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD812C10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 13:08:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A586520675
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 13:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XwUfkKGk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A586520675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36419 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGNpW-00051e-Qd
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 09:08:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGNf7-0004bS-GD
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGNf6-0001B8-F8
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:09 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38193)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hGNf3-00015u-2K
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:06 -0400
Received: by mail-wm1-x343.google.com with SMTP id w15so25304725wmc.3
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 05:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=kMVdzvD/XiERD9we9lBIjwqedh398KDiYXQYlDS231U=;
	b=XwUfkKGkrXVJMk+vO1201fkwjDMcyWw5SXhBM5FV06Y5VvZluX5LaJ+gsW1nymTKsi
	lrxrIO1Fv3fP3ffGmubHBc4DlOabh6Y6Z/+jft6eEedpdVYMGxkhINvXTV7WIDpa434Z
	cXmoFArG9pBeT1uG3W3GONGvaZg0zyB7uotL3dWv+6hYYjIZzK/9fs9ny0lyYY5+cGY0
	n36DACKlJ8GPRIzlekJk/wV6xJDV1v1TgX3h/QSp068JBx5D55V+2COWoXr4Y14oHoui
	GCwhHrkRXF0vaM+X9Oqa+pUY1Rkvq1C49AXo/pyVfrwjkXmHJWKwC0bRMAYzhNjSUWce
	uxwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=kMVdzvD/XiERD9we9lBIjwqedh398KDiYXQYlDS231U=;
	b=Cudqho5CV+Af4bEDVbYHDe5nxFamVVi3rp5LnxaSXfeLCnVhZcOSbNayGFQcwkWlnL
	TeA9N15fVRg0PY4bXso148oAQOA8701a0EPQCZhYpBhqfQALNSnmmAMRAXo90/laYROI
	3juFsGeynnDk1HSf/23Kcdx4P8nD5AKQq0S3AgtRvQbSkCbKyh/08iHoaDOBkJkzwRGt
	EgovNvEafAQvBqYftktbNgRNRcHCCpHCA5xeewyDdA6n4IP3g+ooUXG/16BcnD18H7cl
	1Qfird8a/6r2C/6QRTaFsUrTSgBErYWut17C4MJoKG7yAlAjhJe2EdF7o7K7mUEvl2P7
	1eQw==
X-Gm-Message-State: APjAAAVVNn9RAtr5uNx4sqUIvrXR5zDUZpQw2r5nDMnxM0FMc/E8veeB
	6hv3ZkL01dpN04eHdxMqz8VN+g==
X-Google-Smtp-Source: APXvYqwVYcJvOus7BS4rYoWjWtoUaJ9oX4u68pNhz+cb91nM2UAIJT9xtrHg2pPLP5hEIPL+RLDI/Q==
X-Received: by 2002:a7b:c92f:: with SMTP id h15mr26435726wml.115.1555419480496;
	Tue, 16 Apr 2019 05:58:00 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	v184sm39476572wma.6.2019.04.16.05.57.58
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 16 Apr 2019 05:57:59 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue, 16 Apr 2019 13:57:25 +0100
Message-Id: <20190416125744.27770-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190416125744.27770-1-peter.maydell@linaro.org>
References: <20190416125744.27770-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH 07/26] target/arm: Clear CONTROL_S.SFPA in SG
 insn if FPU present
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190416125725.DvJr8p9HJ9ii--eGVkTzy3W697db6Lx0ZP_68sQJhXE@z>

If the floating point extension is present, then the SG instruction
must clear the CONTROL_S.SFPA bit. Implement this.

(On a no-FPU system the bit will always be zero, so we don't need
to make the clearing of the bit conditional on ARM_FEATURE_VFP.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 27e5f98bc73..b4f1609a1c6 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8809,6 +8809,7 @@ static bool v7m_handle_execute_nsc(ARMCPU *cpu)
     qemu_log_mask(CPU_LOG_INT, "...really an SG instruction at 0x%08" PRIx32
                   ", executing it\n", env->regs[15]);
     env->regs[14] &= ~1;
+    env->v7m.control[M_REG_S] &= ~R_V7M_CONTROL_SFPA_MASK;
     switch_v7m_security_state(env, true);
     xpsr_write(env, 0, XPSR_IT);
     env->regs[15] += 4;
-- 
2.20.1


