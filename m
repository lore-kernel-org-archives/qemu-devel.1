Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A04C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:51:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 684772067D
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVhaNaPq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 684772067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipAo1-0004W7-6U
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 07:51:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60498)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipAWX-00040B-T8
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipAWW-0004Qq-P7
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:21 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:54663)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ipAWW-0004QV-J4
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:20 -0500
Received: by mail-wm1-x32f.google.com with SMTP id b19so2289107wmj.4
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 04:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=+1cYJv2/SCgEaS7XXUU1nSsoWuZ/j2VFPEMFOllKrRM=;
 b=bVhaNaPqrDQgdP5kUomEIYo3Q4Y/Z42aG4o/qISYzhO+jonvaeNpueyKLdrE2pW4Fq
 MqxQqonlWXakjJmXE4PGXY6YFcNJpvkC7FLjWuzJIr0wFygKZvGNJKrF+le0Pwh7Uu1t
 71u7QFREQtcSIonVNzdiHo2UDJ7XuvDwmyVp2WyX03fd6XzObG6LLG+K4P84WA38eMRU
 G3z7NM7ZUbSgsfcbUJWkbgE0GO+evvUjOao9nGJeGwrfyXBL1IErlPRpvukpNLci9gEv
 egb9FabPIdq1PaPRAeRSoOlHWuhWJW+N3D6beDqQZgVNywSHnugn9+VdVjy9f3mTgvOi
 vakA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=+1cYJv2/SCgEaS7XXUU1nSsoWuZ/j2VFPEMFOllKrRM=;
 b=CdphlD8RxGmit2fxuDUDz3lYszGuaOviAixGjhVoJ0f63rXlkINQ6mIeVC/wLL+ETM
 cK3VWeFs6oqGgg74xF/9FSbpxYdKsmBZcxJY8ahG+GxTNOu/6po5ezYqXkzr1USSchcQ
 /Tcc0RzKCtvEhFM9DUDo2stLEYmdqFiO3dE2K18mgUGyOeFkC5rSFYF8mtnBX9p3KC0I
 kmuEOc9T2KxS1BECbuFKozFV61Tgks+pkQdjkh5AnmMExbX9KfEK2WN9T1DTYZcl9mJk
 touH6KP3J4vnyGTV4/cd+dGh4sgdVmtnlZfxFeXupp99eCRqx4xXsxjfoJr/GMrJU2p1
 CW/Q==
X-Gm-Message-State: APjAAAXlzUs3N5AcFLBuRLW4JsmzyXXi8LUaHfRsMnVy68HlEo0x07uR
 rhp+JhTxeK7mcQV9oDnaspsmLaE0
X-Google-Smtp-Source: APXvYqydHOayDxZgebsipaKXg4xEAvDXJmDPPQz5N5+9LHkl0nSzmEKrbk68gVczU7x+kNpuouAC0A==
X-Received: by 2002:a7b:c5d8:: with SMTP id n24mr3549692wmk.124.1578486799468; 
 Wed, 08 Jan 2020 04:33:19 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id o4sm4037750wrw.97.2020.01.08.04.33.18
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 08 Jan 2020 04:33:18 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 22/38] target/i386: Add new bit definitions of
 MSR_IA32_ARCH_CAPABILITIES
Date: Wed,  8 Jan 2020 13:32:39 +0100
Message-Id: <1578486775-52247-23-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1578486775-52247-1-git-send-email-pbonzini@redhat.com>
References: <1578486775-52247-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
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
Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Xiaoyao Li <xiaoyao.li@intel.com>

The bit 6, 7 and 8 of MSR_IA32_ARCH_CAPABILITIES are recently disclosed
for some security issues. Add the definitions for them to be used by named
CPU models.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Message-Id: <20191225063018.20038-2-xiaoyao.li@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index af28293..594326a 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -835,12 +835,15 @@ typedef uint64_t FeatureWordArray[FEATURE_WORDS];
 #define CPUID_TOPOLOGY_LEVEL_DIE      (5U << 8)
 
 /* MSR Feature Bits */
-#define MSR_ARCH_CAP_RDCL_NO    (1U << 0)
-#define MSR_ARCH_CAP_IBRS_ALL   (1U << 1)
-#define MSR_ARCH_CAP_RSBA       (1U << 2)
+#define MSR_ARCH_CAP_RDCL_NO            (1U << 0)
+#define MSR_ARCH_CAP_IBRS_ALL           (1U << 1)
+#define MSR_ARCH_CAP_RSBA               (1U << 2)
 #define MSR_ARCH_CAP_SKIP_L1DFL_VMENTRY (1U << 3)
-#define MSR_ARCH_CAP_SSB_NO     (1U << 4)
-#define MSR_ARCH_CAP_MDS_NO     (1U << 5)
+#define MSR_ARCH_CAP_SSB_NO             (1U << 4)
+#define MSR_ARCH_CAP_MDS_NO             (1U << 5)
+#define MSR_ARCH_CAP_PSCHANGE_MC_NO     (1U << 6)
+#define MSR_ARCH_CAP_TSX_CTRL_MSR       (1U << 7)
+#define MSR_ARCH_CAP_TAA_NO             (1U << 8)
 
 #define MSR_CORE_CAP_SPLIT_LOCK_DETECT  (1U << 5)
 
-- 
1.8.3.1



