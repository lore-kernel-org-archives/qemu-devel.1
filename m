Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9304CCA9EC2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 15:09:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B0F7214E0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 15:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M/awpGGd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B0F7214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP6eY-0002br-2x
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 11:09:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44575)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iP6Ul-0007US-8T
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 10:59:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iP6Uj-00043c-0C
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 10:59:47 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:53090)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iP6Ui-00043F-Qb
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 10:59:44 -0400
Received: by mail-wm1-x32d.google.com with SMTP id p21so9827566wmg.2
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2019 07:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZwXbM1gR9MpWZvFXDuXSv541qXotelrmjZ6gTXEMEYw=;
 b=M/awpGGduVemAbeSnE1cJx3aXKqoV8otSp3/r6Ow1ZkB3ifOVJniiBA0nadUAfuGhe
 ioblWR8qO4aod8k3RjiZL/ja8rZIo2XPU68nSWa8MZRvFk+uAiXvca/xv/m2J4IwgK4a
 oI+CLrkiCB/tE6XvPDaUyeWGq+bhpSvMXjQ1SU8nC2y3FhuUJx5ToUyDg82aBwyco9ZA
 wrqwUMwIv423fJIRvNx5wBb+raJkMdznZgdCXvOGyW4vkglun50fHgpuh4SI7fTDQ9wg
 WcrOPUqmtouFqMIdtS+noi98ROdaZK5MI5EZDkUGlC1YL0po4cuUyV7x/2cHp4jVfjMO
 Pnzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZwXbM1gR9MpWZvFXDuXSv541qXotelrmjZ6gTXEMEYw=;
 b=fICgyl4jw7u3CXKlIWBuGOVr3Z8Y462zuKozqNDpUV3kwL65vtc001ucue6+jilQeR
 QywgfJ5iiXnQ+Tc3FuU4Vu7RLvzH/2yIzkFFiM0OhX1xQcv7aMnXMDrSuXlKUvIUbBxA
 oKOulBT7xese+Z93Bb5HFBl0XaRTJmpiO4aWI28MJqjT1nQDCUL6QRzwfK01oVjv9HOD
 OQnXzUIncM8qUSMAblcmGhGa/QbFmSSOW5PM323XXPYLvQPHN03Molfl9QzuNGDppSTg
 qFYtyR1qbeHHCEPPEgBBiiv1VZ0pkqdJYRNBRwkRTJwPeWjsslk/FGnm9eWp9LrrPHFw
 QVsw==
X-Gm-Message-State: APjAAAXn9oRzvlgsXF23sN03D+ghwebqIQgZmn5QPf1wG9es4Md6/Ee/
 kDWggMhE1pSs+bYdfJVy2K0S12wO4S+6bw==
X-Google-Smtp-Source: APXvYqzLt1hlsXZ6Fl9TLmeNzwjyMMEb4SKJr0fK7lKzWBtg9U0Ur9H0hyu0mEw/UNyB82PF6Gcbmg==
X-Received: by 2002:a7b:cd99:: with SMTP id y25mr421128wmj.76.1572274783524;
 Mon, 28 Oct 2019 07:59:43 -0700 (PDT)
Received: from localhost.localdomain (230.106.138.88.rev.sfr.net.
 [88.138.106.230])
 by smtp.gmail.com with ESMTPSA id 143sm14842876wmb.33.2019.10.28.07.59.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2019 07:59:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 05/12] configure: Detect compiler support for
 __attribute__((alias))
Date: Mon, 28 Oct 2019 15:59:30 +0100
Message-Id: <20191028145937.10914-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191028145937.10914-1-richard.henderson@linaro.org>
References: <20191028145937.10914-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32d
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Such support is present almost everywhere, except for Xcode 9.
It is added in Xcode 10, but travis uses xcode9 by default,
so we should support it for a while yet.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 configure | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/configure b/configure
index 145fcabbb3..3a9862fe5e 100755
--- a/configure
+++ b/configure
@@ -5518,6 +5518,21 @@ if compile_prog "" "" ; then
   vector16=yes
 fi
 
+########################################
+# See if __attribute__((alias)) is supported.
+# This false for Xcode 9, but has been remedied for Xcode 10.
+# Unfortunately, travis uses Xcode 9 by default.
+
+attralias=no
+cat > $TMPC << EOF
+int x = 1;
+extern const int y __attribute__((alias("x")));
+int main(void) { return 0; }
+EOF
+if compile_prog "" "" ; then
+    attralias=yes
+fi
+
 ########################################
 # check if getauxval is available.
 
@@ -7083,6 +7098,10 @@ if test "$vector16" = "yes" ; then
   echo "CONFIG_VECTOR16=y" >> $config_host_mak
 fi
 
+if test "$attralias" = "yes" ; then
+  echo "CONFIG_ATTRIBUTE_ALIAS=y" >> $config_host_mak
+fi
+
 if test "$getauxval" = "yes" ; then
   echo "CONFIG_GETAUXVAL=y" >> $config_host_mak
 fi
-- 
2.17.1


