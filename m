Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB1AC4BA0B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 11:32:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2D7A2467B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 11:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3VhjBfe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2D7A2467B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6uvA-0002S2-2k
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 06:32:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52673)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6utp-0000go-5I
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:30:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6uto-00069O-1g
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:30:45 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44035)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6utn-000626-ID
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:30:43 -0500
Received: by mail-wr1-x442.google.com with SMTP id m16so2512210wrx.11
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 03:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0aufJl2yNuNgq9FoYzfn+p1cP7iQA+ROnRyvAi+WXZg=;
 b=O3VhjBfeYMOrHaIogTJ83JxfQ1sQFBxrmwfFko9NVDpPBiZQpL4h4Jz9FQ4Acs2ymu
 nEnkNac/Pf0VEYzbfNp8f1DS84VSCV0YYOKT4hMINjPgduom6RAOEs3rqPuRolWUU1KI
 jslWG7XFdw+j5KUwrK3j72iD07wfcAmZIPH1hLhrvIkJR00H5I38KoEC9egzt16KuMcd
 MGhNmmPP+XtTlE8nzNs2tbvrhGmYPxF6AxpTMItmRdcfyNEQIIO/iVE8mVS1XFHt7tvC
 ak0z42rE8lA8+y6nBTmqTFMptgXJvvxkai0mQmYr4UsogzvXbTXg/gaJIjhxXqQox6YB
 q0/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=0aufJl2yNuNgq9FoYzfn+p1cP7iQA+ROnRyvAi+WXZg=;
 b=BpKyh0UeMacapenhEIKN+f9vizQVy0L8oOHl2i8gyCFbEqiWZr2x5ndrmpKrLUIIHL
 eZD4TcxVUZ4BvCg14/XuRAmVTcymJ0oNNWNdqvfFoQGdHmJFG0Dsi5Ltel35JgqcY5lF
 PJrexjmLbRHnargYnnWr4q0dZNv1I7i/usp23R78gO6N3cCEUx3wQCW3toHN9fmjzcgB
 /BpJ/mCvIXvcMLVbwRaWSwcDzLTgHmQslB/xxCp+rX1bkTSbLjKEF902/8iZNRvGZ3tn
 1pSUJpfRkdLD3yK7+PEauTm9iQ4P1xn1YpPVu66xEIsi7EkwmhHyHW190+OKIMhcUq/8
 lQyQ==
X-Gm-Message-State: APjAAAVmJbO5Tdqao12Eo2FnYTWXwgZx4s62rgd0q5fU72tzbrkqa74P
 5pc0erQXvqdVzlY7zXaYC6a6xwpz
X-Google-Smtp-Source: APXvYqwxMBk9CRD5BsS8/SnEvJ7vLJFaBZTokuMwwxR0ExrTYpSy5ONeF9It8vWhdL1XjbkczMjVFg==
X-Received: by 2002:adf:f20f:: with SMTP id p15mr5368663wro.219.1582716641581; 
 Wed, 26 Feb 2020 03:30:41 -0800 (PST)
Received: from donizetti.lan ([2001:b07:6468:f312:d0d9:ea10:9775:f33f])
 by smtp.gmail.com with ESMTPSA id h128sm2628154wmh.33.2020.02.26.03.30.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 03:30:41 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/18] qemu-doc: move system requirements chapter inside PC
 section
Date: Wed, 26 Feb 2020 12:30:23 +0100
Message-Id: <20200226113034.6741-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200226113034.6741-1-pbonzini@redhat.com>
References: <20200226113034.6741-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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

The system requirements documented in this chapter are limited to x86 KVM targets.
Clean them up and move them to the target section.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qemu-doc.texi | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index 88e84300e9..dcf7281a00 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -38,7 +38,6 @@
 * Introduction::
 * QEMU System emulator::
 * QEMU System emulator targets::
-* System requirements::
 * Security::
 * Implementation notes::
 * Deprecated features::
@@ -190,6 +189,7 @@ various targets are mentioned in the following sections.
 @menu
 * pcsys_devices::      Peripherals
 * cpu_models_x86::     Supported CPU model configurations on x86 hosts
+* pcsys_req::          OS requirements
 @end menu
 
 @node pcsys_devices
@@ -267,6 +267,13 @@ CS4231A is the chip used in Windows Sound System and GUSMAX products
 @include docs/system/cpu-models-x86.texi
 @raisesections
 
+@node pcsys_req
+@subsection OS requirements
+
+On x86_64 hosts, the default set of CPU features enabled by the KVM accelerator
+require the host to be running Linux v4.5 or newer.  Red Hat Enterprise Linux
+7 is also supported, since the required functionality was backported.
+
 @node PowerPC System emulator
 @section PowerPC System emulator
 @cindex system emulation (PowerPC)
@@ -1038,19 +1045,6 @@ so should only be used with trusted guest OS.
 
 @c man end
 
-@node System requirements
-@chapter System requirements
-
-@section KVM kernel module
-
-On x86_64 hosts, the default set of CPU features enabled by the KVM accelerator
-require the host to be running Linux v4.5 or newer.
-
-The OpteronG[345] CPU models require KVM support for RDTSCP, which was
-added with Linux 4.5 which is supported by the major distros. And even
-if RHEL7 has kernel 3.10, KVM there has the required functionality there
-to make it close to a 4.5 or newer kernel.
-
 @include docs/security.texi
 
 @include qemu-tech.texi
-- 
2.21.1



