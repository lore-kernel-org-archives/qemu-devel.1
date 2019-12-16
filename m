Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B758C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 22:24:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34FE32072B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 22:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sxhIcXsO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34FE32072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igyms-0003RE-RY
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 17:24:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36877)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1igybL-0005Fc-O5
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1igybK-0007Jn-Gx
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:27 -0500
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:39470)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1igybK-0007Ia-Bk
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:26 -0500
Received: by mail-pj1-x1042.google.com with SMTP id v93so3617202pjb.6
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 14:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ywIseiPjqJvH3CWY8/pVr57z5YPy7BfDXHEc/+9ytCA=;
 b=sxhIcXsO1mDqVZ3f3lLseM6hZd8C8hvDkEk9QJWW8H4/7dW6VhtpqbSiGsg7YyeL0g
 bMIJSmd1I/dW3PorOBgri++JD93GQOxlmCupBZFnBXmSsLOCaQ95z2cH1EAGBy+LQ8IF
 RYx8CD6H0WZ7Ag4vHpuzKwu4zw5hbcbJQKWZFv0N844QA1XOAYg+tbuLWOro3tchXDVm
 b+/o4to59ZtVf3CMTXk/WFfOlNQKyP+zv1TpK/F0NIknpVrKdF/EnRsT1ZzMAYzxwIJU
 YxwYBhpjyF5GRqIbmlgW+5EjyILpk/QWpCEfZ2Kbnk0HsJz9To9leiyTch/9Pd3qIOMb
 CnQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ywIseiPjqJvH3CWY8/pVr57z5YPy7BfDXHEc/+9ytCA=;
 b=BUFNHncqRtd0+ejglq1g7tJPSgOxOGxAIv1bUrjkAnKAFIczOBh1fe/KTwp/IARUdh
 EzEM7wkinyHbV1DW2DH/XOIXD4W2UxMwkYP2AH9pS+nThWascun3DSzQ44Gj6indN6Jp
 TY5Mu6ajtcuZsH20NOkwxwEvtq7SbbqZMDtFjeS1EC6/AOvvmq7pWvFlMaxe9oRsPXwQ
 dVkKc0d4E5h/04Qdn/7V/il4iyUF2X7iw0pd7p7+Z2ejdLRW8dPiBJSpdPPguBsftV+0
 nSew+fMoZ9JcB18a92bWTOr8HyjDrrU5MTW8QNoO1+1Tw3NpZQs+cZAicF/PnRuy6FXT
 8elQ==
X-Gm-Message-State: APjAAAVbWx5ID0ydTj2A0LdZ79y68ZL+D75QuDgRSEHCtF7tFTdk92Kq
 5PnYRDeiSubTHCH/y8wdo9xYxBFvmNo=
X-Google-Smtp-Source: APXvYqz5Yd5Rd6nBEH/KuRs8hV+fmNZb8fIa2GPI/UjygCwnBfQSaokiKSn1mYGbBmi6x13fOJ6Jqw==
X-Received: by 2002:a17:902:9a42:: with SMTP id
 x2mr18533066plv.202.1576534345055; 
 Mon, 16 Dec 2019 14:12:25 -0800 (PST)
Received: from localhost.localdomain
 ([2605:e000:c74f:dc00:6838:d2b2:17e2:8445])
 by smtp.gmail.com with ESMTPSA id d6sm529767pjl.8.2019.12.16.14.12.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 14:12:24 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 15/28] target/nios2: Remove MMU_MODE{0,1}_SUFFIX
Date: Mon, 16 Dec 2019 12:11:45 -1000
Message-Id: <20191216221158.29572-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216221158.29572-1-richard.henderson@linaro.org>
References: <20191216221158.29572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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
Cc: Marek Vasut <marex@denx.de>, Chris Wulff <crwulff@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The functions generated by these macros are unused.

Cc: Chris Wulff <crwulff@gmail.com>
Cc: Marek Vasut <marex@denx.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/nios2/cpu.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
index 361b06ffeb..78f633f970 100644
--- a/target/nios2/cpu.h
+++ b/target/nios2/cpu.h
@@ -217,8 +217,6 @@ void do_nios2_semihosting(CPUNios2State *env);
 #define CPU_SAVE_VERSION 1
 
 /* MMU modes definitions */
-#define MMU_MODE0_SUFFIX _kernel
-#define MMU_MODE1_SUFFIX _user
 #define MMU_SUPERVISOR_IDX  0
 #define MMU_USER_IDX        1
 
-- 
2.20.1


