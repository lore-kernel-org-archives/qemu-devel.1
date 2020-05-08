Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4F8C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:46:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 358F42173E
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="flR+XRqH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 358F42173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX5CU-0001A6-Bo
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 11:46:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX5AZ-0007YL-Pv
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:44:11 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:36043)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX5AY-00050V-VM
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:44:11 -0400
Received: by mail-pl1-x642.google.com with SMTP id f15so890626plr.3
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 08:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=60NHpUUrot7w8V6Qsa37kh//ITveCZoOpAk4TR6uozc=;
 b=flR+XRqHuuazMereqgSOR04jcBmcjTUaPIMlPBoqVlvOdNAU0kaCasfr7f/7oeU3bv
 OY2cnbTrwj5hdTYZvTkVcS/lBBUlo+3pKgx4Lg8jzSgR/rGSMqQ/cBI0DOuyaxW/yQ+d
 DVb/eCytAzKGpi6R3l8N0jUhbZN63n4YdagiBrrk5pFmqa6LRu9C8J43f+6Ym21cMsIT
 fmjwLQJR1xgt8Y+wZjMNdrlL78E1p8oE4PErVzjSlTqxmrbCfizwuXmIn8ELZ8sWt4mN
 8tr7f19X2tab8MEi0Q4NJUq8Cc9+qwSBS+d0AqlvFBEDAu8HmNPhPxYImoYdwxTIQJwz
 nvrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=60NHpUUrot7w8V6Qsa37kh//ITveCZoOpAk4TR6uozc=;
 b=anzBrduZ1YLGVahAGpMwiMhDAHDk6/MLF3wT7bk4JuCN/8yLiEMOqayUCW8qEVUAbQ
 ioUlngz6qKeSkeQjDpVy7fj/yrnOnwMTD4ROnU1JYInSYCKKUNahVqTDQBfNlPv5GHwz
 Olas5TerU3Pq4FzJNk0s333zQie/Ht9N1vOH3jiaOQW3Wzak7WdRhH3NkrUzS7JH6XW8
 CuP2nzoHIANmXyyqhFkEYxVns5U2oXeU++HC9GoJOcLvEDO7JK2VY4m5XRU0mXLJ+9+C
 ILGiqs8eQI3O4BL6rQ51qMRMnfSjBcxX9rTpv+BxG8OC/qQEDoAwaTlVnMmRxkD2jKmg
 snww==
X-Gm-Message-State: AGi0Pub/O8AXyA0oJE7ztBaTTW9fjnc29KOhZW07s2lLbeKgMNbIok8R
 PSZjV1qCTvDEtGroOE+a0IKShMMmOGw=
X-Google-Smtp-Source: APiQypK+Vno/T4DJmwHow5vI/R3dt1dRexyB9OZF9QcrRaH2RvJWqtXEt+1a4SgqtBnnWH0TsXZQxg==
X-Received: by 2002:a17:90a:c297:: with SMTP id
 f23mr6236149pjt.21.1588952648845; 
 Fri, 08 May 2020 08:44:08 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id o99sm2727662pjo.8.2020.05.08.08.44.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 08:44:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 01/19] exec: Add block comments for watchpoint routines
Date: Fri,  8 May 2020 08:43:41 -0700
Message-Id: <20200508154359.7494-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200508154359.7494-1-richard.henderson@linaro.org>
References: <20200508154359.7494-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
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


