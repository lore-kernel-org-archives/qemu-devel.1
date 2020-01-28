Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D36C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:21:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E58AE2173E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWrjuP81"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E58AE2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwWQ9-0006Oq-21
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 14:21:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38830)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV8t-0005Pn-Fd
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:59:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV8m-00027Z-RE
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:59:10 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:44329)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV8m-000260-J4
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:59:08 -0500
Received: by mail-wr1-x429.google.com with SMTP id q10so17107172wrm.11
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+w3DGqCwnwP5zmGDT2Dqzlgsx2UcXXMyGmcoAFRBBTs=;
 b=gWrjuP814qCPdwcaHL339QGytjTLzL6KNxbBGO15xa6hMGBVpSxm96re3Rz+KNsSiR
 JhY31H0iRM+p9/f60eQqKq5OkI+js87xfsLyIcYtjdLqReI2wA2xdymIeUsVDNNLf0pW
 ZvYJ9gatDvJZ4PFr2zQ3Eoz31BLpTnYVcGxvqYoCb447eFtXcueX0cG8+pypHAO1aXTa
 xhxkwKjV5BfUA0VTdYGNCIMVqTq3u1yWTFvh2D4uj/WiUn7N5B72UXJlCwbIEMrqJ9NJ
 67ezxiAR2+MmU+dGvNUaCaKNys2cTTIrwEBBd91Mr071NV6vb41FuplVXuazzKw6OXNj
 phvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=+w3DGqCwnwP5zmGDT2Dqzlgsx2UcXXMyGmcoAFRBBTs=;
 b=isZbM23R4RkGvVPmIEjpbZ5DphZLg9/HEicbdTN/ehyJuKtt4RUlNwYXihMPuvKL3S
 FHq4ELp2YHFhL0g6/FRzfFiiKuDD3qxtIA93nEh5Cf3WI0HDiJ6A6wN3v/iiZ/LNmCnO
 hDe86C5fJIxbpMnlmz32STMq52NKcASWdahDti1yGC0FMbco5nJ+VeDSXLY3l+5OAKry
 o4GB1RufzeTlKe2RAp82SYb3JAoc6iB7NLfMLTGcwh4Ngy/ilnpfGhumpy+zK4meg8D6
 gLpXpmCeKk+BTSmBThP/deVQlPeFboQetLL7JmGxwggqWzW6sBHa0dXCNlW3KQxR/+GH
 zzrQ==
X-Gm-Message-State: APjAAAWxm+l3VZZv3h8b7vg3zvlgbz8r44OogC1vHbwG2zoVLMvlrsRF
 U3MN/MAPZZNLXZBBbn4TwAgpe7gm
X-Google-Smtp-Source: APXvYqyqsFUvOxGdBkdEyo84Y/9oPqagTI6715pHPQ3Latafom7Uhxy1OXjt7oHQ1I9NkLE5iTyo6A==
X-Received: by 2002:adf:df03:: with SMTP id y3mr30080416wrl.260.1580234347369; 
 Tue, 28 Jan 2020 09:59:07 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.59.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:59:06 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 135/142] meson: replace mostly useless pc-bios/Makefile
Date: Tue, 28 Jan 2020 18:53:35 +0100
Message-Id: <20200128175342.9066-136-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::429
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
 pc-bios/Makefile    | 19 -------------------
 pc-bios/meson.build | 12 ++++++++++++
 2 files changed, 12 insertions(+), 19 deletions(-)
 delete mode 100644 pc-bios/Makefile

diff --git a/pc-bios/Makefile b/pc-bios/Makefile
deleted file mode 100644
index 315288df84..0000000000
--- a/pc-bios/Makefile
+++ /dev/null
@@ -1,19 +0,0 @@
-#
-# NOTE: only compilable with x86 cross compile tools
-#
-include ../config-host.mak
-
-DEFINES=
-
-TARGETS=
-
-all: $(TARGETS)
-
-%.o: %.S
-	$(CC) $(DEFINES) -c -o $@ $<
-
-%.dtb: %.dts
-	dtc -I dts -O dtb -o $@ $<
-
-clean:
-	rm -f $(TARGETS) *.o *~
diff --git a/pc-bios/meson.build b/pc-bios/meson.build
index 4d99511a5c..62183506f7 100644
--- a/pc-bios/meson.build
+++ b/pc-bios/meson.build
@@ -89,3 +89,15 @@ blobs = files(
 if install_blobs
   install_data(blobs, install_dir: config_host['qemu_datadir'])
 endif
+
+dtc = find_program('dtc', required: false)
+if dtc.found()
+  t = []
+  foreach f: ['bamboo.dts', 'canyonlands.dts']
+    t += custom_target(f,
+                       input: f,
+                       output: '@BASENAME@' + '.dtb',
+                       command: [dtc, '-I', 'dts', '-O', 'dtb', '-o', '@OUTPUT@', '@INPUT@'])
+  endforeach
+  alias_target('update-dtb', t)
+endif
-- 
2.21.0



