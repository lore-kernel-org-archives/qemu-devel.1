Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A3DC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 00:29:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B016820637
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 00:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cGWLpxs8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B016820637
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCYCJ-0002cc-P7
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 20:29:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59497)
 by lists.gnu.org with esmtp (Exim 4.90_1) (envelope-from
 <3odNqXgYKCuwmiObnWUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--yuanzi.bounces.google.com>)
 id 1jCYBZ-0001de-9z
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 20:28:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from
 <3odNqXgYKCuwmiObnWUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--yuanzi.bounces.google.com>)
 id 1jCYBY-00081X-65
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 20:28:21 -0400
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a]:50486)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from
 <3odNqXgYKCuwmiObnWUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--yuanzi.bounces.google.com>)
 id 1jCYBX-0007xs-V8
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 20:28:20 -0400
Received: by mail-pg1-x54a.google.com with SMTP id e2so4683455pgb.17
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 17:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=HLlltgn1uX/7LTT+bcZ1C498BDTTGodBolAGUUxrAg4=;
 b=cGWLpxs8gLQx4MQrlcG4VBaB/2frTdxEZG9g3QdFKUkpnRC0E61JGiVNn1wAygmlav
 KsQOe+uzJUdSLm1Sp/P6nHUIOMr4IbKxFJpys0esYaDEr0C3U3T0EKWnwMDze+71H/yQ
 jLFPKsZNfrMRNrakSGQP+xMMABz6BZBcZ/dg2/6nj97Nv9hH3ZP/CU0AQ30tDLPdAeSQ
 m4a+14OwlSXRWJ7qfYReJDwVLfI74SfEgiChuj+vIRMQ7dBY8mLhsBlNaD9M9g5hb2cK
 ot4tzIMFTwZ30kEV7DcbP797JId7idJa2xOuMwzrLJJg1IQ15dIsPr9dy011dW9kCVZk
 +QOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=HLlltgn1uX/7LTT+bcZ1C498BDTTGodBolAGUUxrAg4=;
 b=q6xsv6Qh+7CUbcB4alp1qJjEoIwQrR7XNbQPT1fgfoxU/mld3TK6Z62ihIjWnPm5I6
 LQK6UD8ooZTeGUtm/h4Y9HXPaCnSOYOff/w6cCT8oreCgdUOYNEgB5onNptvgZ4/XjX/
 5ptZiGBv+ZTckF0yOjMyLdngdDMFb5Ed8vmA2tEwVqqy6YF4JfZ7I3xbj+/feCVzHN47
 y02cpVasXTWaHVudAyTRFHUJrnPfJzM0aawTlXiyp2WdnZeOkep/1Q9AFIdy2GyRbe/O
 gVJIuG5fYyCR8GkFKoqIl24WvQKFZCwu0o7HVBoRFedgFBKvkwAHz2lfYUvjtcCBYh1D
 6EhQ==
X-Gm-Message-State: ANhLgQ3CFrlIveqj6sniO8x6sWTWcm/wAWmJRbxwVKVn6QpzPuPCPzwp
 jbuAnOHWFuZT7+zh+U48y+O78rQ+eUMUFu695Q1zWQEYxczFt/sIF3aKUe8Y69c1XikTzl1tvg5
 44zboaJRbwhEUBXk3M4WtVJBJ6QZZywzbbWARlPjJ6WW26/mXTAY0resoY7x1
X-Google-Smtp-Source: ADFU+vuHqjJySVEYskXnQYpFjO00Au+r2Eyt7MsmUXUcRGIeMKDbOjjEoZ/6ASRSWzSbusDz+1sA0R8pnMg=
X-Received: by 2002:a17:90a:9416:: with SMTP id
 r22mr7120100pjo.2.1584059297961; 
 Thu, 12 Mar 2020 17:28:17 -0700 (PDT)
Date: Thu, 12 Mar 2020 17:28:13 -0700
Message-Id: <20200313002813.3857-1-yuanzi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH] linux-user: Update TASK_UNMAPPED_BASE for aarch64
From: Lirong Yuan <yuanzi@google.com>
To: qemu-devel@nongnu.org, laurent@vivier.eu
Cc: qemu-trivial@nongnu.org, riku.voipio@iki.fi, scw@google.com, 
 jkz@google.com, Lirong Yuan <yuanzi@google.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::54a
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

This change updates TASK_UNMAPPED_BASE (the base address for guest programs) for aarch64. It is needed to allow qemu to work with Thread Sanitizer (TSan), which has specific boundary definitions for memory mappings on different platforms:
https://github.com/llvm/llvm-project/blob/master/compiler-rt/lib/tsan/rtl/tsan_platform.h

Signed-off-by: Lirong Yuan <yuanzi@google.com>
---
 linux-user/mmap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 8685f02e7e..e378033797 100644
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
2.25.1.481.gfbce0eb801-goog


