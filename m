Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF04C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 08:27:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2AE820776
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 08:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QU4AEI7E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2AE820776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPLqD-00039F-J4
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 04:27:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPLmm-0007x7-JU
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 04:23:56 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37368)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPLmi-0007Iy-3o
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 04:23:55 -0400
Received: by mail-wr1-x444.google.com with SMTP id h7so4848813wre.4
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 01:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NZeWul+V/Rl0cRO9OTLRYLbG9eUwDMXR556g7CVpLDw=;
 b=QU4AEI7EpcLSeAluoMVy31ffdAyeYojS3Bc3K/7I0ZsCaf5yw/y3sMiG3Tn6ei1kAR
 EZPGDBaQ86p1MKUaflIL9bYG5G6oX8xCpocezNtRJeZAZ7r3+TxDhksZQWZ+PieHxqs9
 L40TUmxrvf9vusDY/2q+dbZg+1+5mV6qvfoynRCT4FbaBHFNH+23AES6mT5PhxyMFHGn
 CkfV+JwzbGdvv8Zj0m4/gsl/wy0oX37e5syQ5wgYUrB7xwYTWtSwq5FUQpOgRSfXn3IL
 aLHi3swin3p1Iv3FCxVPrmNZyvHp146jUG+L+RLK1vq8W0FnmBm20nh6VnpRwq5IkFQG
 G9Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=NZeWul+V/Rl0cRO9OTLRYLbG9eUwDMXR556g7CVpLDw=;
 b=Lgj6Fy6hAJ3i3B8Kw7VtY/s+qgY3RKlY07PLB4fk5D6vtXgc1xdKAxraFNoKzcSWci
 IFrML7tVG7LJ1GfN70k+ISSqjf5pEFyD+fmRZCmD09DisXGrBXADzXpG10nt1irUF+0w
 8B00ae7LHnM/TiR6BX4kHohUqtFbDkTRpNNBIwfdS01f3mgqvji6vvnVHxYd1yB/z8PA
 pYMNMoo8N+5MROvNdt1K0mAnV8V4v79xgUjL5Bbow+1nFsXw+mQNVFxMLDw+zwiei5m5
 KTrGPIHfS+o/K1Zznh204Clbtfg9VMB7wvUDH/HO7PbwMKN/wdZsUgZTId7h6vqeajTC
 QuiQ==
X-Gm-Message-State: AOAM531otvH+PNPEGft49jRDoFnLzSoOPkcL0xiiPqTUejC9w0/nopsu
 LjdtI+m1l4CKXi0HGGtJSX2XdNBjXoo=
X-Google-Smtp-Source: ABdhPJyVSq0LXgMVugxUN5o8mJ6um5pilqewsspyfr1twvVIv8gLbf0821eLfIa4Ixs5fW2JUnRkMg==
X-Received: by 2002:adf:f3c7:: with SMTP id g7mr10695872wrp.394.1601886230211; 
 Mon, 05 Oct 2020 01:23:50 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:2e86:3d8b:8b70:920c])
 by smtp.gmail.com with ESMTPSA id z15sm11931434wrv.94.2020.10.05.01.23.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 01:23:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/19] default-configs: move files to default-configs/devices/
