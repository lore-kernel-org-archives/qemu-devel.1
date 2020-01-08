Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0CBC282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:48:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5795920720
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOoNFmgy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5795920720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipAlb-0000L5-Lr
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 07:48:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60477)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipAWW-0003yV-Pc
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipAWV-0004Q0-Jd
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:20 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:56013)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ipAWV-0004PQ-DN
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:19 -0500
Received: by mail-wm1-x332.google.com with SMTP id q9so2276610wmj.5
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 04:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=pjqdkb919vSGbnhGqmpTVjV2nd+xhVlSchT013lEZf4=;
 b=SOoNFmgyyOk6cSR2Im99JnLuqnckG49ouCoz9MhUFkUvzVH0p4cz3oUzV8uaCqmkxE
 bWB1Qz+e5kdqCMSi9jylSDKbKzoJU/M6cQEOyKZqoYZjwV1EWzSA4ebrF4pLkRSHzx22
 IuQvX+xCcWj+AL4gl619PeBErChUNZkYTNJNbOXQBGLIeix7g5NO/RMD7yYPu/dw9izL
 HirjQ8sx0WQ99Oc9RIFXfrkwKWuk/3Xe3aCikoHk8pZe+PiFetlTd0Z9biWqvEM12/83
 a/Yu3T0EYF56ez9+zGPolyHkHwal36JXg2jOn9FCfAv9ci8SX7S8c18tjHfi6QbbSKP9
 bEyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=pjqdkb919vSGbnhGqmpTVjV2nd+xhVlSchT013lEZf4=;
 b=HB3cHMW7+0EH6GL0eifBG44b5wYX0Gtwmzpi94fXBW16+6IlVe/bZ8AU+zL24BktId
 WdJxsLEuE1/aOHiEbtNqTn3oWVsk6VPgVoGInquumkgePMuPFoWr52QyhF2f+o5p+53U
 BhtJ0Ac1DOZtiEVc/v0bTONcqlzhhsJ84Ez68kyhJvlJYm2GlZB32ya8rof8I7clEI28
 LTjeRUTYTjnEfw3B4VQQE/svE2E6ywIJ9lG3LdK1FJMNVuyVV9Fq1zdji80jMtB0wpaf
 Mz54gt4Qs2TSqjxM4UDARjcY8vN/VWUdZMXAN8VyoOzl9Yltz5VZtJnZfU8TVdAqv2xK
 ZlTA==
X-Gm-Message-State: APjAAAX6pabeFthva2yjZ5uyTAtSMvoN1xWyGeL9kZ7hniVjKY1+x+XB
 UUSo/nH0lFlnIYDtIdLZyBwwr6r4
X-Google-Smtp-Source: APXvYqyHoiVzUTX26+8pWc32tXhi2ydMlQP0ECfcIKNbpoCRf9HuepfeWz8SMrVdBbNq0M5blgcN5Q==
X-Received: by 2002:a1c:720a:: with SMTP id n10mr3523811wmc.74.1578486798283; 
 Wed, 08 Jan 2020 04:33:18 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id o4sm4037750wrw.97.2020.01.08.04.33.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 08 Jan 2020 04:33:17 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 21/38] target/i386: Fix handling of k_gs_base register in
 32-bit mode in gdbstub
Date: Wed,  8 Jan 2020 13:32:38 +0100
Message-Id: <1578486775-52247-22-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1578486775-52247-1-git-send-email-pbonzini@redhat.com>
References: <1578486775-52247-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::332
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
Cc: "mkdolata@us.ibm.com" <mkdolata@us.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "mkdolata@us.ibm.com" <mkdolata@us.ibm.com>

gdb-xml/i386-32bit.xml includes the k_gs_base register too, so we have to
handle it even if TARGET_X86_64 is not defined.  This is already done in
x86_cpu_gdb_read_register, but not in x86_cpu_gdb_write_register where the
incorrect return value causes all registers after it to be clobbered.

Fixes https://bugs.launchpad.net/qemu/+bug/1857640.

Signed-off-by: Marek Dolata <mkdolata@us.ibm.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/gdbstub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
index aef25b7..572ead6 100644
--- a/target/i386/gdbstub.c
+++ b/target/i386/gdbstub.c
@@ -350,15 +350,15 @@ int x86_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
             env->segs[R_GS].base = ldl_p(mem_buf);
             return 4;
 
-#ifdef TARGET_X86_64
         case IDX_SEG_REGS + 8:
+#ifdef TARGET_X86_64
             if (env->hflags & HF_CS64_MASK) {
                 env->kernelgsbase = ldq_p(mem_buf);
                 return 8;
             }
             env->kernelgsbase = ldl_p(mem_buf);
-            return 4;
 #endif
+            return 4;
 
         case IDX_FP_REGS + 8:
             cpu_set_fpuc(env, ldl_p(mem_buf));
-- 
1.8.3.1



