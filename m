Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C7AC0044D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 00:36:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4FC7206B1
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 00:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xddIzZal"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4FC7206B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCBpT-0004zb-Qt
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 20:36:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54247)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <beata.michalska@linaro.org>) id 1jCBoP-0003eB-Tt
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 20:34:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <beata.michalska@linaro.org>) id 1jCBoO-0002rV-JR
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 20:34:57 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53775)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <beata.michalska@linaro.org>)
 id 1jCBoO-0002pI-Dm
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 20:34:56 -0400
Received: by mail-wm1-x342.google.com with SMTP id 25so4215263wmk.3
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 17:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=rXYfzcBdKI5ubAvqSEIb2KdH42aC5HB1minn7mytn4g=;
 b=xddIzZalQNmm/l4Gy0NEAYwaXcrL17gpkIXF++rfjqb/ruGOmFVAKecoP++D7PRuvL
 cAvRDXQO9Xrg+CDrABN5YPbFnDe3rz3lOHwHiXznBXEiNJbIxoTlSZUAtfwd9vbA/TT9
 wsiobf57P7AdMTK4ZQkUA+KGjWxL248jgcjVX9ytdV37ENRv3shVAjaNextivR/QvmC6
 KttoeU/6CMZG+wP48unX91J7j3EH680Jo9GuHk8BPe8R0qfwZfvMl04M3Sqiz776AuQG
 ue83r06V738R0wgVtwy4xO3sXNK81O3SK3Y4okSHrYkmM3ky38at0vNHUE9hWxBitJKl
 0PGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=rXYfzcBdKI5ubAvqSEIb2KdH42aC5HB1minn7mytn4g=;
 b=cK8RH55f+t5gemuoekQavRnFDR9HcwgeV3j51vXGgkSYtll02wzQerDUtfiRKjkM59
 W7P3oG+aAsR73lnh0I4WiDU2ZQE3zeNYYdz3dBMEIUUYdCYUEMYN2DoJr/8iDTentzr7
 L7/cy+MtsiiXrY0VAKsVNJAi8Nv3uaU9P436RR9rUVXL5sDWH6G/Sn4sWeI1AooqTJ7i
 2b4tdvASG6Mw4LN6VcgCmd7I/hhuPGjZyYZPwUX6VUysvoZUP14yQC4OX2A+nJM7kaez
 dFNdPvWZxjBor8XU9Fvd/vwdAyrLXPHOjUZhGeXBY7PC2u+hNB9Yx2L8E7OKO1MsNO2P
 n7Ig==
X-Gm-Message-State: ANhLgQ2KnSdHxhWqIqtzEq8AcXq1FKxsKaDEjwCsGA+uyjWpX4guNmv6
 8iQ0TUaq/DMgs5f8w7cJE5UyWOZl2oc=
X-Google-Smtp-Source: ADFU+vuOAzDFJuWFD/k+vg7UekR3WmJcRhllQB3RzppJIXyq8+JOmDdDnFIoAxQkCYoPOsWO4dsmog==
X-Received: by 2002:a7b:c458:: with SMTP id l24mr1273688wmi.120.1583973295268; 
 Wed, 11 Mar 2020 17:34:55 -0700 (PDT)
Received: from moi-limbo-9350.home
 (host86-139-146-66.range86-139.btcentralplus.com. [86.139.146.66])
 by smtp.gmail.com with ESMTPSA id o5sm10909988wmb.8.2020.03.11.17.34.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2020 17:34:54 -0700 (PDT)
From: Beata Michalska <beata.michalska@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/2] target/arm: kvm: Inject events at the last stage of
 sync
Date: Thu, 12 Mar 2020 00:34:00 +0000
Message-Id: <20200312003401.29017-2-beata.michalska@linaro.org>
In-Reply-To: <20200312003401.29017-1-beata.michalska@linaro.org>
References: <20200312003401.29017-1-beata.michalska@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: peter.maydell@linaro.org, drjones@redhat.com, Christoffer.Dall@arm.com,
 qemu-arm@nongnu.org, pbonzini@redhat.com, kvmarm@lists.cs.columbia.edu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

KVM_SET_VCPU_EVENTS might actually lead to vcpu registers being modified.
As such this should be the last step of sync to avoid potential overwriting
of whatever changes KVM might have done.

Signed-off-by: Beata Michalska <beata.michalska@linaro.org>
---
 target/arm/kvm32.c | 15 ++++++++++-----
 target/arm/kvm64.c | 15 ++++++++++-----
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
index f703c4f..f271181 100644
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
index 93ba144..be5b31c 100644
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
2.7.4


