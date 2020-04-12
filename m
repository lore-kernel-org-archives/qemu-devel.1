Return-Path: <SRS0=Byls=54=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F4EEC2BB85
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 23:34:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4351720692
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 23:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Us/qZhLy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4351720692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNm6x-0000MK-FS
	for qemu-devel@archiver.kernel.org; Sun, 12 Apr 2020 19:33:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55650)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <changbin.du@gmail.com>) id 1jNm6D-0007Z1-23
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 19:33:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <changbin.du@gmail.com>) id 1jNm6B-0003HJ-Vu
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 19:33:12 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:36585)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <changbin.du@gmail.com>)
 id 1jNm6B-0003H3-Ql
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 19:33:11 -0400
Received: by mail-pj1-x1043.google.com with SMTP id nu11so3136871pjb.1
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2020 16:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=qiiJ/9LQbNwzVn/oldsWyAe6v31V6qg3EJGBL6aKL1k=;
 b=Us/qZhLyrxZDqRSMzrmBtnHrCCRtjpL64Z3ElJr3WUJqlI2EWagcziMk3rpLBwukrF
 ScKPpJFECHPyzmbCjm+DThTE7U+/hImouhEPlPNc/3ubAlD/v2jZS/U9WpmA0bT3QN9U
 hwzBsTwR+4FkG+eiB8qOCeXTtDo1GMKzyNH10h1OGWzYxmjwZYqH8QpkkXuddJ4WryP6
 hM6CfWAlKU28zEPLUHsTago2WsdP5qYq4I8MwoOqdGOfqmdeMf6o7gHFOr11mb8MwU8c
 CfcFwgx6uAna3qMDso9bC2UUr7yO99dQ6F6nF2Wu5akGls35MlgQ2E/LIDWyyU53AHGb
 wtGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=qiiJ/9LQbNwzVn/oldsWyAe6v31V6qg3EJGBL6aKL1k=;
 b=Sr7Sx+FMtcDOKhMBBbkZFkawsxjGqGiqrJm6AfQAtotIseJUlTfpriZZAZ4IHI5RIv
 Pppun8dCmRbTyTZXDlKVjcpL8ocTMS31MJ2qLMaNjtOGeauKR2R5BeRHZ9WrHF3h81iq
 yg7FBcqd3eKG+jds1MNVqne2KVkQuxv/pitHNkvmxht7ZJ4d1nq9f55JXhZFjy7gkCxX
 v2E1vPrR/jKMTw85n58/2pAC/3nsegUj25CQjMIc4VwZo1qDq0oGcrQDODxxr0qcU+Hf
 9K3yUyYNhobzrcu+66Lyyryql2wQb7CkUUCKZlKnOSlcIOh1vxJLP/gmxxt4E/zAAu3T
 Gm+w==
X-Gm-Message-State: AGi0PuZkcmaikPrt+KobDYlVpJfpfPzUeTAIZkNIwoc918PrD7JUQyZh
 BbKFmS/WBufxcOMD7fRj4So=
X-Google-Smtp-Source: APiQypLcYBfnl2QvDJgT6Dn1FJwst8Be7kpdSbfTrI9X6hWy3FhuVRWZsn/paC4CSOFQFHbGJ6qsnQ==
X-Received: by 2002:a17:90a:d14d:: with SMTP id
 t13mr425842pjw.175.1586734390860; 
 Sun, 12 Apr 2020 16:33:10 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
 by smtp.gmail.com with ESMTPSA id c74sm2122065pfb.67.2020.04.12.16.33.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2020 16:33:10 -0700 (PDT)
From: Changbin Du <changbin.du@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v2] gdbstub: Fix segment fault for i386 target
Date: Mon, 13 Apr 2020 07:32:46 +0800
Message-Id: <20200412233246.4212-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
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
Cc: qemu-devel@nongnu.org, Changbin Du <changbin.du@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With GByteArray, we should pass the object itself but not to plus an offset.

gdb log:
Thread 1 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
__memmove_avx_unaligned_erms () at ../sysdeps/x86_64/multiarch/memmove-vec-unaligned-erms.S:384
384	../sysdeps/x86_64/multiarch/memmove-vec-unaligned-erms.S: No such file or directory.

Fixes: a010bdbe71 ("gdbstub: extend GByteArray to read register helpers")
Signed-off-by: Changbin Du <changbin.du@gmail.com>

---
v2: remove m68k fix since it's already queued.
---
 target/i386/gdbstub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
index f3d23b614e..b98a99500a 100644
--- a/target/i386/gdbstub.c
+++ b/target/i386/gdbstub.c
@@ -106,7 +106,7 @@ int x86_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
     } else if (n >= IDX_FP_REGS && n < IDX_FP_REGS + 8) {
         floatx80 *fp = (floatx80 *) &env->fpregs[n - IDX_FP_REGS];
         int len = gdb_get_reg64(mem_buf, cpu_to_le64(fp->low));
-        len += gdb_get_reg16(mem_buf + len, cpu_to_le16(fp->high));
+        len += gdb_get_reg16(mem_buf, cpu_to_le16(fp->high));
         return len;
     } else if (n >= IDX_XMM_REGS && n < IDX_XMM_REGS + CPU_NB_REGS) {
         n -= IDX_XMM_REGS;
-- 
2.25.1


