Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62952C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 12:49:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7C8521D43
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 12:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6bvnpX7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7C8521D43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVwVU-00017L-Ig
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 08:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chetan4windows@gmail.com>)
 id 1kVwNv-0008IS-C3; Fri, 23 Oct 2020 08:41:31 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:34452)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chetan4windows@gmail.com>)
 id 1kVwNs-0004Gy-SI; Fri, 23 Oct 2020 08:41:31 -0400
Received: by mail-pl1-x643.google.com with SMTP id r3so748854plo.1;
 Fri, 23 Oct 2020 05:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ISkbHDipLl0l+/oCb08ZXB2hiTArhbd28mQOJtuVOYY=;
 b=j6bvnpX7wkM5TXS2t+qFm7MhRs3UCjbjeDHzA1wWOu0tyZMvRsVMvpggZRIcNjwoWd
 KJIJtp50sR3SFjEQhV7YWk6MXGtoCQizkJ/Gscr1yYI81ryPVoUD/rr5B31h6WcStw3j
 mrwaUss0+XD33VxlTkTNMzdmVZbtSDpxnA6TiuA62LOGDbQu9UAmHqvWWhY4Qyqja19s
 siNCKO9M+ODIBSSBy7T7hkkSoYGDgWiP6nj/TFMuW3a0LPazDpn3ko9rkOInLPQ4HSJ4
 iCHB3LSRLMGJK3RLqaSRwZS6tAWCLuaOSiz1MUeRJVh6qcWofpJEUUtd9vwbpE/XuyJX
 mLFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ISkbHDipLl0l+/oCb08ZXB2hiTArhbd28mQOJtuVOYY=;
 b=fYhyoOzijiCTlYr5rKhHZgyek9dzrnF3x+yBMTxLnJqknyxetlZGwtrKK7YcoG5juI
 tpsZmibNQULbpUy5WoMygeSmXfFNFJwifZuBkxfpqHHrXcyoOMBD7KR8Lkv6pe5MUDWq
 C0KbNZ4gX4DzZuyVanZK84J4Ty2AZ84ty2lG1zhyrr0NTCFgWpghm2GVP/844zJPr1Kr
 m1mMv/CSPZ7xNHNI55PslPtjVZ3uM4/cIUduXMyZ76ZZxRw6xHhdB7bi73SKxqK43Zvn
 of2CMUjAXxmZ1AkHRGRryhdTznnwELEMV5qo3Q+kBF06v96O6LVoCnJ+awmbHjiBKZnX
 12rw==
X-Gm-Message-State: AOAM531Uh0oF087hb9cuJMOhLnhcz0fnK5p944gC1cQU/PAejO3+kSKx
 fShgSji6B2mmuxU2za2sFv5Xu8DHJLSl9KTq
X-Google-Smtp-Source: ABdhPJxVEWguxZZFhAYfJLa5J54rUM3tiyYrfQpqO4dSnBnLv9zK2MR8oR0s7iMPrk3VN0fsV+qTXQ==
X-Received: by 2002:a17:902:ec02:b029:d1:fc2b:fe95 with SMTP id
 l2-20020a170902ec02b02900d1fc2bfe95mr2210010pld.79.1603456886576; 
 Fri, 23 Oct 2020 05:41:26 -0700 (PDT)
Received: from pulp100.localdomain ([103.199.158.131])
 by smtp.gmail.com with ESMTPSA id q24sm2406102pfn.72.2020.10.23.05.41.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2020 05:41:25 -0700 (PDT)
From: Chetan Pant <chetan4windows@gmail.com>
To: qemu-trivial@nongnu.org
Subject: [PATCH 27/30] x86 hvf cpus: Fix Lesser GPL version number
Date: Fri, 23 Oct 2020 12:40:12 +0000
Message-Id: <20201023124012.20035-1-chetan4windows@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201014134248.14146-1-chetan4windows@gmail.com>
References: <20201014134248.14146-1-chetan4windows@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=chetan4windows@gmail.com; helo=mail-pl1-x643.google.com
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
Cc: qemu-devel@nongnu.org, dirty@apple.com,
 Chetan Pant <chetan4windows@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is no "version 2" of the "Lesser" General Public License.
It is either "GPL version 2.0" or "Lesser GPL version 2.1".
This patch replaces all occurrences of "Lesser GPL version 2" with
"Lesser GPL version 2.1" in comment section.

Signed-off-by: Chetan Pant <chetan4windows@gmail.com>
---
 target/i386/hvf/panic.h      | 2 +-
 target/i386/hvf/vmx.h        | 2 +-
 target/i386/hvf/x86.c        | 2 +-
 target/i386/hvf/x86.h        | 2 +-
 target/i386/hvf/x86_cpuid.c  | 2 +-
 target/i386/hvf/x86_decode.c | 2 +-
 target/i386/hvf/x86_decode.h | 2 +-
 target/i386/hvf/x86_descr.c  | 2 +-
 target/i386/hvf/x86_descr.h  | 2 +-
 target/i386/hvf/x86_emu.c    | 4 ++--
 target/i386/hvf/x86_emu.h    | 2 +-
 target/i386/hvf/x86_flags.c  | 2 +-
 target/i386/hvf/x86_flags.h  | 2 +-
 target/i386/hvf/x86_mmu.c    | 2 +-
 target/i386/hvf/x86_mmu.h    | 2 +-
 target/i386/hvf/x86hvf.c     | 2 +-
 target/i386/hvf/x86hvf.h     | 2 +-
 17 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/target/i386/hvf/panic.h b/target/i386/hvf/panic.h
