Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B152CC432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 19:03:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7932221D7A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 19:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xrCPvpri"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7932221D7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDCZf-0002Xt-3n
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 15:03:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47276)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iDCIq-00020L-0u
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 14:46:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iDCIm-0004Sl-F9
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 14:46:13 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:45561)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iDCIm-0004Rc-98
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 14:46:12 -0400
Received: by mail-pg1-x542.google.com with SMTP id 4so360227pgm.12
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 11:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=60zIbLUAmUNSEgAQIKyqCRl8+f6RWn+eou5eyJkQXA8=;
 b=xrCPvprifaONXZagZ/fLiCRF0Tp5WX4YVEhS72UkFdTUxPK+uVjcB9kbg934woTf8+
 x1dUu7KyBEpkmeOuRycTGdgTIbKZg9ASP3so9ouWNqcb+NU5xCucBbnMqYTbqmo4rWQ5
 GuVB5vc4VeXsHaI/kLo5pKRnvfIOblOVZ/rtGxbPVZUrOvI9WGlCL2J0mtBhQcVtwo0J
 QRSPHhGbFO62lcBncVwXgnkBWQR3L2lfvKU0GMJtOg6X9mbeF5N8uo6xlTcUVSxFUKMS
 lrKeHsQSSR0akGKVKq2IW4sPcW9bXor6306M8bzd0IfIpfEQ2hGv2IqKn/nrfBLCoonr
 MqDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=60zIbLUAmUNSEgAQIKyqCRl8+f6RWn+eou5eyJkQXA8=;
 b=LFd6ho3whf8NYlIoBy/Uh3D/x/6vZ7rKx1iGNe8EVnuVG6qYzAcOUg1bxfHqRGmhrD
 J42AJnhTLE2/6OyC5MtGoEQQETNzbb6XM4tk+xsSiPnUWtcnWD7XRzokQmNorrx3uBrh
 d6lLThbO33i/531dDUjc3htl8YPSBtSbF6fFmMVKHoBZP0TnvVWV7q2bpcPQSvVvap6W
 WHqYcNylOMtsr9BK1D/fe0u9/eETMik6y3gDydrwXMWQBshTwFiVxXXvcHd2Nln4EsIo
 LbNLOcZkz4rYzMENrDSYrp4QFRhLGjK5VzcFdJyVDKT+axgi+G95euSfjz14PW29SEXF
 2BQA==
X-Gm-Message-State: APjAAAUUUI1t6NmngSvTAGx+TsiKFIrlPyTEaLxWUrfuGdhcI7wDUYOj
 IwHg8SBRHAnwWNlkKYo3qr14cwbcxLk=
X-Google-Smtp-Source: APXvYqyN1SicsiA4gerH6TsZ1iZ7ifhN/tw+1MJlS0lG7f1uZ1oa3M96NGEldG5pviFYH8fHLMsZ1w==
X-Received: by 2002:a17:90b:946:: with SMTP id
 dw6mr8133586pjb.48.1569437170739; 
 Wed, 25 Sep 2019 11:46:10 -0700 (PDT)
Received: from localhost.localdomain ([12.206.46.61])
 by smtp.gmail.com with ESMTPSA id l24sm6133229pff.151.2019.09.25.11.46.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2019 11:46:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/16] cputlb: Remove tb_invalidate_phys_page_range
 is_cpu_write_access
Date: Wed, 25 Sep 2019 11:45:46 -0700
Message-Id: <20190925184548.30673-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190925184548.30673-1-richard.henderson@linaro.org>
References: <20190925184548.30673-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

All callers pass false to this argument.  Remove it and pass the
constant on to tb_invalidate_phys_page_range__locked.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
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
index 7d835b1a2b..b3df826039 100644
--- a/exec.c
+++ b/exec.c
@@ -1012,7 +1012,7 @@ const char *parse_cpu_option(const char *cpu_option)
 void tb_invalidate_phys_addr(target_ulong addr)
 {
     mmap_lock();
-    tb_invalidate_phys_page_range(addr, addr + 1, 0);
+    tb_invalidate_phys_page_range(addr, addr + 1);
     mmap_unlock();
 }
 
@@ -1039,7 +1039,7 @@ void tb_invalidate_phys_addr(AddressSpace *as, hwaddr addr, MemTxAttrs attrs)
         return;
     }
     ram_addr = memory_region_get_ram_addr(mr) + addr;
-    tb_invalidate_phys_page_range(ram_addr, ram_addr + 1, 0);
+    tb_invalidate_phys_page_range(ram_addr, ram_addr + 1);
     rcu_read_unlock();
 }
 
-- 
2.17.1


