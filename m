Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0267EC2BB1D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 11:45:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6E7E20674
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 11:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g2Qvk9Xj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6E7E20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCMHA-00056O-VN
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 07:45:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58056)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jCMG8-0003RQ-1S
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 07:44:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jCMG6-00020T-T9
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 07:44:15 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:45696)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jCMG6-0001zv-NA
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 07:44:14 -0400
Received: by mail-wr1-x434.google.com with SMTP id m9so6988913wro.12
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 04:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Wtsv78F6mJieh5xJc3TypPpJyRz/ixRbYU95r889w4Y=;
 b=g2Qvk9XjcN9D9eamrJWm8nqNgyt7qRkO004yCndHWA2Tmb5s6gpBnw3ab1Up/+yt5J
 zffp5WX8PTCaM3CXhFlvAxiQoMOrfT8LvV/bo2vAd7ntAJiDU5f8zAaP/BQnR1soF8dU
 8UIyYxVNMoFTvBgO9TccdMaow9owMuAgY8pfnnxWOMMswOKwXhlCe0JRGhAk0qisZ1+M
 4ZMAXwuDyQDyyPkMTGgOeJv4SKCOEfWf+Wp/Z4PFzwC6FfePaOkSwAmh+BUql0iN85DL
 X+OAssAdR5NSJsgfNKdzIrEs3dZHkol7m3cT9h4AzogpDXSLyBEzF2Qps+phFOGuDG9V
 bXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Wtsv78F6mJieh5xJc3TypPpJyRz/ixRbYU95r889w4Y=;
 b=BZE56fD06kouuzXhWJiFVheClgJvCXmQ0+pWm9jdhVkKDZsO15AFQP+4IrbW247u+6
 JtOig/dK6I+Kpaw3Ezid6gUn9MhUud4bUCdAaZO6N3Pp7CfKr+VwB0WiW4cvZB61d+Ga
 RTnZGGjpGMLKHeDV8FoJtpfeODsUGzm4UaeLfUgBlslbMFrKLkUwUzZhGryFn4qZIgjj
 1CGpCMyCbdgWkR+PR4MEDYbtNwXV3n+beFKlDLXcV+QJCKfoPE/J0rxaJG+77hq7moPG
 69FAPlQV1yVcldBahPodmuSzVicPpd1HVHDfYgj7Ycf6SEIUvEiDfjS1Gx/U17GgoU0r
 sSWA==
X-Gm-Message-State: ANhLgQ3nS/FQ0m5Mmggre9pnnXlW3BejR+J1emjsQqUrs3Phxy0vMQoE
 5rssnyrCE3cub4tuqbzt2zLiURIG/5otxQ==
X-Google-Smtp-Source: ADFU+vsHOULlPTrhQ4uXnyz49FYMK7afZcGMp+6FEWX/hIasJG6KhhtYMxDmooLAhCqFRe3y6fe1Ew==
X-Received: by 2002:adf:f089:: with SMTP id n9mr10639715wro.395.1584013453402; 
 Thu, 12 Mar 2020 04:44:13 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p16sm2688564wmg.22.2020.03.12.04.44.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 04:44:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/12] Update comments in .hx files that mention Texinfo
Date: Thu, 12 Mar 2020 11:43:58 +0000
Message-Id: <20200312114408.16891-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312114408.16891-1-peter.maydell@linaro.org>
References: <20200312114408.16891-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Update the header comments in .hx files that mention STEXI/ETEXI
markup; this is now SRST/ERST as all these files have been
converted to rST.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200306171749.10756-3-peter.maydell@linaro.org
---
 hmp-commands-info.hx | 8 ++++----
 hmp-commands.hx      | 8 ++++----
 qemu-options.hx      | 8 ++++----
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 499d6d54b01..ca5198438de 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -1,9 +1,9 @@
-HXCOMM Use DEFHEADING() to define headings in both help text and texi
-HXCOMM Text between STEXI and ETEXI are copied to texi version and
-HXCOMM discarded from C version
+HXCOMM Use DEFHEADING() to define headings in both help text and rST.
+HXCOMM Text between SRST and ERST is copied to the rST version and
+HXCOMM discarded from C version.
 HXCOMM DEF(command, args, callback, arg_string, help) is used to construct
 HXCOMM monitor info commands
-HXCOMM HXCOMM can be used for comments, discarded from both texi and C
+HXCOMM HXCOMM can be used for comments, discarded from both rST and C.
 HXCOMM
 HXCOMM In this file, generally SRST fragments should have two extra
 HXCOMM spaces of indent, so that the documentation list item for "info foo"
diff --git a/hmp-commands.hx b/hmp-commands.hx
index f12263e071f..7f0f3974ad9 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1,9 +1,9 @@
-HXCOMM Use DEFHEADING() to define headings in both help text and texi
-HXCOMM Text between STEXI and ETEXI are copied to texi version and
-HXCOMM discarded from C version
+HXCOMM Use DEFHEADING() to define headings in both help text and rST.
+HXCOMM Text between SRST and ERST is copied to the rST version and
+HXCOMM discarded from C version.
 HXCOMM DEF(command, args, callback, arg_string, help) is used to construct
 HXCOMM monitor commands
-HXCOMM HXCOMM can be used for comments, discarded from both texi and C
+HXCOMM HXCOMM can be used for comments, discarded from both rST and C.
 
 
     {
diff --git a/qemu-options.hx b/qemu-options.hx
index f9fefd43be9..1d8f852d896 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1,10 +1,10 @@
-HXCOMM Use DEFHEADING() to define headings in both help text and texi
-HXCOMM Text between STEXI and ETEXI are copied to texi version and
-HXCOMM discarded from C version
+HXCOMM Use DEFHEADING() to define headings in both help text and rST.
+HXCOMM Text between SRST and ERST is copied to the rST version and
+HXCOMM discarded from C version.
 HXCOMM DEF(option, HAS_ARG/0, opt_enum, opt_help, arch_mask) is used to
 HXCOMM construct option structures, enums and help message for specified
 HXCOMM architectures.
-HXCOMM HXCOMM can be used for comments, discarded from both texi and C
+HXCOMM HXCOMM can be used for comments, discarded from both rST and C.
 
 DEFHEADING(Standard options:)
 
-- 
2.20.1


