Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B11C2D0C3
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 22:28:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 657E421D7D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 22:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bgk4JFkN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 657E421D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igyr1-0000PV-HZ
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 17:28:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37033)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1igybU-0005Vv-4R
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1igybT-0007YB-1a
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:35 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:44038)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1igybS-0007X9-SW
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:34 -0500
Received: by mail-pg1-x543.google.com with SMTP id x7so4482009pgl.11
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 14:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=b1FV8qQCpJxFWsy94CcM4K8EE5MW0MHS/kAxt/18Mds=;
 b=Bgk4JFkNW+sJ/dz5ELiYElrTsrz3fFLExw3bBCromDd2/Y76ofUA+rClxFN10Hgd0h
 HR1srAVtO5XJ9h0rqIstfAn6QhMWq+wEJJdpFiV35kkcg2p5vLJISK3GPwRb8xmxR0Xq
 ZK0CbS3Ol5Ia7w528KtGnhRIlt70Bp+NHhVN3ROszjSzHThGRtbxRMVOJeoWXphryGTU
 2sMR/cHEsJjul+yrYQoELeBBew1snWwY2zyoiUwBmiirfs3t8zjULI2sLg29ngxIqACc
 MNi+VgDZtE464SNL9pJYCyf+H87GO1C6OPdDyBSFeZvF09V7f161FYedOp6fhwvHD4v/
 IKoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=b1FV8qQCpJxFWsy94CcM4K8EE5MW0MHS/kAxt/18Mds=;
 b=cGfDVq6EjhEHy4zrfcI8825ZzWhaguAjY2KwOrhNa4EPjLF1d1U2aF8xID84cJ5+of
 e8HYHWuCRQ64leDpCAl0jsqrS0xFQQw3kpG+hkDEpYGZS0Cy3lBqkuwyVZLqquJjZTZj
 k/I1oD6mm4bdcqDbt69YxAZ9rT8yS0PhpikKLrdolUa7GHFyxzhmRhVK+iYyvtTzIB4P
 5IJQKEZEVzfL+bGx/ABaOZG4A0r6aKhwKHvRrBuwe3TFK0uTz+M4BJzPevdwYJF6gm5X
 WzCxVmtpof5LX60NIwnwDR+yLgLfNhxlJFVQ5ri3d8bpmgxGyUMFCzL7CerUVXo+I4SV
 3weQ==
X-Gm-Message-State: APjAAAX2eYv21Mxf1l8T70ECOL0q4G8LZsat56pwuSQ1o93+ZCURPVoX
 eFEVzsCsNMy+wOkD19X2lp5ICTm3B2Y=
X-Google-Smtp-Source: APXvYqxlqmUBGuu9wkYGto3MkJ5WYBKHjJI0h0pGkRpVWxxMQpIRgEtXtEWKUDZOAPsD/WwhFuJJFA==
X-Received: by 2002:a62:5202:: with SMTP id g2mr18486921pfb.43.1576534353739; 
 Mon, 16 Dec 2019 14:12:33 -0800 (PST)
Received: from localhost.localdomain
 ([2605:e000:c74f:dc00:6838:d2b2:17e2:8445])
 by smtp.gmail.com with ESMTPSA id d6sm529767pjl.8.2019.12.16.14.12.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 14:12:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 21/28] target/unicore32: Remove MMU_MODE{0,1}_SUFFIX
Date: Mon, 16 Dec 2019 12:11:51 -1000
Message-Id: <20191216221158.29572-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216221158.29572-1-richard.henderson@linaro.org>
References: <20191216221158.29572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The functions generated by these macros are unused.

Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/unicore32/cpu.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/unicore32/cpu.h b/target/unicore32/cpu.h
index 50ed9dd99c..7a32e086ed 100644
--- a/target/unicore32/cpu.h
+++ b/target/unicore32/cpu.h
@@ -133,8 +133,6 @@ void cpu_asr_write(CPUUniCore32State *env1, target_ulong val, target_ulong mask)
 int uc32_cpu_signal_handler(int host_signum, void *pinfo, void *puc);
 
 /* MMU modes definitions */
-#define MMU_MODE0_SUFFIX _kernel
-#define MMU_MODE1_SUFFIX _user
 #define MMU_USER_IDX 1
 static inline int cpu_mmu_index(CPUUniCore32State *env, bool ifetch)
 {
-- 
2.20.1


