Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67199C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 22:32:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31A52206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 22:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dglJnJmf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31A52206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igyua-0004as-A6
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 17:32:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37008)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1igybS-0005SH-Oo
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1igybR-0007VJ-MI
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:34 -0500
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:37907)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1igybR-0007Ub-HN
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:33 -0500
Received: by mail-pj1-x1041.google.com with SMTP id l4so3622780pjt.5
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 14:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pZRCwuJZhFmLfLLVDEuLYlambcalO9LoW5IlxLfh4Nc=;
 b=dglJnJmfBxX3xB4BMXIsaIDRLpLVx+xKl1JYPDYU+yI9XHOFJKSU8dy4bZ9LJz4NQF
 GW881Gl75Obj6HGyFpGC2v+rjDdEGPza4pk3REfZAqM9zl4jn2L9yDUtvVUNlXlSGi7L
 qoGS5FvSZcIKiyWqpJBYcEfPOrE7WImTdWg8/+AWOD8BLk4HhuKmfu17m4+T6KhitpUN
 f/Dx5siaxIKeyu6XshKXgI76ZMbGj04g6is/H0dAffaVjN8QhoeHsITpXBwuQYTDvbZa
 eT6anJXYUOuxKLFUiyP5qLynfiRYUaEm7Fr7QTBi0aYcWK2jOnrWUZp1I2vEpD/nU0e/
 ELVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pZRCwuJZhFmLfLLVDEuLYlambcalO9LoW5IlxLfh4Nc=;
 b=cLGWHrhqYuxXUw0ixoLb5L90gQQnrbKh+3y8rJTo4Tbr05crvmfaLIW47iePvXLiKg
 aAQBWLaIrfX7k80tbdT6zFn177dcB3A/Ruw0ExQovFzBx7aK1oUmSa3WKiWWG2YRuSwq
 Ci3eHx4KAxVdn7+n/0Cv5GkOjNCc6YdUzZAJfQr+eqIy5XlAhCI9ho6DDbq1tp+57UTM
 cADeu9B3Yb7NdJ0HbebQHHovDiDDCNekp6bcxBjSRwKKsXSpkfgEZAdR3E2YAZmkjRxL
 to0o/hxsgOJgkBTpklekPimKV4mW3n7/WJu6VAFcvPik7PXpPreyX7KTjYqo5aHFgpl5
 LImw==
X-Gm-Message-State: APjAAAUBebOyGYrMW2gCkBnG7gvKHNrW0NYvCYYlGbuNbumK7EjukOz+
 YF2lWeaAM/WjaTK2wRnnNDNUaZpoIaw=
X-Google-Smtp-Source: APXvYqyZsrVQdNHxJ3iPbZvRJT/E8HQp3zLVwyPtCTQPRD6YNdvIn14H9aSl141+rqujdQ91hpSzMA==
X-Received: by 2002:a17:902:a616:: with SMTP id
 u22mr5998617plq.173.1576534352309; 
 Mon, 16 Dec 2019 14:12:32 -0800 (PST)
Received: from localhost.localdomain
 ([2605:e000:c74f:dc00:6838:d2b2:17e2:8445])
 by smtp.gmail.com with ESMTPSA id d6sm529767pjl.8.2019.12.16.14.12.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 14:12:31 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 20/28] target/sh4: Remove MMU_MODE{0,1}_SUFFIX
Date: Mon, 16 Dec 2019 12:11:50 -1000
Message-Id: <20191216221158.29572-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216221158.29572-1-richard.henderson@linaro.org>
References: <20191216221158.29572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1041
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
Cc: Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The functions generated by these macros are unused.

Cc: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sh4/cpu.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index ecaa7a18a9..452a596e67 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -254,8 +254,6 @@ void cpu_load_tlb(CPUSH4State * env);
 #define cpu_list sh4_cpu_list
 
 /* MMU modes definitions */
-#define MMU_MODE0_SUFFIX _kernel
-#define MMU_MODE1_SUFFIX _user
 #define MMU_USER_IDX 1
 static inline int cpu_mmu_index (CPUSH4State *env, bool ifetch)
 {
-- 
2.20.1


