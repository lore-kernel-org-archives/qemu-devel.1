Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE571C432C2
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 22:31:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8B9D21655
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 22:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YY+W0QPa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8B9D21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCtKy-0005xc-F2
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 18:31:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56800)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iCs5E-0003Nx-8a
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:11:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iCs54-0007Zn-T1
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:10:52 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:52894)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iCs53-0007ZG-N7
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:10:42 -0400
Received: by mail-wm1-x32f.google.com with SMTP id r19so366652wmh.2
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 14:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=C7cQzdvC5qDF8fEdQbg9CDZMyqyoQP5tNJhlotuKdBE=;
 b=YY+W0QPa5ZGdwrszqiy43MVMBeG/wHdOt0vPL+ybmRXBvY5NEi2jnQ96fNw2s5bT/7
 t8+KmoSi5XJpXDCEngol6FGfEJ/mYpVspR10ZReldtoPgiW2Aa9OOqiIZxPjUutfcjPK
 TtfxTHsYYmyxgPx8SqITkgNngOhMputWKefivetz9vy6ty6QGZ1DTsITb2AUEer6bjfH
 1/HzbRjp9oJvX2qLWe9TDrHQ2MirsYY3x5KnLscP28cpCBG/gS6OEwnKsG5O9zOW6ow5
 iZsQmROCY9KfzpJANLpQmt0r7uLjH7MvZBJ3VGVnrFOabZ001gDUr4Fobv3cdzs60UV0
 QKsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=C7cQzdvC5qDF8fEdQbg9CDZMyqyoQP5tNJhlotuKdBE=;
 b=RHx2HHIFf7d5i0SZ0OKJSXKr0TioaKkG52Fn+VRrK322yoeM9X38t868PYwLF4eQ5k
 9O4D5X17pvkqd6iZEWSHVzWvmFWsy3lQy1whv5FDgRgtswA803Y2AMaLHpvwtlx4c7Nn
 744X4DpDpxs4U+1vTqsqUEpTYs2xesVaoaSsWbfmJWL1fVY2kbzENfwkkvnUUTiFwydE
 xhD18EYA+8fBcj562h6RRLoWOkqMGW+NRQA+TlIZC3Q43pQOfto3KxY9xXS0wZXIzCB8
 i5sXnCckcebPYA36jK0HWJvUTedJhdceFnA8sH8zJFYj5xKg8s8ml4UqinynNDfuw7Fk
 9b8w==
X-Gm-Message-State: APjAAAVTQeSTxj6cyGpuWsSzGfEUjSnKKha75O4ueBZ86ZvtOkH1pu/E
 K3NsPqfbWs3lpBKQoZQvPueyBg==
X-Google-Smtp-Source: APXvYqy5SbSvezD67bnvCXVINW3ozA6kif2iv1fM4c6v7TUYCaCfw+79t5hviw/2EyLReUxgWLpb2w==
X-Received: by 2002:a1c:9ad1:: with SMTP id c200mr2614127wme.165.1569359439171; 
 Tue, 24 Sep 2019 14:10:39 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z6sm2030696wro.16.2019.09.24.14.10.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2019 14:10:35 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 46BAC1FFAF;
 Tue, 24 Sep 2019 22:01:09 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 26/33] .shippable.yml: Build WHPX enabled binaries
Date: Tue, 24 Sep 2019 22:00:59 +0100
Message-Id: <20190924210106.27117-27-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190924210106.27117-1-alex.bennee@linaro.org>
References: <20190924210106.27117-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Fam Zheng <fam@euphon.net>, jsnow@redhat.com, f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20190920113329.16787-4-philmd@redhat.com>
---
 .shippable.yml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.shippable.yml b/.shippable.yml
index bbc6f88510f..01b33bd034e 100644
--- a/.shippable.yml
+++ b/.shippable.yml
@@ -25,6 +25,8 @@ env:
       TARGET_LIST=mips64el-softmmu,mips64el-linux-user
     - IMAGE=debian-ppc64el-cross
       TARGET_LIST=ppc64-softmmu,ppc64-linux-user,ppc64abi32-linux-user
+    - IMAGE=fedora-win10sdk-cross
+      TARGET_LIST=x86_64-softmmu,i386-softmmu
 build:
   pre_ci:
     # usually host ARCH is set by configure
-- 
2.20.1