index 411ef43..a3eabeb 100644
--- a/target/i386/hvf/panic.h
+++ b/target/i386/hvf/panic.h
@@ -5,7 +5,7 @@
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/hvf/vmx.h b/target/i386/hvf/vmx.h
index 587b1b8..24c4cdf 100644
--- a/target/i386/hvf/vmx.h
+++ b/target/i386/hvf/vmx.h
@@ -8,7 +8,7 @@
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/hvf/x86.c b/target/i386/hvf/x86.c
index fdb11c8..cd04518 100644
--- a/target/i386/hvf/x86.c
+++ b/target/i386/hvf/x86.c
@@ -5,7 +5,7 @@
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/hvf/x86.h b/target/i386/hvf/x86.h
index bacade7..9e2c003 100644
--- a/target/i386/hvf/x86.h
+++ b/target/i386/hvf/x86.h
@@ -5,7 +5,7 @@
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/hvf/x86_cpuid.c b/target/i386/hvf/x86_cpuid.c
index 16762b6..ac731c2 100644
--- a/target/i386/hvf/x86_cpuid.c
+++ b/target/i386/hvf/x86_cpuid.c
@@ -7,7 +7,7 @@
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/hvf/x86_decode.c b/target/i386/hvf/x86_decode.c
index 34c5e30..062713b 100644
--- a/target/i386/hvf/x86_decode.c
+++ b/target/i386/hvf/x86_decode.c
@@ -5,7 +5,7 @@
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/hvf/x86_decode.h b/target/i386/hvf/x86_decode.h
index ef79601..a2d7a2a 100644
--- a/target/i386/hvf/x86_decode.h
+++ b/target/i386/hvf/x86_decode.h
@@ -4,7 +4,7 @@
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/hvf/x86_descr.c b/target/i386/hvf/x86_descr.c
index 8c05c34..9f539e7 100644
--- a/target/i386/hvf/x86_descr.c
+++ b/target/i386/hvf/x86_descr.c
@@ -5,7 +5,7 @@
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/hvf/x86_descr.h b/target/i386/hvf/x86_descr.h
index 049ef9a..c356932 100644
--- a/target/i386/hvf/x86_descr.h
+++ b/target/i386/hvf/x86_descr.h
@@ -5,7 +5,7 @@
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
index d3e289e..da570e3 100644
--- a/target/i386/hvf/x86_emu.c
+++ b/target/i386/hvf/x86_emu.c
@@ -5,7 +5,7 @@
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
@@ -23,7 +23,7 @@
 //  This library is free software; you can redistribute it and/or
 //  modify it under the terms of the GNU Lesser General Public
 //  License as published by the Free Software Foundation; either
-//  version 2 of the License, or (at your option) any later version.
+//  version 2.1 of the License, or (at your option) any later version.
 //
 //  This library is distributed in the hope that it will be useful,
 //  but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/hvf/x86_emu.h b/target/i386/hvf/x86_emu.h
index f92a9c5..233f7b8 100644
--- a/target/i386/hvf/x86_emu.h
+++ b/target/i386/hvf/x86_emu.h
@@ -5,7 +5,7 @@
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/hvf/x86_flags.c b/target/i386/hvf/x86_flags.c
index 5ca4f41..fecbca7 100644
--- a/target/i386/hvf/x86_flags.c
+++ b/target/i386/hvf/x86_flags.c
@@ -6,7 +6,7 @@
 //  This library is free software; you can redistribute it and/or
 //  modify it under the terms of the GNU Lesser General Public
 //  License as published by the Free Software Foundation; either
-//  version 2 of the License, or (at your option) any later version.
+//  version 2.1 of the License, or (at your option) any later version.
 //
 //  This library is distributed in the hope that it will be useful,
 //  but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/hvf/x86_flags.h b/target/i386/hvf/x86_flags.h
index 785e80c..75c2a7f 100644
--- a/target/i386/hvf/x86_flags.h
+++ b/target/i386/hvf/x86_flags.h
@@ -6,7 +6,7 @@
 //  This library is free software; you can redistribute it and/or
 //  modify it under the terms of the GNU Lesser General Public
 //  License as published by the Free Software Foundation; either
-//  version 2 of the License, or (at your option) any later version.
+//  version 2.1 of the License, or (at your option) any later version.
 //
 //  This library is distributed in the hope that it will be useful,
 //  but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/hvf/x86_mmu.c b/target/i386/hvf/x86_mmu.c
index 65d4603..882a623 100644
--- a/target/i386/hvf/x86_mmu.c
+++ b/target/i386/hvf/x86_mmu.c
@@ -5,7 +5,7 @@
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/hvf/x86_mmu.h b/target/i386/hvf/x86_mmu.h
index cd6e137..9ae8a54 100644
--- a/target/i386/hvf/x86_mmu.h
+++ b/target/i386/hvf/x86_mmu.h
@@ -5,7 +5,7 @@
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/hvf/x86hvf.c b/target/i386/hvf/x86hvf.c
index 5cbcb32..f267698 100644
--- a/target/i386/hvf/x86hvf.c
+++ b/target/i386/hvf/x86hvf.c
@@ -6,7 +6,7 @@
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/hvf/x86hvf.h b/target/i386/hvf/x86hvf.h
index 79539f7..860bd2e 100644
--- a/target/i386/hvf/x86hvf.h
+++ b/target/i386/hvf/x86hvf.h
@@ -5,7 +5,7 @@
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
-- 
2.17.1


