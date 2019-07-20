Return-Path: <SRS0=lwXe=VR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39884C76188
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 15:21:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CEE92084C
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 15:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4NGI7ON"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CEE92084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1horAp-0007sh-VY
	for qemu-devel@archiver.kernel.org; Sat, 20 Jul 2019 11:21:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39917)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hor8Y-0006Gi-Ho
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 11:19:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hor8W-0008Bl-FP
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 11:19:01 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:34069)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hor8W-00089n-8x
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 11:19:00 -0400
Received: by mail-wr1-x42e.google.com with SMTP id 31so35071197wrm.1
 for <qemu-devel@nongnu.org>; Sat, 20 Jul 2019 08:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2jXZXn8D0C4OSjVChn2Rnr8HsT29F+x6ytM6XlvQE38=;
 b=c4NGI7ON9/d4x/xi6Sl/EIwYaTZA94XoqpbiNdE5DtLM743R+zBIqYLiYtCD/OKUcz
 OyoOlBt7NpnIUxPVAwBrRc0o8dO+LJGwiNb7caWnLUDxdEFUQ/Oj8axb1d7LIrP+nrI0
 9rhkBjUuUrovWW6EaZ0DQFaTAfbADT0lHZ119XPnEVVSbyKtjQT59ZYSvNJ88QIsdqWp
 jvnrUGtwEPc9ZnBt2bvpw79XnGdKGovi/wavCXsT84UHZaHJ3Ff6HMoCbQ+a/caeZDEf
 6k61tBjLFbtQgayNR/fTbSpjO8BbnwHtSdXHua+4V02558silM24pFXDO1JU6jToVeTU
 hdMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=2jXZXn8D0C4OSjVChn2Rnr8HsT29F+x6ytM6XlvQE38=;
 b=Crn7h9c5bpi2QcHMaUNL8r9wiji6VJTDKyEpl5uRb1Lu02raaaBff+w2VNM3/f5EJt
 5UsbV0azKkVrJxz/ReMV9jqtfJPNp1RG7lRh2/St6wxvBakD2OH+Qr98F1SwfQDGNwnZ
 KybsncOiRi+wh9GV1w1rnPSSjMrlVw0j2Hn0DpNx1GZR5rCX3P+tbN+TDC0n4QDhgEIv
 vnR8ym3Pc/giJ0bWsb0Yju6Nh5drjih0GirNbFp1uecD5uyvC1HD33f9UZYL9/TH+gFa
 yacwnP/e5WhsTlU3g51PzFrK0L4FZr0d2SL+tRYL310UKPvZ5TYSUvT3PZCvdSI5k4PW
 k+Yg==
X-Gm-Message-State: APjAAAUALYWtrDDQArJesq0aCHck3Oy8q11xST0eEMnqRGPGRbrhVpPc
 Ocmy8VsLqKjYumXNVPxKNu97kw7r2NE=
X-Google-Smtp-Source: APXvYqz9s6lYir+VZbY9LbmB4TG32+jvQ9irvM6UMPs/nBCIkX3mDpo899b4Z8gxd1JvcidgbgIMNg==
X-Received: by 2002:a5d:4101:: with SMTP id l1mr7062821wrp.202.1563635939034; 
 Sat, 20 Jul 2019 08:18:59 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:8501:6b03:f18c:74f8])
 by smtp.gmail.com with ESMTPSA id 4sm77517291wro.78.2019.07.20.08.18.58
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sat, 20 Jul 2019 08:18:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Sat, 20 Jul 2019 17:18:44 +0200
Message-Id: <20190720151846.7450-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190720151846.7450-1-pbonzini@redhat.com>
References: <20190720151846.7450-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42e
Subject: [Qemu-devel] [PULL 10/12] build-sys: do no support modules on
 Windows
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

Our module system does not support Windows, because it relies on
resolving symbols from the main executable.

If there is enough interest in supporting modules on Windows, we could
generate an import library for the executable and link with it:
https://stackoverflow.com/questions/15454968/dll-plugin-that-uses-functions-defined-in-the-main-executable

However, there is a small chicken egg problem, since the executable
link and exports extra symbols needed by the library...

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20190718120413.27678-1-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 99c64be..7be0e68 100755
--- a/configure
+++ b/configure
@@ -1752,7 +1752,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   guest-agent     build the QEMU Guest Agent
   guest-agent-msi build guest agent Windows MSI installation package
   pie             Position Independent Executables
-  modules         modules support
+  modules         modules support (non-Windows)
   debug-tcg       TCG debugging (default is disabled)
   debug-info      debugging information
   sparse          sparse checker
@@ -2007,6 +2007,11 @@ else
   QEMU_CFLAGS="$QEMU_CFLAGS -Wno-missing-braces"
 fi
 
+# Our module code doesn't support Windows
+if test "$modules" = "yes" && test "$mingw32" = "yes" ; then
+  error_exit "Modules are not available for Windows"
+fi
+
 # Static linking is not possible with modules or PIE
 if test "$static" = "yes" ; then
   if test "$modules" = "yes" ; then
-- 
1.8.3.1