Date: Mon,  5 Oct 2020 10:23:32 +0200
Message-Id: <20201005082349.354095-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201005082349.354095-1-pbonzini@redhat.com>
References: <20201005082349.354095-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248,
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make room for target files in default-configs/targets/

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure                                                 | 6 +++---
 default-configs/{ => devices}/aarch64-linux-user.mak      | 0
 default-configs/{ => devices}/aarch64-softmmu.mak         | 0
 default-configs/{ => devices}/aarch64_be-linux-user.mak   | 0
 default-configs/{ => devices}/alpha-linux-user.mak        | 0
 default-configs/{ => devices}/alpha-softmmu.mak           | 0
 default-configs/{ => devices}/arm-linux-user.mak          | 0
 default-configs/{ => devices}/arm-softmmu.mak             | 0
 default-configs/{ => devices}/armeb-linux-user.mak        | 0
 default-configs/{ => devices}/avr-softmmu.mak             | 0
 default-configs/{ => devices}/cris-linux-user.mak         | 0
 default-configs/{ => devices}/cris-softmmu.mak            | 0
 default-configs/{ => devices}/hppa-linux-user.mak         | 0
 default-configs/{ => devices}/hppa-softmmu.mak            | 0
 default-configs/{ => devices}/i386-bsd-user.mak           | 0
 default-configs/{ => devices}/i386-linux-user.mak         | 0
 default-configs/{ => devices}/i386-softmmu.mak            | 0
 default-configs/{ => devices}/lm32-softmmu.mak            | 0
 default-configs/{ => devices}/m68k-linux-user.mak         | 0
 default-configs/{ => devices}/m68k-softmmu.mak            | 0
 default-configs/{ => devices}/microblaze-linux-user.mak   | 0
 default-configs/{ => devices}/microblaze-softmmu.mak      | 0
 default-configs/{ => devices}/microblazeel-linux-user.mak | 0
 default-configs/{ => devices}/microblazeel-softmmu.mak    | 0
 default-configs/{ => devices}/mips-linux-user.mak         | 0
 default-configs/{ => devices}/mips-softmmu-common.mak     | 0
 default-configs/{ => devices}/mips-softmmu.mak            | 0
 default-configs/{ => devices}/mips64-linux-user.mak       | 0
 default-configs/{ => devices}/mips64-softmmu.mak          | 0
 default-configs/{ => devices}/mips64el-linux-user.mak     | 0
 default-configs/{ => devices}/mips64el-softmmu.mak        | 0
 default-configs/{ => devices}/mipsel-linux-user.mak       | 0
 default-configs/{ => devices}/mipsel-softmmu.mak          | 0
 default-configs/{ => devices}/mipsn32-linux-user.mak      | 0
 default-configs/{ => devices}/mipsn32el-linux-user.mak    | 0
 default-configs/{ => devices}/moxie-softmmu.mak           | 0
 default-configs/{ => devices}/nios2-linux-user.mak        | 0
 default-configs/{ => devices}/nios2-softmmu.mak           | 0
 default-configs/{ => devices}/or1k-linux-user.mak         | 0
 default-configs/{ => devices}/or1k-softmmu.mak            | 0
 default-configs/{ => devices}/ppc-linux-user.mak          | 0
 default-configs/{ => devices}/ppc-softmmu.mak             | 0
 default-configs/{ => devices}/ppc64-linux-user.mak        | 0
 default-configs/{ => devices}/ppc64-softmmu.mak           | 0
 default-configs/{ => devices}/ppc64abi32-linux-user.mak   | 0
 default-configs/{ => devices}/ppc64le-linux-user.mak      | 0
 default-configs/{ => devices}/riscv32-linux-user.mak      | 0
 default-configs/{ => devices}/riscv32-softmmu.mak         | 0
 default-configs/{ => devices}/riscv64-linux-user.mak      | 0
 default-configs/{ => devices}/riscv64-softmmu.mak         | 0
 default-configs/{ => devices}/rx-softmmu.mak              | 0
 default-configs/{ => devices}/s390x-linux-user.mak        | 0
 default-configs/{ => devices}/s390x-softmmu.mak           | 0
 default-configs/{ => devices}/sh4-linux-user.mak          | 0
 default-configs/{ => devices}/sh4-softmmu.mak             | 0
 default-configs/{ => devices}/sh4eb-linux-user.mak        | 0
 default-configs/{ => devices}/sh4eb-softmmu.mak           | 0
 default-configs/{ => devices}/sparc-bsd-user.mak          | 0
 default-configs/{ => devices}/sparc-linux-user.mak        | 0
 default-configs/{ => devices}/sparc-softmmu.mak           | 0
 default-configs/{ => devices}/sparc32plus-linux-user.mak  | 0
 default-configs/{ => devices}/sparc64-bsd-user.mak        | 0
 default-configs/{ => devices}/sparc64-linux-user.mak      | 0
 default-configs/{ => devices}/sparc64-softmmu.mak         | 0
 default-configs/{ => devices}/tilegx-linux-user.mak       | 0
 default-configs/{ => devices}/tricore-softmmu.mak         | 0
 default-configs/{ => devices}/unicore32-softmmu.mak       | 0
 default-configs/{ => devices}/x86_64-bsd-user.mak         | 0
 default-configs/{ => devices}/x86_64-linux-user.mak       | 0
 default-configs/{ => devices}/x86_64-softmmu.mak          | 0
 default-configs/{ => devices}/xtensa-linux-user.mak       | 0
 default-configs/{ => devices}/xtensa-softmmu.mak          | 0
 default-configs/{ => devices}/xtensaeb-linux-user.mak     | 0
 default-configs/{ => devices}/xtensaeb-softmmu.mak        | 0
 meson.build                                               | 2 +-
 75 files changed, 4 insertions(+), 4 deletions(-)
 rename default-configs/{ => devices}/aarch64-linux-user.mak (100%)
 rename default-configs/{ => devices}/aarch64-softmmu.mak (100%)
 rename default-configs/{ => devices}/aarch64_be-linux-user.mak (100%)
 rename default-configs/{ => devices}/alpha-linux-user.mak (100%)
 rename default-configs/{ => devices}/alpha-softmmu.mak (100%)
 rename default-configs/{ => devices}/arm-linux-user.mak (100%)
 rename default-configs/{ => devices}/arm-softmmu.mak (100%)
 rename default-configs/{ => devices}/armeb-linux-user.mak (100%)
 rename default-configs/{ => devices}/avr-softmmu.mak (100%)
 rename default-configs/{ => devices}/cris-linux-user.mak (100%)
 rename default-configs/{ => devices}/cris-softmmu.mak (100%)
 rename default-configs/{ => devices}/hppa-linux-user.mak (100%)
 rename default-configs/{ => devices}/hppa-softmmu.mak (100%)
 rename default-configs/{ => devices}/i386-bsd-user.mak (100%)
 rename default-configs/{ => devices}/i386-linux-user.mak (100%)
 rename default-configs/{ => devices}/i386-softmmu.mak (100%)
 rename default-configs/{ => devices}/lm32-softmmu.mak (100%)
 rename default-configs/{ => devices}/m68k-linux-user.mak (100%)
 rename default-configs/{ => devices}/m68k-softmmu.mak (100%)
 rename default-configs/{ => devices}/microblaze-linux-user.mak (100%)
 rename default-configs/{ => devices}/microblaze-softmmu.mak (100%)
 rename default-configs/{ => devices}/microblazeel-linux-user.mak (100%)
 rename default-configs/{ => devices}/microblazeel-softmmu.mak (100%)
 rename default-configs/{ => devices}/mips-linux-user.mak (100%)
 rename default-configs/{ => devices}/mips-softmmu-common.mak (100%)
 rename default-configs/{ => devices}/mips-softmmu.mak (100%)
 rename default-configs/{ => devices}/mips64-linux-user.mak (100%)
 rename default-configs/{ => devices}/mips64-softmmu.mak (100%)
 rename default-configs/{ => devices}/mips64el-linux-user.mak (100%)
 rename default-configs/{ => devices}/mips64el-softmmu.mak (100%)
 rename default-configs/{ => devices}/mipsel-linux-user.mak (100%)
 rename default-configs/{ => devices}/mipsel-softmmu.mak (100%)
 rename default-configs/{ => devices}/mipsn32-linux-user.mak (100%)
 rename default-configs/{ => devices}/mipsn32el-linux-user.mak (100%)
 rename default-configs/{ => devices}/moxie-softmmu.mak (100%)
 rename default-configs/{ => devices}/nios2-linux-user.mak (100%)
 rename default-configs/{ => devices}/nios2-softmmu.mak (100%)
 rename default-configs/{ => devices}/or1k-linux-user.mak (100%)
 rename default-configs/{ => devices}/or1k-softmmu.mak (100%)
 rename default-configs/{ => devices}/ppc-linux-user.mak (100%)
 rename default-configs/{ => devices}/ppc-softmmu.mak (100%)
 rename default-configs/{ => devices}/ppc64-linux-user.mak (100%)
 rename default-configs/{ => devices}/ppc64-softmmu.mak (100%)
 rename default-configs/{ => devices}/ppc64abi32-linux-user.mak (100%)
 rename default-configs/{ => devices}/ppc64le-linux-user.mak (100%)
 rename default-configs/{ => devices}/riscv32-linux-user.mak (100%)
 rename default-configs/{ => devices}/riscv32-softmmu.mak (100%)
 rename default-configs/{ => devices}/riscv64-linux-user.mak (100%)
 rename default-configs/{ => devices}/riscv64-softmmu.mak (100%)
 rename default-configs/{ => devices}/rx-softmmu.mak (100%)
 rename default-configs/{ => devices}/s390x-linux-user.mak (100%)
 rename default-configs/{ => devices}/s390x-softmmu.mak (100%)
 rename default-configs/{ => devices}/sh4-linux-user.mak (100%)
 rename default-configs/{ => devices}/sh4-softmmu.mak (100%)
 rename default-configs/{ => devices}/sh4eb-linux-user.mak (100%)
 rename default-configs/{ => devices}/sh4eb-softmmu.mak (100%)
 rename default-configs/{ => devices}/sparc-bsd-user.mak (100%)
 rename default-configs/{ => devices}/sparc-linux-user.mak (100%)
 rename default-configs/{ => devices}/sparc-softmmu.mak (100%)
 rename default-configs/{ => devices}/sparc32plus-linux-user.mak (100%)
 rename default-configs/{ => devices}/sparc64-bsd-user.mak (100%)
 rename default-configs/{ => devices}/sparc64-linux-user.mak (100%)
 rename default-configs/{ => devices}/sparc64-softmmu.mak (100%)
 rename default-configs/{ => devices}/tilegx-linux-user.mak (100%)
 rename default-configs/{ => devices}/tricore-softmmu.mak (100%)
 rename default-configs/{ => devices}/unicore32-softmmu.mak (100%)
 rename default-configs/{ => devices}/x86_64-bsd-user.mak (100%)
 rename default-configs/{ => devices}/x86_64-linux-user.mak (100%)
 rename default-configs/{ => devices}/x86_64-softmmu.mak (100%)
 rename default-configs/{ => devices}/xtensa-linux-user.mak (100%)
 rename default-configs/{ => devices}/xtensa-softmmu.mak (100%)
 rename default-configs/{ => devices}/xtensaeb-linux-user.mak (100%)
 rename default-configs/{ => devices}/xtensaeb-softmmu.mak (100%)

