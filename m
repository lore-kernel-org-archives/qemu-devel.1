Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E13C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 16:09:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AD21206A4
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 16:09:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AD21206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVdfG-0001nV-65
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 12:09:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVdVx-0001NX-DD; Mon, 04 May 2020 12:00:17 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:58873)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVdVu-0005mN-L9; Mon, 04 May 2020 12:00:16 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MtwEO-1jHX0O2B6y-00uGmh; Mon, 04 May 2020 18:00:08 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 09/19] chardev: Add macOS to list of OSes that support
 -chardev serial
Date: Mon,  4 May 2020 17:59:46 +0200
Message-Id: <20200504155956.380695-10-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504155956.380695-1-laurent@vivier.eu>
References: <20200504155956.380695-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ztskHpBKtS2LEZa2rd5pUT7MUtywI+lbGEOKJzUhgQcINrv8zeD
 cvokyfxJn/l/J6Id6XWrInilYuQrPmxPpU38sv1bpoFA8T/4BHkinqFjUMfpt0EcpKyW0j5
 6PKOysySrOGbONfH3B0iJ7RxaTgo+YHMyUqa7gnZrVOFp+eTW4RBf7Zjtd8FguuCovwFegZ
 e3gWhNvk+ZrGkZ3O0oHfA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FG5QM0EzYyk=:JebFrSXuin2jq56kRdm6C1
 1llKqLWziMbBx/wph2QKqJvl83Ljz+IppD8Ye8zqjD63SZLgCK4JZftk2sZy2XmW3IWU8ziXx
 DX/JBS0OL39d3ofN1DNlPFsSCde1UQgQpXqYULCBLdOFxLW1Ucc8Vr6OjW8B3FbVEhgjvBzdL
 22L8KXIrWnxmK07w6My1vDEZzsYNA4JIuaZPq4KhJVVqXJ+NMjcwbA5Q8ZqPsBJcCEXT/tGIk
 7iw4gtYCCglwm/+I2rF/oMQrpj5zoe8JYpOoYat6GS4D2dOJV1aSqLf7aTNw8IacuEdJu0u8B
 mrsxcfGegmL2kAFBsNQ3CcslfFEAHQweHdMXggeepou/2a5p0GBLiqdLRBXWcd2hlVqRdxhOy
 cwn8BP4PL/fT91zyoc+q0pQJ1DRzRr9Yzd6vUUONcTzJyr4gPkvp4NQ9u3NCvDksTzVn4frfC
 SB4HPGEiEIChYc/frd99o1YllUosBNsXX9ktWXV7qd3J04Kl6vVt4D7/Vetn609u0altwv7Sx
 LiELoUyBKPhTTY9OP0DKDmfsd+6CpooGu88cw0BGZJV7qazveHxsk0NrIvHpW6SIw34gElCmu
 EHoEkirBUN0fsBMKgZd4fbC2IF1grrsClYl3gEYfp9MKfmyp5ksBIpDD+6HvMX1xHJc3FThoQ
 V+2mWf1ELh4N0dP/HqmTQR4jFYq/hEgbW3x0p1MDgJhlij33TQgqFczRERhu++QB2/+Nc5l/n
 S7Pk9aLyHLn/A44yM91fdeyzHAgGg0WnO2sYyGv16oUP09bkXcWV/0TQ8sjZQY2Jooo7Q8Mkd
 ng04yHkjhJA9XIGOIU7uAlDoP12Ug5mTxcP3bBUg4w9FMuNDzh/Mbp6wiNRZdim6PHyh7TU
Received-SPF: none client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 12:00:07
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, Mikhail Gusarov <dottedmag@dottedmag.net>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Mikhail Gusarov <dottedmag@dottedmag.net>

macOS API for dealing with serial ports/ttys is identical to BSDs.

Signed-off-by: Mikhail Gusarov <dottedmag@dottedmag.net>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200426210956.17324-1-dottedmag@dottedmag.net>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 chardev/char-serial.c | 2 +-
 include/qemu/osdep.h  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/chardev/char-serial.c b/chardev/char-serial.c
index 5b833ea0773b..7c3d84ae243e 100644
--- a/chardev/char-serial.c
+++ b/chardev/char-serial.c
@@ -53,7 +53,7 @@ static void qmp_chardev_open_serial(Chardev *chr,
 
 #elif defined(__linux__) || defined(__sun__) || defined(__FreeBSD__)      \
     || defined(__NetBSD__) || defined(__OpenBSD__) || defined(__DragonFly__) \
-    || defined(__GLIBC__)
+    || defined(__GLIBC__) || defined(__APPLE__)
 
 static void tty_serial_init(int fd, int speed,
                             int parity, int data_bits, int stop_bits)
diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 20f5c5f197d0..ff7c17b85735 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -379,7 +379,7 @@ void qemu_anon_ram_free(void *ptr, size_t size);
 #define HAVE_CHARDEV_SERIAL 1
 #elif defined(__linux__) || defined(__sun__) || defined(__FreeBSD__)    \
     || defined(__NetBSD__) || defined(__OpenBSD__) || defined(__DragonFly__) \
-    || defined(__GLIBC__)
+    || defined(__GLIBC__) || defined(__APPLE__)
 #define HAVE_CHARDEV_SERIAL 1
 #endif
 
-- 
2.26.2


