Return-Path: <SRS0=PST1=DE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A645C4346E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 16:42:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C685F2158C
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 16:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fuxpqudZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C685F2158C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMZky-0003qb-RV
	for qemu-devel@archiver.kernel.org; Sun, 27 Sep 2020 12:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMZiI-0002BW-KB
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 12:39:50 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36212)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMZiH-0005Ir-5w
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 12:39:50 -0400
Received: by mail-wr1-x442.google.com with SMTP id z1so9187321wrt.3
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2020 09:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wcij9GO4gLo8n4f2y2Sh6IBkKvCpAomrBCYklDDmQdw=;
 b=fuxpqudZwh1ft/RJqtRtR2byLfUT/nc8uWACxJX6YyI0b9IsdpM9QOK5jIKW/GSAbn
 TwfmOMF0gl/in4ANDJU6DK2kvqS2PhLZ0HEnEhEJFn2BID8J7Qs43zsJuoidNzD/IMDb
 L2BHm8JoT9hLnV+j233x81Lb+mNwfrNG59w0q2drWhYaLyVIKAbCtiUGZrVRJnDOrBVq
 Ul6K6ZbIJji5xFRd6l531+zpd1V0nO51cJcLW/NvVgkxkTeCjMWR1SLUzczC1zbcYBws
 TBUXwe2w0dysleakmmSGvvgrpTDM8ITKIwcc5XpMQ45G77mQZRilyg4l2ESS0R4ysPzK
 bXgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=wcij9GO4gLo8n4f2y2Sh6IBkKvCpAomrBCYklDDmQdw=;
 b=Hz5ZLzt+lcwiVY2sjG6jC1jy0FRIItEz8+UabljMPy4BLDpnkdwM8/fozSfJ+kFHmn
 ZcUvld2mo7FNL+m37ZWElslNmmBd1Llc1Jwk9VDL/EmCTYSlFUuGJ5ReyI9zUZ9Clnrd
 IGey3dMXWHkQMG+kU70YpvMeyzn0NpNf+4s5OpMZRGKfdKjmzhkuhP2LsERL2D0sUhhg
 9SRF3kAgIL9rRUlZzDQHHMPHcggPQQUo+Gr354B75909PWXXV+VagVgqVUrvjOLUUaM+
 PkqYxhwbb9I2AHXywDD+NrWcYHucWJ7BIFzpTs4uSUhKR64XXXjoj/i0exuufUn+NTMf
 SqNQ==
X-Gm-Message-State: AOAM530b9X8Kuz2G+zITpnrtZyFbJYktt4kfnhBrjdqH1q4OHZ1AaqbL
 dRomDPPTeus3xjnrYt5tJPChmBVoRh4=
X-Google-Smtp-Source: ABdhPJyutFygH37n6cayc8Nm+sya0joDBCNlf8HDoGOMnfQormB6elJNj0HrXRLKTgSfiN0Q9A+udg==
X-Received: by 2002:adf:ef0a:: with SMTP id e10mr14502107wro.362.1601224787118; 
 Sun, 27 Sep 2020 09:39:47 -0700 (PDT)
Received: from localhost.localdomain (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id m10sm5820184wmi.9.2020.09.27.09.39.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2020 09:39:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] hw/mips: Simplify loading 64-bit ELF kernels
Date: Sun, 27 Sep 2020 18:39:42 +0200
Message-Id: <20200927163943.614604-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200927163943.614604-1-f4bug@amsat.org>
References: <20200927163943.614604-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.078,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since 82790064116 ("Cast ELF datatypes properly to host 64bit types")
we don't need to sign-extend the entry_point address. Remove this
unnecessary code.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/mips/mipssim.c | 6 +-----
 hw/mips/r4k.c     | 6 +-----
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/hw/mips/mipssim.c b/hw/mips/mipssim.c
index 1b3b7622035..3aeb1207e1a 100644
--- a/hw/mips/mipssim.c
+++ b/hw/mips/mipssim.c
@@ -76,11 +76,7 @@ static int64_t load_kernel(void)
                            (uint64_t *)&entry, NULL,
                            (uint64_t *)&kernel_high, NULL, big_endian,
                            EM_MIPS, 1, 0);
-    if (kernel_size >= 0) {
-        if ((entry & ~0x7fffffffULL) == 0x80000000) {
-            entry = (int32_t)entry;
-        }
-    } else {
+    if (kernel_size < 0) {
         error_report("could not load kernel '%s': %s",
                      loaderparams.kernel_filename,
                      load_elf_strerror(kernel_size));
diff --git a/hw/mips/r4k.c b/hw/mips/r4k.c
index 3487013a4a1..74f916a3982 100644
--- a/hw/mips/r4k.c
+++ b/hw/mips/r4k.c
@@ -101,11 +101,7 @@ static int64_t load_kernel(void)
                            (uint64_t *)&entry, NULL,
                            (uint64_t *)&kernel_high, NULL, big_endian,
                            EM_MIPS, 1, 0);
-    if (kernel_size >= 0) {
-        if ((entry & ~0x7fffffffULL) == 0x80000000) {
-            entry = (int32_t)entry;
-        }
-    } else {
+    if (kernel_size < 0) {
         error_report("could not load kernel '%s': %s",
                      loaderparams.kernel_filename,
                      load_elf_strerror(kernel_size));
-- 
2.26.2


