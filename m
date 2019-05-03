Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E3E3C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 17:17:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9E8720651
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 17:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="adGp/arE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9E8720651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44945 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMboC-0001Py-2f
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 13:17:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMbkx-0006cs-Bm
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:13:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMbkv-00015A-R9
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:13:55 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55960)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hMbkv-00014Z-K6
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:13:53 -0400
Received: by mail-wm1-x343.google.com with SMTP id y2so7629180wmi.5
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 10:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=CbKBa4cG438327f413qupTHJRviSCiHEjt9FaRlZ34A=;
	b=adGp/arElBmgP9cdgnynjQi4RUkwLIUOgOWhpZ0nbdDlbtyp6xC8A7NR9qB8uA+kvY
	yC8bDtRL/AEXmgwqmRuPr2s+kHU7KYeQr/DEZO6qtNQBWylXoht2frUHTDJDBZxWpupB
	ZBRa1wCWtjVUdkq2r13Xd9pVVIrZp6IG0182c25A03CYekEcBvY61Lpx9MznyxQhTdOD
	4yEbGFcDiOleAR2ajXctQAlOJk69fqdcjwvkm9GbEJqwuSvzTIgcTpDQcVL5a0ewAnd4
	VQmeit6XBXAwDn2FkqSVIt/PBX/T2U7WJVj5hCV6iKNjtfP1dC7qjGaiDZCgeWq5E8cH
	duWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=CbKBa4cG438327f413qupTHJRviSCiHEjt9FaRlZ34A=;
	b=UAza+6x546q0J+I9+bCkf9tiIIkRSwqvNIXYutFY5Bu27GYb+qt/gj/AXHTzAR+Trg
	EKNiQOBG6qqZm5XcYjqs+jkGoU9pxOvBOjrZN7lfZIzuWSNr7PrzmFzhHoA9NNUuvNe8
	BS1YzJ+VHMjPITjlLUYR4w/uj/hgI2hsZippS+w0mFlo4uOG89181moii6noqQH0aK8R
	Id90sLx2+HrEEHoFfNQtWemZLfRUV6fdX2zFDr4oNkGiX3BzvQtgw59raqFoS5fKj/Az
	+13N6V1kTsob1q5+TnhuKrOyayFnTyFoiE10kxFUrJexGtaas/T86wLSLRch2oIY1LMw
	WDOA==
X-Gm-Message-State: APjAAAXEmqiHKpvGYWS/cucnSabrygA58tVWeFI+2jGOFrpypymtl5RC
	3W+Ke4f0nAn3fOFC6THLy/IoPw==
X-Google-Smtp-Source: APXvYqzjEaLEyEKhDCvpOVEk3Cdi5YARYV1XqqavPPNlNPVn2KzpA7ICCHEic+5Usq4xLc2Ph16dXw==
X-Received: by 2002:a7b:c353:: with SMTP id l19mr6743602wmj.12.1556903632582; 
	Fri, 03 May 2019 10:13:52 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id e5sm1717671wrh.79.2019.05.03.10.13.51
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 03 May 2019 10:13:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Fri,  3 May 2019 18:13:47 +0100
Message-Id: <20190503171347.13747-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190503171347.13747-1-peter.maydell@linaro.org>
References: <20190503171347.13747-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH 2/2] hw/arm/boot: Honour image size field in
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
Cc: Mark Rutland <mark.rutland@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190503171347.D3r4vm_-G2s3aWGa8FlBAKyvvyQ_to1gzHObCXBiWc4@z>

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
---
 hw/arm/boot.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 7c978fedde4..34bdd151df8 100644
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


