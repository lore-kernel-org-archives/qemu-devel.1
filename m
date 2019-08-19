Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C995EC3A59B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 05:17:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 955E92086C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 05:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/kneHcH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 955E92086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hza2t-0002DC-Lb
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 01:17:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43434)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1hzZxm-0004ri-Fu
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 01:12:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hzZxl-0007Bm-KB
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 01:12:14 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c]:34901)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hzZxl-00078g-Ee; Mon, 19 Aug 2019 01:12:13 -0400
Received: by mail-pf1-x42c.google.com with SMTP id d85so461751pfd.2;
 Sun, 18 Aug 2019 22:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=0Q6/3Tqqsuch53tx7oUcefBw2d5+9iSqouDG2xIbmao=;
 b=A/kneHcHr/X94j5GQKV/aIGm4IRrnesOTpRnkWGHvBc4cvuDt/4sRAwQ23IU7BOeE1
 jXTRxhANMSm/asMAH1lzihI8Vp4u1/49Dd1hAOj87wHSBBllY12Y5+9XkiMk8JM0UxT8
 /R5WOj0hPlWgORfudDU3saOViBMeYypBw79oWpKcie+UK+hrLqMUnvisSp6eL+ISBSf/
 /WqptQ/ib57jv5E9A5BJisf1PcEGWJpVaTRTcG8xtAtAlKp7SSgpVwurzx25ozaqPYPj
 IReOZASJUL6DdWuODc0lHVcAlM97XdwqTTqslCG9jxcJXd/GWihApw2dEcbOVLQzpA3C
 b1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=0Q6/3Tqqsuch53tx7oUcefBw2d5+9iSqouDG2xIbmao=;
 b=HLly/5ydgiKNO7qoJlX/OIBS8dmHoJaVSSpVQQOb9GbiWFp5bkkFN0A4PFOBRw4Hc8
 U556aBiPsJH9o6kchbDa1RuZeSOCg7oNdX6YS7ZKtabO72mHoFDh2/Tp6MK5mWJ40aXY
 QjnVIWShimGUOOu5FzyycaLoEbgKp/CI3YLeBhVMvaZKD/UJH+gk/8Xbzw29f/y9Bsua
 NPKYh5JJDvQ2uOUlUF7r568KucIut8ZAmdY1mSzdfS/+ivVutxk5ym1mh0o07y0gXhDo
 kM63JHkTLxGM9Zeb623XbaIO0hYVPBTiSg6PyWd1WejySQ5xHjwPUPFFJv0Jvz7KyQ7L
 72qw==
X-Gm-Message-State: APjAAAXwn4uc4RI6pnoHXSRbG9odJw0AfNcI9oMnTUCxUeXalyq5+T0T
 RXIRkZUF61ZBzYED+nUUvKI=
X-Google-Smtp-Source: APXvYqx80YXo+EDFYwasuUPqE7g4QSwTybcxU7vemCZwhPSlV3bA22vI7aV0bfMzWR4o5FtgqXsCSQ==
X-Received: by 2002:a65:6817:: with SMTP id l23mr18386674pgt.46.1566191532644; 
 Sun, 18 Aug 2019 22:12:12 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id q13sm15464986pfl.124.2019.08.18.22.12.11
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Sun, 18 Aug 2019 22:12:12 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Sun, 18 Aug 2019 22:11:38 -0700
Message-Id: <1566191521-7820-6-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1566191521-7820-1-git-send-email-bmeng.cn@gmail.com>
References: <1566191521-7820-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42c
Subject: [Qemu-devel] [PATCH v4 05/28] riscv: roms: Remove executable
 attribute of opensbi images
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Like other binary files, the executable attribute of opensbi images
should not be set.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>

---

Changes in v4:
- new patch to remove executable attribute of opensbi images

Changes in v3: None
Changes in v2: None

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
2.7.4


