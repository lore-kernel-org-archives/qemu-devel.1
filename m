Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF3CC2BA80
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:29:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10C4920842
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mogyeRr9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10C4920842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLWVS-0005GT-8c
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 14:29:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36960)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrs-0003HM-9n
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:49:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrr-0003fU-4I
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:49:04 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:44221)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrq-0003fD-Re
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:49:03 -0400
Received: by mail-wr1-x42f.google.com with SMTP id c15so460848wro.11
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 10:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sdW0l6b6nTSbhLDFO8tdTL2LdtucDsWp9rO++BIIif0=;
 b=mogyeRr9N836X4lTudBjRzbYDylieiCWTT4PZwrosnVp0QYR6naf60R14KOH7YjRQG
 jHsSPoJkU+Nsehjc/lBEr9ejEw/tgeOgJrpA/kRHzG/B1v7EoDyYZMDgYRGR9GYFd1nr
 FyJExuWiznvXqpUM0M5Y4bD/952f5WhuoaJHGe78pRIxwjd81C2saw9fHSRlVxaj6aap
 yjwN20+lg+k4890FtgT09XWfNLj/PAjdUu7oFVKCZs7C8Inqq0EQgAK8I/2T8RDO3cje
 j/QrhFXNgxox6kBm7rpD9kJaDjXh2WMN2XodGd180sMkypohwIHivQAnZhSqoNoJkyH6
 11fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=sdW0l6b6nTSbhLDFO8tdTL2LdtucDsWp9rO++BIIif0=;
 b=oC3FcXE9ui4k5hy1II/KQs6M4tnAtS11rtevG9GuEpjm3EilGjwrmwjEeiPgnJEWo4
 dIQR+BA8TdMtJXOdQ9fTZ1xcRraZfe9s3K2dzT1SqeckbBFqYxJF3wbgMFOMmEkZ5W4O
 48LlnFM2/PV8HHXn/eafaWo0x50ouSUjXPGLk1u/+ISfh3HdVZ5TbFRoqnfo5RkwKui+
 LZiRTK7hLuZE1sgsRmmFC/U5ci1oq5izJ6RTXXNK5v+xYCQvryg087Tcj3+xmW9RXA7U
 JX9Td5et/8aREsUq22UsRhvt2PMxKLXSwd5YSLbWN06/4soZdJoKRxxYpCzkuG9RZ4PQ
 qWkw==
X-Gm-Message-State: AGi0PuYRu9lzz1jsri7GlIeQ9Ks4Ltb6lQhVWVj0WjJUH+4gXm7tQUWQ
 IVP6960iPqC2gUp22lCen77WYMQv80g=
X-Google-Smtp-Source: APiQypJIbyrrRC6KE6m4lKvo3p9EHIHQuoG/Y1gMAo1EoD3Tq8hXybPctjRWgRerJxAFPz1xoerXOw==
X-Received: by 2002:adf:a347:: with SMTP id d7mr353725wrb.21.1586195341646;
 Mon, 06 Apr 2020 10:49:01 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id a67sm364880wmc.30.2020.04.06.10.49.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 10:49:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PATCH-for-5.1 v2 50/54] scripts/coccinelle: Find eventually missing
 error_propagate() calls
Date: Mon,  6 Apr 2020 19:47:39 +0200
Message-Id: <20200406174743.16956-51-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200406174743.16956-1-f4bug@amsat.org>
References: <20200406174743.16956-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In some places in we put an error into a local Error*, but
forget to use it. Add a Coccinelle patch to find such cases
and report them.

Inspired-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .../find-missing-error_propagate.cocci        | 53 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 54 insertions(+)
 create mode 100644 scripts/coccinelle/find-missing-error_propagate.cocci

diff --git a/scripts/coccinelle/find-missing-error_propagate.cocci b/scripts/coccinelle/find-missing-error_propagate.cocci
new file mode 100644
index 0000000000..8b75b37b64
--- /dev/null
+++ b/scripts/coccinelle/find-missing-error_propagate.cocci
@@ -0,0 +1,53 @@
+// Find places likely missing error-propagation code, but code is too
+// complex for automatic transformation, so manual analysis is required.
+//
+// Copyright: (C) 2020 Philippe Mathieu-Daudé
+// This work is licensed under the terms of the GNU GPLv2 or later.
+//
+// spatch \
+//  --macro-file scripts/cocci-macro-file.h --include-headers \
+//  --sp-file scripts/coccinelle/find-missing-error_propagate.cocci
+//
+// Inspired by https://www.mail-archive.com/qemu-devel@nongnu.org/msg691638.html
+
+
+// First match two subsequent calls using local Error*
+// in function provided a Error** argument
+//
+@discard_func_with_errp_argument@
+typedef Error;
+Error *local_err;
+identifier func, errp, errfunc1, errfunc2;
+@@
+void func(..., Error **errp)
+{
+ <+...
+ errfunc1(..., &local_err);
+ ... when != local_err          // local_err is not used between the calls
+ errfunc2(..., &local_err);
+ ...+>
+}
+
+
+// Again, match two subsequent calls using local Error*
+// but ignoring within functions provided a Error** argument
+//
+@manual depends on never discard_func_with_errp_argument@
+Error *local_err;
+identifier errfunc1, errfunc2;
+position p;
+@@
+ errfunc1@p(..., &local_err);
+ ... when != local_err
+ errfunc2(..., &local_err);
+
+
+// As it is likely too complex to transform, report the hit
+//
+@script:python@
+f << manual.errfunc1;
+p << manual.p;
+@@
+print("[[manual check required: "
+      "error_propagate() might be missing in {}() {}:{}:{}]]".format(
+            f, p[0].file, p[0].line, p[0].column))
diff --git a/MAINTAINERS b/MAINTAINERS
index ae71a0a4b0..29d29461f3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2057,6 +2057,7 @@ F: scripts/coccinelle/add-missing-error_propagate.cocci
 F: scripts/coccinelle/err-bad-newline.cocci
 F: scripts/coccinelle/error-use-after-free.cocci
 F: scripts/coccinelle/error_propagate_null.cocci
+F: scripts/coccinelle/find-missing-error_propagate.cocci
 F: scripts/coccinelle/remove_local_err.cocci
 F: scripts/coccinelle/simplify-init-realize-error_propagate.cocci
 F: scripts/coccinelle/use-error_abort-in-instance_init.cocci
-- 
2.21.1


