Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C50BC10F25
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 11:13:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9D692073B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 11:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VrCDslvS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9D692073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAAur-00006x-Vk
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 06:13:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39217)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jAAs1-0003Xd-MW
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:10:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jAArz-0004vV-S3
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:10:21 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:50483)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jAArz-0004rp-Gv
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:10:19 -0500
Received: by mail-wm1-x32f.google.com with SMTP id a5so1947891wmb.0
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 03:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=lSS9b7qPiBKIY3bTnFe/9lzY1JcnBag0mvZBgxxrEXE=;
 b=VrCDslvStIZc8WdPjPUPv+1kb3Y6HCTS8fogBfZ5AyqB9MxqaJgevl+eM0zll/i4ie
 fNWAylVEJi/dxsRZPkvMYJ5Cepo73iglw9Io28a67hD4NYP3MSiTEY97X4RHLB0CO0Zv
 kABOw8bBY8Da47i5Vi+ll+nXS/pmHOLYP/co8Bf6T49V0gAvojE/pyiBxwsloEnm9fp7
 RGq7H/aWQVoW6usy0F0xixrO03Cd1JoK8XHFfMeSy65DcQnPrVjs+E/Y1ENTod9eMRrO
 1CpafQo3yzSOziMTXbSczCcDDRHcEkOSoguNBS+0xpP1y77Mw/L6XKBtRB9P6J2+tCHe
 Iw0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lSS9b7qPiBKIY3bTnFe/9lzY1JcnBag0mvZBgxxrEXE=;
 b=MspkhHIcloN0t+FHrcejt+iXdlZvKSFxoMicQmakJVv2vUvq5ArOe3geSEUj/bPETh
 2mFxKml26pMclrdEsUFEI4ET+qngxFBKYlKXTzg4ARWvxpVhpGoU7yev5Ff/gfn/Jx7j
 PeSI69/LjdbjEB8f+1OFPnhDrhdhfd3I/6k0ZJsJ2BgFpgvIy2fBkMXQM/rhHIimJXWl
 q7lcNMsuIB7ZTzmMzIbGvL2UthgW+rPoOoJqAHV2cuzRuGKjF9iuczHsvn0y25BxoKyq
 qc5C+oCJcW1t72sCM+JlBoxfhseb1hKlnRtAbKfv5+7va6HTpi70rfCRwwro8jSX2/sv
 nbFg==
X-Gm-Message-State: ANhLgQ2VP7ghCu2fVskY2IvbqUVbfBjKMB31v2G/IWqbqTsVi+GX4LqC
 uW6/RwDYy2qiqoeOQH6P8UFiSr4vbQKg7w==
X-Google-Smtp-Source: ADFU+vukxt8yxRVNU7vsGQz5338/LYMZiuXgKFYYDzsYtudiIH354T1/cgIp9JJIluOM7Ztl7uO+7Q==
X-Received: by 2002:a7b:c8c9:: with SMTP id f9mr3388798wml.43.1583493018120;
 Fri, 06 Mar 2020 03:10:18 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y10sm12553029wma.26.2020.03.06.03.10.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2020 03:10:17 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/33] qemu-doc: move included files to docs/system
Date: Fri,  6 Mar 2020 11:09:37 +0000
Message-Id: <20200306110959.29461-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200306110959.29461-1-peter.maydell@linaro.org>
References: <20200306110959.29461-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
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

From: Paolo Bonzini <pbonzini@redhat.com>

Since qemu-doc.texi is mostly including files from docs/system,
move the existing include files there for consistency.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200228153619.9906-12-peter.maydell@linaro.org
Message-id: 20200226113034.6741-12-pbonzini@redhat.com
[PMM: update MAINTAINERS line for qemu-option-trace.texi]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 Makefile                                                  | 8 ++++----
 MAINTAINERS                                               | 5 +++--
 qemu-deprecated.texi => docs/system/deprecated.texi       | 0
 .../system/qemu-option-trace.texi                         | 0
 docs/{ => system}/security.texi                           | 0
 qemu-doc.texi                                             | 4 ++--
 qemu-options.hx                                           | 2 +-
 7 files changed, 10 insertions(+), 9 deletions(-)
 rename qemu-deprecated.texi => docs/system/deprecated.texi (100%)
 rename qemu-option-trace.texi => docs/system/qemu-option-trace.texi (100%)
 rename docs/{ => system}/security.texi (100%)

