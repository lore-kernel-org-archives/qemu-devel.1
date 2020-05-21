Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69121C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:19:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26EFA20759
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jsk7EHgC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26EFA20759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jborC-0002iP-D4
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 13:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50174)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboJD-0004Su-Px
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:44:39 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:34330)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboJC-0006j4-R6
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:44:39 -0400
Received: by mail-qk1-x741.google.com with SMTP id 190so7917992qki.1
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DROR1j7T4nvT3Kb9/UW2YDjxvm1xSx4iyEWd3x/xCYw=;
 b=Jsk7EHgCy0F5z0OqfBb9qvVNN1MWfkVXUS5hylU8y/EYU03wvdaRFqRXrbzaapZeq1
 kW++2lZfsFYNJ0h2NR0XFTWVobJS3D01QoIsvIDMydnamlic1uhsCZpOEEPa6nSa3Dn3
 9zjBSi1O9hOg422U4dl9OYNbZ28soZWNWdtSzgVLvIUZiHKhZgdCt/9cGXert1KBqj0S
 e8qmVFkOyFoe8RpdrlePkU2jq6GA1YeMy8FZ3/3R19xJy6Tw399OpkVLuwH5Uqv+f11Q
 PPN/Zgj7OOpGvnokyqjIPfk7UCddI3jA+OSqco6pwAgJP89wOME7jqZ2j2ue998aJtBQ
 v5Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DROR1j7T4nvT3Kb9/UW2YDjxvm1xSx4iyEWd3x/xCYw=;
 b=XMWHSxuhV7Wfi3yv+90RbgMcBaD/4MqqAMYPIe1yyRWEjPVtztWuyeH/YKuyinKgCn
 3uotd1nM5nWsVo69zBd6ewXUAKbzTiYM1f51HsDnSis6h6MnTxJRq7+GzBqdx/QGgpI7
 hy+s5NPMGtTAEjDs/n2Y6mS7pPIJ+AZWHuym3xnfpAVUdHABMR+WOmbC3J8uo/uOQB6l
 KSIB+p4J4fkUDjKvyN6NoI6bFDDJ8+JnL8vUwIb1veVF16qGgm1h3+Pw9X+PH/pwvsQR
 GEu3cPpMpJ+mQHWyrzHEuVxcr6lPWv+ZZhhFeGbkNi1yzINKi4GLm2a0uh97ioAb0Bal
 znOQ==
X-Gm-Message-State: AOAM531UaonHtgDZ4RpQza/0Wb4RwDtoZFb5s7PwizyRZME+gLyNLuf/
 hfwrIpI5cRsWg6sOx0+UzCtafF0ZFxdadA==
X-Google-Smtp-Source: ABdhPJzTSei10pjMgAv459Ojig7dcZWcbVkLQL+4ciRUS3g86QEZdDSCSCW6/UKMdUpELJHx4Si0Sg==
X-Received: by 2002:a05:620a:14ac:: with SMTP id
 x12mr10392691qkj.262.1590079477697; 
 Thu, 21 May 2020 09:44:37 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:1944:c530:655c:5583])
 by smtp.gmail.com with ESMTPSA id x24sm5923829qth.57.2020.05.21.09.44.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 09:44:37 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 62/74] cpu: call .cpu_has_work with the CPU lock held
Date: Thu, 21 May 2020 12:39:59 -0400
Message-Id: <20200521164011.638-63-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521164011.638-1-robert.foley@linaro.org>
References: <20200521164011.638-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::741;
 envelope-from=robert.foley@linaro.org; helo=mail-qk1-x741.google.com
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
Cc: richard.henderson@linaro.org, cota@braap.org, alex.bennee@linaro.org,
 robert.foley@linaro.org, peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 include/hw/core/cpu.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 6ed806db60..7bf7700630 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -80,7 +80,8 @@ struct TranslationBlock;
  * instantiatable CPU type.
  * @parse_features: Callback to parse command line arguments.
  * @reset_dump_flags: #CPUDumpFlags to use for reset logging.
- * @has_work: Callback for checking if there is work to do.
+ * @has_work: Callback for checking if there is work to do. Called with the
+ * CPU lock held.
  * @do_interrupt: Callback for interrupt handling.
  * @do_unaligned_access: Callback for unaligned access handling, if
  * the target defines #TARGET_ALIGNED_ONLY.
@@ -799,9 +800,16 @@ const char *parse_cpu_option(const char *cpu_option);
 static inline bool cpu_has_work(CPUState *cpu)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
+    bool ret;
 
     g_assert(cc->has_work);
-    return cc->has_work(cpu);
+    if (cpu_mutex_locked(cpu)) {
+        return cc->has_work(cpu);
+    }
+    cpu_mutex_lock(cpu);
+    ret = cc->has_work(cpu);
+    cpu_mutex_unlock(cpu);
+    return ret;
 }
 
 /**
-- 
2.17.1


