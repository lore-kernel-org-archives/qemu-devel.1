Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5A1C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 06:07:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8FAA2086A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 06:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQxM4/0c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8FAA2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39955 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQQbP-0000xt-Vy
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 02:07:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kernellwp@gmail.com>) id 1hQQaX-0000eY-UR
	for qemu-devel@nongnu.org; Tue, 14 May 2019 02:06:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kernellwp@gmail.com>) id 1hQQaU-0004mb-2w
	for qemu-devel@nongnu.org; Tue, 14 May 2019 02:06:55 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:45015)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kernellwp@gmail.com>) id 1hQQaS-0004fk-0a
	for qemu-devel@nongnu.org; Tue, 14 May 2019 02:06:52 -0400
Received: by mail-pf1-x443.google.com with SMTP id g9so8505231pfo.11
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 23:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=UrRUImMU/16S9UAMUsLS/q7MrwOXI/8T+fLWmLkbtpk=;
	b=cQxM4/0chR+C985qN3q14TJSSikOLPQqUpuR37SNGjCMNW7I4SwIC9ugrS2PjIeKDA
	xu9VgedpqyFLsmmcPlCX/9Gyd/lHPncrrOg6xsNJoDMBE9nnc1RXzmCRAHDE8djyCkMm
	NG/pKYbP6SF8aOqUOOAA7BiSOeUqvFWTbZaN6apKw83TBsBnh1CuTYePPJd4o1fSLC8o
	SIvs0WAoRjQBC/sKwi8PFTBoNOMZLAMCyP1v/UDu6kcFeeC1bQPWtrfH2XxGEsq7fWD0
	eMiBYqosKLCuuKCPJPxFWnQIPUcHxLEHRgG4li3+8AcHJXkJwD+x0fX3XzNGMAKHzXd5
	fsEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=UrRUImMU/16S9UAMUsLS/q7MrwOXI/8T+fLWmLkbtpk=;
	b=fFPTiSqe0q1efMIFDJVI3NxajFweWGhJpWbgQnNRoE/P42v8CujmEHMMwRt6Uh3IfM
	tr9ouP/igXOjqBZE1YjsPO64uNJ0AIXVnHBCKX9N8IJnY/Y3KcwH1IQt8MSfT9+ogykV
	hK4v82dlcIJBMNOED5ZXXve94d0A44i7cJEwTtCs8uviHRY9EM7894umoBnXcavnVYnD
	k2dXPrIETWsZ+Th3wyL4kOWZnf1C8KfeyMKBr2RjV5/gZEhLx70zRvze79NSc+idSsC0
	OLI3WuHrkX10FEL+ivtowB2GAk/N+3ct3JK2BN/MpcUmqdcHqnEfxt+8oglS6jMl0bXK
	JPfQ==
X-Gm-Message-State: APjAAAV3ejFa/Y9Vpbb7t8A68r67BPyUQtowIaxLSGvLzrAQXqUWFwDx
	HfblJEnbDWQAzLIJZMJutW7mfauv
X-Google-Smtp-Source: APXvYqyln5zEc+3GWTHA6GymIAAfFqv+OL+uw6EJvSUs0EIPQ0z+P7AJ7eAmy0a5hXlJz0zthX18Sg==
X-Received: by 2002:a62:d044:: with SMTP id p65mr19008527pfg.37.1557814003379; 
	Mon, 13 May 2019 23:06:43 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.123])
	by smtp.googlemail.com with ESMTPSA id
	a80sm41480296pfj.105.2019.05.13.23.06.41
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 13 May 2019 23:06:42 -0700 (PDT)
From: Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To: qemu-devel@nongnu.org,
	kvm@vger.kernel.org
Date: Tue, 14 May 2019 14:06:39 +0800
Message-Id: <1557813999-9175-1-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH] i386: Enable IA32_MISC_ENABLE MWAIT bit when
 exposing mwait/monitor
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wanpeng Li <wanpengli@tencent.com>

The CPUID.01H:ECX[bit 3] ought to mirror the value of the MSR 
IA32_MISC_ENABLE MWAIT bit and as userspace has control of them 
both, it is userspace's job to configure both bits to match on 
the initial setup.

Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 target/i386/cpu.c | 3 +++
 target/i386/cpu.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 722c551..40b6108 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4729,6 +4729,9 @@ static void x86_cpu_reset(CPUState *s)
 
     env->pat = 0x0007040600070406ULL;
     env->msr_ia32_misc_enable = MSR_IA32_MISC_ENABLE_DEFAULT;
+    if (enable_cpu_pm) {
+        env->msr_ia32_misc_enable |= MSR_IA32_MISC_ENABLE_MWAIT;
+    }
 
     memset(env->dr, 0, sizeof(env->dr));
     env->dr[6] = DR6_FIXED_1;
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 0128910..b94c329 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -387,6 +387,7 @@ typedef enum X86Seg {
 #define MSR_IA32_MISC_ENABLE            0x1a0
 /* Indicates good rep/movs microcode on some processors: */
 #define MSR_IA32_MISC_ENABLE_DEFAULT    1
+#define MSR_IA32_MISC_ENABLE_MWAIT      (1ULL << 18)
 
 #define MSR_MTRRphysBase(reg)           (0x200 + 2 * (reg))
 #define MSR_MTRRphysMask(reg)           (0x200 + 2 * (reg) + 1)
-- 
2.7.4


