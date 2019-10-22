Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7043CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 14:12:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 693EC21783
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 14:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GwZdJvg5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 693EC21783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMutD-0000Hk-0o
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 10:11:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37235)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMuHX-0003VL-Tt
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:33:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMuHW-0001co-D4
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:33:03 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:33271)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMuHV-0001cZ-Jd
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:33:01 -0400
Received: by mail-wm1-x32e.google.com with SMTP id 6so3708024wmf.0
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 06:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Jd3gjjSWtiLGtLKohxwgc1UFQoof9TDDl8oztxXNFqQ=;
 b=GwZdJvg5FUQVJs1LfZXvvJwFzBJPINVeTHUqKabr2umrRLjo0Sf4iolcKZSUyevr0M
 0SGrwt37ht94rEC9M8AcpnP6lM5JIpJzOFVsMrf3kd/bRu0RQ6kVi+Ecd7cXzcUA5zow
 j2KHR5BAbzmuHjToVfU1aj7p2YJ7D1zw7v4E8J88pSMYo8KoA7bgCWqtG5B1C6R8rR9K
 9uBSdi8IyZCz78CDIq6uSoVaRYOwPxlxBIe3ewyfCyKRr60G2I5BJINDrXL4RpRFRH/b
 zmt0UHhTs5XE+w3fDE5QgZlfPjvi+cXsPjZVpxD3SAVSeNw0JtRLU1zriey9bh0ypU78
 oJmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Jd3gjjSWtiLGtLKohxwgc1UFQoof9TDDl8oztxXNFqQ=;
 b=Mw3SeyFxKCvWE+Hor/rKdDNhLh7/h36HjrHjJzaInOqN1KTg5saTqVc1SO30JcE/I/
 V+9C/sNVqtXPnqHyN1jGLBtg0KYI0SFu7S0IBGvCl8vjVGIxATXmy2aLdI7g/Gqt+XAJ
 dVSAezyukfDTBL6Frm5+9iTf/BNqB8RsMROhOOn1oUQMnWV7iHeajGbT4ZnzZGlMW5Xg
 mcIsT9qeFL8SJ+UJ16x73KOuzgJtyufF9ItbhRZWZxGZJxKXN2fN+wGo47/QxSjcZqB1
 YgDH1J6EwwsqK01n6OqbWiOMxZuKZ+b10c+Jzl8LurB9dN4mSjRL295kCtkHHO198geM
 ZxEQ==
X-Gm-Message-State: APjAAAXULv8/ddHzLiovjAYd9UczKim0ycBX7DWUqd3sLA4L8IWEPFWc
 rcWPpJXUkNkqOA/JtkQ/7wIr22bs+og=
X-Google-Smtp-Source: APXvYqz/ld1ZMXJNy9SHnmM5pQInHhxitRPBUaUOuYXTNkrTHnZw67sS+M+TqW43DhaLzZ4foZa34g==
X-Received: by 2002:a1c:7d95:: with SMTP id y143mr3202507wmc.143.1571751179739; 
 Tue, 22 Oct 2019 06:32:59 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r2sm20263856wma.1.2019.10.22.06.32.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2019 06:32:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 36/41] hw/arm/xilinx_zynq: Use the IEC binary prefix definitions
Date: Tue, 22 Oct 2019 14:31:29 +0100
Message-Id: <20191022133134.14487-37-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191022133134.14487-1-peter.maydell@linaro.org>
References: <20191022133134.14487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
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

From: Philippe Mathieu-Daudé <philmd@redhat.com>

IEC binary prefixes ease code review: the unit is explicit.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20191021190653.9511-2-philmd@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/xilinx_zynq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index c14774e542c..3a0fa5b23f7 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -16,6 +16,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qapi/error.h"
 #include "cpu.h"
 #include "hw/sysbus.h"
@@ -194,7 +195,7 @@ static void zynq_init(MachineState *machine)
     memory_region_add_subregion(address_space_mem, 0, ext_ram);
 
     /* 256K of on-chip memory */
-    memory_region_init_ram(ocm_ram, NULL, "zynq.ocm_ram", 256 << 10,
+    memory_region_init_ram(ocm_ram, NULL, "zynq.ocm_ram", 256 * KiB,
                            &error_fatal);
     memory_region_add_subregion(address_space_mem, 0xFFFC0000, ocm_ram);
 
-- 
2.20.1


