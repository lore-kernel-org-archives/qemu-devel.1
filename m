Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D12C31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 18:14:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 950152177E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 18:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lphYM1/V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 950152177E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54012 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbqi9-0005Xc-JY
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 14:14:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34033)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hbq0H-00076I-6R
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:28:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hbq0F-0003x3-3c
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:28:40 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54878)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hbq0C-0003sD-ER
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:28:37 -0400
Received: by mail-wm1-x342.google.com with SMTP id g135so3141263wme.4
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 10:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2ielurtjzGKb7Ob3E21QU+qcFZWaTKQ9JelyDfiWc2c=;
 b=lphYM1/VPBturLVvPuAe4PioAnB50jvTV8shBn2ISbOesQV6pD+lMpq24om+fHsDoa
 v+duzE5lG7A5F1e10FUPQ3b6v8yHw87v3uViEI6XWth30QeccQQsSNvXJHRaOjdhiZFO
 LFchlXkYp86Ig0gYDlgcTjN4MblOn6kVDNQ80O6rF9SKnQbqMkMXhcQlNBN7MR6XrMNo
 EK16GlylIXKVtyQ3cZkwDlHB9XdeyyadAwUr3eS5dJ0j7B5IryX3K5G+ikksX8N7tfAm
 LQ6brQQ5rxsBeqxyMarG3yG8Tk9vsG/fzPiBFqKNf7a0dcjWGiT/yepaQmX7FvHLVKQo
 I2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2ielurtjzGKb7Ob3E21QU+qcFZWaTKQ9JelyDfiWc2c=;
 b=VIA5Dh1o+D7XhgsVO8P3jFbKImDQmM0m3izta8ez0uEssPl0oM6V/0fGs96k6cTXHT
 yd/tKK2UbCG2Ag2LC+cDs6iNIRlsSM/LEgXN+cHZh1ncZU8i1hTiTfJzUYEYnSw2euak
 S0EcpqfZmyY38A3MoXKPm06X/UWEru7wsaE/8q2kEvVmon4O8ku/04TNiop5qOrOAjI4
 AVsYNGl0z5hZWKNTGqu9C2x+EP2DulqwnMqbrH8TMC/Uzl+NFInZEaOGmsaBS/iWwpDr
 X5iGW/7H7RxT+AQLxq4XUeb10Xs2B+ec8xcGxQ7CQH/sp6stCdyv6K7oHrXKAbNBdTj8
 4lig==
X-Gm-Message-State: APjAAAW/GO6el/ZdPKZQu/J8RhGVDMkIL0cB0tCZBg7fPUbwdKpx4EK+
 y9R6MiyaC6FiGsxE6yQkjBXleg==
X-Google-Smtp-Source: APXvYqxpePc3nsmS7MKNkLz24NNxFVOv6SYmzINEFKa2dDrC01r1/W8nZCgxG6p3I9xoOjY3z93Xpw==
X-Received: by 2002:a1c:9c8a:: with SMTP id f132mr8766940wme.29.1560533314450; 
 Fri, 14 Jun 2019 10:28:34 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id n3sm544040wro.59.2019.06.14.10.28.29
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 14 Jun 2019 10:28:30 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BFEC11FFC9;
 Fri, 14 Jun 2019 18:12:04 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 14 Jun 2019 18:11:58 +0100
Message-Id: <20190614171200.21078-49-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614171200.21078-1-alex.bennee@linaro.org>
References: <20190614171200.21078-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH v3 48/50] include/exec: wrap cpu_ldst.h in
 CONFIG_TCG
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
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This gets around a build problem with --disable-tcg.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/exec/exec-all.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 90045e77c1..fa4d5b9533 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -21,7 +21,9 @@
 #define EXEC_ALL_H
 
 #include "exec/tb-context.h"
+#ifdef CONFIG_TCG
 #include "exec/cpu_ldst.h"
+#endif
 #include "sysemu/cpus.h"
 
 /* allow to see translation results - the slowdown should be negligible, so we leave it */
-- 
2.20.1


