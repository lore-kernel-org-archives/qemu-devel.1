Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A44FC47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 16:15:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 600A1206CD
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 16:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wswCKfzZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 600A1206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIxZd-0000OB-GP
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 12:15:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33868)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iIxGw-0002bX-8n
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:56:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iIxGv-0007lZ-7N
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:56:06 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:37867)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iIxGv-0007lB-3c
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:56:05 -0400
Received: by mail-yb1-xb44.google.com with SMTP id z125so3257532ybc.4
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 08:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ReDLvA+WR/T82Ne1Z6mUqgY0iX8aRnhgEWdNBPA2eNw=;
 b=wswCKfzZ6ZGMe3YYDoaISuVaqu0ShmUFqHtawTQxD6dxDG6iPuTssqczv+YrA9s6Mp
 u6fq4eIgOF1k20SRumbKrjDvmQQJPtU3CXf48TBNADU5zY4gSLZZvk94IJsACbmgKgXO
 alE0vPdweclCXnEGNWkuE5gqhp+R3Sa48tl0lWotAhebsNMjgw2hp8uLifNQNmj06Q1q
 Ixf75bivWH6cFM3ioQyysonDMftMFv/fKzqmZ6LI3kjGWdk9Gi9NcdVUkCx7Qi7c4AAt
 SwVn7GCirvYX2UyGVPQSDkiuwuV6+7cqkcb864jpkTSWj5L4H4FPlEX3l/MDuYVdamox
 QLmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ReDLvA+WR/T82Ne1Z6mUqgY0iX8aRnhgEWdNBPA2eNw=;
 b=gi0pQnV7JjuQrk+7zLVIXHnvHzGVYiVi5+y2rB7+QHY80ggJKq/ckHXkHWUFEUhAco
 dvda9bJuJAB5uy367IGCEyc9jDVmwlzRwnyIZZUkrumupY6n4y9ARp9BACBbgGMKn4/X
 Xvm252rroUTXGRAqDjyp21PmPH9GJ7vUW++Bf8LCQTTj6PW5KRViXXIu8SJr3K3vaLCJ
 WRu5tD7bFDkcX7VasbCvJFieQPqbAil74I7PgZp2I2r1TD0KoLFfbD5dfi+xjE28Xe3c
 s6hHTuiplX8BpWcwHz0/52Nw2l2hFNMSe1Fo88txbumUTfT5Gm2GwfJhDkavd8hN1QcR
 XKYg==
X-Gm-Message-State: APjAAAVo4zZzuAOf4fP7H9+3viDaX3q8GhLWdgBI4l6+Ir6EthQhhQcD
 rqCLjzek+mVtLRHj+ve/eHcV1B5SPdQ=
X-Google-Smtp-Source: APXvYqwZOkNFX1UP2/pMPPHNfIpIor/Zp5Y8bZZEI5L5PNJDnmm7gRTzymY48VTc5Fvn4QLOGd2cDg==
X-Received: by 2002:a5b:30d:: with SMTP id j13mr10598348ybp.308.1570809364235; 
 Fri, 11 Oct 2019 08:56:04 -0700 (PDT)
Received: from cloudburst.gateway.pace.com (67.216.151.25.pool.hargray.net.
 [67.216.151.25])
 by smtp.gmail.com with ESMTPSA id d17sm2473139ywb.95.2019.10.11.08.56.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2019 08:56:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 14/20] target/arm: Hoist store to cs_base in
 cpu_get_tb_cpu_state
Date: Fri, 11 Oct 2019 11:55:40 -0400
Message-Id: <20191011155546.14342-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011155546.14342-1-richard.henderson@linaro.org>
References: <20191011155546.14342-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b44
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
Cc: laurent.desnogues@gmail.com, peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

By performing this store early, we avoid having to save and restore
the register holding the address around any function calls.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 3f7d3f257d..37424e3d4d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11225,6 +11225,7 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
 {
     uint32_t flags, pstate_for_ss;
 
+    *cs_base = 0;
     flags = rebuild_hflags_internal(env);
 
     if (is_a64(env)) {
@@ -11298,7 +11299,6 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
     }
 
     *pflags = flags;
-    *cs_base = 0;
 }
 
 #ifdef TARGET_AARCH64
-- 
2.17.1


