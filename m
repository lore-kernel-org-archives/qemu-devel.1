Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A6CC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 16:51:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F4442086A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 16:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ceQokZKt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F4442086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDWz3-0000gi-St
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 12:51:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41438)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iDWcI-0002kq-4z
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:27:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iDWcG-0004r0-4c
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:27:41 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36439)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iDWcF-0004qC-SK
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:27:40 -0400
Received: by mail-pg1-f195.google.com with SMTP id t14so1854205pgs.3
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 09:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=mWk22l7+U+HSJUTJYCZqfIFiiQLzuuV4OTUO0HR+ZVI=;
 b=ceQokZKt50XVq/CMsn1tkxFjfpAq5UP4WrHW1IQJuzhq4W72V9XrJPoe3GkNWN3ujo
 GB4DOUrn0c2456X4Zdsw/hNi2swUBXyMYFYwbA7JjkzsIIRJdeAUDlS3NihcFVFB/AaH
 ILWc14HZ6dmEXP7xku/epRdS1CFQS7Ro/90uWYhcS8LjFukAbfIHR6WrR0KYXHWRs6YL
 1ejS5qUjwt/8RzAAgTxzjoc9BDZ7SMc2mA7u/Rsv5ImWmsuwsh853XIdBg2yI88grx4c
 ur79hPMLQtfv5qVylg0Ozowip85nildVPu9QpeLwOrl/5n+J9sAEDsiHqAWF+nRI30SH
 P8Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=mWk22l7+U+HSJUTJYCZqfIFiiQLzuuV4OTUO0HR+ZVI=;
 b=CoXk0qD2wWazcg53M6Arqr/5EfrmMJU1cvPyHZzKWeXdrfCSo9Y8Rxb8KtvwUx82Y8
 kBYLy1jEjf2vxYaxKJ+jtmAVMJLwF8bwRQRaUy5ppwJnUUCWODOdqNLbxMJ9LTQ7nvdh
 TmgVTGzXd7ZGIeRy8uDS/4jqoXIDRErfuvt27VOFpMreNL7qoVRIGdgm1ueF1Od1VyV7
 pyqnP2hlMqqekDanxerVA49TgxbvHHv4TixYhzTvopg7Lb20446PDfiN89FK6AtyZkbT
 iwYgpGSDb8z5ba2yG4kLVCjii0BoE4xweFr+l5YI+nNwfZej3VovMDNZbvoSeNGaSKTv
 P2CA==
X-Gm-Message-State: APjAAAXH7rzIMQcxK2w3IclMDi2DwT0HtYCOVAAO6RdQpXaimvNQxKWn
 Ih2enZEtbzh6A50uH+2IEYK3vzt5R58=
X-Google-Smtp-Source: APXvYqwdKLv5tIzdxDdnU2KDSLc5UygC118tBWL1xptywysNrPuQpr+1qCbTXzN2A3finC6tVLnp/w==
X-Received: by 2002:a62:32c5:: with SMTP id y188mr4504702pfy.97.1569515198469; 
 Thu, 26 Sep 2019 09:26:38 -0700 (PDT)
Received: from localhost.localdomain ([12.157.10.114])
 by smtp.gmail.com with ESMTPSA id 64sm4453169pfx.31.2019.09.26.09.26.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2019 09:26:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 15/18] target/s390x: Rely on unwinding in
 s390_cpu_virt_mem_rw
Date: Thu, 26 Sep 2019 09:26:12 -0700
Message-Id: <20190926162615.31168-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190926162615.31168-1-richard.henderson@linaro.org>
References: <20190926162615.31168-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.215.195
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
Cc: qemu-s390x@nongnu.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For TCG, we will always call s390_cpu_virt_mem_handle_exc,
which will go through the unwinder to set ILEN.  For KVM,
we do not go through do_program_interrupt, so this argument
is unused.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/mmu_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index 5ecd9ee87e..bf7fddb056 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -482,7 +482,7 @@ int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr laddr, uint8_t ar, void *hostbuf,
 
     ret = translate_pages(cpu, laddr, nr_pages, pages, is_write, &tec);
     if (ret) {
-        trigger_access_exception(&cpu->env, ret, ILEN_AUTO, tec);
+        trigger_access_exception(&cpu->env, ret, ILEN_UNWIND, tec);
     } else if (hostbuf != NULL) {
         /* Copy data by stepping through the area page by page */
         for (i = 0; i < nr_pages; i++) {
-- 
2.17.1


