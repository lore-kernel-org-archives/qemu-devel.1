Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A6AC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 07:32:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 343862070A
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 07:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9F9vGR6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 343862070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2UxJ-0003An-1E
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 03:32:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58954)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k2Uvq-0001TY-64; Mon, 03 Aug 2020 03:30:50 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:42921)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k2Uvl-00065n-J8; Mon, 03 Aug 2020 03:30:49 -0400
Received: by mail-wr1-x42c.google.com with SMTP id r4so30216610wrx.9;
 Mon, 03 Aug 2020 00:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=hOBhOxLF7AHcrdOd0fzIV622sepjBiKEqLdNfaOUdcc=;
 b=Z9F9vGR62s/79j2+7Na8Idl1CRKykygqL3pHXc6nIrenXtIyoQPox3jV5fH/lpGBtg
 U+heFK8wfk7YT1udUkEPFjYRRMeEeUb5S6EnF9b8wEJHa0fAZQVZ+pDJdR+S01IGATyR
 fTx6XQBkJ8DqSWBB/2pWI2NrZ7QFZ4W5XPSIvOX2P7ot0UhW5lHhJ9zgqdVuJvpPSA01
 iq0TxqnFDt6GHA9Z/qWNpBOnMd3zTpUUKHI2UOhPxmqeLrA7YETPwnife3+EGcQIkajC
 f/Im6yx0PP8yRukMRHNHWGJLmnICCCfY/MbOBGMSufAZiI9oNg7J4oTt+QUKWBhauxBl
 LPrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=hOBhOxLF7AHcrdOd0fzIV622sepjBiKEqLdNfaOUdcc=;
 b=ZgWWPEzcVNHFaocvUXSHnkhTpOjkNCmN6o1/9yqKeYyCsmOPe4rZqcASutm8UliLbz
 6qmhXXVPkxiJwC5XdEMj8e/IMtipntBBZ5XAAJKvCCrIWKl/iPreeT21BVTd4Wpa0vue
 8bDrUfsIUekQBFBjqGsmkbnrBbPB8tYK0xuG2s4Aq06wFsPq0zF8qOjrEWt/5C+e8vek
 IANeotSsoTI0QhgdobcHu5+IBjPEF1vDJdMhO8dnB79H08YvG+JD0NFzDgbawq2ZEr8C
 4T+YzzSESseb9N2lAyNRRLeH1oE67HZ98ABQwnpNfQDpZONfCeOuGLSJvqJh1JrUTSbE
 yiSw==
X-Gm-Message-State: AOAM533bF99oSQHK6LoqMHeHB/QoaZha0yO2XTqqK6DNZ0bpkHEQPzkX
 hEsfLk2eUVhvIihQUD2jTeg=
X-Google-Smtp-Source: ABdhPJzuaf4hQRe1bTZidP9z+D8CXgqZPKXa+BcNQmvae2dxI6ZNAaugA61o09oujN9+tA8vOQ4YRA==
X-Received: by 2002:adf:df85:: with SMTP id z5mr13421582wrl.267.1596439842473; 
 Mon, 03 Aug 2020 00:30:42 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id 130sm23969438wme.26.2020.08.03.00.30.40
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Mon, 03 Aug 2020 00:30:41 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v6 1/6] configure: Create symbolic links for pc-bios/*.elf
 files
Date: Mon,  3 Aug 2020 00:30:27 -0700
Message-Id: <1596439832-29238-2-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1596439832-29238-1-git-send-email-bmeng.cn@gmail.com>
References: <1596439832-29238-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=bmeng.cn@gmail.com; helo=mail-wr1-x42c.google.com
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
Cc: Bin Meng <bin.meng@windriver.com>
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
index 2acc4d1..790b21d 100755
--- a/configure
+++ b/configure
@@ -8545,6 +8545,7 @@ LINKS="$LINKS tests/qemu-iotests/check"
 LINKS="$LINKS python"
 for bios_file in \
     $source_path/pc-bios/*.bin \
+    $source_path/pc-bios/*.elf \
     $source_path/pc-bios/*.lid \
     $source_path/pc-bios/*.rom \
     $source_path/pc-bios/*.dtb \
-- 
2.7.4


