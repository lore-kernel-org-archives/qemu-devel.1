Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 414BEC33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 14:36:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CF1C2073A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 14:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YEywvG5S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CF1C2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58553 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isSjw-0006on-K6
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 09:36:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56582)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1isSbx-0006OE-Se
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:28:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1isSbw-000780-IZ
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:28:33 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:36723)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1isSbw-00077G-CH
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:28:32 -0500
Received: by mail-wm1-x341.google.com with SMTP id p17so7853860wma.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 06:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=AaqDeBCgzc+sx2R4havB3j4EW9JA28b8FSR+NXh6Mrk=;
 b=YEywvG5SHK9b0nUi6p+fpSDGpVxLtWFdrB0t6+SpKxPv0c3XDTGMIGf/0s6COk9sVu
 FjO7is4LyhYDPZfigdaSI1x0ljJ7HwCPA+VaN/JHfKmAmZtcuDi5gcvSFxTXGnKiYhoS
 moufayVlBQHongGC6PHOzWV1HBe5y76BNEJdQTnmc6RLwXK7GD5Vxu+MMXAEqMZHHf+Q
 /B5MD8KJfIumlZI7KSgkw8rtTdbKolWvjrNvaqjvyTclwfGZZY/E7FOMQi+A+XlafKma
 yCowPX+DUMoYQRhOKAcn3jcsyTisy+wKHeoJ113jXNMd/QeWlBDqSoLXUUjyim4gKM3b
 63qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AaqDeBCgzc+sx2R4havB3j4EW9JA28b8FSR+NXh6Mrk=;
 b=QasfQMQ43j/aXTQcnRHdtSmzEcjfrZ4D2rK7S4H/sUKVEHfe8fzfhBQKcJwe4V4PbK
 qI3Y/sAAKUI7hVq08D4xgCAHJzf56Wmo5SxI475UyNE1DuMeJY9XzyDCvYg+ZZWTvhYr
 eOE8NrCrOdX6FNNHR9HaLHx3kPmULXV49JmlDd/JZOLv4GNkfmuSfluNxrmVjvn+1SFt
 K02gsOoTeJmC2vcqReOTGFC8KopB2jDesV3TyvUuqQJss15hjMwiIuyhWk1JbVpTOWYm
 FjSZi2rhDIa8mNKap4hX8HozthQx7NLyEqfQxk6l/d0Xr3ugVPpqdMJpdjamkR2SCMMX
 7izQ==
X-Gm-Message-State: APjAAAWqXQmz85H8bpeJnBqF1OMI3LRYez6N0uK5IIy9ohoKG1AEI4y3
 HV7F55TteXDF5KXFWrhVfCnyuDLTpR3g0g==
X-Google-Smtp-Source: APXvYqz24ekb1v9Wb+EgUWKRI01BKSNF8V66S+prW+An3r2ANcFzBl4IffJHkGYlfpe7O5zaH71u6g==
X-Received: by 2002:a05:600c:2218:: with SMTP id
 z24mr4864747wml.50.1579271310901; 
 Fri, 17 Jan 2020 06:28:30 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e18sm33811146wrw.70.2020.01.17.06.28.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2020 06:28:30 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/15] target/arm/arm-semi: fix SYS_OPEN to return nonzero
 filehandle
Date: Fri, 17 Jan 2020 14:28:11 +0000
Message-Id: <20200117142816.15110-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200117142816.15110-1-peter.maydell@linaro.org>
References: <20200117142816.15110-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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

From: Masahiro Yamada <masahiroy@kernel.org>

According to the specification "Semihosting for AArch32 and Aarch64",
the SYS_OPEN operation should return:

 - A nonzero handle if the call is successful
 - -1 if the call is not successful

So, it should never return 0.

Prior to commit 35e9a0a8ce4b ("target/arm/arm-semi: Make semihosting
code hand out its own file descriptors"), the guest fd matched to the
host fd. It returned a nonzero handle on success since the fd 0 is
already used for stdin.

Now that the guest fd is the index of guestfd_array, it starts from 0.

I noticed this issue particularly because Trusted Firmware-A built with
PLAT=qemu is no longer working. Its io_semihosting driver only handles
a positive return value as a valid filehandle.

Basically, there are two ways to fix this:

  - Use (guestfd - 1) as the index of guestfs_arrary. We need to insert
    increment/decrement to convert the guestfd and the array index back
    and forth.

  - Keep using guestfd as the index of guestfs_array. The first entry
    of guestfs_array is left unused.

I thought the latter is simpler. We end up with wasting a small piece
of memory for the unused first entry of guestfd_array, but this is
probably not a big deal.

Fixes: 35e9a0a8ce4b ("target/arm/arm-semi: Make semihosting code hand out its own file descriptors")
Cc: qemu-stable@nongnu.org
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200109041228.10131-1-masahiroy@kernel.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/arm-semi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
index 47d61f6fe1f..788fe61b51a 100644
--- a/target/arm/arm-semi.c
+++ b/target/arm/arm-semi.c
@@ -144,7 +144,8 @@ static int alloc_guestfd(void)
         guestfd_array = g_array_new(FALSE, TRUE, sizeof(GuestFD));
     }
 
-    for (i = 0; i < guestfd_array->len; i++) {
+    /* SYS_OPEN should return nonzero handle on success. Start guestfd from 1 */
+    for (i = 1; i < guestfd_array->len; i++) {
         GuestFD *gf = &g_array_index(guestfd_array, GuestFD, i);
 
         if (gf->type == GuestFDUnused) {
@@ -168,7 +169,7 @@ static GuestFD *do_get_guestfd(int guestfd)
         return NULL;
     }
 
-    if (guestfd < 0 || guestfd >= guestfd_array->len) {
+    if (guestfd <= 0 || guestfd >= guestfd_array->len) {
         return NULL;
     }
 
-- 
2.20.1