diff --git a/configure b/configure
index a5841241be..1981f58aa9 100755
--- a/configure
+++ b/configure
@@ -1719,13 +1719,13 @@ default_target_list=""
 mak_wilds=""
 
 if [ "$softmmu" = "yes" ]; then
-    mak_wilds="${mak_wilds} $source_path/default-configs/*-softmmu.mak"
+    mak_wilds="${mak_wilds} $source_path/default-configs/devices/*-softmmu.mak"
 fi
 if [ "$linux_user" = "yes" ]; then
-    mak_wilds="${mak_wilds} $source_path/default-configs/*-linux-user.mak"
+    mak_wilds="${mak_wilds} $source_path/default-configs/devices/*-linux-user.mak"
 fi
 if [ "$bsd_user" = "yes" ]; then
-    mak_wilds="${mak_wilds} $source_path/default-configs/*-bsd-user.mak"
+    mak_wilds="${mak_wilds} $source_path/default-configs/devices/*-bsd-user.mak"
 fi
 
 # If the user doesn't explicitly specify a deprecated target we will
diff --git a/default-configs/aarch64-linux-user.mak b/default-configs/devices/aarch64-linux-user.mak
similarity index 100%
rename from default-configs/aarch64-linux-user.mak
rename to default-configs/devices/aarch64-linux-user.mak
diff --git a/default-configs/aarch64-softmmu.mak b/default-configs/devices/aarch64-softmmu.mak
similarity index 100%
rename from default-configs/aarch64-softmmu.mak
rename to default-configs/devices/aarch64-softmmu.mak
diff --git a/default-configs/aarch64_be-linux-user.mak b/default-configs/devices/aarch64_be-linux-user.mak
similarity index 100%
rename from default-configs/aarch64_be-linux-user.mak
rename to default-configs/devices/aarch64_be-linux-user.mak
diff --git a/default-configs/alpha-linux-user.mak b/default-configs/devices/alpha-linux-user.mak
similarity index 100%
rename from default-configs/alpha-linux-user.mak
rename to default-configs/devices/alpha-linux-user.mak
diff --git a/default-configs/alpha-softmmu.mak b/default-configs/devices/alpha-softmmu.mak
similarity index 100%
rename from default-configs/alpha-softmmu.mak
rename to default-configs/devices/alpha-softmmu.mak
diff --git a/default-configs/arm-linux-user.mak b/default-configs/devices/arm-linux-user.mak
similarity index 100%
rename from default-configs/arm-linux-user.mak
rename to default-configs/devices/arm-linux-user.mak
diff --git a/default-configs/arm-softmmu.mak b/default-configs/devices/arm-softmmu.mak
similarity index 100%
rename from default-configs/arm-softmmu.mak
rename to default-configs/devices/arm-softmmu.mak
diff --git a/default-configs/armeb-linux-user.mak b/default-configs/devices/armeb-linux-user.mak
similarity index 100%
rename from default-configs/armeb-linux-user.mak
rename to default-configs/devices/armeb-linux-user.mak
diff --git a/default-configs/avr-softmmu.mak b/default-configs/devices/avr-softmmu.mak
similarity index 100%
rename from default-configs/avr-softmmu.mak
rename to default-configs/devices/avr-softmmu.mak
diff --git a/default-configs/cris-linux-user.mak b/default-configs/devices/cris-linux-user.mak
similarity index 100%
rename from default-configs/cris-linux-user.mak
rename to default-configs/devices/cris-linux-user.mak
diff --git a/default-configs/cris-softmmu.mak b/default-configs/devices/cris-softmmu.mak
similarity index 100%
rename from default-configs/cris-softmmu.mak
rename to default-configs/devices/cris-softmmu.mak
diff --git a/default-configs/hppa-linux-user.mak b/default-configs/devices/hppa-linux-user.mak
similarity index 100%
rename from default-configs/hppa-linux-user.mak
rename to default-configs/devices/hppa-linux-user.mak
diff --git a/default-configs/hppa-softmmu.mak b/default-configs/devices/hppa-softmmu.mak
similarity index 100%
rename from default-configs/hppa-softmmu.mak
rename to default-configs/devices/hppa-softmmu.mak
diff --git a/default-configs/i386-bsd-user.mak b/default-configs/devices/i386-bsd-user.mak
similarity index 100%
rename from default-configs/i386-bsd-user.mak
rename to default-configs/devices/i386-bsd-user.mak
diff --git a/default-configs/i386-linux-user.mak b/default-configs/devices/i386-linux-user.mak
similarity index 100%
rename from default-configs/i386-linux-user.mak
rename to default-configs/devices/i386-linux-user.mak
diff --git a/default-configs/i386-softmmu.mak b/default-configs/devices/i386-softmmu.mak
similarity index 100%
rename from default-configs/i386-softmmu.mak
rename to default-configs/devices/i386-softmmu.mak
diff --git a/default-configs/lm32-softmmu.mak b/default-configs/devices/lm32-softmmu.mak
similarity index 100%
rename from default-configs/lm32-softmmu.mak
rename to default-configs/devices/lm32-softmmu.mak
diff --git a/default-configs/m68k-linux-user.mak b/default-configs/devices/m68k-linux-user.mak
similarity index 100%
rename from default-configs/m68k-linux-user.mak
rename to default-configs/devices/m68k-linux-user.mak
diff --git a/default-configs/m68k-softmmu.mak b/default-configs/devices/m68k-softmmu.mak
similarity index 100%
rename from default-configs/m68k-softmmu.mak
rename to default-configs/devices/m68k-softmmu.mak
diff --git a/default-configs/microblaze-linux-user.mak b/default-configs/devices/microblaze-linux-user.mak
similarity index 100%
rename from default-configs/microblaze-linux-user.mak
rename to default-configs/devices/microblaze-linux-user.mak
diff --git a/default-configs/microblaze-softmmu.mak b/default-configs/devices/microblaze-softmmu.mak
similarity index 100%
rename from default-configs/microblaze-softmmu.mak
rename to default-configs/devices/microblaze-softmmu.mak
diff --git a/default-configs/microblazeel-linux-user.mak b/default-configs/devices/microblazeel-linux-user.mak
similarity index 100%
rename from default-configs/microblazeel-linux-user.mak
rename to default-configs/devices/microblazeel-linux-user.mak
diff --git a/default-configs/microblazeel-softmmu.mak b/default-configs/devices/microblazeel-softmmu.mak
similarity index 100%
rename from default-configs/microblazeel-softmmu.mak
rename to default-configs/devices/microblazeel-softmmu.mak
diff --git a/default-configs/mips-linux-user.mak b/default-configs/devices/mips-linux-user.mak
similarity index 100%
rename from default-configs/mips-linux-user.mak
rename to default-configs/devices/mips-linux-user.mak
diff --git a/default-configs/mips-softmmu-common.mak b/default-configs/devices/mips-softmmu-common.mak
similarity index 100%
rename from default-configs/mips-softmmu-common.mak
rename to default-configs/devices/mips-softmmu-common.mak
diff --git a/default-configs/mips-softmmu.mak b/default-configs/devices/mips-softmmu.mak
similarity index 100%
rename from default-configs/mips-softmmu.mak
rename to default-configs/devices/mips-softmmu.mak
diff --git a/default-configs/mips64-linux-user.mak b/default-configs/devices/mips64-linux-user.mak
similarity index 100%
rename from default-configs/mips64-linux-user.mak
rename to default-configs/devices/mips64-linux-user.mak
diff --git a/default-configs/mips64-softmmu.mak b/default-configs/devices/mips64-softmmu.mak
similarity index 100%
rename from default-configs/mips64-softmmu.mak
rename to default-configs/devices/mips64-softmmu.mak
diff --git a/default-configs/mips64el-linux-user.mak b/default-configs/devices/mips64el-linux-user.mak
similarity index 100%
rename from default-configs/mips64el-linux-user.mak
rename to default-configs/devices/mips64el-linux-user.mak
diff --git a/default-configs/mips64el-softmmu.mak b/default-configs/devices/mips64el-softmmu.mak
similarity index 100%
rename from default-configs/mips64el-softmmu.mak
rename to default-configs/devices/mips64el-softmmu.mak
diff --git a/default-configs/mipsel-linux-user.mak b/default-configs/devices/mipsel-linux-user.mak
similarity index 100%
rename from default-configs/mipsel-linux-user.mak
rename to default-configs/devices/mipsel-linux-user.mak
diff --git a/default-configs/mipsel-softmmu.mak b/default-configs/devices/mipsel-softmmu.mak
similarity index 100%
rename from default-configs/mipsel-softmmu.mak
rename to default-configs/devices/mipsel-softmmu.mak
diff --git a/default-configs/mipsn32-linux-user.mak b/default-configs/devices/mipsn32-linux-user.mak
similarity index 100%
rename from default-configs/mipsn32-linux-user.mak
rename to default-configs/devices/mipsn32-linux-user.mak
diff --git a/default-configs/mipsn32el-linux-user.mak b/default-configs/devices/mipsn32el-linux-user.mak
similarity index 100%
rename from default-configs/mipsn32el-linux-user.mak
rename to default-configs/devices/mipsn32el-linux-user.mak
diff --git a/default-configs/moxie-softmmu.mak b/default-configs/devices/moxie-softmmu.mak
similarity index 100%
rename from default-configs/moxie-softmmu.mak
rename to default-configs/devices/moxie-softmmu.mak
diff --git a/default-configs/nios2-linux-user.mak b/default-configs/devices/nios2-linux-user.mak
similarity index 100%
rename from default-configs/nios2-linux-user.mak
rename to default-configs/devices/nios2-linux-user.mak
diff --git a/default-configs/nios2-softmmu.mak b/default-configs/devices/nios2-softmmu.mak
similarity index 100%
rename from default-configs/nios2-softmmu.mak
rename to default-configs/devices/nios2-softmmu.mak
diff --git a/default-configs/or1k-linux-user.mak b/default-configs/devices/or1k-linux-user.mak
similarity index 100%
rename from default-configs/or1k-linux-user.mak
rename to default-configs/devices/or1k-linux-user.mak
diff --git a/default-configs/or1k-softmmu.mak b/default-configs/devices/or1k-softmmu.mak
similarity index 100%
rename from default-configs/or1k-softmmu.mak
rename to default-configs/devices/or1k-softmmu.mak
diff --git a/default-configs/ppc-linux-user.mak b/default-configs/devices/ppc-linux-user.mak
similarity index 100%
rename from default-configs/ppc-linux-user.mak
rename to default-configs/devices/ppc-linux-user.mak
diff --git a/default-configs/ppc-softmmu.mak b/default-configs/devices/ppc-softmmu.mak
similarity index 100%
rename from default-configs/ppc-softmmu.mak
rename to default-configs/devices/ppc-softmmu.mak
diff --git a/default-configs/ppc64-linux-user.mak b/default-configs/devices/ppc64-linux-user.mak
similarity index 100%
rename from default-configs/ppc64-linux-user.mak
rename to default-configs/devices/ppc64-linux-user.mak
diff --git a/default-configs/ppc64-softmmu.mak b/default-configs/devices/ppc64-softmmu.mak
similarity index 100%
rename from default-configs/ppc64-softmmu.mak
rename to default-configs/devices/ppc64-softmmu.mak
diff --git a/default-configs/ppc64abi32-linux-user.mak b/default-configs/devices/ppc64abi32-linux-user.mak
similarity index 100%
rename from default-configs/ppc64abi32-linux-user.mak
rename to default-configs/devices/ppc64abi32-linux-user.mak
diff --git a/default-configs/ppc64le-linux-user.mak b/default-configs/devices/ppc64le-linux-user.mak
similarity index 100%
rename from default-configs/ppc64le-linux-user.mak
rename to default-configs/devices/ppc64le-linux-user.mak
diff --git a/default-configs/riscv32-linux-user.mak b/default-configs/devices/riscv32-linux-user.mak
similarity index 100%
rename from default-configs/riscv32-linux-user.mak
rename to default-configs/devices/riscv32-linux-user.mak
diff --git a/default-configs/riscv32-softmmu.mak b/default-configs/devices/riscv32-softmmu.mak
similarity index 100%
rename from default-configs/riscv32-softmmu.mak
rename to default-configs/devices/riscv32-softmmu.mak
diff --git a/default-configs/riscv64-linux-user.mak b/default-configs/devices/riscv64-linux-user.mak
similarity index 100%
rename from default-configs/riscv64-linux-user.mak
rename to default-configs/devices/riscv64-linux-user.mak
diff --git a/default-configs/riscv64-softmmu.mak b/default-configs/devices/riscv64-softmmu.mak
similarity index 100%
rename from default-configs/riscv64-softmmu.mak
rename to default-configs/devices/riscv64-softmmu.mak
diff --git a/default-configs/rx-softmmu.mak b/default-configs/devices/rx-softmmu.mak
similarity index 100%
rename from default-configs/rx-softmmu.mak
rename to default-configs/devices/rx-softmmu.mak
diff --git a/default-configs/s390x-linux-user.mak b/default-configs/devices/s390x-linux-user.mak
similarity index 100%
rename from default-configs/s390x-linux-user.mak
rename to default-configs/devices/s390x-linux-user.mak
diff --git a/default-configs/s390x-softmmu.mak b/default-configs/devices/s390x-softmmu.mak
similarity index 100%
rename from default-configs/s390x-softmmu.mak
rename to default-configs/devices/s390x-softmmu.mak
diff --git a/default-configs/sh4-linux-user.mak b/default-configs/devices/sh4-linux-user.mak
similarity index 100%
rename from default-configs/sh4-linux-user.mak
rename to default-configs/devices/sh4-linux-user.mak
diff --git a/default-configs/sh4-softmmu.mak b/default-configs/devices/sh4-softmmu.mak
similarity index 100%
rename from default-configs/sh4-softmmu.mak
rename to default-configs/devices/sh4-softmmu.mak
diff --git a/default-configs/sh4eb-linux-user.mak b/default-configs/devices/sh4eb-linux-user.mak
similarity index 100%
rename from default-configs/sh4eb-linux-user.mak
rename to default-configs/devices/sh4eb-linux-user.mak
diff --git a/default-configs/sh4eb-softmmu.mak b/default-configs/devices/sh4eb-softmmu.mak
similarity index 100%
rename from default-configs/sh4eb-softmmu.mak
rename to default-configs/devices/sh4eb-softmmu.mak
diff --git a/default-configs/sparc-bsd-user.mak b/default-configs/devices/sparc-bsd-user.mak
similarity index 100%
rename from default-configs/sparc-bsd-user.mak
rename to default-configs/devices/sparc-bsd-user.mak
diff --git a/default-configs/sparc-linux-user.mak b/default-configs/devices/sparc-linux-user.mak
similarity index 100%
rename from default-configs/sparc-linux-user.mak
rename to default-configs/devices/sparc-linux-user.mak
diff --git a/default-configs/sparc-softmmu.mak b/default-configs/devices/sparc-softmmu.mak
similarity index 100%
rename from default-configs/sparc-softmmu.mak
rename to default-configs/devices/sparc-softmmu.mak
diff --git a/default-configs/sparc32plus-linux-user.mak b/default-configs/devices/sparc32plus-linux-user.mak
similarity index 100%
rename from default-configs/sparc32plus-linux-user.mak
rename to default-configs/devices/sparc32plus-linux-user.mak
diff --git a/default-configs/sparc64-bsd-user.mak b/default-configs/devices/sparc64-bsd-user.mak
similarity index 100%
rename from default-configs/sparc64-bsd-user.mak
rename to default-configs/devices/sparc64-bsd-user.mak
diff --git a/default-configs/sparc64-linux-user.mak b/default-configs/devices/sparc64-linux-user.mak
similarity index 100%
rename from default-configs/sparc64-linux-user.mak
rename to default-configs/devices/sparc64-linux-user.mak
diff --git a/default-configs/sparc64-softmmu.mak b/default-configs/devices/sparc64-softmmu.mak
similarity index 100%
rename from default-configs/sparc64-softmmu.mak
rename to default-configs/devices/sparc64-softmmu.mak
diff --git a/default-configs/tilegx-linux-user.mak b/default-configs/devices/tilegx-linux-user.mak
similarity index 100%
rename from default-configs/tilegx-linux-user.mak
rename to default-configs/devices/tilegx-linux-user.mak
diff --git a/default-configs/tricore-softmmu.mak b/default-configs/devices/tricore-softmmu.mak
similarity index 100%
rename from default-configs/tricore-softmmu.mak
rename to default-configs/devices/tricore-softmmu.mak
diff --git a/default-configs/unicore32-softmmu.mak b/default-configs/devices/unicore32-softmmu.mak
similarity index 100%
rename from default-configs/unicore32-softmmu.mak
rename to default-configs/devices/unicore32-softmmu.mak
diff --git a/default-configs/x86_64-bsd-user.mak b/default-configs/devices/x86_64-bsd-user.mak
similarity index 100%
rename from default-configs/x86_64-bsd-user.mak
rename to default-configs/devices/x86_64-bsd-user.mak
diff --git a/default-configs/x86_64-linux-user.mak b/default-configs/devices/x86_64-linux-user.mak
similarity index 100%
rename from default-configs/x86_64-linux-user.mak
rename to default-configs/devices/x86_64-linux-user.mak
diff --git a/default-configs/x86_64-softmmu.mak b/default-configs/devices/x86_64-softmmu.mak
similarity index 100%
rename from default-configs/x86_64-softmmu.mak
rename to default-configs/devices/x86_64-softmmu.mak
diff --git a/default-configs/xtensa-linux-user.mak b/default-configs/devices/xtensa-linux-user.mak
similarity index 100%
rename from default-configs/xtensa-linux-user.mak
rename to default-configs/devices/xtensa-linux-user.mak
diff --git a/default-configs/xtensa-softmmu.mak b/default-configs/devices/xtensa-softmmu.mak
similarity index 100%
rename from default-configs/xtensa-softmmu.mak
rename to default-configs/devices/xtensa-softmmu.mak
diff --git a/default-configs/xtensaeb-linux-user.mak b/default-configs/devices/xtensaeb-linux-user.mak
similarity index 100%
rename from default-configs/xtensaeb-linux-user.mak
rename to default-configs/devices/xtensaeb-linux-user.mak
diff --git a/default-configs/xtensaeb-softmmu.mak b/default-configs/devices/xtensaeb-softmmu.mak
similarity index 100%
rename from default-configs/xtensaeb-softmmu.mak
rename to default-configs/devices/xtensaeb-softmmu.mak
diff --git a/meson.build b/meson.build
index 0f0cc21d16..41e5763e75 100644
--- a/meson.build
+++ b/meson.build
@@ -695,7 +695,7 @@ foreach target : target_dirs
 
     config_devices_mak = target + '-config-devices.mak'
     config_devices_mak = configure_file(
-      input: ['default-configs' / target + '.mak', 'Kconfig'],
+      input: ['default-configs/devices' / target + '.mak', 'Kconfig'],
       output: config_devices_mak,
       depfile: config_devices_mak + '.d',
       capture: true,
-- 
2.26.2



