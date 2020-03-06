Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F315DC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 11:28:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C215A2072D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 11:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WbIk0Wd9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C215A2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAB9z-0003Dp-0o
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 06:28:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40161)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jAAsY-0004WU-Mv
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:10:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jAAsX-0006HH-8s
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:10:54 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:52289)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jAAsW-00068E-R3
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:10:53 -0500
Received: by mail-wm1-x336.google.com with SMTP id p9so1931321wmc.2
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 03:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=bpB7oaRkghBQMQU5VFov+2/nC+u5q6dHi7FMVSXg1VU=;
 b=WbIk0Wd9Bx9YuWLPr3zRwaRo+xZYwWFzPs+OOtsZXxVhXVganGC3CSmEp8c3xrM5Yy
 d2pCaHf6IxFjAGR4MA3scDzhuxAOcD+7gayVvjg8UiowWeln1F7ObaQukSoxcMPQNBQ5
 1GdgoyAt6JbaKKpyF9golHswjGEAq/6cdfHSVA4gNPmC405/QpLgXBVl3Ud/NpiRbyAP
 hW/HSmNghZgX5TZHpaOqxapR/DUvDDboiOyzW3bnM4ymTxYAxoEnBSYquiPmmW3ObyGu
 MWk/oeIihAxVLcO45F5M0TqpIzv4vWx9oHRfckl0kBHH4aUEIsRzkqkNkMCMP+S9SzUl
 Eo2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bpB7oaRkghBQMQU5VFov+2/nC+u5q6dHi7FMVSXg1VU=;
 b=ImkxqhQE/3DGAg6tDovs4Ep2QjGz7CLRFTy9amkw10L3fi3aoVFmO8eUOdwa3nFGWs
 VO0zGaOHBY0cftNDAvVuZq3Ak0eO6UFnz0tZWAMWQ5Z05ksbGTmYoJXMJt4WSC4Sc+Lo
 ZbAlzRzanh0pVvYXsyBROliQQAbLriOtLbTG9WWBFJmi4DG7evU52pQHdA31HOIXCPnB
 mKdgsQVmyoFS1CIYxmcFiXLvn0nBCTVnDkVHRG1Na4k2vzJv/a+J396dW1GQckfguKn1
 LRNxbbjSYlhCibVROB+UgnNO8OqtT0rstwJ9GbAe6wD7/auiihWZm8YC3I5OIdAhhxBZ
 irPA==
X-Gm-Message-State: ANhLgQ2PC0htWRB26AlaBTAuAbb9So0vE+YLSjZVywJKTM90s2yvdjRI
 KC9GSIfDb6Xm35U3op2jeJIT05lsjhT0LQ==
X-Google-Smtp-Source: ADFU+vs0JIqnGsI68U0tIkl9DOwPbTH/6G1OX1PeENq8JaOVJJO1Z3cK8JGsHUVOB1VypK06F62LFQ==
X-Received: by 2002:a1c:4e03:: with SMTP id g3mr3479774wmh.22.1583493049714;
 Fri, 06 Mar 2020 03:10:49 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y10sm12553029wma.26.2020.03.06.03.10.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2020 03:10:49 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/33] docs: Stop building qemu-doc
Date: Fri,  6 Mar 2020 11:09:57 +0000
Message-Id: <20200306110959.29461-32-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200306110959.29461-1-peter.maydell@linaro.org>
References: <20200306110959.29461-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::336
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

Stop building the old texinfo qemu-doc; all its contents are
now available in the Sphinx-generated manuals and manpages.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20200228153619.9906-32-peter.maydell@linaro.org
---
 docs/specs/ivshmem-spec.txt |  4 ++--
 Makefile                    | 39 ++++---------------------------------
 .gitignore                  |  3 ---
 docs/index.html.in          |  1 -
 4 files changed, 6 insertions(+), 41 deletions(-)

diff --git a/docs/specs/ivshmem-spec.txt b/docs/specs/ivshmem-spec.txt
index 042f7eae225..1beb3a01ec3 100644
--- a/docs/specs/ivshmem-spec.txt
+++ b/docs/specs/ivshmem-spec.txt
@@ -38,8 +38,8 @@ There are two basic configurations:
   Interrupts are message-signaled (MSI-X).  vectors=N configures the
   number of vectors to use.
 
-For more details on ivshmem device properties, see The QEMU Emulator
-User Documentation (qemu-doc.*).
+For more details on ivshmem device properties, see the QEMU Emulator
+user documentation.
 
 
 == The ivshmem PCI device's guest interface ==
diff --git a/Makefile b/Makefile
index ef10b9a031d..9d4b2241265 100644
--- a/Makefile
+++ b/Makefile
@@ -344,7 +344,6 @@ MANUAL_BUILDDIR := docs
 endif
 
 ifdef BUILD_DOCS
-DOCS=qemu-doc.html qemu-doc.txt
 DOCS+=$(MANUAL_BUILDDIR)/system/qemu.1
 DOCS+=$(MANUAL_BUILDDIR)/tools/qemu-img.1
 DOCS+=$(MANUAL_BUILDDIR)/tools/qemu-nbd.8
