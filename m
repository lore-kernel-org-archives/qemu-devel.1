Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF30C43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:34:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FB02206D4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWXFWA8h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FB02206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDwsG-0002UQ-QX
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:34:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58638)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLM-00040K-Cu; Thu, 03 Sep 2020 17:00:30 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:37566)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLI-0007eh-Qc; Thu, 03 Sep 2020 17:00:27 -0400
Received: by mail-oi1-x244.google.com with SMTP id e6so4528173oii.4;
 Thu, 03 Sep 2020 14:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=6r9u0nklxBNegI6NxrGJn+A8hZD/QGA53VvgRXsDcyg=;
 b=KWXFWA8hj94/SWqn/xbLuHS1H9UAOa+m7lre17CIgN8saTbSwxAw3Yas7iMEWF26s/
 0CZxC5QDw4DZvc1MmeH/o8p6eDm28iJR5Zooz2/G2VBzZy+uCgWtMbKHv1WhLs1ZJs/4
 uhQIzyrlBStx+jMvZirgwgfxeGQW8wfsrL1J8+z9yvoRyAsnjkYKmeeDOKqzGu7k8EHI
 KGGwgConXzb9hbaaZJEMX+gjEJlgE9Vz4VrF+1A5BA7w5iuAEYts1vLCyqYKLN19vajX
 edkQre34dloPQcQBqy4fVnmAZgWY2bg9ZHqPwVv/6cnolONvlqs6tIHPa5OQ5YXwvoJL
 jFfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=6r9u0nklxBNegI6NxrGJn+A8hZD/QGA53VvgRXsDcyg=;
 b=majznx8yco2ZDnDkL0TiIoHef9OCp0Zt19ESRMY5HNXY0FmA8h28Sk2BsrkUlb5L2Z
 9OokvRyOKZAC5wUNMzmjB2d3lwg6Mz94KMMJSrxYUY+xe/qH9HKeIKzfW5obI5XWTZXC
 R38IPicZO6NMaKOZZaNp6Weaer+Ydc9YdSnxFVmJ+d6kJ2XozVqQj8YtoSsnOI9GqpY4
 poRfH4mpRDtQN/e27gcxJclcNsXx0xkt/93ShLjLUGcLQkUDZdD0BzIb+HpQDYGzsd4R
 WLHwxVgSmbYvQhDqHwxu4foT1m66EJ1u3dQsaX+rdEdfuxELa1htNzaYAZqQ8IEFRNEq
 cVkg==
X-Gm-Message-State: AOAM533+nEXmu+8bFewjqEQ8HabNKaxp/JYs6sdIS9YSENVpCuDb2qgC
 ptytdM+QYkJbxbIgqqQGSiZ3v/kaLyY=
X-Google-Smtp-Source: ABdhPJykNqvtwFfgk7fq7JGgjho3xrw+T0BCycsxkMlAa5tFID4os47Q4XalaeEpGLqWbi1AQluqSQ==
X-Received: by 2002:a54:4704:: with SMTP id k4mr2708157oik.78.1599166822706;
 Thu, 03 Sep 2020 14:00:22 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id p9sm759437oti.22.2020.09.03.14.00.21
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 14:00:22 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 33/77] hw/display/artist: Unbreak size mismatch memory accesses
Date: Thu,  3 Sep 2020 15:58:51 -0500
Message-Id: <20200903205935.27832-34-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=flukshun@gmail.com; helo=mail-oi1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Helge Deller <deller@gmx.de>, Sven Schnelle <svens@stackframe.org>,
 qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Helge Deller <deller@gmx.de>

Commit 5d971f9e6725 ("memory: Revert "memory: accept mismatching sizes
in memory_region_access_valid") broke the artist driver in a way that
the dtwm window manager on HP-UX rendered wrong.

Fixes: 5d971f9e6725 ("memory: Revert "memory: accept mismatching sizes in memory_region_access_valid")
Signed-off-by: Sven Schnelle <svens@stackframe.org>
Signed-off-by: Helge Deller <deller@gmx.de>
(cherry picked from commit e0cf02ce680f11893aca9642e76d6ae68b9375af)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/display/artist.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/hw/display/artist.c b/hw/display/artist.c
index 753dbb9a77..d7bce918b8 100644
--- a/hw/display/artist.c
+++ b/hw/display/artist.c
@@ -1199,20 +1199,16 @@ static const MemoryRegionOps artist_reg_ops = {
     .read = artist_reg_read,
     .write = artist_reg_write,
     .endianness = DEVICE_NATIVE_ENDIAN,
-    .valid = {
-        .min_access_size = 1,
-        .max_access_size = 4,
-    },
+    .impl.min_access_size = 1,
+    .impl.max_access_size = 4,
 };
 
 static const MemoryRegionOps artist_vram_ops = {
     .read = artist_vram_read,
     .write = artist_vram_write,
     .endianness = DEVICE_NATIVE_ENDIAN,
-    .valid = {
-        .min_access_size = 1,
-        .max_access_size = 4,
-    },
+    .impl.min_access_size = 1,
+    .impl.max_access_size = 4,
 };
 
 static void artist_draw_cursor(ARTISTState *s)
-- 
2.17.1


