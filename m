Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CEAC43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 09:52:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B614206F2
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 09:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o2TnlfC5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B614206F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHlex-0007lk-Jw
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 05:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37855)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jHlce-0003PU-Jt
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 05:49:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jHlcd-0003kR-Fn
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 05:49:52 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34925)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jHlcd-0003ie-9G
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 05:49:51 -0400
Received: by mail-wr1-x444.google.com with SMTP id d5so10655208wrn.2
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 02:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NX+/xJBO2eLA0qrDo402hCKb9wStxwlhkWpgyP99xxg=;
 b=o2TnlfC51qHCoQyELEpYc7/FBX58X9f6fMjHKCdf1Qp0StfokFuDeYcbmoivnyGK5S
 HhMRiYX9bCjuQpslezT6alSfc0TpabmGCU5HLV0EZxVhxNXpqWJp/f+AVbMeFwNHS7pS
 TsytYCP5AzXF9UhWotZ8Kf77ZIEWc56RvCxFv43+R/BZCs/3C98jkXCRIDYFqfKS1+l9
 MmGUmE17uxii5i9wYPWYuUZjgpiJwVKyl5I6mKLgrcgLkp8RqAe2dod6Mwww51k3BHCF
 vgBzqMBIkuY3ptMQdZgkdwjq2HqOlBkUo6A7IJ8ke9KhSRF0bGCHpzjOaLhDOyQj9uhm
 f/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NX+/xJBO2eLA0qrDo402hCKb9wStxwlhkWpgyP99xxg=;
 b=nRIkLL7n7tqOLz5GBFW9qiFwpQhe5Pwj3qpvw/Wu2oWxrWxxTJZkPoklDkuGwJXWdH
 z31IENGbid41XKRTDrtENSXrcHhQLMdyhg8ZRsiQ2R5Mvd7KBSmjtUDrvnRE4Ro0q9bT
 RgJ6he0m+rrEFIF2NVwhq6UjfoeTWygrGHVU31shHJzxM1bfddSRmDWJA1O9oo6Cfgvg
 SF05B8k4mVqSTo1ESZ4x+oP5Z5QwDZQBXAXkGKA8/BTxj7C7SW/HaMXwx5S8IM69wLZL
 R0XcmT3vkntIRHTKc4DjQpu6rJ7rEh0iuIf0AXCsetL7CZsAyK9btj5n0lBvGdHyyYqz
 RH8w==
X-Gm-Message-State: ANhLgQ0WpEqDirtGOLSOtmS0kfNjrlglyW4wMy5jUTzv/4D6PaWP+Pk2
 QC4unpEXyxg0CGhhj55ujMVFNw==
X-Google-Smtp-Source: ADFU+vuhCMgXx5XCYufU7J4hEzJSzKZFn4CG2ngoa3jgtr3dnoi7ks+WDG/dxwqYNz7wliogIqg5zQ==
X-Received: by 2002:adf:fc45:: with SMTP id e5mr7709694wrs.56.1585302590234;
 Fri, 27 Mar 2020 02:49:50 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p10sm2851547wre.15.2020.03.27.02.49.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2020 02:49:46 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A57B41FF8F;
 Fri, 27 Mar 2020 09:49:45 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 3/7] tests/tcg: remove extraneous pasting macros
Date: Fri, 27 Mar 2020 09:49:41 +0000
Message-Id: <20200327094945.23768-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200327094945.23768-1-alex.bennee@linaro.org>
References: <20200327094945.23768-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are not using them and they just get in the way.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/x86_64/system/boot.S | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

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


