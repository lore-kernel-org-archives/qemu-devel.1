Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E22C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 16:49:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BA3D22208
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 16:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DsUvAmiR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BA3D22208
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLUR1-0000vT-Iu
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 12:49:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36954)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kLUDE-0003dH-Bz
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 12:35:17 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:52233)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kLUDB-0008RS-GY
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 12:35:14 -0400
Received: by mail-wm1-x341.google.com with SMTP id q9so41818wmj.2
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 09:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Rm2OIQ3KoukVIwag1MvSRERXyXhR/5qK1T8emNp0sFQ=;
 b=DsUvAmiR/dSVpubW8GEyQn1DPdqd3WIDMW6cg+debPS5mAHfNY7gph0YZgo45SgrR0
 k1Zn/Td6EP+jcBBPKMhyYQafUbd9gv4CMtLlkYV5rgiDq8UJiPrBihMxzHCLW8UHsoSe
 9q/hajfkUJ54DIAtXT0aJmqisHhRbMwdyudORJpAD9eURNj+oljggKupUz3G/3Zh1Dc4
 EcwjjdqYS/GG+mHDsrPYZ5z47H0Ha+up0cn3HfwfbRzRlkNsD1uePIW1BFZRihf37sI9
 JvM9K6WZdfKhbT7fotfghDxdlJ8i3W7wJVLILHhMVi517PVacQWj3aF5zd1wKL848eSC
 zYZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=Rm2OIQ3KoukVIwag1MvSRERXyXhR/5qK1T8emNp0sFQ=;
 b=Ynm7lUt22i5YGWSZpCcoySNW8oYhQDIllWGSjbSxOZ13UlMzLGZS/fWciQzrJzW8zw
 VIyYP861A5NniZ/DltOaiPMt0woFvrtDLvMpS5v6SQM2PlOA0CG51NNE6ZsQlK13zkWt
 ityGwn/o6t+zpXySySv41s927gR6hVZWoL3WdiNhuDoVPshd7v6taU9XEUWApl1JHrSA
 53tkd26TbIWDElChHCI6+9wtp0gzEoHqcZTaRNZH+/nVVFl8gx9SgxXG7EPSZlKyCwXF
 lbzEg1g+RhhgMND2gKjSPZW2QJ0u5x7cttjDPDRfQz/E36WkjByF71Tgsah5vqNl7EEo
 2NZQ==
X-Gm-Message-State: AOAM532uh703g4RKDq6UZ66YhSUsFAiPr7oiu2Yfpti/e2xIyYLN9SRr
 w7/FizJK4WynQrBogVK6gxl5mmC6dvA=
X-Google-Smtp-Source: ABdhPJzNuEAnNB3TeW2cUlJccYGQ9L8G/OILYFMMWPt0A4nPGydv19x7iKdNzsCqKrAdr769omqquA==
X-Received: by 2002:a7b:cd88:: with SMTP id y8mr64617wmj.24.1600965311227;
 Thu, 24 Sep 2020 09:35:11 -0700 (PDT)
Received: from x1w.redhat.com (234.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.234])
 by smtp.gmail.com with ESMTPSA id r21sm5065209wrc.70.2020.09.24.09.35.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2020 09:35:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH] scripts/qemu-version.sh: Always describe tag version
Date: Thu, 24 Sep 2020 18:35:09 +0200
Message-Id: <20200924163509.142565-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I'm not sure why sometime I get this error:

  $ make
  Generating qemu-version.h with a meson_exe.py custom command
  fatal: No tags can describe 'dc9f825f99eb5dc82f127e6c95fbe3a503e11346'.
  Try --always, or create some tags.

While to --always option is not clear in GIT-DESCRIBE(1):

   --always
       Show uniquely abbreviated commit object as fallback.

using it works and fix my builds:

  $ git describe --match 'v*' --dirty --always
  dc9f825f99e-dirty

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 scripts/qemu-version.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/qemu-version.sh b/scripts/qemu-version.sh
index 03128c56a2c..a7135511588 100755
--- a/scripts/qemu-version.sh
+++ b/scripts/qemu-version.sh
@@ -9,7 +9,7 @@ version="$3"
 if [ -z "$pkgversion" ]; then
     cd "$dir"
     if [ -e .git ]; then
-        pkgversion=$(git describe --match 'v*' --dirty | echo "")
+        pkgversion=$(git describe --match 'v*' --dirty --always | echo "")
     fi
 fi
 
-- 
2.26.2


