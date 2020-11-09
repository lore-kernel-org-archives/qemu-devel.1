Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA26EC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 09:50:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1329F206ED
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 09:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F06rSHBK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1329F206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc3ox-0008K1-V7
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 04:50:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33338)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kc3kV-0004Ve-BE
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 04:46:07 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37609)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kc3kT-0003AX-LI
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 04:46:06 -0500
Received: by mail-wm1-x341.google.com with SMTP id c16so7304096wmd.2
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 01:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=skEK8mcEbaIFgeS0C2weI3p2dBXQu/ugQCxgA8/QJFY=;
 b=F06rSHBKrzqDcu8FaVWSwws98lz5ArIBJmV6GpbautZMtgl2r+YYdcFYVWealFs9t/
 TN5556bSf+/nyhzs1b3SBy/EWxHicKqZ77PPvLiHWH0LYMJsQTkFOCkdv3Gujh0dRK/z
 AxFEih+MVOq3F3oabqYB24UXKuUiDcZXd0swk1NYUYN7XB2He6dS9pJMeP/hJm+Tusds
 qIdbGRbFmSd2VGwpJ4N6MxCWNktY+ksnTGEsxY/EY+TaH6l2Q8bRgOUdy3ckSzbeLO1e
 I5KvkOpoJz7eBHHtPP/6EtSuKEsydtV4zevKzuf8S/v5aLa2bDTolpeFNcJVwqKm/moh
 aLug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=skEK8mcEbaIFgeS0C2weI3p2dBXQu/ugQCxgA8/QJFY=;
 b=GS+ng40M3tFB3jD7afOVBws2pTIlfaFkEPHqUYyTjslzwzXoE6PM0qXAOW+TDIiefQ
 5GzthA61QiEw0L8U4IHAwVOgPliZoNJ5AGqEaGFUVkU3l2HwROBRrEvuGD/XKJug3pjL
 dMxLfQeFkEOieDZStm23YkvXd47Fkv5IKj6YPl7HbKTMvWFt9pWE9oLVKiYMxCuUfayJ
 4QTG56zLBORXx9UHhSfWF1KP6ZoAzUwhv9yuV2b4aSfb/1jsNopzGlhXuTNGJ9J/Fkxv
 oGN5rS+VDS+a9L0QBZMA40bdMHQIW45+kr4HooUbv9oSYtCSnyIMLP3w4VM3n/WKt07m
 zWKw==
X-Gm-Message-State: AOAM5307xWcgrvwnCOKqMRvYRqNqqzrl8VsYNparHC+O96SYn3FU7Xn0
 bbNFNUtJf41RWKzqW9Nhhv2p0h+XCM8=
X-Google-Smtp-Source: ABdhPJxDdTB7I9WJICHIIjy4yAPQvmdbvjdorOinX1TetlCZiYP42zLjOjlMNmvL8ohxokfQ4DLVcQ==
X-Received: by 2002:a7b:c308:: with SMTP id k8mr10264042wmj.76.1604915164072; 
 Mon, 09 Nov 2020 01:46:04 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id u6sm12219003wmj.40.2020.11.09.01.46.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2020 01:46:03 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] accel/stubs: Simplify kvm-stub.c
Date: Mon,  9 Nov 2020 10:45:47 +0100
Message-Id: <20201109094547.2456385-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201109094547.2456385-1-f4bug@amsat.org>
References: <20201109094547.2456385-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now than kvm-stub.c is only built on system-mode emulation,
we can simplify its #ifdef'ry.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 accel/stubs/kvm-stub.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index 680e0994637..68fdfce50ed 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -13,10 +13,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "sysemu/kvm.h"
-
-#ifndef CONFIG_USER_ONLY
 #include "hw/pci/msi.h"
-#endif
 
 KVMState *kvm_state;
 bool kvm_kernel_irqchip;
@@ -91,7 +88,6 @@ int kvm_memcrypt_encrypt_data(uint8_t *ptr, uint64_t len)
   return 1;
 }
 
-#ifndef CONFIG_USER_ONLY
 int kvm_irqchip_add_msi_route(KVMState *s, int vector, PCIDevice *dev)
 {
     return -ENOSYS;
@@ -158,4 +154,3 @@ bool kvm_arm_supports_user_irq(void)
 {
     return false;
 }
-#endif
-- 
2.26.2


