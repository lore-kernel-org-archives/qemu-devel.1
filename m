Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E721EC10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 16:27:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC6662084F
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 16:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbBAubcD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC6662084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45891 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDtay-0008L2-Tr
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 12:27:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hDtWl-0004Z9-4k
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:23:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hDtWk-0003US-4h
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:23:15 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:45458)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1hDtWj-0003TX-Tm
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:23:14 -0400
Received: by mail-wr1-x429.google.com with SMTP id s15so21649839wra.12
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 09:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=J/oX2Py0fTzs8jjZVuYDRStPJAK1DgZHWNwrWKfTCFU=;
	b=nbBAubcDKlZUtyrL0DR9I9vj0e5w7B8rMWbAN+MsNvVZoSJlUN6qdSRFEeW7Ou++TK
	CLTRt/CoufNL+T4nQ92JJzyx/3C6cTu8ShqobeWn+rYu9sGc1anhkMZwtaw8M+5wqLqq
	hvyJHNJV3U22gUqDMFr+V7u66PY0CSOZxjC0EDV0F5Y4dPjFVSOuBGGoJ7O0ZEn+bq8r
	m/Ad/lIonEWZDimtDU3msV62wGs64K49pXH7eHQovM5SY08HNxQn7d+6A5ZF07py2YpA
	TC/foxsAbJSk4bHy8I+iTWn8Kx/A8rc2Tw33Tir1HMqYPOxXTYBEGNucxwcSXX/6XQ5H
	IWHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	bh=J/oX2Py0fTzs8jjZVuYDRStPJAK1DgZHWNwrWKfTCFU=;
	b=iT3Vb0ZWeXUTLbqt6aimdv13ZrNQEVpXCPvRpoBdtgyAaYSn6wu0qyDCuAe/fnoaE1
	mNaj/4muQynRENSMU3M1I17Iii2T7x4Aj5TSdkypvpzyL+7K1BgIfkZSYsP3WLHZOkfZ
	YQmBB3IYfVqtHSexz6yhBtE2rOAsyNQpKv4yImHExak3Nw/Kjm5VZzBfMK2U96cruAT7
	wBhtfNzJh4zoXfvlcM5AqgiHKnBegdjz3p039VzyUiPqA8zM8yet3Zi80TtZdIdxybz0
	PzsgsgE0JQLP4167bHLjZU4OwPofZjKlj+xzAHNX73datptZCQa3fuurUC4ISeNvIJKi
	OpeA==
X-Gm-Message-State: APjAAAUPdFN4KhC0ru1nfk6mKN/dRB8ziIzJXIOAdEO9/vb6GR9HA0rl
	gM8wpoLiJWttA/dvsNbeoEEB8DYY
X-Google-Smtp-Source: APXvYqyQ+r8lW1vi4HIicna5uqVl3dtZdMZ6WCxLHFH45Re4PX8qhJ0IQukPrkww3NHWl+JHO6aWeA==
X-Received: by 2002:a5d:62c4:: with SMTP id o4mr2469619wrv.282.1554826992681; 
	Tue, 09 Apr 2019 09:23:12 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	e1sm59579736wrw.66.2019.04.09.09.23.08
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 09 Apr 2019 09:23:12 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  9 Apr 2019 18:23:03 +0200
Message-Id: <1554826986-37164-3-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1554826986-37164-1-git-send-email-pbonzini@redhat.com>
References: <1554826986-37164-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::429
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
Message-ID: <20190409162303.SCHQGX8savfw7AxuPoCdBIgb2eg43zfCe6e0V_-TK20@z>

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



