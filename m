Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89A6C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 04:13:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1561222C4
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 04:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U4d5yTE1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1561222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifFqe-0008Li-Bb
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 23:13:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49299)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ifFez-0000vl-Gf
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 23:01:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ifFex-0004EI-FM
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 23:01:05 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:38060)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ifFex-0004Aw-3E
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 23:01:03 -0500
Received: by mail-pl1-x642.google.com with SMTP id a17so4534pls.5
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 20:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=cdzUkCGd4j9cyI7GBjpMOiOf+nGUeT9o9Hdz62SsCpo=;
 b=U4d5yTE18ArAv/25Nxrz4jz1YA0MzeWCk/NTL7hd1tfPPcJinFivSlHDbc4u25L+8C
 saVhdaTIOyLpGZtkMCAs6vMvYxXubjPJVBQOdQJcP/+2N7BEYRCSv5YOBBli+H/BsnCl
 nn6Oc+Cze/C5FBflxbX1MWc2RbnUuDoyUcGw8f+LRlZk/kgyC+y7F32e8comyVOwxi3d
 n7UG6qPcHkZ6hfiQSn52eQEZBN53pDK+JXZxH0HikxfBNfwAYVDkW0fC/898499+T1xU
 /vBxa4hzelM0UmF9KgHQMsRY6BQDxfNUL631r8c/QR29gaw6P91w/pDENPnTpOdJT8yB
 djMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cdzUkCGd4j9cyI7GBjpMOiOf+nGUeT9o9Hdz62SsCpo=;
 b=Os+Kn6nk2ZWO8p1K0AaGUK6QOV4vlfUAaFcgutwa4MNROiZujTQT+uAWpsPJFp9Y8z
 9OZazuPxEM+kom9LsKEkXyNc6o1bqmEBJt4AjXLfnZxiovjuU4RyoipcXfDbTyJZwa4L
 yMuWMRM+cpPJo2cJyF3ViR9fGwyMEXTsPHDl7KJBfX6IsyaWWvb+M20a0gRmX3qv6Uvj
 HGzT8SpYson91Ie5QuqnYWtRibY6PWlD6mh2gcCTFwL+utD+5TtxbXYKSlE2CRwxf2Qv
 7v2TQhNVqzOHm3j0TQ70a5m2O3Bb7sos1eoRxdHnZSodb+dY9mdd0hHKQzZS1Bu4j0lh
 NEHQ==
X-Gm-Message-State: APjAAAUrGmOUuVgF3jdi4pacd4OObzrktge3ndQ7+F/ouSsUcEiuHWx6
 hIZK712lpOPPuei+t7AiB1kh5MKeACI=
X-Google-Smtp-Source: APXvYqwvnQMx/5beYozyVtjRQ4yGSbLGqA5XPtQ7MV6mg63knysAmIbkLEQMIYkxF3bfrZn8cSrrLA==
X-Received: by 2002:a17:902:12c:: with SMTP id
 41mr7147011plb.160.1576123260944; 
 Wed, 11 Dec 2019 20:01:00 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id z130sm4666391pgz.6.2019.12.11.20.00.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2019 20:01:00 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 16/28] target/alpha: Remove MMU_MODE{0,1}_SUFFIX
Date: Wed, 11 Dec 2019 20:00:27 -0800
Message-Id: <20191212040039.26546-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191212040039.26546-1-richard.henderson@linaro.org>
References: <20191212040039.26546-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The functions generated by these macros are unused.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/cpu.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index a530249a5b..3f782c0efe 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -193,8 +193,6 @@ enum {
    PALcode cheats and usees the KSEG mapping for its code+data rather than
    physical addresses.  */
 
-#define MMU_MODE0_SUFFIX _kernel
-#define MMU_MODE1_SUFFIX _user
 #define MMU_KERNEL_IDX   0
 #define MMU_USER_IDX     1
 #define MMU_PHYS_IDX     2
-- 
2.20.1


