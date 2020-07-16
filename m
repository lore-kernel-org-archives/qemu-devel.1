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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92EADC433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 05:57:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AF072065E
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 05:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3b8bHtH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AF072065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvwts-00070k-Fy
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 01:57:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jvwsp-0005eL-6p; Thu, 16 Jul 2020 01:56:39 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38875)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jvwsn-0000Kn-Lj; Thu, 16 Jul 2020 01:56:38 -0400
Received: by mail-wm1-x344.google.com with SMTP id f18so9714444wml.3;
 Wed, 15 Jul 2020 22:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=BHeKtHmNWiAjV5Xy3SbLdEwwCu4Vu5ZZ6NV6lX457O4=;
 b=d3b8bHtHOLqMe8zIUGln1BEIdLByd+SFIqRGoysSJfp1vT2mXtRfXMd1dam+edHfTf
 gFuLaN9lhWj/xjjtxVtmDYbaLwj95T7RMpmaLs/jRjpI/dozjgTKj0BRKkyJBlhBeXDl
 1G9iMPA70vThqO3ZEXuGl1bXV6SsZ1VcUm/Wl+JqTfQ0KcZ9iBSQnnahNzEFzE6MYQhW
 Ta30/2CtGvMVmWICgqHZT6GGtSY6yqsIDwoy3w8WGHbFzUY+iSsAA1/u0reHDxdvkaIO
 w5Je7xrfWCwVukDgsizwflWn4QD0SjUQqBD0So/xVd2CxWpQE//A1FhWUdAx3zSG47zr
 kjOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=BHeKtHmNWiAjV5Xy3SbLdEwwCu4Vu5ZZ6NV6lX457O4=;
 b=LqOPDYlvHibZI6lCMu7VdteZ7vVMnRoxpV430GhqWbMsUwfitGVaXWQ1Xi2KFZn0Rq
 IJ3Ky2jplCiuSXo5Ixxj4AkIZMVYZWTrNtkNUMp5sLuH6DBEsfp4jKvuSzh3ivUvhLmi
 peZVGxTccS1P4emnqWBwLOytv5t92uopAQYsc0UQLJ7W8XKALjIRVYi/+NMFdcDG5B0O
 NIk4uGcQlW/pA5oairnxZ3kqTEtE6i+x3TGPobFFMt381Qevw9XG0XYBwuP/cfh1a1Hk
 AbrjKM5kemajMG0lyS93EqOzx1qOUhWi+ZBnh6Z6BPLF0POsQH35kp8bmJPN2m8dXY/y
 qTIQ==
X-Gm-Message-State: AOAM532vJSzpyvRqIh7yJR4nWyqh+0iVbNkvILErrkA4D+K6zzpaxiJr
 QNQyrdMne8cMYNq1hijYebg=
X-Google-Smtp-Source: ABdhPJye6fll3K++lOytsGfUhED+dT4+vl7x9X07FmaRhUexyW4CUHQKQv5BHfIAvhc1g8wHET4kLg==
X-Received: by 2002:a7b:c936:: with SMTP id h22mr2654430wml.114.1594878995257; 
 Wed, 15 Jul 2020 22:56:35 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id f12sm7193458wrw.53.2020.07.15.22.56.33
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Wed, 15 Jul 2020 22:56:34 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v5 1/7] configure: Create symbolic links for pc-bios/*.elf
 files
Date: Wed, 15 Jul 2020 22:56:05 -0700
Message-Id: <1594878971-26050-2-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1594878971-26050-1-git-send-email-bmeng.cn@gmail.com>
References: <1594878971-26050-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=bmeng.cn@gmail.com; helo=mail-wm1-x344.google.com
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

Now we need to ship the OpenSBI fw_dynamic.elf image for the
RISC-V Spike machine, it requires us to create symbolic links
for pc-bios/*.elf files.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

---

(no changes since v2)

Changes in v2:
- new patch: configure: Create symbolic links for pc-bios/*.elf files

 configure | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configure b/configure
index b751c85..af027c5 100755
--- a/configure
+++ b/configure
@@ -8584,6 +8584,7 @@ LINKS="$LINKS tests/qemu-iotests/check"
 LINKS="$LINKS python"
 for bios_file in \
     $source_path/pc-bios/*.bin \
+    $source_path/pc-bios/*.elf \
     $source_path/pc-bios/*.lid \
     $source_path/pc-bios/*.rom \
     $source_path/pc-bios/*.dtb \
-- 
2.7.4


