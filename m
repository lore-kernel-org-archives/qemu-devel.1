Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD026C761A6
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 13:34:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88BA32070B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 13:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mA4SMlf3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88BA32070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3gXl-0004h4-Mp
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 08:34:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55189)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j3gWi-0002xG-Ds
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 08:33:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j3gWh-0003kR-AT
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 08:33:32 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:50981)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j3gWh-0003k5-4D; Mon, 17 Feb 2020 08:33:31 -0500
Received: by mail-wm1-x343.google.com with SMTP id a5so17148343wmb.0;
 Mon, 17 Feb 2020 05:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Akr7B/6EjPnwm6unavMg229GyGf7rHs9Me2/2WnNero=;
 b=mA4SMlf3namsK0FpuNXD5G47f4dYHn/5ZwJTjlxGfM9MuE11n6165OhHWOAeor/pB3
 SXc+q8ZbCsi+LaHrwPj5vPlcQzo1gkh8ENX6w1vgp2Qcc4EML0Oci0AUDNXxtd/sOPEs
 9qm6xvFZoopN7c1Im9AH9qTpuzLAH/yroUmuL2LHE9C3tMJsPEgZvQu/id5bmu6vf0yS
 yU5olkoOIyzxSCJMxetaZLFb5UASe4dCpaFiv+WLF9QKwsfyk5cmQ+snYLd0q9iTXqBC
 xReVDytcR8pnFwj+p/72Fa433DSmXKxMtxpsUPKoFoMQKDqQW7OaBVsOZCqC3nGp8AZF
 LYyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=Akr7B/6EjPnwm6unavMg229GyGf7rHs9Me2/2WnNero=;
 b=D8c2AqkgxjXWn9s3DmvO3o27G4+27uUQ3x33WbDWd83dLLcGyVJ/ihcdKDvFJ+fpGj
 Yr8hAylay06A3on1MXEjkx/cXGntRd6U45FpvAJDRpJpEgEsuvhDkpaPDXBYgO02WUSA
 iZFSImjzyM+laLcVQlXa/w0NEf8dWQn/ustX964SUj7XiS83YCoMzDC/VVcsUZ/R3zpF
 4ATnwA2ATyXUt3lcEQstALGpJODUZJQD/myGv6mmeykR7LBpX8hImRgGtm8ZWAJzuq2A
 binGGYjdu0hfsK2yLU+gFrgihW57hbm21xx3DKv4ESWq7aEGoMGvnhbWRPyt1dW6IWaY
 dc8Q==
X-Gm-Message-State: APjAAAVhZbLV7m8r/MZbbWHEe/oNUEnF4AjUkpwqO5aE4Pqk7KnmThSF
 XKdTKQkOd9SjhaykiyzlAZ+9Q61xu6o=
X-Google-Smtp-Source: APXvYqy+KqNx+xpV3bIqHouHjKxAidz3kUTAqNFnVphZJGqmRKtlCOCfx//cd1Xj2aw+GaP39cuQWQ==
X-Received: by 2002:a05:600c:d7:: with SMTP id
 u23mr22847380wmm.145.1581946409627; 
 Mon, 17 Feb 2020 05:33:29 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id x132sm28575891wmg.0.2020.02.17.05.33.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2020 05:33:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3] configure: Avoid compiling system tools on user build by
 default
Date: Mon, 17 Feb 2020 14:33:27 +0100
Message-Id: <20200217133327.25144-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: qemu-block@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

User-mode does not need the system tools. Do not build them by
default if the user specifies --disable-system.

This disables building the following binaries on a user-only build:

- elf2dmp
- qemu-edid
- qemu-ga
- qemu-img
- qemu-io
- qemu-nbd
- ivshmem-client
- ivshmem-server

The qemu-user binaries are not affected by this change.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v3:
- fixed typos (Aleksandar)
v2:
- use simpler if/else statement (therefore not adding Richard R-b)
- improved description (Aleksandar)
---
 configure | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 6f5d850949..efe00dd497 100755
--- a/configure
+++ b/configure
@@ -455,7 +455,7 @@ guest_agent_ntddscsi="no"
 guest_agent_msi=""
 vss_win32_sdk=""
 win_sdk="no"
-want_tools="yes"
+want_tools=""
 libiscsi=""
 libnfs=""
 coroutine=""
@@ -2213,6 +2213,16 @@ else
     echo big/little test failed
 fi
 
+##########################################
+# system tools
+if test -z "$want_tools"; then
+    if test "$softmmu" = "no"; then
+        want_tools=no
+    else
+        want_tools=yes
+    fi
+fi
+
 ##########################################
 # cocoa implies not SDL or GTK
 # (the cocoa UI code currently assumes it is always the active UI
-- 
2.21.1


