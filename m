Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D92CC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:36:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4311821773
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VLvgCR18"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4311821773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37728 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTop9-0004t1-HC
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 10:36:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hTodu-0002u0-1E
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:24:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hTodt-00076K-0a
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:24:25 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:44535)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hTodr-0006v8-3H
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:24:24 -0400
Received: by mail-wr1-x42d.google.com with SMTP id w13so6485476wru.11
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 07:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=r8KGu8IeOBjMN2NrTnfDSqKnNbY/WeWtTXuKw6y5tUs=;
	b=VLvgCR18MT3KyToUwozLEw3mBdJo5Z93pj1+++uvL+E2ZEtNiXVTkDTCQDr/1bc+7r
	zsfyb+zHHGEDK69CeidJ/+0F4TqTzNUYkaWGPClvOpGXnVUEd2y/Oom4ZJpVC21dZJv8
	o2KL+6wX9BclBkwhm2Jg6bx1ImYvPGCeDuMxeClv9vMUmUdltOUEkCpqIfkf9pZwJKBc
	xa85ulN3qCXlSb9lUb+4kEs+xKkz0DoIUfMRxs/YB6I0rs0tuKafVgPbvcABDFgT0ogU
	CoOzd+suLCbyzbq8WCGVmiPtqN4d9p2rT9Vse38H9TlwKb/qQFPZwyKVwIQf/UMLB0iK
	dwzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=r8KGu8IeOBjMN2NrTnfDSqKnNbY/WeWtTXuKw6y5tUs=;
	b=tKvKIvh8RU3D385+/+JgxJHXKBxMDdj8LvMrYOYt4U41/sDVlkpt9YWi2Q9Fl8x84u
	0c355J6ScKzZeZO/tROA0YE2xwBt/w2WPpuDfoX7zSFYvMM/ZA6P05/QhGlDC9Xj/cfM
	Ol+RkBqsJymC4cFKs1ys+v/0SS7zIvnZi68s39SvcEAjfpjdN/57SNDPtgtWAUeYhDUF
	00gt1s8NbBm6rMqaTI1bUBeklxeR1XBy4AS7fHpvgn6VlMXRVtuWfiIbubUk71USWrN5
	at2s/L3V4a59PJMyMI48vKLt/esDHnYwGCuXwMaYHRD+tTiyfv8nBWfiBel3hSUNfTfG
	GCIA==
X-Gm-Message-State: APjAAAWtg/XRjTq29irZAtF4Ul6Zj+UP0xUjo7mFXsvEjzqgyVQAVqmO
	8o3n9NJeSQ9ArRrkl7XyOdR/yjeWUDhJHw==
X-Google-Smtp-Source: APXvYqwb5cQiUYK4n2BWIrWvbDgWWWCxy3YKcwKtPSJ4R5lT0gf0Dba9N/zh3sxNC0JRYCMd3zhQpA==
X-Received: by 2002:a5d:63d2:: with SMTP id c18mr8206666wrw.134.1558621449530; 
	Thu, 23 May 2019 07:24:09 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id z5sm9700617wmi.34.2019.05.23.07.24.08
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 07:24:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 15:23:54 +0100
Message-Id: <20190523142357.5175-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523142357.5175-1-peter.maydell@linaro.org>
References: <20190523142357.5175-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::42d
Subject: [Qemu-devel] [PULL 09/12] hw/arm/exynos4: Remove unuseful debug code
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20190520214342.13709-2-philmd@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/exynos4_boards.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
index 71f0af3bdbb..1b82bce2f4d 100644
--- a/hw/arm/exynos4_boards.c
+++ b/hw/arm/exynos4_boards.c
@@ -35,20 +35,6 @@
 #include "hw/net/lan9118.h"
 #include "hw/boards.h"
 
-#undef DEBUG
-
-//#define DEBUG
-
-#ifdef DEBUG
-    #undef PRINT_DEBUG
-    #define  PRINT_DEBUG(fmt, args...) \
-        do { \
-            fprintf(stderr, "  [%s:%d]   "fmt, __func__, __LINE__, ##args); \
-        } while (0)
-#else
-    #define  PRINT_DEBUG(fmt, args...)  do {} while (0)
-#endif
-
 #define SMDK_LAN9118_BASE_ADDR      0x05000000
 
 typedef enum Exynos4BoardType {
@@ -140,16 +126,6 @@ exynos4_boards_init_common(MachineState *machine,
     exynos4_board_binfo.gic_cpu_if_addr =
             EXYNOS4210_SMP_PRIVATE_BASE_ADDR + 0x100;
 
-    PRINT_DEBUG("\n ram_size: %luMiB [0x%08lx]\n"
-            " kernel_filename: %s\n"
-            " kernel_cmdline: %s\n"
-            " initrd_filename: %s\n",
-            exynos4_board_ram_size[board_type] / 1048576,
-            exynos4_board_ram_size[board_type],
-            machine->kernel_filename,
-            machine->kernel_cmdline,
-            machine->initrd_filename);
-
     exynos4_boards_init_ram(s, get_system_memory(),
                             exynos4_board_ram_size[board_type]);
 
-- 
2.20.1


