Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9874BC10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 17:05:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63138206F1
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 17:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SSy+c+wx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63138206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCRHN-0004w6-Fh
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 13:05:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35970)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jCQxw-000104-Ox
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jCQxt-0005Km-La
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:46 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:52340)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jCQxt-0005KU-Eq
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:45 -0400
Received: by mail-wm1-x32c.google.com with SMTP id 11so6848372wmo.2
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 09:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=vJ3ZeC2bpotYlmZBdGp1J0EoxT3McUTT78mDcwucmBE=;
 b=SSy+c+wxss2xwJUAOZM8mE8US+pFFEr7EIT0fDnXwmW1Ea+KD6NXjzfP2r0MaM4aky
 gGmnH0ZC7oM+NQhbsAF22IRH+kg3gj4kLz1FX0HnCAO+AYf3/DhakIuh3RPShiKDrOrf
 uEXD4ofLs0dFK9K7vbQvepcALp4JYUTQ5YQAzrRDAKDtxCsHMaQ7mYFZjxtdBCqbUIn7
 pcH3RH4zR/4wUqumqpLjykgUPgcClquhxEzU00L8Qo8BjzFb159UpX02+TgmiJal4zaV
 syIcUbyLLVVBQYqRzU5JXinNBjPn8pNiA4sunDEPX06DzjKD+tThwQonCm11k59R0QHc
 DMrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vJ3ZeC2bpotYlmZBdGp1J0EoxT3McUTT78mDcwucmBE=;
 b=Y0H9WdNYf6h9dbbNn2nKXe2D88KauAjgIAdbbHiiRj2j9MllcSSYHcmbv0UPnomfmv
 BxRSPCdkGCWtgSUlagh1fpJuRf5DU43srj3vmNZlvdyrWwva4WIjdUgePqKNNZk20476
 TB+mwe8mNt5BRymvIIRgkxPH7z+pBb6cc1UGmI9fEDlDcBYKAj9Cw13Dchgy1XsJMMSk
 u+5Zz4K1Va0+QUNNvKv3pwOzYip3anxSo5yStWP3SIIzxOi4Aa8Suug+1vhhQVjVGbMF
 D0Aq0c7KeiqRmSyxtIhV4i9BR25MRGIzApMhweOoRoFEzbwVBTGZEZRLfAzWmXUxJecs
 S3UQ==
X-Gm-Message-State: ANhLgQ2u2OaepKa3OkwbtResoDPPl1iTfw9skmb42gaeapwue3clw1VQ
 FfPfST1TyqaNGwy8mAgayFpMF8eqC6HJ3w==
X-Google-Smtp-Source: ADFU+vvRKsPrPFKd8kbcdW/U+9AHTl9nDJEbsTFOt/i+FNVHOg1Oi+ihwJnMUJZdCcEeMu1Cq4qYhQ==
X-Received: by 2002:a7b:c1cd:: with SMTP id a13mr5535735wmj.105.1584031544151; 
 Thu, 12 Mar 2020 09:45:44 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j15sm36838640wrp.85.2020.03.12.09.45.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 09:45:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 36/36] target/arm: kvm: Inject events at the last stage of sync
Date: Thu, 12 Mar 2020 16:44:59 +0000
Message-Id: <20200312164459.25924-37-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312164459.25924-1-peter.maydell@linaro.org>
References: <20200312164459.25924-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32c
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

From: Beata Michalska <beata.michalska@linaro.org>

KVM_SET_VCPU_EVENTS might actually lead to vcpu registers being modified.
As such this should be the last step of sync to avoid potential overwriting
of whatever changes KVM might have done.

Signed-off-by: Beata Michalska <beata.michalska@linaro.org>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Message-id: 20200312003401.29017-2-beata.michalska@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm32.c | 15 ++++++++++-----
 target/arm/kvm64.c | 15 ++++++++++-----
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
index f703c4fcad8..f271181ab8e 100644
--- a/target/arm/kvm32.c
+++ b/target/arm/kvm32.c
@@ -409,17 +409,22 @@ int kvm_arch_put_registers(CPUState *cs, int level)
         return ret;
     }
 
-    ret = kvm_put_vcpu_events(cpu);
-    if (ret) {
-        return ret;
-    }
-
     write_cpustate_to_list(cpu, true);
 
     if (!write_list_to_kvmstate(cpu, level)) {
         return EINVAL;
     }
 
+    /*
+     * Setting VCPU events should be triggered after syncing the registers
+     * to avoid overwriting potential changes made by KVM upon calling
+     * KVM_SET_VCPU_EVENTS ioctl
+     */
+    ret = kvm_put_vcpu_events(cpu);
+    if (ret) {
+        return ret;
+    }
+
     kvm_arm_sync_mpstate_to_kvm(cpu);
 
     return ret;
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 93ba1448daf..be5b31c2b0f 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -1094,17 +1094,22 @@ int kvm_arch_put_registers(CPUState *cs, int level)
         return ret;
     }
 
-    ret = kvm_put_vcpu_events(cpu);
-    if (ret) {
-        return ret;
-    }
-
     write_cpustate_to_list(cpu, true);
 
     if (!write_list_to_kvmstate(cpu, level)) {
         return -EINVAL;
     }
 
+   /*
+    * Setting VCPU events should be triggered after syncing the registers
+    * to avoid overwriting potential changes made by KVM upon calling
+    * KVM_SET_VCPU_EVENTS ioctl
+    */
+    ret = kvm_put_vcpu_events(cpu);
+    if (ret) {
+        return ret;
+    }
+
     kvm_arm_sync_mpstate_to_kvm(cpu);
 
     return ret;
-- 
2.20.1


