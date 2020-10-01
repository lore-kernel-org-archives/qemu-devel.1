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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EAF2C4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:36:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D77F2072E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oxh9Ke+O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D77F2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO1ZZ-00079D-IZ
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 12:36:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kO1Qb-0005m3-NP; Thu, 01 Oct 2020 12:27:33 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:43517)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kO1QX-0003E3-Mf; Thu, 01 Oct 2020 12:27:33 -0400
Received: by mail-pf1-x441.google.com with SMTP id f18so4998005pfa.10;
 Thu, 01 Oct 2020 09:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CBOHCjIK1sZQcljIQo3RuLz+8eqKABqWe+n9Gj0wJng=;
 b=oxh9Ke+OW8Y92hFsdJ6SL2bq/L7e1taIKTac06Tle3DALzrj2CPE1EKwwo68rnXBcP
 /Z0uCsh1mNw8F1BHDKAbNwBc2aCZgCl8DakG1DC1AwG+Ud9FzxrbxLcP+Uxszc1/md1l
 xd/oReBUPW+e7NCn9xHPxBoyJX3wTyxZqcsUSGlkMuB9XOUIIn7dj+dG+GBCE5LF7vzk
 Abw6lSxnB2Rw0rbdTv1VzHs0I09cvBFZfjdbL1Cx1acaPFccMQBmqezXqBNf0F6yDRAq
 YhUQXVknQIkg6QldcmnBKeSjc+0Jzvg5eHrr4KbAkGsVCvl6b6TTI/YyIjuXUjCdyBHl
 6EFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CBOHCjIK1sZQcljIQo3RuLz+8eqKABqWe+n9Gj0wJng=;
 b=T/IxzzfvI0RTO5wLrDZ2WVgxfKLX9i4h5KUEEfoaEl82btvDIYWD9y8eEnptm9z6ZU
 qbukGIgci3klJ/iyeJS03QsavT9DkuL4RpnJCzIEhx/6nXbHSEUEKStKYJ2qPNC+6HMW
 XQ1V+Kqt7JsDbqJiJYGRbv63ryLXe8vhUD06WqpF3tu5gltaGImiHMWVvr0qpkKHctG5
 4/MCulJj1N4383beViRsqqRJ4KiTjwHXDA/9IXA5+Uqyoyoi8XtRMV4ozzSTyN7Waq4w
 ZrbNGFBW9RgimRpGi+eInVKT5epWlfvYofBmZRaMNPUDWdDVB71tVgQTFREyeqhWh5Vi
 SmtQ==
X-Gm-Message-State: AOAM533u8MGAvpOkxqlSvduNiA5ofuSmtXCXyAprdhmKC0CwVDYbJ1vF
 x5qHcKH67XwpHL+RhTT9Oozd98dPL4EMZA==
X-Google-Smtp-Source: ABdhPJzsh7/Gc+x81A/PgVMt1m9PAjMePjscvS9qwA12cOnKG6zCwhL4HF3Of0mNw3x3YCfkaDqzNQ==
X-Received: by 2002:a62:26c1:0:b029:142:2501:35ef with SMTP id
 m184-20020a6226c10000b0290142250135efmr7786204pfm.79.1601569647211; 
 Thu, 01 Oct 2020 09:27:27 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id e8sm3810174pgj.8.2020.10.01.09.27.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 09:27:26 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] doc: more texi cleanup
Date: Fri,  2 Oct 2020 00:27:04 +0800
Message-Id: <20201001162705.219-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20201001162705.219-1-luoyonggang@gmail.com>
References: <20201001162705.219-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x441.google.com
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


