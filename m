Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D49CC43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 22:10:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5211D2071B
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 22:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rciY0xXw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5211D2071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHxBZ-00023k-Ii
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 18:10:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49271)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jHx59-0003E9-OT
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 18:04:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jHx58-0000Zs-N4
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 18:04:03 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:37492)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jHx58-0000XD-HX
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 18:04:02 -0400
Received: by mail-pf1-x441.google.com with SMTP id h72so5151616pfe.4
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 15:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cb2unVg/y3kPzR3lxHeExP2weV+dUFcGMy6C6nOZx0Q=;
 b=rciY0xXwixWMtFjY9FnLTIKNpNa8jYlmscZG59dmFxKZoLNZo3RwfDya2FtY2zwN4d
 TLpCytN15We2Sc314zGpSLuahtx8bUcqfsOCv3BQ04mF04O3b7v+SVsRqroS12o30bDW
 iAEWr1eQZH266xgEfwJICt+UByvCVB+HXlRgOLm0UgaUSOWJD3/KOuU8ZUGSO6xCqNjo
 /91q2KsyfGds28ovnIaKkJ0BXBT1RpS9z3r2DWJFlZYQGEvJRpxL44Jee9o+z9p05W7D
 j5a68dklAfR4tvN2b0HFPFh5fIWmYhLZAuXi6hgsUO0KnW3x5xVIp0kRD4LFYHMC5TSp
 0tcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cb2unVg/y3kPzR3lxHeExP2weV+dUFcGMy6C6nOZx0Q=;
 b=MALR6Kyh6XHr5F2LbWQTlm0fOrdZJ+muX8zAdwnPwOf2oNbvNpxcnkBNrSlen04CP8
 T5aRQwn/G2/kdzPJNzzKZHZOI3mCIobFPBGhRg/p09POVpTauLhAQ8V9kpNQsUZH8ujg
 EneO5LEWuPKvFwXu5KD1fDbqfD92lvU1HEeZBLfEx19K+DpyfaQuMzkewdc5mqyGphmo
 T2qAYNxn1ujlkotQx5clui2Zo/+fm6SU1/5/yCsw1Q1QeajoORkCA6jI0OtboDPUjOH7
 QA3Bziil8HPMIpVfR3Wea+dpVdWPXPuqJi/YPPd4JdAUghG/A2ToJukAbDmkEQkWVNEJ
 lTVQ==
X-Gm-Message-State: ANhLgQ1xVqY7a8Eg1HiZZn9Aea0NI4mz0Xm3UOTKKumPHCQI0Dy4C6OZ
 LNwrVZrb8C0xApZhaj2YgOl7hb6OLyo=
X-Google-Smtp-Source: ADFU+vtnfthVRC5SDRUhSJTimH+HZybzPs0huqnZlv+n7XxLWr03WbbQl4DpVw0xoKLgXykTP6uXyg==
X-Received: by 2002:a63:ce4a:: with SMTP id r10mr1454308pgi.225.1585346641010; 
 Fri, 27 Mar 2020 15:04:01 -0700 (PDT)
Received: from localhost.localdomain (174-21-138-234.tukw.qwest.net.
 [174.21.138.234])
 by smtp.gmail.com with ESMTPSA id y29sm4516929pge.22.2020.03.27.15.03.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2020 15:04:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.0 v3 4/7] configure: Always detect -no-pie toolchain
 support
Date: Fri, 27 Mar 2020 15:03:50 -0700
Message-Id: <20200327220353.27233-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200327220353.27233-1-richard.henderson@linaro.org>
References: <20200327220353.27233-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: dim@FreeBSD.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 alex.bennee@linaro.org, roger.pau@citrix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The CFLAGS_NOPIE and LDFLAGS_NOPIE variables are used
in pc-bios/optionrom/Makefile, which has nothing to do
with the PIE setting of the main qemu executables.

This overrides any operating system default to build
all executables as PIE, which is important for ROMs.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 configure | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/configure b/configure
index cbde833f6e..7ba18783cb 100755
--- a/configure
+++ b/configure
@@ -2107,26 +2107,24 @@ if ! compile_prog "-Werror" "" ; then
 	"Thread-Local Storage (TLS). Please upgrade to a version that does."
 fi
 
-if test "$pie" != "no" ; then
-  cat > $TMPC << EOF
+cat > $TMPC << EOF
 
 #ifdef __linux__
 #  define THREAD __thread
 #else
 #  define THREAD
 #endif
-
 static THREAD int tls_var;
-
 int main(void) { return tls_var; }
-
 EOF
-  # check we support --no-pie first...
-  if compile_prog "-Werror -fno-pie" "-no-pie"; then
-    CFLAGS_NOPIE="-fno-pie"
-    LDFLAGS_NOPIE="-nopie"
-  fi
 
+# Check we support --no-pie first; we will need this for building ROMs.
+if compile_prog "-Werror -fno-pie" "-no-pie"; then
+  CFLAGS_NOPIE="-fno-pie"
+  LDFLAGS_NOPIE="-no-pie"
+fi
+
+if test "$pie" != "no" ; then
   if compile_prog "-fPIE -DPIE" "-pie"; then
     QEMU_CFLAGS="-fPIE -DPIE $QEMU_CFLAGS"
     QEMU_LDFLAGS="-pie $QEMU_LDFLAGS"
-- 
2.20.1


