Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E30FC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:18:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08E022072B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PugTkC4J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08E022072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihYHB-0000wb-F8
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 07:18:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46346)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY2r-000687-E7
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY2p-0008Uj-Sn
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:12 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41980)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ihY2p-0008QI-Ki
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:11 -0500
Received: by mail-wr1-x443.google.com with SMTP id c9so1998468wrw.8
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 04:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=gHpB9VBgS6owHr3NE5d8EsFR0LXGLo1Ca+/lorSA0No=;
 b=PugTkC4JU+8PJde+ZygRyZ89UWHsiqUAfCd6J5W/sZLp8EoX9MeG/W75FBmCA4hwFy
 lyXAKyX2Q8f+kc+1lqtM9t0KBNwCivo8T60k0eKhm6+sYLJQuRuBUKdMeAaWD+bEwS3s
 eYCNvEiTr7upCWMe3dhnoT+lVfOafvmZGuLsZSWcpSE2s2k95gDdNBI+nwbF/hnVTLmP
 CGJu+O7Psgax0XWBnO7HfISAv+gMiokjlPXyQMCNeT0qcvWbquxoUnINOU6ydJYSXO4e
 WiirTM0VYFTD2EUWuqZ01yOq1CFJXJigJoOl81jGc3WTf5NP/tLgz/L8QcQ6KgC1kW1v
 R2gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=gHpB9VBgS6owHr3NE5d8EsFR0LXGLo1Ca+/lorSA0No=;
 b=tHVTyUoN/sY/cF8+T9fH4j891lCChD1s3V9TLbExXbwN4114xLK5Ih91RpeTwNAfpe
 J9r0SxQljFu5+AToY6b6C+d7PmzYLr2vJfa8kZxCMaY6Hyj9osglC0z2hoDpkn0E0697
 0Yi6+MesIk41WwaYXZlZIL0FPiWejetPuP3x4LrASBlIkdQEDmrPPbZXdQNjTks72UTa
 xE66UPy9NsZztOQPna0V1E+M/FkjloQpeokzpQBLFQf5xetyI5c59+5uKpXvmE0sEl7g
 WBlVrRnZ18Od7RGB5BAwQKiNVzmcCAChaOsvPPMdx/NIfm3Fyr9XnvMRfsvR7S1Tq6OH
 mJgw==
X-Gm-Message-State: APjAAAW5KzQuFsC+KbPyyish00wypwL3IEhD3Lwejb8bswIuP+Hg1Qpo
 EpnlOOpji+MqYUcMY/BYFxF/8lX0
X-Google-Smtp-Source: APXvYqz+niIFp7yMD7LTxod3V6z4Kw9i2ZbUabKe32Vk6PG78DANN5E6YqXsMGLQCmFgupYyVqwEdw==
X-Received: by 2002:a5d:6802:: with SMTP id w2mr2373008wru.353.1576670590265; 
 Wed, 18 Dec 2019 04:03:10 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n67sm2236838wmf.46.2019.12.18.04.03.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Dec 2019 04:03:09 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 15/87] vl: extract accelerator option processing to a separate
 function
Date: Wed, 18 Dec 2019 13:01:41 +0100
Message-Id: <1576670573-48048-16-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
References: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As a first step towards supporting multiple "-accel" options, push the
late processing of -icount and -accel into a new function, and use
qemu_opts_foreach to retrieve -accel options instead of stashing
them into globals.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 vl.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/vl.c b/vl.c
index 6e58c1d..7ed9026 100644
--- a/vl.c
+++ b/vl.c
@@ -2706,6 +2706,25 @@ static int do_configure_icount(void *opaque, QemuOpts *opts, Error **errp)
     return 0;
 }
 
+static int do_configure_accelerator(void *opaque, QemuOpts *opts, Error **errp)
+{
+    if (tcg_enabled()) {
+        qemu_tcg_configure(opts, &error_fatal);
+    }
+    return 0;
+}
+
+static void configure_accelerators(void)
+{
+    qemu_opts_foreach(qemu_find_opts("accel"),
+                      do_configure_accelerator, NULL, &error_fatal);
+
+    if (use_icount && !(tcg_enabled() || qtest_enabled())) {
+        error_report("-icount is not allowed with hardware virtualization");
+        exit(1);
+    }
+}
+
 int main(int argc, char **argv, char **envp)
 {
     int i;
@@ -4103,14 +4122,7 @@ int main(int argc, char **argv, char **envp)
     qemu_spice_init();
 
     cpu_ticks_init();
-    if (use_icount && !(tcg_enabled() || qtest_enabled())) {
-        error_report("-icount is not allowed with hardware virtualization");
-        exit(1);
-    }
-
-    if (tcg_enabled()) {
-        qemu_tcg_configure(accel_opts, &error_fatal);
-    }
+    configure_accelerators();
 
     if (default_net) {
         QemuOptsList *net = qemu_find_opts("net");
-- 
1.8.3.1



