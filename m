Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FD0C04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 14:52:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0BFC20848
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 14:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H8Vw5e9C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0BFC20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59498 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRHka-0006FQ-0c
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 10:52:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hRHfb-0002cl-0J
	for qemu-devel@nongnu.org; Thu, 16 May 2019 10:47:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hRHfZ-0008JW-MS
	for qemu-devel@nongnu.org; Thu, 16 May 2019 10:47:42 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:50458)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hRHfZ-0008Hp-94
	for qemu-devel@nongnu.org; Thu, 16 May 2019 10:47:41 -0400
Received: by mail-wm1-x341.google.com with SMTP id f204so3965740wme.0
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 07:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=GibGcyTIcznIDyrFlRM3SJZWG0A8Mzt1f5zkapp7jhE=;
	b=H8Vw5e9C8/9W/6OsKd81L4/LvbBc2gh2ltRh2oswyCqbSq88kWs6lpAxp3orCMc/jX
	LCRa8pEa+gCuox1nRe5+hcUgLe71W5es9StoMYW3KMGiNcEkhxCxuBWYFFap1+qnxidU
	k10jihy6GbiOWzv3rojFlAddeW8nDmQEr69j7y8zdyAOWSJH6yeatDF2EEnqvoSddlBh
	8sNdUl67gTOYxS9p92PwAX7iW3fqI75WB3tJghGZ1qR7CuQAefC/NUQnRuUDotGMfppT
	znBGqXo8hvBXnrb4gNRgs9Yo85PsoIZpostZBcXPCkCI6BKAKhXiAbyDBFub22lvpDT5
	EFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=GibGcyTIcznIDyrFlRM3SJZWG0A8Mzt1f5zkapp7jhE=;
	b=mRZVcRksXlONYLh7nQe86EQ3KVwchCfsd4q1+khbgZyk39E7O896OubeHBbPEuswXP
	hgbY+9TaWIlb5AbYW/8MZUOCZirK7AAaz6aZ1+3q8hcf5Ghi1a3DS34U63rG/jEn526A
	ub2hIxMK9rnOAHPLPXKoL+oValZ3rmZCFKqVU0hFxLXVDpAlmYk1d4vaDOEtR9lK/oiZ
	ALczErWfF65/C6ZTxQpCUxqngh/oNtqePao+l9/2F14+1IHSSdzA2f4wny6P4K7vJ+Du
	vXTcI2NiQUyCSUOa1ZOizCwKGfOJlD0TiOpCfzg0P3JDuLnC6O7AaWKSzSHfTpM2AtEa
	UBhg==
X-Gm-Message-State: APjAAAWksxsxQ6+LwKX38KnVAT6STCvjZ8oaM1ddVLoF8WdxdMZQTfFZ
	mYu+ejeBG2MLblijP8d8pfXGRQ==
X-Google-Smtp-Source: APXvYqzzvrGLTAMifVaW+w/j/ewdzNHniyUyJF3W9lTDfCcAYL2wH6By/+QRagfzPayS/ZrD1XUQ7w==
X-Received: by 2002:a1c:e916:: with SMTP id q22mr27842504wmc.148.1558018060254;
	Thu, 16 May 2019 07:47:40 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id o8sm7629018wra.4.2019.05.16.07.47.39
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 May 2019 07:47:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Thu, 16 May 2019 15:47:33 +0100
Message-Id: <20190516144733.32399-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190516144733.32399-1-peter.maydell@linaro.org>
References: <20190516144733.32399-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH v2 4/4] hw/arm/boot: Honour image size field in
 AArch64 Image format kernels
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

Since Linux v3.17, the kernel's Image header includes a field image_size,
which gives the total size of the kernel including unpopulated data
sections such as the BSS). If this is present, then return it from
load_aarch64_image() as the true size of the kernel rather than
just using the size of the Image file itself. This allows the code
which calculates where to put the initrd to avoid putting it in
the kernel's BSS area.

This means that we should be able to reliably load kernel images
which are larger than 128MB without accidentally putting the
initrd or dtb in locations that clash with the kernel itself.

Fixes: https://bugs.launchpad.net/qemu/+bug/1823998
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/arm/boot.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index e441393fdf5..fc6f37ba6cf 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -910,6 +910,7 @@ static uint64_t load_aarch64_image(const char *filename, hwaddr mem_base,
                                    hwaddr *entry, AddressSpace *as)
 {
     hwaddr kernel_load_offset = KERNEL64_LOAD_ADDR;
+    uint64_t kernel_size = 0;
     uint8_t *buffer;
     int size;
 
@@ -937,7 +938,10 @@ static uint64_t load_aarch64_image(const char *filename, hwaddr mem_base,
          * is only valid if the image_size is non-zero.
          */
         memcpy(&hdrvals, buffer + ARM64_TEXT_OFFSET_OFFSET, sizeof(hdrvals));
-        if (hdrvals[1] != 0) {
+
+        kernel_size = le64_to_cpu(hdrvals[1]);
+
+        if (kernel_size != 0) {
             kernel_load_offset = le64_to_cpu(hdrvals[0]);
 
             /*
@@ -955,12 +959,21 @@ static uint64_t load_aarch64_image(const char *filename, hwaddr mem_base,
         }
     }
 
+    /*
+     * Kernels before v3.17 don't populate the image_size field, and
+     * raw images have no header. For those our best guess at the size
+     * is the size of the Image file itself.
+     */
+    if (kernel_size == 0) {
+        kernel_size = size;
+    }
+
     *entry = mem_base + kernel_load_offset;
     rom_add_blob_fixed_as(filename, buffer, size, *entry, as);
 
     g_free(buffer);
 
-    return size;
+    return kernel_size;
 }
 
 static void arm_setup_direct_kernel_boot(ARMCPU *cpu,
-- 
2.20.1


