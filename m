Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6ADC10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 15:57:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 221A82133D
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 15:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvXF1QTD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 221A82133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45133 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDt7c-0000fU-6A
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 11:57:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hDt5u-00085w-Uz
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:55:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hDt5t-0004hn-If
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:55:30 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:37164)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1hDt5t-0004ZC-4p
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:55:29 -0400
Received: by mail-wm1-x332.google.com with SMTP id v14so3942836wmf.2
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 08:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=J/oX2Py0fTzs8jjZVuYDRStPJAK1DgZHWNwrWKfTCFU=;
	b=FvXF1QTDpU6TaBFbNUGnUlewy8t6GaaDqjenPSQheCRGIPFOtDvprpCzD07LR15mZe
	xfToRJpQnMWOmB9JxMPNPO2D9564WwPDbDBX82FxL14sf4wn9hFQXfkVHQt+EvldiuOF
	el/OnuNtQnrSCqGDU4CwBAITNf38Kx/PIOB6EjwFJUVYruMTHbW/XIHDVAqvG+pSQiJk
	j5TKU5fMd9vt9rpxLGi08Sg/Jdc9U8QkIuVywjxKV0aAwas59OjpmUDJEJn74ZW1AH44
	agc0vqCq+uiWjDqR8U9tZ3N+4ysQ0fHzSErdDn2JPGoP4uiZmyUDR4s9sizIiDBSfO47
	9lxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	bh=J/oX2Py0fTzs8jjZVuYDRStPJAK1DgZHWNwrWKfTCFU=;
	b=cBkAQy1qVfJx9kQ2qBIOK9AtV3EbGZFQI7oWNg6FPXdQPBwSiYdhQkDiyszawVWFb1
	dn2qYfKXG1YdbATeHFsNJyaeL8pJjvtfE0UV40JkheKw1zufrr6lEP/9ChdWbdzZAp6T
	0HcitU8NUxgOqFF6/VoIysTpkg5H5qb9c9naA3XuXDkpAU9Mg17nBNSws/VVX9k6LFye
	wnkPlH3/GNeg3xxVRluituYNp7e0wGckejlWZvdyBBZikQOOX35yXZV5S+rFASSC+2Oj
	CcQv7nzA/nAj/dP9trFq9ALV/NxqSykcQ4via+12PiW9wyxBM9k75U83tWAiOXTsKnFf
	esXw==
X-Gm-Message-State: APjAAAWbGA6+FOoCItkpqANpk0B9CegQQQQQ7NAySa8JjcLen50fQGZr
	L0cx2aNqpZK+7UKoc5GdmGbpcf9n
X-Google-Smtp-Source: APXvYqxSx4q2pTGiQ92UGGrX1JNMoptBKT4UXnPFsJt7uHKBuPePvkxnZAooMObkgPky7ptg+sV89g==
X-Received: by 2002:a1c:c287:: with SMTP id s129mr23509899wmf.63.1554825319658;
	Tue, 09 Apr 2019 08:55:19 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	g84sm23117586wmf.25.2019.04.09.08.55.18
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 09 Apr 2019 08:55:19 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  9 Apr 2019 17:55:13 +0200
Message-Id: <1554825316-33288-3-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1554825316-33288-1-git-send-email-pbonzini@redhat.com>
References: <1554825316-33288-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::332
Subject: [Qemu-devel] [PULL 2/5] roms: Allow passing configure options to
 the EDK2 build tools
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409155513.zm26_3Sy9NUhZ_TVn9TITTwMpV8hDRkzM1ggZEBhi8o@z>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Since commit f590a812c210 we build the EDK2 EfiRom utility
unconditionally.

Some distributions require to use extra compiler/linker flags,
i.e. SUSE which enforces the PIE protection (see [*]).

EDK2 build tools already provide a set of variables for that,
use them to allow the caller to easily inject compiler/linker
options..

Now build scripts can pass extra options, example:

  $ make -C roms \
      EDK2_BASETOOLS_OPTFLAGS='-fPIE' \
      efirom

[*] https://lists.opensuse.org/opensuse-factory/2017-06/msg00403.html

Reported-by: Olaf Hering <olaf@aepfle.de>
Suggested-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190409134536.15548-3-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 roms/Makefile | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/roms/Makefile b/roms/Makefile
index d28252d..1ff78b6 100644
--- a/roms/Makefile
+++ b/roms/Makefile
@@ -120,8 +120,21 @@ build-efi-roms: build-pxe-roms
 		$(patsubst %,bin-i386-efi/%.efidrv,$(pxerom_targets)) \
 		$(patsubst %,bin-x86_64-efi/%.efidrv,$(pxerom_targets))
 
+# Build scripts can pass compiler/linker flags to the EDK2 build tools
+# via the EDK2_BASETOOLS_OPTFLAGS (CPPFLAGS and CFLAGS) and
+# EDK2_BASETOOLS_LDFLAGS (LDFLAGS) environment variables.
+#
+# Example:
+#
+#  make -C roms \
+#    EDK2_BASETOOLS_OPTFLAGS='...' \
+#    EDK2_BASETOOLS_LDFLAGS='...' \
+#    efirom
+#
 $(EDK2_EFIROM):
-	$(MAKE) -C edk2/BaseTools
+	$(MAKE) -C edk2/BaseTools \
+		EXTRA_OPTFLAGS='$(EDK2_BASETOOLS_OPTFLAGS)' \
+		EXTRA_LDFLAGS='$(EDK2_BASETOOLS_LDFLAGS)'
 
 slof:
 	$(MAKE) -C SLOF CROSS=$(powerpc64_cross_prefix) qemu
-- 
1.8.3.1



