Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E62C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:15:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CABEE20854
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cRVbvWRz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CABEE20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK2zl-0001GR-7g
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 12:14:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36595)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2pU-0003JA-BD
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2pT-0006ns-5O
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:16 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46859)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK2pS-0006mq-QL
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:15 -0400
Received: by mail-wr1-x443.google.com with SMTP id o18so20326772wrv.13
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=mUu/crkcybfRwlc27TBLyKHlAqm7Yf19HYM5Zi4VawI=;
 b=cRVbvWRzpP/t9q006tIEyolsGUNF2FY1DqySFPOGmDnfrTco8kNvk7QUeTcd4WTTR1
 jpoZLILBUwa8xYzcPWAgsa3ElXYU8tc/TWzrecF/EKnf/nMw5nsB1koGJDtUfL2yMEmF
 hc1qhcVXIBujzThAr6CDO9fFGKpJ+M0If1o83Q+7mJrgms9NGBQf0KkZBV8jE4gJfZU1
 nhUkrfRBPG6JwILq5kWY9CgrBtGo9TKl1Vu/AXRJAkLOdTCq0a9EXQSrIlKF38tR62te
 yDgEIsgNgD1htANQsnhKMPxbq8DyYf+w/SS3Ef9gElZsZCeX93n9c5Sji5f/jGFD5THy
 uzZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mUu/crkcybfRwlc27TBLyKHlAqm7Yf19HYM5Zi4VawI=;
 b=pdZlbqLNHFmXHw7tLJQVM394NoEf2sqGPyarTCYJp3Ji17TlWwmxtmI0lOUfJ1y/ot
 PcRsjfF0lFAbKi4TrQ9tmE6XRd87dDTduD6GTok9AYg2+obNJcjnfxfvb4k5gjHMy4Td
 CuNi00BxM2/oyLDOE6wTencL6siHfFH1gHMiwV5XEjODPQ/Gkn5ODYkfhhBrimQx5vFl
 55OM7aECV79Xbb2dt9X3b3AIothsW21iD6TYKL4Md5p4spDgwOvA3cl0uAtNzEoYcXfc
 QuuD/D95oGf4oDUtzGQHpsoqymm21fsOt+VXUl0z7H/WJmLO5Me3zE55AfH4zYW3DXPk
 2uoQ==
X-Gm-Message-State: APjAAAXjXQ7Phnotm+wK2htocpCP4kHkWnQEiqiKLwcj9WEqv1NQmmg6
 t/aIif6N3NLE+SZuj6zewvkqcNcU3QLARA==
X-Google-Smtp-Source: APXvYqzTtWuwrQpkW5CHvUZ0baiGO5wUSdFoGL3DyrIJdXpQnuzj1YZc2uABKj5rrrxaB+ebZhVuZQ==
X-Received: by 2002:a05:6000:103:: with SMTP id
 o3mr2571323wrx.357.1571069053252; 
 Mon, 14 Oct 2019 09:04:13 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 5sm18029779wrk.86.2019.10.14.09.04.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 09:04:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/68] ARM: KVM: Check KVM_CAP_ARM_IRQ_LINE_LAYOUT_2 for
 smp_cpus > 256
Date: Mon, 14 Oct 2019 17:02:59 +0100
Message-Id: <20191014160404.19553-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014160404.19553-1-peter.maydell@linaro.org>
References: <20191014160404.19553-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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

From: Eric Auger <eric.auger@redhat.com>

Host kernel within [4.18, 5.3] report an erroneous KVM_MAX_VCPUS=512
for ARM. The actual capability to instantiate more than 256 vcpus
was fixed in 5.4 with the upgrade of the KVM_IRQ_LINE ABI to support
vcpu id encoded on 12 bits instead of 8 and a redistributor consuming
a single KVM IO device instead of 2.

So let's check this capability when attempting to use more than 256
vcpus within any ARM kvm accelerated machine.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Message-id: 20191003154640.22451-4-eric.auger@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index b10581fa066..b473c63edb1 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -182,6 +182,7 @@ int kvm_arm_get_max_vm_ipa_size(MachineState *ms)
 
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
+    int ret = 0;
     /* For ARM interrupt delivery is always asynchronous,
      * whether we are using an in-kernel VGIC or not.
      */
@@ -195,7 +196,14 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
 
     cap_has_mp_state = kvm_check_extension(s, KVM_CAP_MP_STATE);
 
-    return 0;
+    if (ms->smp.cpus > 256 &&
+        !kvm_check_extension(s, KVM_CAP_ARM_IRQ_LINE_LAYOUT_2)) {
+        error_report("Using more than 256 vcpus requires a host kernel "
+                     "with KVM_CAP_ARM_IRQ_LINE_LAYOUT_2");
+        ret = -EINVAL;
+    }
+
+    return ret;
 }
 
 unsigned long kvm_arch_vcpu_id(CPUState *cpu)
-- 
2.20.1


