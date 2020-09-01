Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240C7C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 06:00:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEE7F2087D
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 06:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uuM+jyk9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEE7F2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCzL1-0007ve-2J
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 02:00:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <natechancellor@gmail.com>)
 id 1kCzKF-0007MQ-Gp; Tue, 01 Sep 2020 01:59:23 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:43755)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <natechancellor@gmail.com>)
 id 1kCzKD-0006zw-UE; Tue, 01 Sep 2020 01:59:23 -0400
Received: by mail-qk1-x742.google.com with SMTP id o64so8444654qkb.10;
 Mon, 31 Aug 2020 22:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ATehQTFPQGDP5m0IRjqr98dUqF4iMmiSLriTP7c5fYg=;
 b=uuM+jyk94GY6iqWA9IFSCCFLcRL1DjWzwMFmC2GvU5HgxjO+mseZ0XDi93dnmduNNP
 XtNo8NyUexmkM1XWUSIdRQDB9HoDDnhPESy+eAY5qZbq/qV19DXdp3wsQERLH6Y9BHoa
 9AderZSFFcAY9I6wYGgOqpziptLR6KlZehmPRSx5hTfgfoiH+J+YIBRPxuMtT5SENStc
 Zq05NWUYuJgPN3dfmv3EO6+byGsijw3slkyTe+z9jySt9V99ajNDMN/xIuAdGASgdPZD
 nmVBfzQZdclvKCr9/WNH3pZDW7fkAh+cal9OAjHPKdq3Gur4WGbmqT6uM/5w6uHqetpv
 mWIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ATehQTFPQGDP5m0IRjqr98dUqF4iMmiSLriTP7c5fYg=;
 b=nqyeFdm9QWmr/ErS5XjCeyYKy7ijxH0r9BeEeIms/TeKN+kqX8cShC4ZFrlf7yDW6Z
 3tG9T7rnd1biiZvZYP2f1McHq4kj0G9xqYWBiqO+vWKbi+YTJzLJWD5OIcEarEUYVjpi
 qwbIRRkZl66GYKuRaQhV8HieMYU9YCcUnz4BbmTWrZjNTjGrorJh1ZLZllkLlbM2TNkQ
 7EfbPumF997Z5t4j1/cmzP6QjOl+ntuO2yhhYcXBCeacK1nY1EBJMtt9uzLZ+H4SKsIz
 gWc6iu4CkVYuRxoQFi/jfkzishN8xzNXYBkqjalpg638iw3QB3xatXFqKe7FLSV3PT7o
 N3QQ==
X-Gm-Message-State: AOAM5332lfY3cTX9GZBAq9hdGc7StgD8EnvudQMbLw2N0T1LmnmamjrL
 w84tDuHKwjor/xnme18a15U=
X-Google-Smtp-Source: ABdhPJz7AXvxYGepdIbRBFn52dQ+6eeq5XBhKmR+ZTBXbCWFp6FHVzQ6ReLBNRL/FZOTete79ZcNPw==
X-Received: by 2002:a05:620a:21d2:: with SMTP id
 h18mr253737qka.407.1598939959567; 
 Mon, 31 Aug 2020 22:59:19 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:45d1:2600::1])
 by smtp.gmail.com with ESMTPSA id b9sm129026qtt.39.2020.08.31.22.59.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 22:59:18 -0700 (PDT)
From: Nathan Chancellor <natechancellor@gmail.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Subject: [PATCH] riscv: sifive_test: Allow 16-bit writes to memory region
Date: Mon, 31 Aug 2020 22:58:23 -0700
Message-Id: <20200901055822.2721209-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::742;
 envelope-from=natechancellor@gmail.com; helo=mail-qk1-x742.google.com
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
Cc: qemu-riscv@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Nathan Chancellor <natechancellor@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When shutting down the machine running a mainline Linux kernel, the
following error happens:

$ build/riscv64-softmmu/qemu-system-riscv64 -bios default -M virt \
    -display none -initrd rootfs.cpio -kernel Image -m 512m \
    -nodefaults -serial mon:stdio
...
Requesting system poweroff
[    4.999630] reboot: Power down
sbi_trap_error: hart0: trap handler failed (error -2)
sbi_trap_error: hart0: mcause=0x0000000000000007 mtval=0x0000000000100000
sbi_trap_error: hart0: mepc=0x000000008000d4cc mstatus=0x0000000000001822
sbi_trap_error: hart0: ra=0x000000008000999e sp=0x0000000080015c78
sbi_trap_error: hart0: gp=0xffffffe000e76610 tp=0xffffffe0081b89c0
sbi_trap_error: hart0: s0=0x0000000080015c88 s1=0x0000000000000040
sbi_trap_error: hart0: a0=0x0000000000000000 a1=0x0000000080004024
sbi_trap_error: hart0: a2=0x0000000080004024 a3=0x0000000080004024
sbi_trap_error: hart0: a4=0x0000000000100000 a5=0x0000000000005555
sbi_trap_error: hart0: a6=0x0000000000004024 a7=0x0000000080011158
sbi_trap_error: hart0: s2=0x0000000000000000 s3=0x0000000080016000
sbi_trap_error: hart0: s4=0x0000000000000000 s5=0x0000000000000000
sbi_trap_error: hart0: s6=0x0000000000000001 s7=0x0000000000000000
sbi_trap_error: hart0: s8=0x0000000000000000 s9=0x0000000000000000
sbi_trap_error: hart0: s10=0x0000000000000000 s11=0x0000000000000008
sbi_trap_error: hart0: t0=0x0000000000000000 t1=0x0000000000000000
sbi_trap_error: hart0: t2=0x0000000000000000 t3=0x0000000000000000
sbi_trap_error: hart0: t4=0x0000000000000000 t5=0x0000000000000000
sbi_trap_error: hart0: t6=0x0000000000000000

The kernel does a 16-bit write when powering off the machine, which
was allowed before commit 5d971f9e67 ("memory: Revert "memory: accept
mismatching sizes in memory_region_access_valid""). Make min_access_size
match reality so that the machine can shut down properly now.

Cc: qemu-stable@nongnu.org
Fixes: 88a07990fa ("SiFive RISC-V Test Finisher")
Fixes: 5d971f9e67 ("memory: Revert "memory: accept mismatching sizes in memory_region_access_valid"")
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

Please let me know if the tags are wrong or inappropriate, this is my
first QEMU patch.

 hw/riscv/sifive_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_test.c b/hw/riscv/sifive_test.c
index 0c78fb2c93..8c70dd69df 100644
--- a/hw/riscv/sifive_test.c
+++ b/hw/riscv/sifive_test.c
@@ -59,7 +59,7 @@ static const MemoryRegionOps sifive_test_ops = {
     .write = sifive_test_write,
     .endianness = DEVICE_NATIVE_ENDIAN,
     .valid = {
-        .min_access_size = 4,
+        .min_access_size = 2,
         .max_access_size = 4
     }
 };

base-commit: 2f4c51c0f384d7888a04b4815861e6d5fd244d75
-- 
2.28.0


