Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FF0CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:44:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E31521929
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ag8ntVPr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E31521929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNuGp-0004T9-RX
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 03:44:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40339)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtpt-0004W8-S8
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 03:16:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtps-00078m-MN
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 03:16:37 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:35402)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNtps-000780-Gl
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 03:16:36 -0400
Received: by mail-wr1-x432.google.com with SMTP id l10so1044272wrb.2
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 00:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zhRtg+sEApcMcRytM7hTlQSCCfAJvUQn9AKAeTxM7RA=;
 b=ag8ntVPrTB6Hdqcf0VI6ZBY+jozPz0D/WjuQZXT6cK4lR7mLJAoTbN+sekjAw5eTO9
 JqUHa3La6o6DRx/x6aKG2TNwSl0jmfGtjWoNjQqcoSjK7OW2zgSHWhuhuNr9oYU5lNjv
 39OBRo5wZMJMHQcaLim+Imjt6Zpbdtj7gOgs1AqvV7R+kZb1VYy5OXbT+lnsiK1ngNEy
 v2mAwqlwPwlM61g7rraBOsG3UmwUU2mXPWlBPy+EyrHCEWPS/HBN6kJPVrIvtgwMzmJR
 ueLgr0BlJui4CBB/QFTztofBNoigWCp450izXI43FN5OYbBUGjTMQ9Ge3qjloQsrqxEJ
 0GMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zhRtg+sEApcMcRytM7hTlQSCCfAJvUQn9AKAeTxM7RA=;
 b=BVv8tGdU3ogt1AP6B3Py/thkFERFgFwtGGyDq0WYreAg1rGlShMiaBr7SQ87BID9A3
 7zIr2AY/Mw0D8yfxggG3egCdL8UygtAJqk+5z21w9t/k47kaRlTbwn2QRJ0K1tbNIKLH
 U3RZLkqh7J+KFiuc5xWsS+ekqMfK0ceoyYBQZqu412FAzVdpadObxqATV/bIGr+MDS1Q
 9p2ZrfEVUeFm/LVh7X5wRTXH/Txt83rtZO+7Bh8avpmXn5dBb/+I+5xa1hB8SKyLaXv7
 bv3/P8pUYDtcRZc69kmcwKEx2ZJbfKkLRQTpSP6HYymfyCuhEeDcKsWeMvQbdUxrrUpK
 9Nsg==
X-Gm-Message-State: APjAAAXX2qRqjiM3+ulEC0Y5KZLYwGywtWXpP5W6gKWBzExjLm4jQr4p
 XGFotl70L6WSK1W3kpZpHdF9PQ==
X-Google-Smtp-Source: APXvYqyQppsDGmmfkncHN/xe/vXR9Je6tp+fTk+XFoFl+8xGZrzeLtEZtcFTpWzFNbJm6Ih2eQEsVA==
X-Received: by 2002:adf:eb8c:: with SMTP id t12mr1419545wrn.34.1571987795305; 
 Fri, 25 Oct 2019 00:16:35 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w17sm1199346wra.34.2019.10.25.00.16.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 00:16:32 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E43A01FFC4;
 Fri, 25 Oct 2019 07:37:17 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 44/73] target/hppa: fetch code with translator_ld
Date: Fri, 25 Oct 2019 07:36:44 +0100
Message-Id: <20191025063713.23374-45-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025063713.23374-1-alex.bennee@linaro.org>
References: <20191025063713.23374-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Emilio G. Cota" <cota@braap.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index c1b2822f605..2f8d407a82b 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -4221,7 +4221,7 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
     {
         /* Always fetch the insn, even if nullified, so that we check
            the page permissions for execute.  */
-        uint32_t insn = cpu_ldl_code(env, ctx->base.pc_next);
+        uint32_t insn = translator_ldl(env, ctx->base.pc_next);
 
         /* Set up the IA queue for the next insn.
            This will be overwritten by a branch.  */
-- 
2.20.1


