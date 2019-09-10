Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB3CECDE27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 08:45:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 110A120863
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 08:45:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 110A120863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7yFN-0004EI-F5
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 04:45:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57350)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1i7xw2-0007st-D0
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:25:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1i7xw1-0006ax-9m
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:25:06 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:40231)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1i7xw1-0006aR-2v
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:25:05 -0400
Received: by mail-wm1-f48.google.com with SMTP id t9so2378169wmi.5
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 01:25:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=0zhLpxGbfvJYXKDT6JDUoSPfFak+q70sNluuZCqQPHw=;
 b=ZVNrDsB9RxU8uPOyht9rm4d8XFm4+HtwGQR6UNt7CDnS7UwejCGh7PHg4QUh//aIeL
 gLSfTLtj1EL1iD1//j2JTlh8CwZ6+Y02JpANe/0YEcrqgY1MUnnB8THCYWx2IHYsg7ww
 2gJo22iuMB+d0DB6SRGayjBPXjuaoPOiPtWMgb7+pZ6SmL1G3v+mr1rKJ9QYf9RAEOVe
 1HLnHpwYUAXoNZoIYQYNAV+mjwYKwK+F/bOZoewTHbJEYXcY0r+/S9HKEYeE4n0p/eRE
 FHAJtFVhx6l1kOx6Lt/UOuI7rPrX/qREmXXa2kzEVYg5C+BKLW2rqHc2Hs7PsahnNBr1
 FSoQ==
X-Gm-Message-State: APjAAAXFWfsaRhQmh35M4R5dvwv2tRR/3/MLXx3Bp4WrMjRHB93cQjjR
 IQzYTXHd5/+ZkTgw/zK6eyviWA==
X-Google-Smtp-Source: APXvYqzM5/Y2LKArQlJacpDa9q5tJDwufts+l7/1u5PKAO1U1GIbmK6/1nbI5glE/i4h0CQ0vyu0AQ==
X-Received: by 2002:a1c:cb83:: with SMTP id b125mr2997937wmg.43.1568190303900; 
 Wed, 11 Sep 2019 01:25:03 -0700 (PDT)
Received: from localhost ([148.69.85.38])
 by smtp.gmail.com with ESMTPSA id y12sm12645165wrn.74.2019.09.11.01.25.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2019 01:25:03 -0700 (PDT)
Date: Tue, 10 Sep 2019 12:04:47 -0700
Message-Id: <20190910190513.21160-22-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190910190513.21160-1-palmer@sifive.com>
References: <20190910190513.21160-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.48
Subject: [Qemu-devel] [PULL 21/47] riscv: roms: Remove executable attribute
 of opensbi images
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
Cc: Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Palmer Dabbelt <palmer@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bmeng.cn@gmail.com>

Like other binary files, the executable attribute of opensbi images
should not be set.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 pc-bios/opensbi-riscv32-virt-fw_jump.bin     | Bin
 pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin | Bin
 pc-bios/opensbi-riscv64-virt-fw_jump.bin     | Bin
 3 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100755 => 100644 pc-bios/opensbi-riscv32-virt-fw_jump.bin
 mode change 100755 => 100644 pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin
 mode change 100755 => 100644 pc-bios/opensbi-riscv64-virt-fw_jump.bin

diff --git a/pc-bios/opensbi-riscv32-virt-fw_jump.bin b/pc-bios/opensbi-riscv32-virt-fw_jump.bin
old mode 100755
new mode 100644
diff --git a/pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin b/pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin
old mode 100755
new mode 100644
diff --git a/pc-bios/opensbi-riscv64-virt-fw_jump.bin b/pc-bios/opensbi-riscv64-virt-fw_jump.bin
old mode 100755
new mode 100644
-- 
2.21.0


