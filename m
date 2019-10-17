Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A41FA3736
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:38:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 324692089C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="skQ4kprB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 324692089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL5yb-0008Dl-7l
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 09:38:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33952)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5dj-000864-U6
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:16:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5di-0005TT-KS
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:16:27 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54842)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iL5di-0005T8-Dp
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:16:26 -0400
Received: by mail-wm1-x342.google.com with SMTP id p7so2527895wmp.4
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 06:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=K+1mXE6c26sJ05xL/OiaWYUlLkihUxvX+Cms6fDNZy0=;
 b=skQ4kprBFAkH6oRF0+0aDe5wxPbSBlRhVDQnJ4CzGC3oW6HSeOiMVPpC8nm24LTfR3
 sbLuQRbOsNSMVF7leDmgObEZvCNoYQx/EMfsWS8k4UguHuLbZe5sNVH9187uYMd9y7Tg
 yB79vjBUa4jIwfsCLDtUPa//vYzI3Ec1axACdQMe+w82KVElgBWyPljirDvYjqF4dIxK
 H88uEPHQu+xi9h9Q1z8RXum+YvSHDD0FWoSm5hfSsaJvhtwYXL9pKmLI5Zop5n9rbH5b
 srfwn2aBbfUzmG5E8mjLUK0L354M93sPId/SIOvIvlK0ghWUF7yK8BGkwkud57/rftqd
 TQAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=K+1mXE6c26sJ05xL/OiaWYUlLkihUxvX+Cms6fDNZy0=;
 b=F9+6GWWAs9D4ayNL8x/SCj9EeDKLEt58SH9bwj4hJg9ZRi9ZwB/bhpebD8a3r/Y47X
 CUxmciX48ycRG2nDjraYhrm95Pk/JS2kIezkkNSDPLx3Fcts5qcEtbZmiKxfgh8YpFBz
 punspXyeGDi1xGTDFqQAweWsNeN6ggqNvew8s+d+UvnzUjTvyGdd/cTJxqJv7l+0NjIF
 3H/aCQg6tk1TzYajybV59o4Ky49Up8lTb8HuTzyRTDehP90Mqu10UN4lF4OrHtm/29d/
 ZL8bZeiczWwWBd7sIQOSZ29Cfcr6MJdq23bg/Ze05ivF3BzKEZiEdbL7fEc5relVBndE
 5Rew==
X-Gm-Message-State: APjAAAWHVO5U/99WipeMrmU5XtuJck8/9obROnT5qZbZLfozdFI9/5u3
 l1NeZ75mE9HlLtKsTcSk91Gsuw==
X-Google-Smtp-Source: APXvYqxUUxKo4xiOVqDOZa2eSoFnlHlu5frMuvLn02t9T3hFisu6UMv5ev7UVJtTuq8UbPNpTniaCQ==
X-Received: by 2002:a05:600c:29a:: with SMTP id
 26mr3060695wmk.127.1571318185259; 
 Thu, 17 Oct 2019 06:16:25 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u26sm2387029wrd.87.2019.10.17.06.16.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 06:16:21 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C2A261FF9A;
 Thu, 17 Oct 2019 14:16:16 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v6 10/54] cputlb: document get_page_addr_code
Date: Thu, 17 Oct 2019 14:15:31 +0100
Message-Id: <20191017131615.19660-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017131615.19660-1-alex.bennee@linaro.org>
References: <20191017131615.19660-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: robert.foley@futurewei.com,
 Richard Henderson <richard.henderson@linaro.org>, peter.puhov@futurewei.com,
 aaron@os.amperecomputing.com, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/exec-all.h | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 04795c49bf..e4206cb173 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -504,7 +504,15 @@ void mmap_lock(void);
 void mmap_unlock(void);
 bool have_mmap_lock(void);
 
-static inline tb_page_addr_t get_page_addr_code(CPUArchState *env1, target_ulong addr)
+/**
+ * get_page_addr_code() - user-mode version
+ * @env: CPUArchState
+ * @addr: guest virtual address of guest code
+ *
+ * Returns @addr.
+ */
+static inline tb_page_addr_t get_page_addr_code(CPUArchState *env,
+                                                target_ulong addr)
 {
     return addr;
 }
@@ -512,8 +520,18 @@ static inline tb_page_addr_t get_page_addr_code(CPUArchState *env1, target_ulong
 static inline void mmap_lock(void) {}
 static inline void mmap_unlock(void) {}
 
-/* cputlb.c */
-tb_page_addr_t get_page_addr_code(CPUArchState *env1, target_ulong addr);
+/**
+ * get_page_addr_code() - full-system version
+ * @env: CPUArchState
+ * @addr: guest virtual address of guest code
+ *
+ * If we cannot translate and execute from the entire RAM page, or if
+ * the region is not backed by RAM, returns -1. Otherwise, returns the
+ * ram_addr_t corresponding to the guest code at @addr.
+ *
+ * Note: this function can trigger an exception.
+ */
+tb_page_addr_t get_page_addr_code(CPUArchState *env, target_ulong addr);
 
 void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length);
 void tlb_set_dirty(CPUState *cpu, target_ulong vaddr);
-- 
2.20.1


