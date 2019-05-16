Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EAA3C04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 14:53:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69BC42082E
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 14:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="siYCmilX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69BC42082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59500 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRHkr-0006Sa-JK
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 10:53:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hRHfZ-0002bP-Rp
	for qemu-devel@nongnu.org; Thu, 16 May 2019 10:47:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hRHfY-0008Hx-KV
	for qemu-devel@nongnu.org; Thu, 16 May 2019 10:47:41 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45700)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hRHfY-0008G7-D0
	for qemu-devel@nongnu.org; Thu, 16 May 2019 10:47:40 -0400
Received: by mail-wr1-x442.google.com with SMTP id b18so3683910wrq.12
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 07:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=l9q7KvmjaLy6huMCLkNzLHAGghAhe5aW2pE9iFxRei4=;
	b=siYCmilXdCQxs0pTnh8rf295KB88n2tg3pdX3QvoPyXQqmhksf1Kxuw127Sy048LOb
	Pj7IWwFOatj83QodTxOm2oRAE5okdEmtYzdFlB2a0zIowtMOhmgSHlW16JMK/dF6LWN+
	pezYWy7mS2OLXXYlevM3XFwFZTu9ptLUUkbXzUS8n2NSSdqtHhr0y8G0/OyNnfZLTw99
	eUuKHFTLxIiTR43JE+LVlWfrkj0Y26zcSWK7FfsUabYMHTeqqWgfrKVrY0dXPXlPP0fI
	3FvQyMznOc8CM0mZkPfr2H0j8bTzQOlXhjRA9k+R1V2E4PmvbICdROlfbZZzOl5gO+xx
	fHXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=l9q7KvmjaLy6huMCLkNzLHAGghAhe5aW2pE9iFxRei4=;
	b=Dp4s3Lup7VKWBuz1s8HDkmRii0+kkbkmzjvTfALJ4Vt/Hp7g3q3mVzsx5ZBVUfrsWQ
	F8ECbZHCUZIciFMpKr5q4rAIxv5Wc5lASyC1LNc2yok7YQao/jdEpgT2TRhREHjdmBlM
	BkH02m35XMTdcuhT1TaAf0g6gOxtqgumbC1kLP+zLZW5rodBJliOaWSPROUg0zPi1Amd
	hYOm31pIy1C7ikDiovru1Ysl1Srw+ihkOUs3Mui3+sWBjVNRFmpOuPruljNQPRHkH5fE
	7TG+liyl4cxtodIIc0tl05KpkEIOsqofYY7flwazz/ZmYIhqKd91yDox3fP9q/m2VSq3
	avDg==
X-Gm-Message-State: APjAAAUcRYx2POBW3R7ZEmKkxw8GuJHxLn0rJ2yBhhj2OTmUniW5ocIX
	TWkvSVm+5B07cVQBSH1TGYRNdg==
X-Google-Smtp-Source: APXvYqx0E3d7kqMINU4Wxx4KBJs2TUmPTAyeuT4VhjY/bozFY/2i4qlC23tsg0unTnm19siU1Qspdg==
X-Received: by 2002:adf:dcc4:: with SMTP id x4mr5709889wrm.107.1558018059213; 
	Thu, 16 May 2019 07:47:39 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id o8sm7629018wra.4.2019.05.16.07.47.38
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 May 2019 07:47:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Thu, 16 May 2019 15:47:32 +0100
Message-Id: <20190516144733.32399-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190516144733.32399-1-peter.maydell@linaro.org>
References: <20190516144733.32399-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH v2 3/4] hw/arm/boot: Avoid placing the initrd
 on top of the kernel
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
Cc: Mark Rutland <mark.rutland@arm.com>,
	Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We currently put the initrd at the smaller of:
 * 128MB into RAM
 * halfway into the RAM
(with the dtb following it).

However for large kernels this might mean that the kernel
overlaps the initrd. For some kinds of kernel (self-decompressing
32-bit kernels, and ELF images with a BSS section at the end)
we don't know the exact size, but even there we have a
minimum size. Put the initrd at least further into RAM than
that. For image formats that can give us an exact kernel size, this
will mean that we definitely avoid overlaying kernel and initrd.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/boot.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 935be3b92a5..e441393fdf5 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -999,20 +999,6 @@ static void arm_setup_direct_kernel_boot(ARMCPU *cpu,
     if (info->nb_cpus == 0)
         info->nb_cpus = 1;
 
-    /*
-     * We want to put the initrd far enough into RAM that when the
-     * kernel is uncompressed it will not clobber the initrd. However
-     * on boards without much RAM we must ensure that we still leave
-     * enough room for a decent sized initrd, and on boards with large
-     * amounts of RAM we must avoid the initrd being so far up in RAM
-     * that it is outside lowmem and inaccessible to the kernel.
-     * So for boards with less  than 256MB of RAM we put the initrd
-     * halfway into RAM, and for boards with 256MB of RAM or more we put
-     * the initrd at 128MB.
-     */
-    info->initrd_start = info->loader_start +
-        MIN(info->ram_size / 2, 128 * 1024 * 1024);
-
     /* Assume that raw images are linux kernels, and ELF images are not.  */
     kernel_size = arm_load_elf(info, &elf_entry, &elf_low_addr,
                                &elf_high_addr, elf_machine, as);
@@ -1064,6 +1050,26 @@ static void arm_setup_direct_kernel_boot(ARMCPU *cpu,
     }
 
     info->entry = entry;
+
+    /*
+     * We want to put the initrd far enough into RAM that when the
+     * kernel is uncompressed it will not clobber the initrd. However
+     * on boards without much RAM we must ensure that we still leave
+     * enough room for a decent sized initrd, and on boards with large
+     * amounts of RAM we must avoid the initrd being so far up in RAM
+     * that it is outside lowmem and inaccessible to the kernel.
+     * So for boards with less  than 256MB of RAM we put the initrd
+     * halfway into RAM, and for boards with 256MB of RAM or more we put
+     * the initrd at 128MB.
+     * We also refuse to put the initrd somewhere that will definitely
+     * overlay the kernel we just loaded, though for kernel formats which
+     * don't tell us their exact size (eg self-decompressing 32-bit kernels)
+     * we might still make a bad choice here.
+     */
+    info->initrd_start = info->loader_start +
+        MAX(MIN(info->ram_size / 2, 128 * 1024 * 1024), kernel_size);
+    info->initrd_start = TARGET_PAGE_ALIGN(info->initrd_start);
+
     if (is_linux) {
         uint32_t fixupcontext[FIXUP_MAX];
 
-- 
2.20.1


