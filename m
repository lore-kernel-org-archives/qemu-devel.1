Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BBBC43457
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 21:04:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F133F207BB
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 21:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yx0iaM/S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F133F207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTtN6-0000i7-TE
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 17:04:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37964)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eafanasova@gmail.com>)
 id 1kTtM3-0007rh-Ic
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 17:03:07 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:42480)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eafanasova@gmail.com>)
 id 1kTtM1-0007us-AZ
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 17:03:07 -0400
Received: by mail-lf1-x143.google.com with SMTP id a7so7991992lfk.9
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2020 14:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=N6hEF7OQXNqkChSy9Ne4Ue5yKVOERWYUsm/i+t2FDZU=;
 b=Yx0iaM/SCAnxUuT9qEr7RlSK2cjGYZ1fhRWD/XrlDAAiJ+3I/wditfQhBCjSLgfiX6
 3FaEKA/ruxf9DZ1UB8zL1yogD5HYFxW/mHVA3rovss8dbP/nZcIIaStIMmHnuFapQ/nX
 mHpsgcjTgdf+fLq9mKpJEQSiAvAZYUkTAMJ91CggUFbouOUZMWm0dagm5nxtbVcZcqYK
 uWP9+vvgRGSiLEhEmExp1h47tlfTvcdqZOGIpxBaVe4uIqkQzncYJrNwTPm8jzjs9iww
 xdfshIfDmyHOErM0zlyMXoDDOPwWhPKkpftVq1Bq2hy3I0wz5Dwfd0TrlG9MHJ5MccsL
 WwHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=N6hEF7OQXNqkChSy9Ne4Ue5yKVOERWYUsm/i+t2FDZU=;
 b=oZs/TDLzlvhhLs9QxSN7FH6YWArIX5/DU9F3wG7VquKuYHB5fgib7kzTVezzmroGob
 PlNkp0bQfS46NTrjLkvNZELTFCXoSP1c0UaL1wojOCevFNxRSfHSCS0EiAt8r0VeVU2n
 m/r/tVEpTZMtck7mwqYSQUb+Wc+6WY03eavOt2Tig5l+bO8kX3k//0HvHzuKtsdR7wKO
 DmXUIoVsGyvr91ax4r0KPy7LF0z/HnGrH3amXVU4j5outfXTWsfVp3FKf3Viy+MmJe4h
 ICWGK8kdOVu9AYdpwn0Yyx+YzHRa23xljFGGJXDEmoAapQJrvtEMJy98CMPMyBQnwUMM
 PD0Q==
X-Gm-Message-State: AOAM533iqFAmQkCH8kMNo0KCAUghGJBueq7vA/avg+g+ltmySlDBEtGZ
 lAFXOUrN+I095NxiJwvxQIJKIxThjuVjJozn
X-Google-Smtp-Source: ABdhPJzfCN8U1Yh6HdIovy6tPfymlA0Y9J874VMWzvJ7dpir0+470VdWnakks9CFBgtyOwToU+IGtw==
X-Received: by 2002:a19:c8c2:: with SMTP id y185mr3654357lff.231.1602968580331; 
 Sat, 17 Oct 2020 14:03:00 -0700 (PDT)
Received: from localhost.localdomain (37-145-186-126.broadband.corbina.ru.
 [37.145.186.126])
 by smtp.gmail.com with ESMTPSA id a17sm2414840ljp.129.2020.10.17.14.02.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2020 14:02:59 -0700 (PDT)
From: Elena Afanasova <eafanasova@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] softmmu/memory: fix memory_region_ioeventfd_equal()
Date: Sat, 17 Oct 2020 14:01:02 -0700
Message-Id: <20201017210102.26036-2-eafanasova@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201017210102.26036-1-eafanasova@gmail.com>
References: <20201017210102.26036-1-eafanasova@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::143;
 envelope-from=eafanasova@gmail.com; helo=mail-lf1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Elena Afanasova <eafanasova@gmail.com>, pbonzini@redhat.com,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eventfd can be registered with a zero length when fast_mmio is true.
Handle this case properly when dispatching through QEMU.

Signed-off-by: Elena Afanasova <eafanasova@gmail.com>
---
 softmmu/memory.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/softmmu/memory.c b/softmmu/memory.c
index 403ff3abc9..3ca2154a64 100644
--- a/softmmu/memory.c
+++ b/softmmu/memory.c
@@ -203,10 +203,17 @@ static bool memory_region_ioeventfd_before(MemoryRegionIoeventfd *a,
 }
 
 static bool memory_region_ioeventfd_equal(MemoryRegionIoeventfd *a,
-                                          MemoryRegionIoeventfd *b)
-{
-    return !memory_region_ioeventfd_before(a, b)
-        && !memory_region_ioeventfd_before(b, a);
+                                          MemoryRegionIoeventfd *mrb)
+{
+    if (int128_eq(a->addr.start, mrb->addr.start) &&
+            (!int128_nz(mrb->addr.size) ||
+             int128_eq(a->addr.size, mrb->addr.size)) &&
+            (a->match_data == mrb->match_data) &&
+            ((mrb->match_data && (a->data == mrb->data)) || !mrb->match_data) &&
+            (a->e == mrb->e))
+        return true;
+
+    return false;
 }
 
 /* Range of memory in the global map.  Addresses are absolute. */
-- 
2.25.1