@@ -768,10 +767,6 @@ distclean: clean
 	rm -f $(SUBDIR_DEVICES_MAK)
 	rm -f po/*.mo tests/qemu-iotests/common.env
 	rm -f roms/seabios/config.mak roms/vgabios/config.mak
-	rm -f qemu-doc.info qemu-doc.aux qemu-doc.cp qemu-doc.cps
-	rm -f qemu-doc.fn qemu-doc.fns qemu-doc.info qemu-doc.ky qemu-doc.kys
-	rm -f qemu-doc.log qemu-doc.pdf qemu-doc.pg qemu-doc.toc qemu-doc.tp
-	rm -f qemu-doc.vr qemu-doc.txt
 	rm -f qemu-plugins-ld.symbols qemu-plugins-ld64.symbols
 	rm -f config.log
 	rm -f linux-headers/asm
@@ -851,8 +846,6 @@ install-sphinxdocs: sphinxdocs
 install-doc: $(DOCS) install-sphinxdocs
 	$(INSTALL_DIR) "$(DESTDIR)$(qemu_docdir)"
 	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/index.html "$(DESTDIR)$(qemu_docdir)"
-	$(INSTALL_DATA) qemu-doc.html "$(DESTDIR)$(qemu_docdir)"
-	$(INSTALL_DATA) qemu-doc.txt "$(DESTDIR)$(qemu_docdir)"
 	$(INSTALL_DATA) docs/interop/qemu-qmp-ref.html "$(DESTDIR)$(qemu_docdir)"
 	$(INSTALL_DATA) docs/interop/qemu-qmp-ref.txt "$(DESTDIR)$(qemu_docdir)"
 ifdef CONFIG_POSIX
@@ -1110,34 +1103,10 @@ docs/interop/qemu-qmp-qapi.texi: qapi/qapi-doc.texi
 docs/interop/qemu-ga-qapi.texi: qga/qapi-generated/qga-qapi-doc.texi
 	@cp -p $< $@
 
-html: qemu-doc.html docs/interop/qemu-qmp-ref.html docs/interop/qemu-ga-ref.html sphinxdocs
-info: qemu-doc.info docs/interop/qemu-qmp-ref.info docs/interop/qemu-ga-ref.info
-pdf: qemu-doc.pdf docs/interop/qemu-qmp-ref.pdf docs/interop/qemu-ga-ref.pdf
-txt: qemu-doc.txt docs/interop/qemu-qmp-ref.txt docs/interop/qemu-ga-ref.txt
-
-qemu-doc.html qemu-doc.info qemu-doc.pdf qemu-doc.txt: \
-	qemu-options.texi \
-	qemu-monitor.texi \
-	qemu-monitor-info.texi \
-        docs/system/quickstart.texi \
-        docs/system/invocation.texi \
-        docs/system/keys.texi \
-        docs/system/mux-chardev.texi \
-        docs/system/monitor.texi \
-        docs/system/cpu-models-x86.texi \
-        docs/system/images.texi \
-        docs/system/net.texi \
-        docs/system/usb.texi \
-        docs/system/ivshmem.texi \
-        docs/system/linuxboot.texi \
-        docs/system/vnc-security.texi \
-        docs/system/tls.texi \
-        docs/system/gdb.texi \
-        docs/system/build-platforms.texi \
-        docs/system/license.texi \
-	docs/system/cpu-models-x86.texi docs/system/cpu-models-mips.texi \
-	docs/system/deprecated.texi docs/system/qemu-option-trace.texi \
-	docs/system/security.texi
+html: docs/interop/qemu-qmp-ref.html docs/interop/qemu-ga-ref.html sphinxdocs
+info: docs/interop/qemu-qmp-ref.info docs/interop/qemu-ga-ref.info
+pdf: docs/interop/qemu-qmp-ref.pdf docs/interop/qemu-ga-ref.pdf
+txt: docs/interop/qemu-qmp-ref.txt docs/interop/qemu-ga-ref.txt
 
 docs/interop/qemu-ga-ref.dvi docs/interop/qemu-ga-ref.html \
     docs/interop/qemu-ga-ref.info docs/interop/qemu-ga-ref.pdf \
diff --git a/.gitignore b/.gitignore
index bc0a035f9cc..0c5af83aa74 100644
--- a/.gitignore
+++ b/.gitignore
@@ -46,9 +46,6 @@
 !/qapi/qapi-visit-core.c
 /qapi/qapi-visit.[ch]
 /qapi/qapi-doc.texi
-/qemu-doc.html
-/qemu-doc.info
-/qemu-doc.txt
 /qemu-edid
 /qemu-img
 /qemu-nbd
diff --git a/docs/index.html.in b/docs/index.html.in
index a576ace8a27..cc19aad2ec5 100644
--- a/docs/index.html.in
+++ b/docs/index.html.in
@@ -7,7 +7,6 @@
     <body>
         <h1>QEMU @@VERSION@@ Documentation</h1>
         <ul>
-            <li><a href="qemu-doc.html">User Documentation</a></li>
             <li><a href="qemu-qmp-ref.html">QMP Reference Manual</a></li>
             <li><a href="qemu-ga-ref.html">Guest Agent Protocol Reference</a></li>
             <li><a href="interop/index.html">System Emulation Management and Interoperability Guide</a></li>
-- 
2.20.1


