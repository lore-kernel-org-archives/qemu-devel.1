Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F32C4724C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:53:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 818B8206D6
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZdydXPRh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 818B8206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX5Jq-0000KL-Nj
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 11:53:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX5Ab-0007cP-T1
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:44:13 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:33558)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX5Ab-0005Am-0K
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:44:13 -0400
Received: by mail-pl1-x644.google.com with SMTP id t7so896289plr.0
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 08:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ar4ktbgi8ho4D2K0AlAA7ABuossIOEQqKwU/YvDdwbY=;
 b=ZdydXPRhNZgdD9zIFzZz76BjDSza6fXyPwoktHSKq7jeSb7C+qRauV9UNTecJMcHrH
 aCLreOkVI61D/fUeZbNToHXSgnM32z1uxxAwKnV+OPL8MMkABOlOjyeoHrEc0Vi88FPS
 QqJkExE+Fq6JNmTWppxFqyQXIRVvAYuppbIEYDKGrB6Mh+FUfLhIW6v7AxtxDzMKFJL3
 8kep2b42X7eDkAPGv7afHva/HOdF5py6CacNgwTVAIHL9iinlljmIojFlXgJQB21u6mG
 s3pX+hPkd5D7gKcZ0qcZOU7TYxJ+iDKQZPpAXAX8xfu+g31O5Medq3iXP4OwUB+dUce3
 ZD2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ar4ktbgi8ho4D2K0AlAA7ABuossIOEQqKwU/YvDdwbY=;
 b=iB+V8o+uaEvxKtl44tjctXJVfE4tzp3jezE6AcwuD7hLBpt4TeXbMyL7I4/HkB+WrL
 WGZT+FWP6aUOfep3Q6vmFQchrCDUoleZ66yrjqNhO3uafYaqGKwHe6FkTWLeFJZUTi9y
 LjmL1dkI0Iyh56m+C9du2afW988uvMyphecV3HMPJj8ySZfH2pwyacdkUDh7fA7y0i0m
 9a+TfgwhyJ3aye9jtVmimziDAy1rscIIip4FRoLCLjEgfi4/20KkAanQYoI5qKmlXsA7
 TKxwBH03iDwfD+mlfvMPoLLv34kd7zX48kGXo4R98HWOCvXRk2jNkGQyNTWxyMg6bP56
 Pzaw==
X-Gm-Message-State: AGi0PuZTVfbrtbEQyQdz5um2JAgDdm0pUG7NIYGuw7PBArKtWwg4sHpk
 ZB21Lf/yfinhX2gAjiS22xin1ST6iSs=
X-Google-Smtp-Source: APiQypKiTjGeNdHu+OHkpKpoh+yyEFanFn+8hTeLZNB2Al5ycxoRjJIO9GS8DWKBJEhNJswI3KUypQ==
X-Received: by 2002:a17:902:c213:: with SMTP id
 19mr3027627pll.172.1588952651211; 
 Fri, 08 May 2020 08:44:11 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id o99sm2727662pjo.8.2020.05.08.08.44.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 08:44:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 03/19] accel/tcg: Add block comment for probe_access
Date: Fri,  8 May 2020 08:43:43 -0700
Message-Id: <20200508154359.7494-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200508154359.7494-1-richard.henderson@linaro.org>
References: <20200508154359.7494-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
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
 include/exec/exec-all.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 350c4b451b..d656a1f05c 100644
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


