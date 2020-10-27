Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF88AC388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:41:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10D9621655
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FC1NsVul"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10D9621655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXOHi-0005Ev-3P
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 08:41:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNPq-0001ku-Kh
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:45:26 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:34319)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNPi-0004f8-SS
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:45:26 -0400
Received: by mail-wr1-x429.google.com with SMTP id i1so1563131wro.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 04:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=dDusG3z6mR5gstnpBesURGofR8KKSuArrx+sPNkErXw=;
 b=FC1NsVulKhsmrOCo6St5EEjEEfBl6iiWtdwgY2TgxKlCK/rKOjuZCjWn3fOJW+AcjD
 X3j06pxkb/kM+/3++a9T1AuJeCdbSP5sr+VQ4duZcxiPuYHhBHnh3GOGqM/8mruSdJBi
 Yc/ezLfv5xDF2oECnoqAgEgMqpZnOIeAKHnUJYj5CrMVk6UksY8k3l98Hbzqlwf8IXMv
 D2sc3NsxRmSVyIRDoGy+sBY35B0V7Mr1UwyQEjcqWMY6zuFaMS6ovnTYWQyxq6hSZPGi
 vvwyiChNEBTWi+6j5NxEJsltYj5V99qX22m3ftCSQv5TzRacMLW6iseqX9XijdQZqxwE
 hHqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dDusG3z6mR5gstnpBesURGofR8KKSuArrx+sPNkErXw=;
 b=f20x4Hy0G+vb+yIja/UKvCjPfm085l9WGCYXLLli7xG4FJtdqIwDCp8B20DAtID4Y8
 sZge0qQclm3byjG8g1clI1UMSY/6dUyQhfiEP974EJ1erb+t1i9FUmf4FslzHIE4nRF3
 iXxKIDGZO8TbMKkM9EYDZ5smbKZEHTerOeWtUr1S8JPHgcr73MvmoLJhNvYwGeT0m7tW
 CV30Bcu/6SiJInV1YrODIo7PN68hNoOH797t2CpZM76aXXEFoLm29Yi6BMV6geRnDQz4
 cyrM8nizGxBVQ+o7GLiOBG4/cUoWZV4YGTVRn3btn9cTXqmhb5p090pzflCfkk4QKTeW
 Nrxg==
X-Gm-Message-State: AOAM532pNUZ+c3FKeWGWlKKBahsW4Jw/7Gq4Gw97CSB2nFwk1SUb+UxT
 cpx++rkn1O9yGpIIK7nXCJBOGN0RzepGaA==
X-Google-Smtp-Source: ABdhPJyhXeTx0xIszoNFGPXV3QskuHHU68vYlwiteCGpRdX29SXEfj+rD6OPlFO5pzuKmyFpg6YV1g==
X-Received: by 2002:adf:ab4e:: with SMTP id r14mr2347536wrc.397.1603799117124; 
 Tue, 27 Oct 2020 04:45:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 32sm1712203wro.31.2020.10.27.04.45.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 04:45:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/48] hw/arm/raspi: Add the Raspberry Pi 3 model A+
Date: Tue, 27 Oct 2020 11:44:19 +0000
Message-Id: <20201027114438.17662-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201027114438.17662-1-peter.maydell@linaro.org>
References: <20201027114438.17662-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

The Pi 3A+ is a stripped down version of the 3B:
- 512 MiB of RAM instead of 1 GiB
- no on-board ethernet chipset

Add it as it is a closer match to what we model.

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20201024170127.3592182-10-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/raspi.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 0f5ea7e99b5..990509d3852 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -348,6 +348,15 @@ static void raspi2b_machine_class_init(ObjectClass *oc, void *data)
 };
 
 #ifdef TARGET_AARCH64
+static void raspi3ap_machine_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    RaspiMachineClass *rmc = RASPI_MACHINE_CLASS(oc);
+
+    rmc->board_rev = 0x9020e0; /* Revision 1.0 */
+    raspi_machine_class_common_init(mc, rmc->board_rev);
+};
+
 static void raspi3b_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -373,6 +382,10 @@ static const TypeInfo raspi_machine_types[] = {
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi2b_machine_class_init,
 #ifdef TARGET_AARCH64
+    }, {
+        .name           = MACHINE_TYPE_NAME("raspi3ap"),
+        .parent         = TYPE_RASPI_MACHINE,
+        .class_init     = raspi3ap_machine_class_init,
     }, {
         .name           = MACHINE_TYPE_NAME("raspi3b"),
         .parent         = TYPE_RASPI_MACHINE,
-- 
2.20.1


