Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 479FBC4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:58:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D81B021707
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0vyucP9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D81B021707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO2r3-0001bp-ST
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 13:58:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kO2UK-0006xf-Dk; Thu, 01 Oct 2020 13:35:28 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:45233)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kO2UI-0005MF-DZ; Thu, 01 Oct 2020 13:35:28 -0400
Received: by mail-pf1-x442.google.com with SMTP id x22so5205453pfo.12;
 Thu, 01 Oct 2020 10:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ISGs5OEQLGnXagQuHrQpiO7zWMUyVJljF11LPlE9tYg=;
 b=H0vyucP9BSwZUEQNPOZEPuts4b+yyofuoJUNP/HSCSwPCLMWmJJ99igcopygeqQGi/
 WwNN1DgImB8Flb4nLyMJNYRholzfCNGaofS4Npzjn9wbU5F5RXd3ZuJumDS4e/vryJ7t
 Hme0/Z+uF0mQ2APeN1Sm6H5giwNNlWd3YUqugrVM3hK0cem5ZMQERDktwf2QC89kDKGH
 JbRRT1RlfP967/PAWoE/jEIFPg5Ku0EQ9ezqzYMbwAwOHc4uQvU6pn3WL5BdG6HVWRYP
 cPbY5KbzSKHgbyFMnKZzmtm1usNXwdQteorHE5O4rBsgDpSUKVbtFk/mTjsiWo999gdK
 6R/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ISGs5OEQLGnXagQuHrQpiO7zWMUyVJljF11LPlE9tYg=;
 b=kh3B9BrxXuIwTXp37I5K4q7jefYr7eO6qdYC5bnzEnhPR+Q2HeudIcGztqNEztF8ox
 o2eDPHAc7+Vd0RQmbGrr+Tr1Fke/jF7bYI9QsXSwTBa189gb4MUnbBqcRqEICd7/wO0/
 CxNHtjmNlmwrX9GB4WaQrKIDysKYAZMjVZzXEvcb30CHzAIMmjcbmQlJCgUNGujTIpav
 BA0KtiDw6PcPgp1yO0Dm+0l7eNM8TZm8nBDvBiHPKcf6QEZYZZxsGSSGc75FUGazUJ6b
 CmCBH5UCmSrekx3visD/QEVWh9fhQSkDTIUfDuHQ5KGRS+4Ulz/KKxMJNKSLc734lFyO
 eNvA==
X-Gm-Message-State: AOAM533HtZGCZYNLAIuAM1resLLqYdTy2hDpUm1GS8p7cbEMzREM+Ahu
 jXIoP0GU4r4tJJlwkA0NJQkWsts34mY+uA==
X-Google-Smtp-Source: ABdhPJxpAQWaGLW3bm79J50b98xUfkYvTEoD/zdL6Aqu9iSv8ZafP2dcTjLo39K25JbubPRaUENrHA==
X-Received: by 2002:a63:d251:: with SMTP id t17mr7021974pgi.280.1601573724208; 
 Thu, 01 Oct 2020 10:35:24 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id b7sm4445646pjq.1.2020.10.01.10.35.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 10:35:23 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] doc: Remove texi referenced in qemu-img-cmds.hx and
 target/i386/cpu.c
Date: Fri,  2 Oct 2020 01:35:03 +0800
Message-Id: <20201001173503.1107-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20201001173503.1107-1-luoyonggang@gmail.com>
References: <20201001173503.1107-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Yonggang Luo <luoyonggang@gmail.com>, QEMU Trivial <qemu-trivial@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is no texi document anymore

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 qemu-img-cmds.hx  | 2 +-
 target/i386/cpu.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
index b89c019b76..cab8234235 100644
--- a/qemu-img-cmds.hx
+++ b/qemu-img-cmds.hx
@@ -1,5 +1,5 @@
 HXCOMM Keep the list of subcommands sorted by name.
-HXCOMM Use DEFHEADING() to define headings in both help text and texi
+HXCOMM Use DEFHEADING() to define headings in both help text and rST
 HXCOMM Text between SRST and ERST are copied to rST version and
 HXCOMM discarded from C version
 HXCOMM DEF(command, callback, arg_string) is used to construct
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index f37eb7b675..f8231f56b6 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4127,7 +4127,7 @@ static PropValue tcg_default_props[] = {
  * We resolve CPU model aliases using -v1 when using "-machine
  * none", but this is just for compatibility while libvirt isn't
  * adapted to resolve CPU model versions before creating VMs.
- * See "Runnability guarantee of CPU models" at * qemu-deprecated.texi.
+ * See "Runnability guarantee of CPU models" at * deprecated.rst.
  */
 X86CPUVersion default_cpu_version = 1;
 
-- 
2.28.0.windows.1


