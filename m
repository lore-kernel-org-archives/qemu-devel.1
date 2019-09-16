Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E15C4CECD
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 15:52:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F2212184D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 15:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWmLOeeb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F2212184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9tJ9-0003Ij-Hk
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 11:52:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53790)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1i9sD5-0006e7-4H
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:42:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1i9sD3-0007Ws-2a
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:42:34 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:39718)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1i9sD2-0007WW-Pt
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:42:32 -0400
Received: by mail-wr1-x42e.google.com with SMTP id r3so9038646wrj.6
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 07:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2ZFt5Ej0MDKjJMSatLtGLf2qPb/bGGxrP7DW7hhkcec=;
 b=eWmLOeebRHotKX7qHJQc6pC3pkJ8m9mrsJtYKPGgyoaRSHR6QKdvQMIEulYtFW7BdL
 aovw2Vp1UskS4xtFZyrIHthxw9aQF6/Q07LP2UX55kxqZ6LJcQkvN65UDmCVGOV5zIrc
 BZ3ST66AJolhI1CerW4obu+G/q26FVgIs68pb8FmbSSPdQg3yo+hCUAbgvrqxUwV9HsA
 9dxSCfaSLR4mwyU9nvq8q1B4FAl+XsZqiw3pg6OOZUBsK7Th38UgSRWitc/uEQLLW2jo
 7F6x2S7oGNsvrFq5nZlfQuaRZL3BEKyBXDJIDqCxUFcnm9XydPIBcmaVJXrAVsiejvL8
 w6Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=2ZFt5Ej0MDKjJMSatLtGLf2qPb/bGGxrP7DW7hhkcec=;
 b=jqkyfF/KYbYKFVOvwc90wR67pecsnsYMfDEkVriatTA9OvxrIxjRaHzcTht/v5lJk2
 ref7D4cGu0KVX38lKvuPQJl1xstu9eO8/YcmgV2trjPJMZf95iy9pHDrGfIuH+4wILqo
 9xwfpyV4T8yIMSIDw6MdQdJCGk3b47VqPvDbWH/7UrM1amqkcYh0q4E5dEmlpOdm5yOa
 EBAEA2UfU2trpU9hxPSkeaA4/cpc7RxDzaujSPeAiaUeeLfGe3CTVJqfpmXtwxK+MEgU
 3fW+nJzvd9bRZ/bFsfnlBz9lM02tzfbv8vN9ZG112m4ksybsJh76nYpBdh5oQz8esXU7
 e9fw==
X-Gm-Message-State: APjAAAUpveB8w/xoL7T5Di8l6xdflcM2fkm2FwnJYVSk3LVkpc1picjH
 q4K8WkJCYohv/3miaX5cRTWSnMNI
X-Google-Smtp-Source: APXvYqwnCDUKGboUj/aOlkNWN4zrDVkidLlRvbGwxtqbjy/kq8HoT11aWCxn+6nk5FucB/r9dw1LRQ==
X-Received: by 2002:a05:6000:188:: with SMTP id
 p8mr121525wrx.220.1568644951525; 
 Mon, 16 Sep 2019 07:42:31 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id i14sm17024298wra.78.2019.09.16.07.42.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Sep 2019 07:42:30 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 16 Sep 2019 16:41:58 +0200
Message-Id: <1568644929-9124-19-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1568644929-9124-1-git-send-email-pbonzini@redhat.com>
References: <1568644929-9124-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42e
Subject: [Qemu-devel] [PULL 18/29] hw/i386/pc: Rename bochs_bios_init as
 more generic fw_cfg_arch_create
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

The bochs_bios_init() function is not restricted to the Bochs
BIOS and is useful to other BIOS.
Since it is not specific to the PC machine, and can be reused
by other machines of the X86 architecture, rename it as
fw_cfg_arch_create().

Suggested-by: Samuel Ortiz <sameo@linux.intel.com>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190818225414.22590-5-philmd@redhat.com>
---
 hw/i386/pc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index dd5ec2e..b15af77 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -936,7 +936,7 @@ static void pc_build_smbios(PCMachineState *pcms)
     }
 }
 
-static FWCfgState *bochs_bios_init(PCMachineState *pcms)
+static FWCfgState *fw_cfg_arch_create(PCMachineState *pcms)
 {
     FWCfgState *fw_cfg;
     uint64_t *numa_fw_cfg;
@@ -1614,7 +1614,7 @@ void pc_cpus_init(PCMachineState *pcms)
      * Limit for the APIC ID value, so that all
      * CPU APIC IDs are < pcms->apic_id_limit.
      *
-     * This is used for FW_CFG_MAX_CPUS. See comments on bochs_bios_init().
+     * This is used for FW_CFG_MAX_CPUS. See comments on fw_cfg_arch_create().
      */
     pcms->apic_id_limit = x86_cpu_apic_id_from_index(pcms,
                                                      ms->smp.max_cpus - 1) + 1;
@@ -1869,7 +1869,7 @@ void pc_memory_init(PCMachineState *pcms,
                                         option_rom_mr,
                                         1);
 
-    fw_cfg = bochs_bios_init(pcms);
+    fw_cfg = fw_cfg_arch_create(pcms);
 
     rom_set_fw(fw_cfg);
 
-- 
1.8.3.1



