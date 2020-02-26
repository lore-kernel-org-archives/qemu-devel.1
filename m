Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB85AC4BA0B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 11:36:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1DDA2467B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 11:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cSLGxYEm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1DDA2467B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42795 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6uzL-0000TO-SC
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 06:36:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52731)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6utr-0000kM-9S
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:30:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6utp-0006Jy-US
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:30:47 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38936)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6utp-0006F0-M0
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:30:45 -0500
Received: by mail-wr1-x443.google.com with SMTP id y17so2543001wrn.6
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 03:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iyAOoKunzPZ19bC6OmFh6556v4B6Tprte6jss8mhQpk=;
 b=cSLGxYEmiwa2XI2Mo8W4PmDFqXVSJTYxoPaBayKxcppTepxWcmd09ywQ0Sk41NnDis
 umxPJOwJI54btoyC97UewHXtI/L69UOgAxQZABADK8Fm6aUbujqPspnadLtOw6Uf9NZo
 E6pb3Tfl8vk8Lc4g4gFGhNZ/F0EsLqXvpJWiQCDuKSqvRLAmrv5cQOJOs32S1VAvPri1
 37lipHEeZnC8HOonvJ23bDf8b0Amx9aonlT+yAtCgD33aSnlochvBahMG17uugqBQf74
 dcc/l3lOyH5IYbVuKrk1HjKNw2OnZOX2cQTe6YUiN979Lz03ij49LO0KOecrHxN7ePTD
 f97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=iyAOoKunzPZ19bC6OmFh6556v4B6Tprte6jss8mhQpk=;
 b=DAivw9PUfKLJU+5f7XfvBi6FFx56r8tB8xLQQdc2DnH2NLWLVQLPC7omm1xnJk+7di
 zbqMGrjB8rRXTfgHF3u5507aWHCtilEcSON8a2SQQW/tV9uo2YgBqrSceTdE2rAqD5r6
 2n++vu1kSWQN6P+bW5vhOjUg3w+4sW1BojVGE0uKSp8Uu5JYwqLxb4OvxszZS7UpxUbW
 cHHktSPwaC0kpAqs77F6F5glcwlRs3Iuegdu2y32X54ypNCOWQMvRZkGlr6poPcN1YTU
 PlV9VZt5a9CKKY97LObLc21y5Gc06Hs7+iZyZK7fDsGKQQylL47iOATaePgrjqQmdoqE
 RqeQ==
X-Gm-Message-State: APjAAAWHXBdbAi5yn1oRxyeE5gEznkRMSb+Nzmk07981GR2yV1pOZMJg
 ofuayCGsni5BEh7tP8jL+gbePu2b
X-Google-Smtp-Source: APXvYqwK53733LmSr48rNdJG3H+4MJy3J1EilERTIjoDspU5CpoJjlixRkqSkYyN8Vg8xFGYYXAF2A==
X-Received: by 2002:a5d:6802:: with SMTP id w2mr4988659wru.353.1582716644372; 
 Wed, 26 Feb 2020 03:30:44 -0800 (PST)
Received: from donizetti.lan ([2001:b07:6468:f312:d0d9:ea10:9775:f33f])
 by smtp.gmail.com with ESMTPSA id h128sm2628154wmh.33.2020.02.26.03.30.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 03:30:43 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/18] qemu-doc: move qemu-tech.texi into main section
Date: Wed, 26 Feb 2020 12:30:26 +0100
Message-Id: <20200226113034.6741-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200226113034.6741-1-pbonzini@redhat.com>
References: <20200226113034.6741-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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

The only remaining content in qemu-tech.texi is a few paragraphs
about managed start up options.  Move them in the main section
about full system emulation.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile                                           | 2 +-
 qemu-tech.texi => docs/system/managed-startup.texi | 9 +--------
 qemu-doc.texi                                      | 5 ++---
 3 files changed, 4 insertions(+), 12 deletions(-)
 rename qemu-tech.texi => docs/system/managed-startup.texi (92%)

diff --git a/Makefile b/Makefile
index d937dfe297..c36971fd39 100644
--- a/Makefile
+++ b/Makefile
@@ -1113,7 +1113,7 @@ txt: qemu-doc.txt docs/interop/qemu-qmp-ref.txt docs/interop/qemu-ga-ref.txt
 
 qemu-doc.html qemu-doc.info qemu-doc.pdf qemu-doc.txt: \
 	qemu-options.texi \
-	qemu-tech.texi qemu-option-trace.texi \
+	qemu-option-trace.texi \
 	qemu-deprecated.texi qemu-monitor.texi \
 	qemu-monitor-info.texi \
         docs/system/quickstart.texi \
diff --git a/qemu-tech.texi b/docs/system/managed-startup.texi
similarity index 92%
rename from qemu-tech.texi
rename to docs/system/managed-startup.texi
index 35da6a40af..ec168095cc 100644
--- a/qemu-tech.texi
+++ b/docs/system/managed-startup.texi
@@ -1,11 +1,4 @@
-@node Implementation notes
-@appendix Implementation notes
-
-@menu
-* Managed start up options::
-@end menu
-
-@node Managed start up options
+@node managed_startup
 @section Managed start up options
 
 In system mode emulation, it's possible to create a VM in a paused state using
diff --git a/qemu-doc.texi b/qemu-doc.texi
index f702dce455..e4bff7edbe 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -39,7 +39,6 @@
 * QEMU System emulator::
 * QEMU System emulator targets::
 * Security::
-* Implementation notes::
 * Deprecated features::
 * Recently removed features::
 * Supported build platforms::
@@ -144,6 +143,7 @@ accelerator is required to use more than one host CPU for emulation.
 * vnc_security::       VNC security
 * network_tls::        TLS setup for network services
 * gdb_usage::          GDB usage
+* managed_startup::    Managed startup options
 @end menu
 
 @include docs/system/quickstart.texi
@@ -159,6 +159,7 @@ accelerator is required to use more than one host CPU for emulation.
 @include docs/system/vnc-security.texi
 @include docs/system/tls.texi
 @include docs/system/gdb.texi
+@include docs/system/managed-startup.texi
 
 @node QEMU System emulator targets
 @chapter QEMU System emulator targets
@@ -190,8 +191,6 @@ various targets are mentioned in the following sections.
 
 @include docs/security.texi
 
-@include qemu-tech.texi
-
 @include qemu-deprecated.texi
 
 @include docs/system/build-platforms.texi
-- 
2.21.1