diff --git a/Makefile b/Makefile
index 56382a45936..7e60a435426 100644
--- a/Makefile
+++ b/Makefile
@@ -1110,7 +1110,7 @@ docs/interop/qemu-ga-qapi.texi: qga/qapi-generated/qga-qapi-doc.texi
 	@cp -p $< $@
 
 qemu.1: qemu-doc.texi qemu-options.texi qemu-monitor.texi qemu-monitor-info.texi
-qemu.1: qemu-option-trace.texi
+qemu.1: docs/system/qemu-option-trace.texi
 docs/system/qemu-cpu-models.7: docs/system/qemu-cpu-models.texi docs/system/cpu-models-x86.texi docs/system/cpu-models-mips.texi
 
 html: qemu-doc.html docs/interop/qemu-qmp-ref.html docs/interop/qemu-ga-ref.html sphinxdocs
@@ -1120,8 +1120,7 @@ txt: qemu-doc.txt docs/interop/qemu-qmp-ref.txt docs/interop/qemu-ga-ref.txt
 
 qemu-doc.html qemu-doc.info qemu-doc.pdf qemu-doc.txt: \
 	qemu-options.texi \
-	qemu-option-trace.texi \
-	qemu-deprecated.texi qemu-monitor.texi \
+	qemu-monitor.texi \
 	qemu-monitor-info.texi \
         docs/system/quickstart.texi \
         docs/system/invocation.texi \
@@ -1140,7 +1139,8 @@ qemu-doc.html qemu-doc.info qemu-doc.pdf qemu-doc.txt: \
         docs/system/build-platforms.texi \
         docs/system/license.texi \
 	docs/system/cpu-models-x86.texi docs/system/cpu-models-mips.texi \
-	docs/security.texi
+	docs/system/deprecated.texi docs/system/qemu-option-trace.texi \
+	docs/system/security.texi
 
 docs/interop/qemu-ga-ref.dvi docs/interop/qemu-ga-ref.html \
     docs/interop/qemu-ga-ref.info docs/interop/qemu-ga-ref.pdf \
diff --git a/MAINTAINERS b/MAINTAINERS
index 615615c32f3..584264535c2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2234,7 +2234,7 @@ M: Stefan Hajnoczi <stefanha@redhat.com>
 S: Maintained
 F: trace/
 F: trace-events
-F: qemu-option-trace.texi
+F: docs/system/qemu-option-trace.texi
 F: scripts/tracetool.py
 F: scripts/tracetool/
 F: scripts/qemu-trace-stap*
@@ -2804,7 +2804,8 @@ F: contrib/gitdm/*
 
 Incompatible changes
 R: libvir-list@redhat.com
-F: qemu-deprecated.texi
+F: docs/system/deprecated.texi
+F: docs/system/deprecated.rst
 
 Build System
 ------------
diff --git a/qemu-deprecated.texi b/docs/system/deprecated.texi
similarity index 100%
rename from qemu-deprecated.texi
rename to docs/system/deprecated.texi
diff --git a/qemu-option-trace.texi b/docs/system/qemu-option-trace.texi
similarity index 100%
rename from qemu-option-trace.texi
rename to docs/system/qemu-option-trace.texi
diff --git a/docs/security.texi b/docs/system/security.texi
similarity index 100%
rename from docs/security.texi
rename to docs/system/security.texi
diff --git a/qemu-doc.texi b/qemu-doc.texi
index e4bff7edbee..d3e743719ab 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -189,9 +189,9 @@ various targets are mentioned in the following sections.
 @include docs/system/target-m68k.texi
 @include docs/system/target-xtensa.texi
 
-@include docs/security.texi
+@include docs/system/security.texi
 
-@include qemu-deprecated.texi
+@include docs/system/deprecated.texi
 
 @include docs/system/build-platforms.texi
 
diff --git a/qemu-options.hx b/qemu-options.hx
index 084a1c1f8c9..5a4ac8e2396 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4221,7 +4221,7 @@ HXCOMM This line is not accurate, as some sub-options are backend-specific but
 HXCOMM HX does not support conditional compilation of text.
 @item -trace [[enable=]@var{pattern}][,events=@var{file}][,file=@var{file}]
 @findex -trace
-@include qemu-option-trace.texi
+@include docs/system/qemu-option-trace.texi
 ETEXI
 DEF("plugin", HAS_ARG, QEMU_OPTION_plugin,
     "-plugin [file=]<file>[,arg=<string>]\n"
-- 
2.20.1


