Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECA6C2BA2B
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 07:24:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D87220663
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 07:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oGsjS1xb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D87220663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemote.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNtS9-0005Sh-F5
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 03:24:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36974)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chenhuacai@gmail.com>) id 1jNtQK-0002q4-56
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 03:22:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chenhuacai@gmail.com>) id 1jNtQJ-0006KR-3A
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 03:22:28 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:32971)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <chenhuacai@gmail.com>)
 id 1jNtQI-0006IT-UC
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 03:22:27 -0400
Received: by mail-pl1-x644.google.com with SMTP id ay1so3122346plb.0
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2020 00:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=IYw9KM308fvuCNV456QoScKTZAovGHwS9ZllmosmZHA=;
 b=oGsjS1xbf9xogVsLJWnou0X56088c+jXKkPfT4EJU21wV61xCDLOKDxpfmfG3pbREz
 8RQpXNeO/EqiBDGVeX6h16ORRBAT4GMuyFDC1fiPSjnwWXiceuU2GkdRxDubsjebobmS
 wdS/aovMHceQneB3xpCwn4W03T2EFMhwJdatsQgjPMvzabeRU3KMqOvbM/uPSCVUmMQZ
 Y2VqTQKgDxDT6DXqWega5bMoOk65CMSUjR63sJ+QZjjf8AbyyIgnO00cNo/wjESjTQBz
 9rZnV43N3RDME72XFmvzcsoVa3MUW1LuYiBW4T+krx3BSkwHC0rX+Y48YBgSGkDTyCFh
 m9OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=IYw9KM308fvuCNV456QoScKTZAovGHwS9ZllmosmZHA=;
 b=Kvsky2/FF3urnQEwVxSKr5Veq8dDmX2CioB3iFlocfBdz5pPtfaXRWsVm2Kc13tUXw
 kKdS6L98qVFUgVdeiZsldwQg2to5AUD0iaUukXeDBUfeRdbTxM7imf7Fei81X70eGVng
 EFK3wT9VkvjPTD3xNyEocQs48Ocn/3WJgJGGBZyQibAOWuxlQLzS7SIALeN/LCZbSE3C
 lmFFXcjUP2V351uoIOscFdDWGDIrDruADzz5yAcFDqztSdg1PFENRP6reFuVcrytsUqA
 6WAnZoZNsyfw9Lc1OSPGmcOwuZs0FTz7YbQjd0jKf8T5B8dHYUsVhWoYSRcH9PkbSZ0F
 UqYg==
X-Gm-Message-State: AGi0PuZWgJKs0gaIEi9PDB8yaDkVESt5vwIHFHSYlepnLWYCgC41LLKz
 9fIJhpCBUcNC0a86Gb6h7C2I+GevO7k=
X-Google-Smtp-Source: APiQypLratNJjdldNhRTz0xpzWmi6lNCP7lJRob5L/BRLECvfri/in1gAYGd1LdcJFUKuecUGIfAQw==
X-Received: by 2002:a17:90a:c295:: with SMTP id
 f21mr12982259pjt.176.1586762546007; 
 Mon, 13 Apr 2020 00:22:26 -0700 (PDT)
Received: from software.domain.org (28.144.92.34.bc.googleusercontent.com.
 [34.92.144.28])
 by smtp.gmail.com with ESMTPSA id u8sm7241341pgl.19.2020.04.13.00.22.23
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 13 Apr 2020 00:22:25 -0700 (PDT)
From: Huacai Chen <chenhc@lemote.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH 02/15] KVM: MIPS: Define KVM_ENTRYHI_ASID to
 cpu_asid_mask(&boot_cpu_data)
Date: Mon, 13 Apr 2020 15:30:11 +0800
Message-Id: <1586763024-12197-3-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1586763024-12197-1-git-send-email-chenhc@lemote.com>
References: <1586763024-12197-1-git-send-email-chenhc@lemote.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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
Cc: kvm@vger.kernel.org, Huacai Chen <chenhuacai@gmail.com>,
 qemu-devel@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 linux-mips@vger.kernel.org, stable@vger.kernel.org,
 Fuxin Zhang <zhangfx@lemote.com>, Huacai Chen <chenhc@lemote.com>,
 Xing Li <lixing@loongson.cn>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Xing Li <lixing@loongson.cn>

The code in decode_config4() of arch/mips/kernel/cpu-probe.c

        asid_mask = MIPS_ENTRYHI_ASID;
        if (config4 & MIPS_CONF4_AE)
                asid_mask |= MIPS_ENTRYHI_ASIDX;
        set_cpu_asid_mask(c, asid_mask);

set asid_mask to cpuinfo->asid_mask.

So in order to support variable ASID_MASK, KVM_ENTRYHI_ASID should also
be changed to cpu_asid_mask(&boot_cpu_data).

Cc: stable@vger.kernel.org
Signed-off-by: Xing Li <lixing@loongson.cn>
[Huacai: Change current_cpu_data to boot_cpu_data for optimization]
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/kvm_host.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 41204a4..5794584 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -275,7 +275,7 @@ enum emulation_result {
 #define MIPS3_PG_FRAME		0x3fffffc0
 
 #define VPN2_MASK		0xffffe000
-#define KVM_ENTRYHI_ASID	MIPS_ENTRYHI_ASID
+#define KVM_ENTRYHI_ASID	cpu_asid_mask(&boot_cpu_data)
 #define TLB_IS_GLOBAL(x)	((x).tlb_lo[0] & (x).tlb_lo[1] & ENTRYLO_G)
 #define TLB_VPN2(x)		((x).tlb_hi & VPN2_MASK)
 #define TLB_ASID(x)		((x).tlb_hi & KVM_ENTRYHI_ASID)
-- 
2.7.0


