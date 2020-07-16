Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E511C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 06:02:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB9CA20578
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 06:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grUecDMg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB9CA20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvwy4-0004Ei-4P
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 02:02:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jvwt3-00063y-LX; Thu, 16 Jul 2020 01:56:53 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38107)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jvwt1-0000NQ-5C; Thu, 16 Jul 2020 01:56:53 -0400
Received: by mail-wr1-x444.google.com with SMTP id z13so5692702wrw.5;
 Wed, 15 Jul 2020 22:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=R3qj7wfb+LJ+KgPGAv0T5wNtaiHsbTmKg4zjBiQ+Yjg=;
 b=grUecDMgm7QOuvpO/nX578gM9+E/BQEMzL+jdHrAPUl2Jg3EqNkgRZekz54K4VVZ1J
 Ai2kJi53rHiePacBpTm0F6nlxcT9xMZ3+Q82XcfoT3H9fp202cK9SbhqTksXfRsk0Qh3
 CC0RHduLVv0UyPzjS1zIH+GaJUMdtR9Wjuq3P52SjWnCDHucX60LdU7ctWBDaGOuUQNe
 T9XBO1gCinbHFnNKLrhC/a8obXY0U7iy8D/PG0bBst2S0HHbZdhHQIo9gZ2ZFNs1VNs2
 yVBHOnkeZyqL4h5WhJ34hdrSMkljCM9RtvTyWqVRz36YNvgjbE73IwfyEdoPTdV8jPAj
 aZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=R3qj7wfb+LJ+KgPGAv0T5wNtaiHsbTmKg4zjBiQ+Yjg=;
 b=OGUM4v0xY7C0IuW8+7mxGm2hX2Z1hllYFXHSS1Oakyr/O1VqtX2dlklOOX2ZxHmtqi
 NwW+7mO/QhYo1FyvU3GLD0IPAsqN2JKRErT93foZh2JeiAzRvJM6xtcKjR20JiWP3H1d
 jDqUkix8eYX2XOoxe8knPg9j/W7w1jsbUX/4UzkrS6bI+qf1rJOZLsvuOCpkvWlK2Uhg
 oJGMetFtcPwKNpJWMvr4w7bT6wQ0AASCV5pgV1A/JkPOuxzl35p0IcVQOEBv1/yaSqOF
 0tGLWBkFkQqSDx47+MMo2FJTEYlZtaNMjjlrfixCr3L1J0vryjyOU8X2Xd+D8vS//Tn7
 3Zxw==
X-Gm-Message-State: AOAM533nylOMMhenQTT1oo+dZeBsrVNZ4ZKPdFS8YJ4nkZsgpyPuJ/vR
 gOmLiCLKn7DDavs2GsPgfL0=
X-Google-Smtp-Source: ABdhPJwl8TUzopxRsoXnSdo+c5lv+FktsGcl4lxuQmru8uECTly/1wh9fALu+RVvej8hHudlsaJ0rA==
X-Received: by 2002:adf:b1cf:: with SMTP id r15mr3570710wra.118.1594879009657; 
 Wed, 15 Jul 2020 22:56:49 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id f12sm7193458wrw.53.2020.07.15.22.56.47
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Wed, 15 Jul 2020 22:56:49 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v5 7/7] Makefile: Ship the generic platform bios ELF images
 for RISC-V
Date: Wed, 15 Jul 2020 22:56:11 -0700
Message-Id: <1594878971-26050-8-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1594878971-26050-1-git-send-email-bmeng.cn@gmail.com>
References: <1594878971-26050-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=bmeng.cn@gmail.com; helo=mail-wr1-x444.google.com
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
Cc: Anup Patel <anup@brainfault.org>, Bin Meng <bin.meng@windriver.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

At present only the generic platform fw_dynamic bios BIN images
are included in the 'make install' target for 'virt' and 'sifive_u'
machines. This updates the install blob list to include ELF images
which are needed by the 'spike' machine.

Signed-off-by: Bin Meng <bin.meng@windriver.com>

---

Changes in v5:
- Ship generic fw_dynamic.elf images in the Makefile

Changes in v3:
- change fw_jump to fw_dynamic in the Makefile

Changes in v2:
- new patch: Makefile: Ship the generic platform bios images for RISC-V

 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index a6d6234..142c545 100644
--- a/Makefile
+++ b/Makefile
@@ -841,7 +841,8 @@ u-boot.e500 u-boot-sam460-20100605.bin \
 qemu_vga.ndrv \
 edk2-licenses.txt \
 hppa-firmware.img \
-opensbi-riscv32-generic-fw_dynamic.bin opensbi-riscv64-generic-fw_dynamic.bin
+opensbi-riscv32-generic-fw_dynamic.bin opensbi-riscv64-generic-fw_dynamic.bin \
+opensbi-riscv32-generic-fw_dynamic.elf opensbi-riscv64-generic-fw_dynamic.elf
 
 
 DESCS=50-edk2-i386-secure.json 50-edk2-x86_64-secure.json \
-- 
2.7.4


