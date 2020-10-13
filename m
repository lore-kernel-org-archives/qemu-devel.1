Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D39C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 12:08:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54D0F21582
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 12:08:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54D0F21582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSJ6Q-0001Ga-95
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 08:08:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kSIpo-0007NM-UL; Tue, 13 Oct 2020 07:51:16 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:42241)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kSIpm-0004zG-7C; Tue, 13 Oct 2020 07:51:16 -0400
Received: from localhost.localdomain ([82.252.141.186]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MAP77-1kdcgr3u1b-00BqNI; Tue, 13 Oct 2020 13:51:07 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 11/14] goldfish_rtc: change MemoryRegionOps endianness to
 DEVICE_NATIVE_ENDIAN
Date: Tue, 13 Oct 2020 13:50:49 +0200
Message-Id: <20201013115052.133355-12-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201013115052.133355-1-laurent@vivier.eu>
References: <20201013115052.133355-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:isqjquIyRKhzxDwZBmyeLbKalgvLq5RFzTA6gFwB7EsIdFx0opX
 3ad2G5zk3tbI2/h/secRkSaz+b8D8Ngg38ss9o9qYMaPhJNiN4AZ397UqUigBT3AsT4emOw
 sKqBLbWteqU077pzpsuQ8w5uUR7wb6TSMHQSI+x5y/p2a8ThYAeGUlGHSCYqKyy6obzZpTk
 bQmNiGFrpqN5k1u4qem7w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2od1rpwOPhs=:VQvHW9RS6fBY4fz/r7D4oK
 CSDDBq9rxV9tNovLY8HtUH/nxNfHcwPEzTDngijbgB0iYMlVCApkqHoei+2d8D40AMdtHO8Jl
 rCqGwzY5LPrl2a80eXdSueEQU1zvPKgg8L33rH2dVJdSrTDU/m62IazbyQ+ZNBYSlsp2cnyhO
 iPKq9eNgMrBZCySvyHQujmSgf8HrlH2iS9HmYiCuVX9UWMLyeS70ljj9COM1A06X0C2EDqkpq
 VJkxR7Y49r4uSGf0OmxCzupPwGgHRVI/I+xJ+9tPJqcS9ffR7ym5AyKWxfcGoZYlwWYCKt42M
 6VlMx51XtA/rtiwV67+8TQxG3ecWQ43wejTLa3rBFPfqgyNxsCRwe9klntmfaRV3N5pP6zb2h
 lu3KzEIHIMPDfhMKlGjV5TzRCaBWnu6JpmmzUEveHZuLHhUtKrhWa7Ex2Zvd0W7gu7K+CQ3ph
 Jj9JciWVxuQzFztN+ALQ0ePosAkC6JMNgLRiB4O4fwzURFCHH/BkEdaDRDJgmtYrwUQbU5quF
 6awqg+uCGkBSka+eXeQPotyVA1c1mQll5k0j7+PgvU5iOno1uGKlxcLRfx/nDWz3X+l0omJQ9
 BYqlpTiCeEn0lRvk4k9Bw9V9JYQcLDYDKJBkgy0OcI2HWuzdNHGAlqPvSEKBoXBVfXeNQxIxZ
 MP/JDxlhIIG+sFf+A3rPC5cGHaNvYEt5fAgW2COikjB7kUdI96bxlHhBjJzeCHkXXULU5/kHS
 2QOSJPHMu7cUwxZTIZxzh9kFB3/Y/tT60l596LbMELh6eBGLg0+AQuWnP0u6Y1S+Nx+Pkn7aT
 4pBcNWXlK1EpuXatWFj8AmiqRbrAsK+9n80SDqI/2oDwT4aTfSHM+fVGyUs5cCdYLZ/XiKs
Received-SPF: none client-ip=212.227.17.10; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 07:51:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-trivial@nongnu.org,
 Anup.Patel@wdc.com, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>,
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Laurent Vivier <lvivier@redhat.com>

The doc [1] doesn't define the endianness, but the kernel driver
uses readl() to access the registers, so we can guess it depends
on the architecture endianness.

As riscv architecture endianness is little it might not change anything
for it.

Moreover, android implementation uses DEVICE_NATIVE_ENDIAN [2]

[1] https://android.googlesource.com/platform/external/qemu/+/master/docs/GOLDFISH-VIRTUAL-HARDWARE.TXT
[2] https://android.googlesource.com/platform/external/qemu/+/refs/heads/emu-master-dev/hw/timer/goldfish_timer.c#177

Fixes: 9a5b40b84279 ("hw: rtc: Add Goldfish RTC device")
Cc: Anup.Patel@wdc.com
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20201009113843.60995-2-lvivier@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/rtc/goldfish_rtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/rtc/goldfish_rtc.c b/hw/rtc/goldfish_rtc.c
index 6ddd45cce039..0f4e8185a796 100644
--- a/hw/rtc/goldfish_rtc.c
+++ b/hw/rtc/goldfish_rtc.c
@@ -217,7 +217,7 @@ static int goldfish_rtc_post_load(void *opaque, int version_id)
 static const MemoryRegionOps goldfish_rtc_ops = {
     .read = goldfish_rtc_read,
     .write = goldfish_rtc_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = DEVICE_NATIVE_ENDIAN,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4
-- 
2.26.2


