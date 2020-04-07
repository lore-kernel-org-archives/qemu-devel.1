Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44AC4C2BB55
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 15:54:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DDC620678
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 15:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oICfkXuy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DDC620678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLqYQ-0000Dk-8O
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 11:54:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43624)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jLqVY-0003NK-Mu
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 11:51:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jLqVX-0004HD-Q9
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 11:51:24 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:56292)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jLqVX-0004G3-KI
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 11:51:23 -0400
Received: by mail-wm1-x32f.google.com with SMTP id e26so2231890wmk.5
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2020 08:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PbesXQUG3Qr2w0fWSAAmJ+0PO5T8KwoqRlchy88FHNA=;
 b=oICfkXuyhHmVwAl/4mRoLJSLXNu7mcNg6OYmbVeiUFowmscviTbv4Jng1F5GyClnCG
 ms1SJSe9UBA9xZMjeB++Tr09GKcAG4QIyBQ8UJ8xAx/Wfz1pzunESgQ0LkE+p6w/9T8x
 e8nF2eM0WTFnpHSlT9AhKUimda8H6RDkF+P2P3DHHx19D5bMTuyJSYCflRFIef8FQK0U
 1OTAx/YMXLHU6AGNpJEaDuuxd5OO0MwFg0upr8ZkZrDo9p0WHhELLe3yvM/f+gPEP9HF
 K34jXbe2209aKKo1vcGrHS1pjy0P/Rm9+XVMF9isBJm2nrQ52SqWnzh/J/TdlHVsa5QJ
 Ev7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PbesXQUG3Qr2w0fWSAAmJ+0PO5T8KwoqRlchy88FHNA=;
 b=ZhT9JoTgEjIZr/L59qkPUbs1jDHn53mS/mx0jz7BOda27hzwePRRpKkCRNiXMA3Xi3
 p+hYusJQUU8qfPOk76M5TPu1BonQQj319G2w3mlgqPGu9hP6LV2o/BTAg12twV1yI3Ss
 T4BZ2OQ4cSPB/SfYm0sDUmR+gAksxz5g8YKEPv0oSykbg+nU3s0FMqdCRowmo8dFIZMa
 hb0CiStHMF6oRcB2fT6cvvoucdrC7aRXl4P8vi/7Cw6NnintpwWfWw3DysBLT4D9IMzq
 7+kgXUzdL3BHvU1r5dnBQfMO2/dnaK/km+BexqBaKiLEtl45uiagAb+BcZSLMnIm69ik
 EAHQ==
X-Gm-Message-State: AGi0PuYU847egmJPwXwHh3p7kH4rZp95Xw3uYxNSyi71rmD9UPJIRS1I
 IBzqQhpIkvPP31hNjBgTzReNpg==
X-Google-Smtp-Source: APiQypI6enBHBjwxKsjTmidUIkeHHES++K9FcDFLYF4KpUS94vV4Iiu4+FBpNBoHGxZQGHAlvD0LLg==
X-Received: by 2002:a05:600c:2251:: with SMTP id
 a17mr2993003wmm.106.1586274682624; 
 Tue, 07 Apr 2020 08:51:22 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p3sm11048654wrq.97.2020.04.07.08.51.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2020 08:51:19 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A00BA1FF90;
 Tue,  7 Apr 2020 16:51:18 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 04/13] tests/tcg: remove extraneous pasting macros
Date: Tue,  7 Apr 2020 16:51:09 +0100
Message-Id: <20200407155118.20139-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200407155118.20139-1-alex.bennee@linaro.org>
References: <20200407155118.20139-1-alex.bennee@linaro.org>
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are not using them and they just get in the way.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200403191150.863-4-alex.bennee@linaro.org>

diff --git a/tests/tcg/x86_64/system/boot.S b/tests/tcg/x86_64/system/boot.S
index 205cfbd3982..73b19a2bda6 100644
--- a/tests/tcg/x86_64/system/boot.S
+++ b/tests/tcg/x86_64/system/boot.S
@@ -41,10 +41,7 @@
 #define XEN_ELFNOTE_PHYS32_ENTRY  18
 
 #define __ASM_FORM(x)	x
-#define __ASM_FORM_RAW(x)     x
-#define __ASM_FORM_COMMA(x) x,
-#define __ASM_SEL(a,b)           __ASM_FORM(b)
-#define __ASM_SEL_RAW(a,b)      __ASM_FORM_RAW(b)
+#define __ASM_SEL(a,b)  __ASM_FORM(b)
 #define _ASM_PTR	__ASM_SEL(.long, .quad)
 
 	ELFNOTE(Xen, XEN_ELFNOTE_VIRT_BASE,      _ASM_PTR 0x100000)
-- 
2.20.1


