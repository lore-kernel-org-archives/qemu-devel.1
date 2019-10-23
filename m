Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81588CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 15:39:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5001E2064A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 15:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jX7BbMZt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5001E2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNIjE-0006ks-Sm
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 11:39:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35328)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iNI8v-0008CZ-Bw
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:01:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iNI8s-0001I3-7e
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:01:45 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:36630)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iNI8r-0001B1-UV
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:01:42 -0400
Received: by mail-qk1-x743.google.com with SMTP id y189so20056655qkc.3
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 08:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=uBYls1SEkoMOURVj/C3yUJq0TivKPiwCZV3WGA+/blg=;
 b=jX7BbMZtmCMcQNAA2JyC6isSAjc+uHKsYPzLSkyYxQgRloKo42DLTG2el1Pwy7imCD
 c9eiFdTNnoxf7+6KQUiKcQDjBaDlGXbeDOOq1a5hMcR4PF9SEeeHXAjNZlavdHdnohSA
 bzHeCUYYPhi67/lGkgfVTnkE2nsbg8B5aX3RbNaszoXSBi57+5WP74ubw5Bwe1bSe8n/
 /gHB3Tj0jR4d4nWsuoNI0Ium1zSjP1SF6wk1kgXNhL7o3wYmzyOzdiVWuSE0ThUWxOxj
 bmYckK8vgNfJtWX6FGtPLMxneKPIv2sGvgebn7RciW9zPEmKHZCois8utIQdhpoXp54G
 UIog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=uBYls1SEkoMOURVj/C3yUJq0TivKPiwCZV3WGA+/blg=;
 b=orJwcMH/xDNV2ljl6j3uPiOBtoAoC6yNHXrosPZvbPRn37D8fRntTPt0Hyo5nxLDon
 6hhHx0vqn+lw6tedBHN0wgm4/d4dJbqtSLbTCX8aWaPcfqlTNNp2/ah/+40HIAzxEyLz
 GHZtBPD9B4cWpZQ30OJDA3o+Wo+K5F+cVXHW/supw9T4RCqvJPVLrGw8EdhWP0CA0uJi
 DuX6R7wetLAruC9IJaWqAygwuyrsmdk4ZhwLzsHvn32BNEcXooRVLIfLd1CV9s/ZPoJF
 Dxq6SadMEgzLkokszJ9NAK9OjvTHLuL52dnvu0seL6S6rL45Pz22Dna8sdplw1tULdKz
 ejsA==
X-Gm-Message-State: APjAAAWsp5G/ZPUpO1YugOZpe6prmK+kCWYUptIfPcpMiFFiKQjEOI8I
 JgipNCCiBIqy6M+STYlwRGxWpJjWNvA=
X-Google-Smtp-Source: APXvYqxyL54cWvZL6imBachjGXjLYcU6CS7fyOeSH21UEAakeV+dk2wzN9FVfMPKO7KVbAlN6YSLsA==
X-Received: by 2002:a05:620a:204b:: with SMTP id
 d11mr8974408qka.379.1571842891810; 
 Wed, 23 Oct 2019 08:01:31 -0700 (PDT)
Received: from localhost.localdomain (198-4-20-64.static.cosmoweb.net.
 [64.20.4.198])
 by smtp.gmail.com with ESMTPSA id l189sm11030168qke.69.2019.10.23.08.01.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2019 08:01:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 22/24] linux-user/aarch64: Rebuild hflags for
 TARGET_WORDS_BIGENDIAN
Date: Wed, 23 Oct 2019 11:00:55 -0400
Message-Id: <20191023150057.25731-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191023150057.25731-1-richard.henderson@linaro.org>
References: <20191023150057.25731-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::743
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Continue setting, but not relying upon, env->hflags.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/cpu_loop.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
index 1295fa8531..31c845a70d 100644
--- a/linux-user/aarch64/cpu_loop.c
+++ b/linux-user/aarch64/cpu_loop.c
@@ -173,6 +173,7 @@ void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
     for (i = 1; i < 4; ++i) {
         env->cp15.sctlr_el[i] |= SCTLR_EE;
     }
+    arm_rebuild_hflags(env);
 #endif
 
     if (cpu_isar_feature(aa64_pauth, cpu)) {
-- 
2.17.1


