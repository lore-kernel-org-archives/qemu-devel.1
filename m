Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E8AC33CAA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 05:27:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 802E521835
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 05:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbIELcrU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 802E521835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuV1t-0006hQ-BV
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 00:27:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42090)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1iuV01-0004bA-Cu
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 00:25:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1iuV00-0001kG-Fd
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 00:25:49 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:37087)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1iuUzy-0001iq-4c; Thu, 23 Jan 2020 00:25:46 -0500
Received: by mail-pf1-x444.google.com with SMTP id p14so978577pfn.4;
 Wed, 22 Jan 2020 21:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id;
 bh=2duhfw96sX4LBq6GDO3w2q/itW+l/UJOYIKKmbqgxFI=;
 b=XbIELcrUceOkmOeYXmEhPNhiHGDWMhs/oW2NBlUPu//SIjWE+M48kdvIQsUl0CGriS
 I1QszDNHaJ8CL7mAYHHJKf6xeZAw6/Zhp+LGCnYoECl/+vv1AN7vNkoBdgJMng5VkODm
 2s2DmNhkVRZYmIeeG7bVftPV3Q+CQha/XGarebg7JVhDCV56QfpOFRxsNhp4T81nNKOb
 izBqwa/y7q/JYqJXs+S+XCKbrWfSbXsw7llakl0zv5lJYq5ep1gIxyRh/Z9GiVt7bxYv
 zjjR1IVj6GgkgTEqQg7ODxxoI0G/EebY6B4/eKqBcpg+lOYGhMMoLOiz8docz+Qgr9kc
 Sn8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
 bh=2duhfw96sX4LBq6GDO3w2q/itW+l/UJOYIKKmbqgxFI=;
 b=FT6Wtbj6Jp0cJlKysu/+zEl75qqw2ZScWmvagv9FybBT7g+wRbdUfg4v8BvAN5OEvZ
 D1wKuigl7EszxDiPSb7VHnRS9NowpiGpJNJ6FgGT2Yj264FQs4vWlKHm7uwa7L58+X2o
 7DVU5B9WhBnn1Ae71cNpzsHsYDo/Y7N+rEzfmgzdWszhHZNyVe+fBThsUcDAN96NMk9d
 F3wA58K7ocHIneCt8BYn1aJVb3c7d8jymuUJ2E8okUQrrAXj6FwdwLjTHnyUKIa++ZbF
 i78Y4wht3O+F6RztiS1ozf1lU8WYIHjiwGp76UMFrG8YZcq6GP62boyVfCaAaeHe0W4/
 nXbw==
X-Gm-Message-State: APjAAAXUVJLdDMGPvMwNLCC6S+eh7z4XSliNn0o1DGoOJbPmfBITpljO
 xU9XUugiUaRvdPrdxfwlVBQ=
X-Google-Smtp-Source: APXvYqzH8ki4PZ7TJHbYCn3FCb2ECA9eQSY7IRGWbujN3MOrreo2P2DL4lCsIPArSVGocPI5LYJbPA==
X-Received: by 2002:a63:ed48:: with SMTP id m8mr2059270pgk.399.1579757143993; 
 Wed, 22 Jan 2020 21:25:43 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id k16sm763630pje.18.2020.01.22.21.25.42
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 22 Jan 2020 21:25:43 -0800 (PST)
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 0/8] Fix Exynos4210 DMA support
Date: Wed, 22 Jan 2020 21:25:32 -0800
Message-Id: <20200123052540.6132-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 59520dc65e ("hw/arm/exynos4210: Add DMA support for the Exynos4210")
introduced DMA support for Exynos4210. Unfortunately, it never really
worked. DMA interrupt line and polarity was wrong, and the serial port
needs extra code to support DMA. This patch series fixes the problem.

The series also converts pl330 and exynos4210_uart code to support tracing.
While not strictly necessary, this was very useful for debugging,
and it seemed too valuable to drop it from the final series. Similar,
improved support for receive FIFO handling is not strictly necessary
to fix DMA handling, but I initially thought that it was and added the
code. Like tracing support it seemed too valuable to drop it.

The series was tested with qemu's smdkc210 and nuri emulations and with
exynos4210-smdkv310.dtb. Without the series, the emulation does not react
to serial line input, and serial line output stalls when using DMA. With
this series in place, serial line input is handled correctly, serial
output does not stall, and DMA interrupts are observed and handled.

v3: Increased number of or-irq-lines to 48 to support the full number
    of lines needed. Simplifications in handling UCON register when
    handling receive timeouts. Don't save timer state in VMSTATE.
    Added Reviewed-by: tags as received.
v2: Addressed all feedback comments but one (see last patch of series).
    Please see individual patches for details.

