Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFDFC4BA0B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 11:36:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84157206E6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 11:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3SKuUyN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84157206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6uzc-0000kd-MH
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 06:36:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52754)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6uts-0000ll-9M
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:30:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6utr-0006RH-1h
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:30:48 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:46466)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6utq-0006MA-Qr
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:30:46 -0500
Received: by mail-wr1-x42e.google.com with SMTP id j7so2493079wrp.13
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 03:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wDkymYdFzHCwHf5Q3ArZ93ZTz3wfoxfk80L8lK+9V9Y=;
 b=Y3SKuUyNUbzo9kLCaPTiAm+weq3eI0xRhQqfPejPhdEMJtuw0LJfHStr6EoF39m1p2
 wDXjFSbJvQ3QoxRkksgbfzQQsurF9wG09azPDee26IvtTzelnLU5Ea4pE4RXzsJYBpyZ
 HYdmIJdvn7azHDRdk96bo+nVKxjBXD2iUh6i30Jg/OFTrZbOksEHWj+tZMPByl1ShYRF
 YolDn54TLhO/b+LpPermUw94Pdevx1R4DPQw2Ak19SVPnY5UsRtzDevDMSn38UxWFk5X
 kERamW2Z93BB9C4EqB+PR5nvzmwWKGGo+3G+F8KXovjedtXbTiN1TDMmBbYbhk4bL8qF
 BvRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=wDkymYdFzHCwHf5Q3ArZ93ZTz3wfoxfk80L8lK+9V9Y=;
 b=n8w3RnK8WKFXA3XoAgt9YOwUKpOghGbfDAXD84AZNMa+RzgVadjG7o/1htGC1RHGuN
 NPzXPW8log1MpeaVzgW4HvzYdmWk5U2+cyUFbhgkPgkpGVuVouO+bXnZGIgitJRlnPDu
 AVgGoTjnFGN/eemxo0PskXsvz3HJcC2+9kaWYU6uU94ogCf/JkYXbLZC4uLrMi+RSC0Z
 nHu8ywePq08kBjPvwxicwVWSGFnd3abd2indgo1XCMHhh1jjE/k+gaf8q4kEWQFuqhMd
 SSHdIBRql3148l5SgUGcTLXBSKyYp392Dwx8gtHJ+gos9/+HboULDEzLzh5KNHLMiqp4
 sttg==
X-Gm-Message-State: APjAAAUVGuEVlVy9HDqRGTF5ENYXbUfXsjzfsAAHxHiCbNJRI3hefHg5
 vKlNlU8QoomBvpnehXsI2RYB1FNK
X-Google-Smtp-Source: APXvYqyxkqFKxYb1ukF0WAQtgVSjHD31ckWpC/ogRMYrbJ3c7ItJzlez2vPJnmH5JB5ar33t3EScFw==
X-Received: by 2002:adf:8b54:: with SMTP id v20mr4909371wra.13.1582716645241; 
 Wed, 26 Feb 2020 03:30:45 -0800 (PST)
Received: from donizetti.lan ([2001:b07:6468:f312:d0d9:ea10:9775:f33f])
 by smtp.gmail.com with ESMTPSA id h128sm2628154wmh.33.2020.02.26.03.30.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 03:30:44 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/18] qemu-doc: move included files to docs/system
Date: Wed, 26 Feb 2020 12:30:27 +0100
Message-Id: <20200226113034.6741-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200226113034.6741-1-pbonzini@redhat.com>
References: <20200226113034.6741-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42e
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since qemu-doc.texi is mostly including files from docs/system,
move the existing include files there for consistency.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS                                               | 3 ++-
 Makefile                                                  | 8 ++++----
 qemu-deprecated.texi => docs/system/deprecated.texi       | 0
 .../system/qemu-option-trace.texi                         | 0
 docs/{ => system}/security.texi                           | 0
 qemu-doc.texi                                             | 4 ++--
 qemu-options.hx                                           | 2 +-
 7 files changed, 9 insertions(+), 8 deletions(-)
 rename qemu-deprecated.texi => docs/system/deprecated.texi (100%)
 rename qemu-option-trace.texi => docs/system/qemu-option-trace.texi (100%)
 rename docs/{ => system}/security.texi (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 574b80498c..0d3ee8bdc6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2796,7 +2796,8 @@ F: contrib/gitdm/*
 
 Incompatible changes
 R: libvir-list@redhat.com
-F: qemu-deprecated.texi
+F: docs/system/deprecated.texi
+F: docs/system/deprecated.rst
 
 Build System
 ------------
diff --git a/Makefile b/Makefile
index c36971fd39..6b5193b838 100644
--- a/Makefile
+++ b/Makefile
@@ -1103,7 +1103,7 @@ docs/interop/qemu-ga-qapi.texi: qga/qapi-generated/qga-qapi-doc.texi
 	@cp -p $< $@
 
 qemu.1: qemu-doc.texi qemu-options.texi qemu-monitor.texi qemu-monitor-info.texi
-qemu.1: qemu-option-trace.texi
+qemu.1: docs/system/qemu-option-trace.texi
 docs/system/qemu-cpu-models.7: docs/system/qemu-cpu-models.texi docs/system/cpu-models-x86.texi docs/system/cpu-models-mips.texi
 
 html: qemu-doc.html docs/interop/qemu-qmp-ref.html docs/interop/qemu-ga-ref.html sphinxdocs
@@ -1113,8 +1113,7 @@ txt: qemu-doc.txt docs/interop/qemu-qmp-ref.txt docs/interop/qemu-ga-ref.txt
 
 qemu-doc.html qemu-doc.info qemu-doc.pdf qemu-doc.txt: \
 	qemu-options.texi \
-	qemu-option-trace.texi \
-	qemu-deprecated.texi qemu-monitor.texi \
+	qemu-monitor.texi \
 	qemu-monitor-info.texi \
         docs/system/quickstart.texi \
         docs/system/invocation.texi \
@@ -1133,7 +1132,8 @@ qemu-doc.html qemu-doc.info qemu-doc.pdf qemu-doc.txt: \
         docs/system/build-platforms.texi \
         docs/system/license.texi \
 	docs/system/cpu-models-x86.texi docs/system/cpu-models-mips.texi \
-	docs/security.texi
+	docs/system/deprecated.texi docs/system/qemu-option-trace.texi \
+	docs/system/security.texi
 
 docs/interop/qemu-ga-ref.dvi docs/interop/qemu-ga-ref.html \
     docs/interop/qemu-ga-ref.info docs/interop/qemu-ga-ref.pdf \
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
index e4bff7edbe..d3e743719a 100644
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
index ac315c1ac4..5fbfa2797c 100644
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
2.21.1



