Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4CF3C4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 15:44:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A1F521907
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 15:44:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A1F521907
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAc8V-0005E5-Aw
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 11:44:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49441)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1iAbsP-00073s-JT
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:28:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1iAbsO-0006mx-8O
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:28:17 -0400
Received: from mail-pg1-f177.google.com ([209.85.215.177]:34228)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1iAbsO-0006mD-0m
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:28:16 -0400
Received: by mail-pg1-f177.google.com with SMTP id n9so62327pgc.1
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 08:28:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=0zhLpxGbfvJYXKDT6JDUoSPfFak+q70sNluuZCqQPHw=;
 b=aqrdvBJwUdrYLBBkHuQl524iZK0FHtFPdxw3+d34MqjDptEA5hPjDmlc+hKbMAX4G1
 b54XsXH5j8/y26lYAzpI7ACvQ3len/GXxiidwOf4BbBFPtrTKc+gF9A+MC7g9+woaVYb
 ZiUqbB8Z49aG2I9i8BRWcepq9NHIPGWR6uzGz5SWw3Tf+jjYX6/yxY2t34uxMMXvhZI8
 x2rzz4PYfuDcFhM7soR7N4Kj0EiVbq8nu7O1Fi+mSEP1wjS6VhDY66c1cp3MAGW1ilzC
 eM9bYQA1GEpWw1a7C+WRAwVsCPqZaTwtHpsw45MmMkZM9vJaxGH/qzRrZ7nXZuV32tNl
 BVhA==
X-Gm-Message-State: APjAAAXYEGXy8IkA8XvHgdBKdUPH/uusf5JEOPDAYhSlCOGdKj6HJKXY
 718Xol5laU9p1nxuESpzIM9fGA==
X-Google-Smtp-Source: APXvYqx8ajtS3KPqIVO6RFPZoVwoWoaFGkzftQs0B4mggERLuOWo/9GwVttFWHfMKI+VsHN/QQNKUg==
X-Received: by 2002:a65:67d4:: with SMTP id b20mr4497385pgs.445.1568820494753; 
 Wed, 18 Sep 2019 08:28:14 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id f22sm5512651pgb.4.2019.09.18.08.28.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2019 08:28:13 -0700 (PDT)
Date: Wed, 18 Sep 2019 07:56:13 -0700
Message-Id: <20190918145640.17349-22-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190918145640.17349-1-palmer@sifive.com>
References: <20190918145640.17349-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.215.177
Subject: [Qemu-devel] [PULL 21/48] riscv: roms: Remove executable attribute
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


