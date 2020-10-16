Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE7BC433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 13:35:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE60D20848
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 13:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4lFa8PR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE60D20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTPtV-0002xf-LX
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 09:35:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTPrH-0000SR-Vn
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 09:33:23 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35414)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTPrG-00017z-2F
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 09:33:23 -0400
Received: by mail-wm1-x341.google.com with SMTP id q5so3030262wmq.0
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 06:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=kjTvXXHneKE+iLOlSjtIgsRLPHz1K53cljjvbS1RzE8=;
 b=f4lFa8PRWIvtUzdmVuRUntUfeBfTwtmg+/Vv3YM3mM+qeyoMxZdw6LVJNe2XX67CbK
 aruKz5YwVPTa8IGx0kgCRYj00RRzmzX9rx8TCs8dPdGcDqb1z7WsEO7DnFDamtOOvxPE
 GZZ+OX5mKKD7IF+kfzPAJLHOr3mn8w8Rp07X95x18XdTS6IQg+lY7TxOfLwkWD/g1NiZ
 cgHOq3fhLP+UEsFjII5IMoS22SYXvOxavV0pc0VoewcCrsxmCJJVrftiuTS6eSKZLSsz
 sOVYlz6xkkU83iq2pxFBRzr0A3vIH9XXNzU5zHdiE0HCvWJXFBqVFPOwIwR+hv6NVc2A
 PdBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=kjTvXXHneKE+iLOlSjtIgsRLPHz1K53cljjvbS1RzE8=;
 b=nuUwaggmhjYOpBpIC9gYiaHXS/j8bk5ALUxKXoEzH90xftaQZlqrlZOkaw1rBwrBOE
 TnfwY2lYIv47xN/ULENOJ44xxUXJr0tBgyu8wPrK/KQUJnqkWg90uFdybLxSipW9okQc
 Qu6RI3+ceJF+XqJ+pkBezJ5IVapzC2W3OCJ+eq0bpTGstjwhGid714S8o+tsSqV7O4GU
 Es/fgvzkMY6qQamCc9ks8K4/2EUHeOmZT+SfNFlPIaAS7kTl7JOqf9uyy2+/4EmDqQUQ
 crWaUHDkWaqTqEZSc3kxcmd6O6hUKZ+m8+QM/I8q948XTEhEBZ6DMOLlcpTSajX8yeMR
 m5wQ==
X-Gm-Message-State: AOAM531DqMmtd0DFOQbpG8CTLJmB+xJKStYERXs+ROpgJjR4VvFt18PI
 Bpt6M+8JdKj4PEzpWC4AQ/rWqkq/Bkg=
X-Google-Smtp-Source: ABdhPJxasALL/hyCnT2e11Atgt/Hil8biIBuiQL+La7abxrEZKM5qAXayHveSjCXsh1pGqPOht+qLA==
X-Received: by 2002:a1c:6a0a:: with SMTP id f10mr4010044wmc.86.1602855199826; 
 Fri, 16 Oct 2020 06:33:19 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id v17sm3856182wrc.23.2020.10.16.06.33.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2020 06:33:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Victor Kamensky <kamensky@cisco.com>
Subject: [RFC PATCH v3] target/mips: Increase number of TLB entries on the
 34Kf core (16 -> 64)
Date: Fri, 16 Oct 2020 15:33:17 +0200
Message-Id: <20201016133317.553068-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Khem Raj <raj.khem@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Richard Purdie <richard.purdie@linuxfoundation.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Per "MIPS32 34K Processor Core Family Software User's Manual,
Revision 01.13" page 8 in "Joint TLB (JTLB)" section:

  "The JTLB is a fully associative TLB cache containing 16, 32,
   or 64-dual-entries mapping up to 128 virtual pages to their
   corresponding physical addresses."

There is no particular reason to restrict the 34Kf core model to
16 TLB entries, so raise its config to 64.

This is helpful for other projects, in particular the Yocto Project:

  Yocto Project uses qemu-system-mips 34Kf cpu model, to run 32bit
  MIPS CI loop. It was observed that in this case CI test execution
  time was almost twice longer than 64bit MIPS variant that runs
  under MIPS64R2-generic model. It was investigated and concluded
  that the difference in number of TLBs 16 in 34Kf case vs 64 in
  MIPS64R2-generic is responsible for most of CI real time execution
  difference. Because with 16 TLBs linux user-land trashes TLB more
  and it needs to execute more instructions in TLB refill handler
  calls, as result it runs much longer.

(https://lists.gnu.org/archive/html/qemu-devel/2020-10/msg03428.html)

Buglink: https://bugzilla.yoctoproject.org/show_bug.cgi?id=13992
Reported-by: Victor Kamensky <kamensky@cisco.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v3: KISS
Supersedes: <20201015224746.540027-1-f4bug@amsat.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/mips/translate_init.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/mips/translate_init.c.inc b/target/mips/translate_init.c.inc
index 637caccd890..ad21756f4d9 100644
--- a/target/mips/translate_init.c.inc
+++ b/target/mips/translate_init.c.inc
@@ -254,7 +254,7 @@ const mips_def_t mips_defs[] =
         .CP0_PRid = 0x00019500,
         .CP0_Config0 = MIPS_CONFIG0 | (0x1 << CP0C0_AR) |
                        (MMU_TYPE_R4000 << CP0C0_MT),
-        .CP0_Config1 = MIPS_CONFIG1 | (1 << CP0C1_FP) | (15 << CP0C1_MMU) |
+        .CP0_Config1 = MIPS_CONFIG1 | (1 << CP0C1_FP) | (63 << CP0C1_MMU) |
                        (0 << CP0C1_IS) | (3 << CP0C1_IL) | (1 << CP0C1_IA) |
                        (0 << CP0C1_DS) | (3 << CP0C1_DL) | (1 << CP0C1_DA) |
                        (1 << CP0C1_CA),
-- 
2.26.2


