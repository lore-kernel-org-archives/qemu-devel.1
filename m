Return-Path: <SRS0=bgql=3H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01921C33CB1
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 16:44:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B76382469A
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 16:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QsZ7eGny"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B76382469A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isrCe-0005i3-EH
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 11:44:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36073)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1isrBF-0003wd-0G
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 11:42:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1isrBE-00024x-3a
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 11:42:36 -0500
Received: from mail-yw1-xc2a.google.com ([2607:f8b0:4864:20::c2a]:34794)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1isrBB-0001zy-Vr; Sat, 18 Jan 2020 11:42:34 -0500
Received: by mail-yw1-xc2a.google.com with SMTP id b186so15873924ywc.1;
 Sat, 18 Jan 2020 08:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id;
 bh=nPqd6PZ8sC+NVZHb4o0W07SjU+hF6Ok7k2NBcMjqx88=;
 b=QsZ7eGnySVkNno1lKHqJtYVl9EW24gb8qqz0IuaTjfxW+8w+C5+baAW7NZUjChwz4z
 OIPwomRG3sWveUBZiML4CJRaTFbGecVfBpsUVBxiPpboKbUn6uaKlJpIQQNwkttkaHeH
 u1oN5t3VqtatZgxWozsdXL1gdM5jHLSSBoEmlA5fP8vvRvLGLqzYOBgqruR4ipJk1No/
 Coyu7wfKbteUlRYFnjgk1C6dM0J7L9FCdwdzE8yifDBYgDGuT8etkD7ICn3E3jCIgP26
 kNO3lAr9PtgS15xe+wAQff1vTR5WUOanXW1h1aN1EACYCg1JVsgqIdGQcIKh+q49MtMJ
 LJig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
 bh=nPqd6PZ8sC+NVZHb4o0W07SjU+hF6Ok7k2NBcMjqx88=;
 b=bFVIxDpUfZshuJGRMViVXb/KsQ6CkLhc7S4f58EaUfPitBlc3HLkOCd6AU11tO8TQo
 e0ADmOs/snWqUos4GhauZ5ssMa7HfWDehix8iWUXymBJUtjap/eYgmxTtdcFuF1A3PA2
 +wHTYe8PK1oE29RxJO8KzCuEQPEqDQfIxo7os6ndI2Dk9jfdUkkHddce+XiP7wqywzz8
 5Hf42yuHbGzvclotRQeReiZQMHNQJvl4poE1TpjaZgTIVrgHbzmiwQGM/jq+V/p2fsFU
 KJa9VKgGrpsKxWJ3A4enLFfbVJ2l5yJ2Hx/AyNNeT/wMAvWgImz8Z5NHsMItttD4MwRq
 NuPg==
X-Gm-Message-State: APjAAAVzilaK7ziNZ94hAS+IuCFKDBmJ2V4jnCSLyR0568S5IcHZ060m
 MOxh0SA7a2mMb8XpkmijWDI=
X-Google-Smtp-Source: APXvYqyZ4HQJDk+/ppEqgvIH9+scris0tBBmmdWQD28mMqWfe0D+HC0gYQnK8l2W5lppUEfdRYXmBg==
X-Received: by 2002:a81:a210:: with SMTP id w16mr35028944ywg.261.1579365753252; 
 Sat, 18 Jan 2020 08:42:33 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id u185sm13202479ywf.89.2020.01.18.08.42.31
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 18 Jan 2020 08:42:32 -0800 (PST)
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 0/7] Fix Exynos4210 DMA support
Date: Sat, 18 Jan 2020 08:42:22 -0800
Message-Id: <20200118164229.22539-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c2a
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
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Guenter Roeck <linux@roeck-us.net>
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

v2: Addressed all feedback comments but one (see last patch of series).
    Please see individual patches for details.

