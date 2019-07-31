Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A0EC32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:20:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13DD3206A3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mGqpAqrb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13DD3206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsrKw-0007QT-9w
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 12:20:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42404)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hsrG7-0005wF-Lx
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:15:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hsrG6-0004A5-2p
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:15:23 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38178)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hsrG5-00047z-QL
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:15:21 -0400
Received: by mail-wr1-x442.google.com with SMTP id g17so70334827wrr.5
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 09:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Snunrr/avWrIhXGLbDExuqiqLPGhcfnkTu5o+XPO9YI=;
 b=mGqpAqrb6thsotXl+ANgkByVidUUeGUcohf/pZCyVb1wV2wR+IBNiGzBgyKA3NATm2
 jeYtXQUeplIyRZ07zwvc1B/EcN61hPdFRj9f5Qq8tDudDcbOhmSZSTDRxovlj4Zxw8ic
 u9nv6N02rQj627dcANzy0vOvkiKp8J6txTLn52YlKZXqe+83dSt9jq2qpzg1CxN4oSXb
 0hkk9ZY8ZFcCx78LvjaT24bD/8utggVRYcERHOeziLt8tyyOSeRPmC5aQO6T1lHKKnzq
 eC8lfwuxSGtPL/pfaEwlyTGGGptKwPb0mQzYVJ+yrSH4AtgYSBv/wqj6bTY0VH9WAXqH
 lY8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Snunrr/avWrIhXGLbDExuqiqLPGhcfnkTu5o+XPO9YI=;
 b=RKdWF4vO064N4Z58gRgbHebCMfwQ9PRv9UGWn1a075ghHJi0gAF9KECa+6XHMIgO51
 Lbx6thxLtBAhjHPSWLpS4sNdLY21eNC8nuBygsGOEes1O9DGv2cXuz3bbbcoAdDDcHME
 al6tV5zxZ7hfHyojDN3sTuK5RegkvXDx/ViTD4ctmRSQc6joX3siFLuveaIW3lVmuCvG
 7Q1NhDvy9bToWyJrulydQBdcwnv1ueuaSI0CzqCbqJKeTCZrcI/iC90+9DD2N+lw91Bw
 VdLufz5fgC3ADP/hNOQhHiD1w/BOGwDlTsnL8ULenyuTn+3rNkJeLbU+4lOpw0VKso/v
 ljpQ==
X-Gm-Message-State: APjAAAUPQIsPqn9cxTD64xUlZwPa8D36DtGcYZPssfXlCDDIRmowuXVJ
 TGeHXYitMlbTBtZ4nP68+ZamIQ==
X-Google-Smtp-Source: APXvYqwLOjp0cptjpeQn31nEqTgFcH9lYtDKPV+Sdy9JVjNh8krSLdLRoaLgtFi0h4iY/Hpqzx9yYQ==
X-Received: by 2002:a5d:5644:: with SMTP id j4mr54415173wrw.144.1564589718242; 
 Wed, 31 Jul 2019 09:15:18 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id x185sm63457489wmg.46.2019.07.31.09.15.14
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 09:15:15 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6C43F1FFCB;
 Wed, 31 Jul 2019 17:07:24 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 17:07:19 +0100
Message-Id: <20190731160719.11396-55-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190731160719.11396-1-alex.bennee@linaro.org>
References: <20190731160719.11396-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH  v4 54/54] include/exec/cpu-defs.h: fix typo
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 aaron@os.amperecomputing.com, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>, bobby.prani@gmail.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-defs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index 31deca369ea..355fa817a93 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -233,7 +233,7 @@ typedef struct CPUTLB { } CPUTLB;
 #endif  /* !CONFIG_USER_ONLY && CONFIG_TCG */
 
 /*
- * This structure must be placed in ArchCPU immedately
+ * This structure must be placed in ArchCPU immediately
  * before CPUArchState, as a field named "neg".
  */
 typedef struct CPUNegativeOffsetState {
-- 
2.20.1


