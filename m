Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30CBC2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:30:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F99720708
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBr6a0jv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F99720708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36197 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwWZV-0001Ly-Ev
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 14:30:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38079)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV8Q-00050B-H6
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:58:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV8O-0001Fa-F4
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:58:45 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:45415)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV8N-00019p-6h
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:58:44 -0500
Received: by mail-wr1-x42a.google.com with SMTP id a6so2512953wrx.12
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EqESmTEtT/p3MOmEHvZQu226y3+te7VsvQrlKN5RVQg=;
 b=OBr6a0jv8uS3MYTIIn+NiUR/XjgJ7xKMjKWVJG+TJzx+UvCX/ucoGOmnpcVGrooTJY
 jTHvIjcVAVavH8wM+yAQxZ+vBivw1LjnaZMaZC7ayH+4jPw+mebxdsK95Wq0+mg1tsLx
 St7vASEsEvxlm+875VKyU5PBypN2hf2FCPNcRapNxmrQFEzM6RhAQQIPSjeMwPDn23Nh
 Vt+Ctzn3BBAr4rcHsRZMNtdDifW17VJZlVxog+6m2GORmpZ9MYBepBlJM0Bjnki/xA46
 IJ8SzTyNQr9QRfDZkbBCwD4MmWoBI0U3UzpnhgjuSKcrP+Uf0IV1hxLzjRoF6iLVhLUV
 Njtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=EqESmTEtT/p3MOmEHvZQu226y3+te7VsvQrlKN5RVQg=;
 b=LfdoppLV1nP4sJHGGkQXjUajuJ5b4H7VsmExGPSgrC8JB8N0YlKUmw73g8OzzkQj7x
 WmFyIQVQvwfYtoITIa5ffWgU8ytWffhdDnap8ErpssnEdBRL24mz6BWnrHkT+QVGvdVb
 TZdNNQpwQxJ48t63nGsQ3vYUGFFJ343DjHZaw9FYHvK2XULUk7OLCiDIUr5eFiwp8f8q
 +A+7G2wjuWA8ahb7NIIk6ej4NR2vfs9dAnnWlu1dWey5JmOWx8h16u99JzZeW+ta1ddh
 XNH3CrS0BJJHbrQQve4XG0T8MX67RQYXP3N8HilQUeW4lbag5LqnYkWfF3QCDhkkj43c
 4DBQ==
X-Gm-Message-State: APjAAAVa6egMZaflXgmI12H21F1/9HhswiNhf2qrdxGTgfwJqgZzsmIv
 H4ReF6yhkKr4AIM9cchC72kAlBEt
X-Google-Smtp-Source: APXvYqxIITdVIZiT8XInipDc/VLxahqw0O3S/7ZjM7YiDmdhpRQg6Dp4/58VZFqF8tk/dJBFsUhVMw==
X-Received: by 2002:a5d:6144:: with SMTP id y4mr29258626wrt.15.1580234321714; 
 Tue, 28 Jan 2020 09:58:41 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.58.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:58:41 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 124/142] meson: generate version.texi
Date: Tue, 28 Jan 2020 18:53:24 +0100
Message-Id: <20200128175342.9066-125-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 Makefile             | 6 ------
 docs/meson.build     | 4 ++++
 docs/version.texi.in | 2 ++
 3 files changed, 6 insertions(+), 6 deletions(-)
 create mode 100644 docs/version.texi.in

diff --git a/Makefile b/Makefile
index c8681ddec7..2614138f62 100644
--- a/Makefile
+++ b/Makefile
@@ -379,12 +379,6 @@ MAKEINFOFLAGS=--no-split --number-sections $(MAKEINFOINCLUDES)
 TEXI2PODFLAGS=$(MAKEINFOINCLUDES) -DVERSION="$(VERSION)" -DCONFDIR="$(qemu_confdir)"
 TEXI2PDFFLAGS=$(if $(V),,--quiet) -I $(SRC_PATH) $(MAKEINFOINCLUDES)
 
-docs/version.texi: $(SRC_PATH)/VERSION config-host.mak
-	$(call quiet-command,(\
-		echo "@set VERSION $(VERSION)" && \
-		echo "@set CONFDIR $(qemu_confdir)" \
-	)> $@,"GEN","$@")
-
 %.html: %.texi docs/version.texi
 	$(call quiet-command,LC_ALL=C $(MAKEINFO) $(MAKEINFOFLAGS) --no-headers \
 	--html $< -o $@,"GEN","$@")
diff --git a/docs/meson.build b/docs/meson.build
index 0f86c0b522..124987dc57 100644
--- a/docs/meson.build
+++ b/docs/meson.build
@@ -1,3 +1,7 @@
+configure_file(output: 'version.texi',
+               input: 'version.texi.in',
+               configuration: config_host)
+
 sphinx = find_program('sphinx-build', required: build_docs)
 
 SPHINX_ARGS = [sphinx, '-W', '-q', '-d', '@PRIVATE_DIR@',
diff --git a/docs/version.texi.in b/docs/version.texi.in
new file mode 100644
index 0000000000..0a723b8be6
--- /dev/null
+++ b/docs/version.texi.in
@@ -0,0 +1,2 @@
+@set VERSION @VERSION@
+@set CONFDIR @qemu_confdir@
-- 
2.21.0



