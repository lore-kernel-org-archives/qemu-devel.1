Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B54BC47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:37:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1F6C2070B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WGRsa/jb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1F6C2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUCBS-0005Iw-Un
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 12:37:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49288)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUC2u-0001VL-N4
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:28:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUC2t-0006Ll-02
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:28:20 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:39140)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUC2s-0006LS-K6
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:28:18 -0400
Received: by mail-pj1-x1041.google.com with SMTP id e6so906728pjt.4
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 09:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=60NHpUUrot7w8V6Qsa37kh//ITveCZoOpAk4TR6uozc=;
 b=WGRsa/jb4slKUiLxKpF6qoZYYNfNvBuoETV4tG9wSE13m/jUvjchzXgxa1rSfXRT13
 /CgcsPHr5LCUILO9VY7BX6SJ0SKYsIcXP/+LJp+Wnm0J7TR61kaqy9QLdomzo+4TmcbS
 8NaP9oQ7Sj/L/sgx5tLQoQA9VUziIuJ/QE3IFF6TPF2hhYxagvojGDS0wLwBA4Dw6R94
 AI1HRxQ5a0GgFG0uYtwZUkbSXyonU60+rLJCwmAOePsqnvCichA8WvF2yFaX5OZa8CXd
 Vm3AiDeIgL29yTuSip76/6rIkEF6nj5BQmDXHNGZBxDUqpeXht7GY/re6SoEQG9VkGPL
 cq6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=60NHpUUrot7w8V6Qsa37kh//ITveCZoOpAk4TR6uozc=;
 b=U2sTDm8bu4TxoTM1mTlhQk2pzKjCLA7YVvOHOMeUPp+FP2RjHO8OMcncXwHKiLEb4N
 VdptbqmgcfRxPVZZ+9RmdoOdg0aK/16lzr88Wl/YvrqX9TJqBVXjcf7bVnsawMKoxb01
 W/QjMM05PBIT2FLnEraqSmBrSAyTxmv2VVl3e1zYr55RTWwdq2yZLyf2R6IpeoIj3xfm
 pUHpZA99xqnIQlkX91uRnLCeHkyl8MVk0C9jUnCI3wpZVPjSE49luEA/YD286oF4uKmG
 4DV4mgfOk0M0c22kmUpneOUEfVb4RLEWC9AqMPnaL7sMY+qf493/JcxdBv3aVJhsEmd/
 +MAA==
X-Gm-Message-State: AGi0PuYtS+wNALYl01ARIvlHWO0ORGOU4Vu2SNtEo/cjAWayrh3PwRBm
 qKXiksg00ZP0Q9MtIESlJWXVm1fgfVM=
X-Google-Smtp-Source: APiQypLRep7am6BYi3UWF0K0/qL9z+NQ/MzqfEVLPSGG2uEcEuDFNSVloqUi2msTAFcB50uO3YGOEw==
X-Received: by 2002:a17:90a:276a:: with SMTP id
 o97mr3964206pje.194.1588264096700; 
 Thu, 30 Apr 2020 09:28:16 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id j5sm243514pfh.58.2020.04.30.09.28.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 09:28:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 01/18] exec: Add block comments for watchpoint routines
Date: Thu, 30 Apr 2020 09:27:56 -0700
Message-Id: <20200430162813.17671-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430162813.17671-1-richard.henderson@linaro.org>
References: <20200430162813.17671-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::1041
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 5bf94d28cf..07f7698155 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1100,8 +1100,31 @@ int cpu_watchpoint_remove(CPUState *cpu, vaddr addr,
                           vaddr len, int flags);
 void cpu_watchpoint_remove_by_ref(CPUState *cpu, CPUWatchpoint *watchpoint);
 void cpu_watchpoint_remove_all(CPUState *cpu, int mask);
+
+/**
+ * cpu_check_watchpoint:
+ * @cpu: cpu context
+ * @addr: guest virtual address
+ * @len: access length
+ * @attrs: memory access attributes
+ * @flags: watchpoint access type
+ * @ra: unwind return address
+ *
+ * Check for a watchpoint hit in [addr, addr+len) of the type
+ * specified by @flags.  Exit via exception with a hit.
+ */
 void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
                           MemTxAttrs attrs, int flags, uintptr_t ra);
+
+/**
+ * cpu_watchpoint_address_matches:
+ * @cpu: cpu context
+ * @addr: guest virtual address
+ * @len: access length
+ *
+ * Return the watchpoint flags that apply to [addr, addr+len).
+ * If no watchpoint is registered for the range, the result is 0.
+ */
 int cpu_watchpoint_address_matches(CPUState *cpu, vaddr addr, vaddr len);
 #endif
 
-- 
2.20.1


