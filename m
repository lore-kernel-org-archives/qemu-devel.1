Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2599EC4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 15:25:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBC2C2072D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 15:25:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBC2C2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFJWf-0006zG-2O
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 11:25:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57818)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jFJVa-0005Id-Nx
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:24:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jFJVZ-0007Uy-GM
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:24:26 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:33409)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jFJVZ-0007UG-8H
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:24:25 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M9Fvl-1jAfD80ZZH-006LV7; Fri, 20 Mar 2020 16:24:22 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v4 04/32] linux-user: Update TASK_UNMAPPED_BASE for aarch64
Date: Fri, 20 Mar 2020 16:23:40 +0100
Message-Id: <20200320152408.182899-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200320152408.182899-1-laurent@vivier.eu>
References: <20200320152408.182899-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:K0+EDF4+N6CLAt5XB/+SPTU0b5zH6ARXRKD+CHNHjm8JoJ7jFmr
 hp7W4/1SayBYCAlznLiPNo9ECERuaNNjUfFz9AyKfiLb//rLadddr37SUmNlUwXksvcN1zM
 Gv0ZhILaTBX0HjSnyuvXemRgGbDgVfNvu7ZEDQPeH+KD3bGxErdUqieH4I/xL4xVOemjLEp
 LSLyddCqlJg8IxmQzTcvQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mMxHi3Vi/qw=:4/KMThh4XemcSXpbtDi/j/
 Isdy/JP6RCkKltDnFoJte0pc/330Y3aH7IFsfcHFVxi6bkcs3VbYI5sZTl5zuWsKVmc0La+fG
 956GQ1Nyf2hQ68TJQj6mU1y4WxavUgYVJjO5v8UsYdkYDH6IZiDkXfS92Sv/M97OBmGlA6K25
 xxqYhHrFQJeH3al4karo8c05N2eZ2twa5yGMDDmn7sP/2YpCZt/k7SJ+QE5vL8l8ZaFpJPaEg
 vDzts3+Xh3r3tNxCzne8PTHv7BKkjZ/c5OqU2YRdNsmMAgD7jYZMDVoExLgyN6R6zPsapZx4g
 rfwmRfjxdoOxpP1UhR2nyUlQYlNGU/OqnlxF55QiIGIcAX7yhAy0cyUTNjgnW+fpxY0K0u1OV
 /jqv7JTGH2UZghpn4xi+cekZj4aG6VJgNgbWDIwuGxZzbIfyCl8FxEGe/rxXWTR+/05Tpe8a0
 tggGnHioWkErHotQZvKt20W3VZP95GFCD2F6z2yfTcJWXNSjkzySq62KubVreGFUSJ4FF9Rjq
 ewqWT4pnd9WCxmh2uJhOzbPBzz2s2Jfhp+2igUOPsmEaS3DdLJs3AVLH+qEQ6gqcB2vRlXqO6
 +C82LV6NcKcMsaprcl43ux2Iu5QA4+QIUwFOPNCr7oya3XTKcBWqYaTNgmwoxEditKezFyrHq
 bC1A0Ia9nzrTmIOsYMewyVauVNcCSLUn1/fECWkI/tDiC9AUybHzp4h/hTfRLgZznguD3QfWt
 Lq3Ev2k1WixTqYBeFGZi+Ud4LCQ7zhxhMCNy1mV238vNQvZA8Cr7A5P2mdpSqCwJ/KQbRTjap
 ylBZWmAq0ZAI+Rs25D+t3ixtd9I6ypIVXhuP7EiLLiFC50bXrf9nuDsxQ1eMapIWJrvh3Tk
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Lirong Yuan <yuanzi@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Lirong Yuan <yuanzi@google.com>

This change updates TASK_UNMAPPED_BASE (the base address for guest programs) for aarch64. It is needed to allow qemu to work with Thread Sanitizer (TSan), which has specific boundary definitions for memory mappings on different platforms:
https://github.com/llvm/llvm-project/blob/master/compiler-rt/lib/tsan/rtl/tsan_platform.h

Signed-off-by: Lirong Yuan <yuanzi@google.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200313002813.3857-1-yuanzi@google.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/mmap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 8685f02e7e90..e37803379747 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -184,7 +184,11 @@ static int mmap_frag(abi_ulong real_start,
 }
 
 #if HOST_LONG_BITS == 64 && TARGET_ABI_BITS == 64
+#ifdef TARGET_AARCH64
+# define TASK_UNMAPPED_BASE  0x5500000000
+#else
 # define TASK_UNMAPPED_BASE  (1ul << 38)
+#endif
 #else
 # define TASK_UNMAPPED_BASE  0x40000000
 #endif
-- 
2.25.1


