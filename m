Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DED1C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 13:37:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 223E4206F9
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 13:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SeSlMpVO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 223E4206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY8cb-0007NC-8k
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 09:37:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48968)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY8Zc-0001ry-9q
 for qemu-devel@nongnu.org; Mon, 11 May 2020 09:34:24 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:39230)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY8Zb-00071C-00
 for qemu-devel@nongnu.org; Mon, 11 May 2020 09:34:23 -0400
Received: by mail-wm1-x333.google.com with SMTP id y24so19312611wma.4
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 06:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=DLnD8953PRrsw//8fypvw6MUqDO9NndS+JGe2zBreDM=;
 b=SeSlMpVOHNTTqxXWGPXooYTZZr1cpLNMuqH1xBfF9AcBDx2AodmCHuy8quWnfkkk0a
 Ccpubbe2CrrSZ/7lkvCGyvD3oxIjKeKUVQ3QoAZCZeH+p2vn3hCo3i7DnKHJUD+7GKeo
 01Zu3BJ8hwUaUh7MkPYo7MA+VFSYLsOIi/Q/GBq0S7+7dcF8CF0QF8vf/QdaqNWXlxHh
 8vHTjpFk6nqwXHjNfpbykS1ebZg2tq5ugcWV50f8oTfPgXlCdVyuAloSTZw/ESZkVkY5
 wCO4+eSdlMjwl8OxRsNkcrtBMXZWLOCIP4dhwJz3zf3oz5cUhMXP1mwiSUYTVTFZaUPq
 BJhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DLnD8953PRrsw//8fypvw6MUqDO9NndS+JGe2zBreDM=;
 b=P+K8fc2bnyoVBHN3N8QwJ8i3ACz9ua7S+GxRrewEdOztlLMwrn1sWCOxguCnhoQjAK
 MrKIPlIhzy3eMaiuoiNJLPJxZ+cydLiyOx4Wls7Vf6y0FG8//hfhcZtSJWl96TzHAOk4
 34qm4YUISnFx+vmEed9OXwX+MgDA8MZneCq6d1na7Q8L8fEAnIvGUOuCepLHgBgUR7F+
 mioWFscPiHk/OWFC39Cu03y2G44T/BF8mzgAeVJvaLl5ajsgEqMxSjc2/PKA92pDxmaf
 dMWS6BpEId5HKHo+tNCkA/CzGXJ/Xi178f9eMwCJaICtDbUZWd8thUFg6piY8fl/cI2f
 fYPw==
X-Gm-Message-State: AGi0PuYelVlOkzlwUkfDMu5bgWvwhrfhMLS/P1wiq4ytEhGrb2WzkF72
 szzFNx03eRZ2gh09X3M6mwXXDEA8Shw89w==
X-Google-Smtp-Source: APiQypJvj0hbwPspA9eLR8ZUFeJ9u+/EgXvYxVT7nLYuistz7uPiBD2FrNv504FVYvTfoZCrBk17KA==
X-Received: by 2002:a1c:740e:: with SMTP id p14mr8253679wmc.102.1589204058846; 
 Mon, 11 May 2020 06:34:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id m3sm2154818wrn.96.2020.05.11.06.34.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 06:34:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/34] accel/tcg: Add block comment for probe_access
Date: Mon, 11 May 2020 14:33:41 +0100
Message-Id: <20200511133405.5275-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200511133405.5275-1-peter.maydell@linaro.org>
References: <20200511133405.5275-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200508154359.7494-4-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/exec/exec-all.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 350c4b451be..d656a1f05c0 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -330,6 +330,23 @@ static inline void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *cpu,
 {
 }
 #endif
+/**
+ * probe_access:
+ * @env: CPUArchState
+ * @addr: guest virtual address to look up
+ * @size: size of the access
+ * @access_type: read, write or execute permission
+ * @mmu_idx: MMU index to use for lookup
+ * @retaddr: return address for unwinding
+ *
+ * Look up the guest virtual address @addr.  Raise an exception if the
+ * page does not satisfy @access_type.  Raise an exception if the
+ * access (@addr, @size) hits a watchpoint.  For writes, mark a clean
+ * page as dirty.
+ *
+ * Finally, return the host address for a page that is backed by RAM,
+ * or NULL if the page requires I/O.
+ */
 void *probe_access(CPUArchState *env, target_ulong addr, int size,
                    MMUAccessType access_type, int mmu_idx, uintptr_t retaddr);
 
-- 
2.20.1


