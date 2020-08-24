Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72069C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 08:09:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B2722074D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 08:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1xJd8C3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B2722074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kA7Xl-00071j-C9
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 04:09:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1kA7WG-0005dD-26
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 04:07:56 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:43598)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1kA7WE-0000ZQ-AT
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 04:07:55 -0400
Received: by mail-pg1-x541.google.com with SMTP id d19so4180929pgl.10
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 01:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=T0AMPeoov8/+jsVMPNHuOXt7CN3A6v044R1IXSJ7/jQ=;
 b=C1xJd8C3hoqGxQBJqFOOhw4PHb3PCpvBmxztHoN8YmkSeSFaoAUfSAyxMpWQMffzOW
 ONnW3C09QDDusd320DdHrmLDLJWj2BLbFX7guJCxLzK/hx278r79bT57aJ044Ih3q4C8
 uqtRBFN1UyVNYSj14yLQN2l2FCWBvRJch3D9iIcZ5QR0hJbmV6pmjwKCzCAlYfhifepS
 xzX+lsi8aRuiLIx0Wyk1G8miMK1v+xc27woTPNCeGJQ+ytuYDTj5u3RyvIJOtx4K+R5l
 JS/K8yn6iofQK5fcGtxqlTjH9KmjLkGrvybgIq6Ly9zRNjHKHohPX+igLfGOKTJbjxL4
 AhoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=T0AMPeoov8/+jsVMPNHuOXt7CN3A6v044R1IXSJ7/jQ=;
 b=W/embesCUPQDZcjy6iI0mdeXQUC1S7v/39Xv79NLWrBLiktAR4ruAWavLIXTXRokT9
 RKAi/botMeV2VX69YzvPqPdJtMpSRggcIZk+BF5Jbu+92PEQsXK3r21kuReAGgMluduk
 Yv6u1F5ZeKxyHPkhbpJOsaI5L+r4KUuNzP8ZSeX7I2dM729YUaFm5DV6vpb7gejsI8ng
 OUndVtSAHdSeniPPlRNxbgnDj0kbzQhlZ9zRxIgOsf2tdAuHjMsSyLT4lcv6inh/GHRi
 X5HTNWCBLKlKRauAMRvZR7ADvCDfVBZDK8P437X9oq70szBQ6cGRr8706VOmgY9eaeS2
 3tvQ==
X-Gm-Message-State: AOAM530xUe50c1FbFtpO+iJ4pNMylZrJtIwrmVHx8m7kDL7H3lZSMsrJ
 opGLhl+xVNkVaZsAf9UAjc4=
X-Google-Smtp-Source: ABdhPJxGOILzHZ9R3+A1Iku1hrj8uG5VNx79Our8RYVYtoObU7qnyhmKpOi1Y0XdQupCu6ej10hoWQ==
X-Received: by 2002:a63:d34e:: with SMTP id u14mr2652649pgi.122.1598256472867; 
 Mon, 24 Aug 2020 01:07:52 -0700 (PDT)
Received: from software.domain.org ([45.77.13.216])
 by smtp.gmail.com with ESMTPSA id z26sm8769242pgc.44.2020.08.24.01.07.45
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 24 Aug 2020 01:07:52 -0700 (PDT)
From: Huacai Chen <zltjiangshi@gmail.com>
X-Google-Original-From: Huacai Chen <chenhc@lemote.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: [PATCH V2 for-5.2] hw/null-machine: Add the kvm_type() hook for MIPS
Date: Mon, 24 Aug 2020 16:11:08 +0800
Message-Id: <1598256668-12131-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=zltjiangshi@gmail.com; helo=mail-pg1-x541.google.com
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
Cc: Huacai Chen <chenhuacai@gmail.com>, Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, qemu-devel@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MIPS has two types of KVM: TE & VZ, and TE is the default type. Now,
libvirt uses a null-machine to detect the kvm capability. In the MIPS
case, it will return "KVM not supported" on a VZ platform by default.
So, add the kvm_type() hook to the null-machine.

This seems not a very good solution, but I cannot do it better now.

Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 hw/core/meson.build    | 2 +-
 hw/core/null-machine.c | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/core/meson.build b/hw/core/meson.build
index fc91f98..b6591b9 100644
--- a/hw/core/meson.build
+++ b/hw/core/meson.build
@@ -35,7 +35,6 @@ softmmu_ss.add(files(
   'machine-hmp-cmds.c',
   'machine.c',
   'nmi.c',
-  'null-machine.c',
   'qdev-fw.c',
   'qdev-properties-system.c',
   'sysbus.c',
@@ -45,5 +44,6 @@ softmmu_ss.add(files(
 
 specific_ss.add(when: 'CONFIG_SOFTMMU', if_true: files(
   'machine-qmp-cmds.c',
+  'null-machine.c',
   'numa.c',
 ))
diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
index 7e69352..4b4ab76 100644
--- a/hw/core/null-machine.c
+++ b/hw/core/null-machine.c
@@ -17,6 +17,9 @@
 #include "sysemu/sysemu.h"
 #include "exec/address-spaces.h"
 #include "hw/core/cpu.h"
+#ifdef TARGET_MIPS
+#include "kvm_mips.h"
+#endif
 
 static void machine_none_init(MachineState *mch)
 {
@@ -55,6 +58,9 @@ static void machine_none_machine_init(MachineClass *mc)
     mc->no_floppy = 1;
     mc->no_cdrom = 1;
     mc->no_sdcard = 1;
+#ifdef TARGET_MIPS
+    mc->kvm_type = mips_kvm_type;
+#endif
 }
 
 DEFINE_MACHINE("none", machine_none_machine_init)
-- 
2.7.0


