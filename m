Return-Path: <SRS0=thrq=XR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 475E6C3A5A2
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2019 04:14:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1462D2080F
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2019 04:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mR1Po/VF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1462D2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBtGZ-00049d-6I
	for qemu-devel@archiver.kernel.org; Sun, 22 Sep 2019 00:14:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40983)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iBsy6-0001wH-Bw
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 23:55:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iBsy5-0008Lm-0L
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 23:55:26 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:41685)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iBsy4-0008LI-PE
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 23:55:24 -0400
Received: by mail-pl1-x641.google.com with SMTP id t10so4964599plr.8
 for <qemu-devel@nongnu.org>; Sat, 21 Sep 2019 20:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Ss7y4dx7Ozqbb6/ZwGCVABLVohdKahfSvIHor1C9aWE=;
 b=mR1Po/VFhedo64cklbQLJtV7ILp2Doi8K3Aey46xzAvTpRclB+hCWfpDiae31WELk7
 Ft22XvMFWbnX5nQvO8H6fN6Px5Jv+Af4dN+d5Aa9IXvnzpRTS37vLzNuEjuRHD1BDzCO
 xqifaw7UBHGvkoql1fuWNPwXqkqqPWFm7ECCHiNvX7lj3PT7fir8KqL7EnMeW2GeljKF
 MyxCvbAtGwViD+DiyF1bh6JwvsOD9r/0b6PwNQ7V5RkPMidL/qo1B366KoGGzreEI8a7
 x+JGB2JgunXxqlL2bZIuMyU6iyaODzGj58uHphKz6ClAusoj+SPlATmCxSZQ8iVPRCu3
 3yKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Ss7y4dx7Ozqbb6/ZwGCVABLVohdKahfSvIHor1C9aWE=;
 b=flwGlg8OJedNn0ib3fSLpOEj5blDFCFKJURbEwadsyDeZn6aknRVSpTIG7ihsLXAan
 iiRUqwfxfZwJ5fwppjE3n3IqSbT6QCItfRtixcrywruN58WC2C223LZQOQYp1UBBT9ow
 O71nX5/HhKtTT+Ok8KmGEp89BITPgdJPNwWi/r1JeGU/lhyefTIGvqBG834Gsn+b0ZZI
 AGpwesfywOzzfWk9ZiNpBEIe0d8itzsQY9vjdfA16oibhCQqw2lRfXtzEO0siWfgOiyl
 ftjDGeenmR+4J4NYJdiNclON+FzzUvZpzGw3V3hN6+4ftt3vnzNkTRXl8DvqAF0rnHO2
 k6lg==
X-Gm-Message-State: APjAAAW8w/6mdHfjzWNOIwyUMd+OUnrRMCTEPaecmaubgIwaH1yWK7Gt
 ZYzBY6QKsD5dVTCZ8S59XSOQJwPouPs=
X-Google-Smtp-Source: APXvYqxGP0fYPzAjHte0+MY7WeOnjdkAYrCSYxEG811+hCQoTjbbhg5+wAzN0KVF6tcQz8fU8SxnoA==
X-Received: by 2002:a17:902:fe86:: with SMTP id
 x6mr25554899plm.28.1569124523489; 
 Sat, 21 Sep 2019 20:55:23 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id z4sm6452921pjt.17.2019.09.21.20.55.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Sep 2019 20:55:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 18/20] cputlb: Remove tb_invalidate_phys_page_range
 is_cpu_write_access
Date: Sat, 21 Sep 2019 20:54:56 -0700
Message-Id: <20190922035458.14879-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190922035458.14879-1-richard.henderson@linaro.org>
References: <20190922035458.14879-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: pbonzini@redhat.com, alex.bennee@linaro.org, stefanha@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

All callers pass false to this argument.  Remove it and pass the
constant on to tb_invalidate_phys_page_range__locked.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translate-all.h | 3 +--
 accel/tcg/translate-all.c | 6 ++----
 exec.c                    | 4 ++--
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/accel/tcg/translate-all.h b/accel/tcg/translate-all.h
index 64f5fd9a05..31f2117188 100644
--- a/accel/tcg/translate-all.h
+++ b/accel/tcg/translate-all.h
@@ -28,8 +28,7 @@ struct page_collection *page_collection_lock(tb_page_addr_t start,
 void page_collection_unlock(struct page_collection *set);
 void tb_invalidate_phys_page_fast(struct page_collection *pages,
                                   tb_page_addr_t start, int len);
-void tb_invalidate_phys_page_range(tb_page_addr_t start, tb_page_addr_t end,
-                                   int is_cpu_write_access);
+void tb_invalidate_phys_page_range(tb_page_addr_t start, tb_page_addr_t end);
 void tb_check_watchpoint(CPUState *cpu);
 
 #ifdef CONFIG_USER_ONLY
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 5d1e08b169..de4b697163 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1983,8 +1983,7 @@ tb_invalidate_phys_page_range__locked(struct page_collection *pages,
  *
  * Called with mmap_lock held for user-mode emulation
  */
-void tb_invalidate_phys_page_range(tb_page_addr_t start, tb_page_addr_t end,
-                                   int is_cpu_write_access)
+void tb_invalidate_phys_page_range(tb_page_addr_t start, tb_page_addr_t end)
 {
     struct page_collection *pages;
     PageDesc *p;
@@ -1996,8 +1995,7 @@ void tb_invalidate_phys_page_range(tb_page_addr_t start, tb_page_addr_t end,
         return;
     }
     pages = page_collection_lock(start, end);
-    tb_invalidate_phys_page_range__locked(pages, p, start, end,
-                                          is_cpu_write_access);
+    tb_invalidate_phys_page_range__locked(pages, p, start, end, 0);
     page_collection_unlock(pages);
 }
 
diff --git a/exec.c b/exec.c
index 090bcc05da..fed25d029b 100644
--- a/exec.c
+++ b/exec.c
@@ -978,7 +978,7 @@ const char *parse_cpu_option(const char *cpu_option)
 void tb_invalidate_phys_addr(target_ulong addr)
 {
     mmap_lock();
-    tb_invalidate_phys_page_range(addr, addr + 1, 0);
+    tb_invalidate_phys_page_range(addr, addr + 1);
     mmap_unlock();
 }
 
@@ -1005,7 +1005,7 @@ void tb_invalidate_phys_addr(AddressSpace *as, hwaddr addr, MemTxAttrs attrs)
         return;
     }
     ram_addr = memory_region_get_ram_addr(mr) + addr;
-    tb_invalidate_phys_page_range(ram_addr, ram_addr + 1, 0);
+    tb_invalidate_phys_page_range(ram_addr, ram_addr + 1);
     rcu_read_unlock();
 }
 
-- 
2.17.1


