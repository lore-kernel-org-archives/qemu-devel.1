Return-Path: <SRS0=KEGy=6R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA7DC28CBC
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 11:33:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4D82205ED
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 11:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUaZIIED"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4D82205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVCsL-0003Rm-Qi
	for qemu-devel@archiver.kernel.org; Sun, 03 May 2020 07:33:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVCrK-0001z7-7l; Sun, 03 May 2020 07:32:34 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:32981)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVCrJ-0008Q2-Hq; Sun, 03 May 2020 07:32:33 -0400
Received: by mail-wm1-x343.google.com with SMTP id v8so13328840wma.0;
 Sun, 03 May 2020 04:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fkF6VfCkC8dhwiBfLS0TZm2WgnTIh9zitw46wfovxro=;
 b=mUaZIIEDAePhgq6/tvBl/eHjQ3qhX21PQAopjxr5no9eeHsiMlAJkQ0xJWLfK0bIy1
 jLd39+GHIFRoOjLsCOV4YtmXqALWUZRyOJHOhe8dzdm76EZUm/8H2oKTjsHuGZ/bzo00
 yeAaaRHRoatabQDOU72QlcQg0z58alf5azSMVPwkEvSnWeTWkvurxB+8dYCWSW4k6e0j
 UdIKBG1ElIhFw2Mfrwx42B62QrUaJJM/LDSKf1+0HBN0U6mvdbJghUi8WFrzYI0RrORL
 7HBoggktHDiloS03vRgtEhD0NvBhVQEOd5Jmww4pEwjjS03kcDbMAwjMiovSxrMH07hJ
 2yHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=fkF6VfCkC8dhwiBfLS0TZm2WgnTIh9zitw46wfovxro=;
 b=o8n1WPYak8P9icqHcXdIHnJMlmz6zPcYFNP/g5/2URaG7XanOoYrjp0PH6NenvGy1r
 f5T9plvXe8I5Zh2DTqpx+zmABANIV7KjPbd3yaRcz1IKu+xaPEU9BMQD3u7nP+Bh05l2
 ANaXBog8p3PQ7z95is776lQz7zAsq7M/4CoNySMbUnnfzsdDe6KjrfuBOXukVpgq5puI
 qEOTBGo+p5+esKtcL0RbdWYd2cuRRhiimcjEkceEaN6tLwSRttcbK7j+lP0D3kzD6Rta
 Ct9hWE+YsqH9nPUfR66xrwCTBJel+0COVCO4e1BaKIXf5DeYctlSPXygGc9F7gPjb1cO
 lS2A==
X-Gm-Message-State: AGi0PubT6TfzB5KFI1EJ9xS8/uz/TTwTstls/rJqp9U9v/bvNXCifqCw
 z1ZinTZxZwlfS7Yu8sp1uEcjwum9
X-Google-Smtp-Source: APiQypKkpY9uBhhLB96WAnNWqH2t5ZthyVsw+AyDsl1xzDW4IbVXKzzX5jicaFPfGZKdhGHHQ7+zdA==
X-Received: by 2002:a1c:f416:: with SMTP id z22mr9056661wma.32.1588505551382; 
 Sun, 03 May 2020 04:32:31 -0700 (PDT)
Received: from localhost.localdomain (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id n9sm13485904wrx.61.2020.05.03.04.32.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 May 2020 04:32:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 2/2] linux-user/mmap: Fix Clang 'type-limit-compare'
 warning
Date: Sun,  3 May 2020 13:32:20 +0200
Message-Id: <20200503113220.30808-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200503113220.30808-1-f4bug@amsat.org>
References: <20200503113220.30808-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When building with Clang 10 on Fedora 32, we get:

    CC      linux-user/mmap.o
  linux-user/mmap.c:720:49: error: result of comparison 'unsigned long' > 18446744073709551615 is always false [-Werror,-Wtautological-type-limit-compare]
          if ((unsigned long)host_addr + new_size > (abi_ulong)-1) {
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~

Fix by restricting the check for when target sizeof(abi_ulong) is
smaller than target sizeof(unsigned long).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 linux-user/mmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index e378033797..b14652d894 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -714,6 +714,7 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
             errno = ENOMEM;
             host_addr = MAP_FAILED;
         }
+#if TARGET_ABI_BITS < TARGET_LONG_BITS
         /* Check if address fits target address space */
         if ((unsigned long)host_addr + new_size > (abi_ulong)-1) {
             /* Revert mremap() changes */
@@ -721,6 +722,7 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
             errno = ENOMEM;
             host_addr = MAP_FAILED;
         }
+#endif /* TARGET_ABI_BITS < TARGET_LONG_BITS */
     }
 
     if (host_addr == MAP_FAILED) {
-- 
2.21.3


