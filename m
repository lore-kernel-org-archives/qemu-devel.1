Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3228C3F68F
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:09:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C79ED22522
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MESs5Iia"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C79ED22522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwVJ8-0002Us-UD
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:09:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58096)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV4I-0006Uj-I3
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:54:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV4G-0008L3-JJ
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:54:29 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:50732)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV4G-0008IP-D1
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:54:28 -0500
Received: by mail-wm1-x330.google.com with SMTP id a5so3523334wmb.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gnuJrzJMsy83i/juNiNrTB42IxUjXYwNq6iNGjiTIgE=;
 b=MESs5IiaseSx+qdPosxBSAjb5kqr0zBgOE0rp3FlJ3wZiZx+aoUL5Lg9nXfwkvxT+q
 idRPypNFsX17x9J3EioEriMFsnGl2wK4tF0bHBnMYULwYEkThvAN1gg5swuLYjV0wPXK
 cWXKraAt1uCzs/MSVe3qHg2Y59hD05twqw8smA1iAMQy581ga1RfTi2ilc17ZL8RMUFv
 EPkoTmjp2clSHU4OGQCjTFu77zXZVNV7U/s7k+rjF/8LUouUrAz5RUVySDSA3dJ5j3Ra
 a0mtF2zYifWcdUnlCz3dV8dXk6rSlesAxTBXNZopkGcgBCMCJTuWLtKJ9lJpsTC+gxdY
 AC5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=gnuJrzJMsy83i/juNiNrTB42IxUjXYwNq6iNGjiTIgE=;
 b=P6h8rBWccd9DczvlQqqzjDStz9IstMRCM6m+EBGPQRRbhjZ9Ygut6XaGO61/7UNyDR
 AGdCF+7p6zwRnVcbKBNJCR0CIDq6T4YYE4uLWoXCU9/r6uzd9Wc0ffXbhYxVt5eNNgK6
 ysBcvArn6CIuGHlMJgY5uA0Bf7zSQJePSPajSDIg8+WpXJ4xtQNpfpXBUbFivJVHLpdO
 WeuF/cHEfSNHEtYhvzSTgYHS3PTWug9c25avdnY0pru0/A411gw54eGfMncvbGNLlPcu
 cx/rjkTkIKgB2zEOeix6RJ0gk6bVFRx5oU1TzTALIJHszr6aXX+yyEJZ+4h+kEMgIvMz
 Wx3w==
X-Gm-Message-State: APjAAAWUAGduSYgneikszydCwgsQ/z/WUz3e8j1Ag567B0R9K6aw8N0u
 HyN3Go2N/0sSPh4fMn3AMP6ndRrt
X-Google-Smtp-Source: APXvYqwnQgQ3dv2o5f7SpBpt34AS/UqJ/aaKJAP2+Z5fvpvitjuhcTG31RF6/Yi67cxpJKUvr/UTUg==
X-Received: by 2002:a7b:cc6a:: with SMTP id n10mr6351802wmj.170.1580234066011; 
 Tue, 28 Jan 2020 09:54:26 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.54.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:54:25 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 015/142] meson: add version.o
Date: Tue, 28 Jan 2020 18:51:35 +0100
Message-Id: <20200128175342.9066-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::330
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
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index d22c0c93d3..94727e8dfb 100644
--- a/meson.build
+++ b/meson.build
@@ -23,8 +23,14 @@ configure_file(input: files('scripts/ninjatool.py'),
 m = cc.find_library('m', required: false)
 util = cc.find_library('util', required: false)
 socket = []
+version_res = []
 if host_machine.system() == 'windows'
   socket = cc.find_library('ws2_32')
+
+  win = import('windows')
+  version_res = win.compile_resources('version.rc',
+                                      depend_files: files('pc-bios/qemu-nsis.ico'),
+                                      include_directories: include_directories('.'))
 endif
 glib = declare_dependency(compile_args: config_host['GLIB_CFLAGS'].split(),
                           link_args: config_host['GLIB_LIBS'].split())
@@ -179,4 +185,5 @@ util_ss = util_ss.apply(config_host, strict: false)
 libqemuutil = static_library('qemuutil',
                              sources: util_ss.sources() + stub_ss.sources() + genh,
                              dependencies: [util_ss.dependencies(), m, glib, socket])
-qemuutil = declare_dependency(link_with: libqemuutil)
+qemuutil = declare_dependency(link_with: libqemuutil,
+                              sources: version_res)
-- 
2.21.0



