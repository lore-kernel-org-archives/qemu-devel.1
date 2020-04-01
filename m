Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD0CC43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 09:49:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C1E720772
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 09:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LVtRNlmk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C1E720772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJZzb-0005lT-9U
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 05:49:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38387)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jJZyf-0004BJ-BF
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 05:48:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jJZye-000296-Ep
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 05:48:05 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45978)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jJZye-00028a-9G
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 05:48:04 -0400
Received: by mail-wr1-x444.google.com with SMTP id t7so29716404wrw.12
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2020 02:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dAKPurE9Z4/yGpaiKXNSiApWEbrm/XJIzako9b36VuI=;
 b=LVtRNlmkf0SEwI6n3XILfZ5dEar6Zo/Wcgi6qnaCoi1I15MiGFbqSvCHsrv9PS3i1o
 ZMiAD67aotCYrzK/mZo5ttz70YvCuuDsocbEYl8SaXnBiDacY4z1kIdbGfhJF2Oud3U/
 bNDIBt+ThGflldG5q3jWmGwCUq87h2Fg3D3wtQtE2RQdNfCPFSMcSXQkJulzKRT51EZu
 31JXdpj+q/zsaPQbi1wlJOzgtB5hRwAdwaCf4ml64J0VSeTS8ARVn7qqrz5txk8zcPx6
 1WW0NLaBO55JlFCDwJzC0C56/qfyc49QPJ+E65a3cXu8xA5TuaEj7KniqwPuxZuCoIt+
 cFZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dAKPurE9Z4/yGpaiKXNSiApWEbrm/XJIzako9b36VuI=;
 b=Ct8B7oAoujH9cFYFZdan5M8QYLOVhX6/xaEE1expbTL7xEOHGY3R775T1nXDY8cutE
 HzzffU2TEuxhSOVYXvN6dtw/fbbCdPiwF0x25Hbh772DIEDMAWkA87POjf+Wc6WEpluN
 qGshfYffhTsP3gHdbEH5GrX/JDeLDTaP3MxWSbwZWtCh4kCND9lx/UFUgj4HzEXGskt6
 +dH+XgoPtrLK1aLvQWXdmLjAdM+7JrynCCoiYMf3vxy8mPkOz6CKuLDGShHDyqMac+84
 tioFYHBnGrj9jTQ9Uk/BdI+q0b4gCSGULso6+Lj//78M1f69n+L5KecvFzuePLaNBwUM
 M6Bw==
X-Gm-Message-State: ANhLgQ3MrymAgA8LVTrmdbKZWeZkZ5/DEOlLhqZ2QksHMW25gA5oarvG
 fPCLUUqZo+novFi9resu+whQyg==
X-Google-Smtp-Source: ADFU+vsr7EyfLQyeJzCaT+WrNl2x1XNaklo5gCYZfKRAM9VLGJbhHttSoMl3sjscGKELvUyjEgtMcw==
X-Received: by 2002:adf:b6a5:: with SMTP id j37mr25065764wre.412.1585734483166; 
 Wed, 01 Apr 2020 02:48:03 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 9sm1926646wmm.6.2020.04.01.02.48.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2020 02:48:00 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E86F91FF87;
 Wed,  1 Apr 2020 10:47:59 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 01/10] elf-ops: bail out if we have no function symbols
Date: Wed,  1 Apr 2020 10:47:50 +0100
Message-Id: <20200401094759.5835-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200401094759.5835-1-alex.bennee@linaro.org>
References: <20200401094759.5835-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It's perfectly possible to have no function symbols in your elf file
and if we do the undefined behaviour sanitizer rightly complains about
us passing NULL to qsort. Check nsyms before we go ahead.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/elf_ops.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
index a1411bfcab6..b5d4074d1e3 100644
--- a/include/hw/elf_ops.h
+++ b/include/hw/elf_ops.h
@@ -170,8 +170,13 @@ static int glue(load_symbols, SZ)(struct elfhdr *ehdr, int fd, int must_swab,
         }
         i++;
     }
-    syms = g_realloc(syms, nsyms * sizeof(*syms));
 
+    /* check we have symbols left */
+    if (nsyms == 0) {
+        goto fail;
+    }
+
+    syms = g_realloc(syms, nsyms * sizeof(*syms));
     qsort(syms, nsyms, sizeof(*syms), glue(symcmp, SZ));
     for (i = 0; i < nsyms - 1; i++) {
         if (syms[i].st_size == 0) {
-- 
2.20.1


