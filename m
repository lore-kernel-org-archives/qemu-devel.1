Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7084DC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 14:48:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B9E22075F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 14:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v6Ihq+HM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B9E22075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZbds-0000y0-FF
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 10:48:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44518)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jZbZS-0002Pp-Hw
 for qemu-devel@nongnu.org; Fri, 15 May 2020 10:44:18 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:40785)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jZbZQ-0000yo-J2
 for qemu-devel@nongnu.org; Fri, 15 May 2020 10:44:18 -0400
Received: by mail-wr1-x42b.google.com with SMTP id e16so3843600wra.7
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 07:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=shIR+tStLvvJHR4Gop6YH3kVk2PMh0U4kUFwicdynrY=;
 b=v6Ihq+HMqawdA8xXa+LH7phlq10TP3+j0uU+vmjmsetX5aowjTMFnTUDJQ49Onn5TD
 S1o7SwlWhPXhyj/emZgC8CswixlHLC0q4zU7ov95tyaSyw+2m51LkvoIpadn7rwVpdUA
 AtaULYlIhoDP7D4ITZYdTuONU5/D8zyGXE87sByhHoqCNlnv1Cm+LhO0R+aElAZ+sCWt
 f7sFOLfaSylLEbNT/J6fsxze/NtExFNHXc0pU+jWaptUZjztJKwEEQLZu1nPMIibVaDK
 pMgF1GykwwL7RVJLHR/1ABwJufCGUaeNz1JCkMBOTSUo6Yi9VY3HztmOR/aj6MaMS9h0
 TWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=shIR+tStLvvJHR4Gop6YH3kVk2PMh0U4kUFwicdynrY=;
 b=XE9eaAY4acPZhOUGxeXB6otK9QvYUti/4adiA//FJDOhEq4h6xIffy41NSk/CGxVt1
 Du2NmwdXVVHmBShlRooa1Y1Jf/Wvqk+0u074an6eMSsfJksbaxdfKkSlb050k9qBJR7s
 6hqwCYNvbcPkdqoj2+qR/lEe45KNUL8MoeUHrQbKdW3t3HOp1ou3Va4yLFayl6AvmRfv
 d0Pm/KVtyWPEpM/Gu0eZ7KReX3VqFVwIbSoQdGEamoV8nK0NvwyguEYDTAhztClXyl2f
 PPiQHxyZCPMIrO6h+lIQC5eeBUfuu8HFcWX0wYTwgj/CB8C0WOipeVItnDMBPWuCWcBP
 cwjA==
X-Gm-Message-State: AOAM530DznDzsmEr6CpnfNMqqs93gkd6eVlAzaXMWM3vgvjjiOPYAhhZ
 ZZcjPzfVocVYbULhQk6hvkoHSw==
X-Google-Smtp-Source: ABdhPJxj5jpDbDsiw9I3it+o1VgEOfyvw5ZBdIisdVnWaJ3CMiRuiuNUftLzngevoeAfH8p2O5BCKA==
X-Received: by 2002:a5d:5011:: with SMTP id e17mr5017213wrt.347.1589553855265; 
 Fri, 15 May 2020 07:44:15 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b19sm4182142wmd.26.2020.05.15.07.44.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2020 07:44:12 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B54DA1FF92;
 Fri, 15 May 2020 15:44:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 06/13] accel/tcg: don't disable exec_tb trace events
Date: Fri, 15 May 2020 15:43:58 +0100
Message-Id: <20200515144405.20580-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200515144405.20580-1-alex.bennee@linaro.org>
References: <20200515144405.20580-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I doubt the well predicted trace event check is particularly special in
the grand context of TCG code execution.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200513175134.19619-8-alex.bennee@linaro.org>

diff --git a/accel/tcg/trace-events b/accel/tcg/trace-events
index 01852217a66..385b9f749b8 100644
--- a/accel/tcg/trace-events
+++ b/accel/tcg/trace-events
@@ -1,10 +1,10 @@
 # See docs/devel/tracing.txt for syntax documentation.
 
-# TCG related tracing (mostly disabled by default)
+# TCG related tracing
 # cpu-exec.c
-disable exec_tb(void *tb, uintptr_t pc) "tb:%p pc=0x%"PRIxPTR
-disable exec_tb_nocache(void *tb, uintptr_t pc) "tb:%p pc=0x%"PRIxPTR
-disable exec_tb_exit(void *last_tb, unsigned int flags) "tb:%p flags=0x%x"
+exec_tb(void *tb, uintptr_t pc) "tb:%p pc=0x%"PRIxPTR
+exec_tb_nocache(void *tb, uintptr_t pc) "tb:%p pc=0x%"PRIxPTR
+exec_tb_exit(void *last_tb, unsigned int flags) "tb:%p flags=0x%x"
 
 # translate-all.c
 translate_block(void *tb, uintptr_t pc, uint8_t *tb_code) "tb:%p, pc:0x%"PRIxPTR", tb_code:%p"
-- 
2.20.1


