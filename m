Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A08C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 07:41:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E1A620873
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 07:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M08Tkbow"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E1A620873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46700 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM6LC-0006Dh-N4
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 03:41:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM69W-0004P3-HM
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:29:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM69R-0002TF-N9
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:29:09 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39151)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hM69M-0000mD-3M
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:29:04 -0400
Received: by mail-wr1-x442.google.com with SMTP id a9so1794635wrp.6
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 00:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=Fq+y9Y8taPmtsyd8oOc7f9ZWDD3UWEkWOvqVLG/Lt40=;
	b=M08TkbowMNzKjXu92BROOswqomQg3jQWqbVYbvAvdoHrrKtXdFl0obLqqWyvJP5OoB
	4qYoQbNTUN45z7e+KP8IfqAz+DGywmg8d4hv7q5VJKvRX2JuqaO0wzup4JpCT0v3nkfc
	rPgkEJH8qIea0F4daMLm9VRGLnJUF14vt7L3kPjG6ayI2+Q0mjpy5t0JL9HL60lcI4DC
	0SmC0hLkAu7M0KFJcO2i51kJfZ6TsQh6rPf2P2TYpKDSMM1B3e4a4SABc9+DW5oSGWt6
	hPELVUb69eZoAt0me0SvboRVXu1DsOdBuSsG3mc5st3d6ASLGCuHlg7+A33S2nFyjYne
	YOwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=Fq+y9Y8taPmtsyd8oOc7f9ZWDD3UWEkWOvqVLG/Lt40=;
	b=AfNj4UUvkU29WHNyft/tg7g8ug7J1gEGX4z0Yx0RtqMb5s5feJqVvVBot3JZbgWqbl
	RFtKQM4Ue6TP4wtncjS8cMcuD5dqGvgmW08lahORqGz+Led50Q2AbV5ThW6Xt+XXi8Yr
	z//TUllDKOxRKnzwMJtn88mXk6LOeeVCZVp50wQQdT0hwOndo8Nrv7m49ZXrBGgid4ae
	pmy5fjdLh90VVfpUzoZDUn413jcGqlnyXLFBLp3aSXzjZbw8MUdSaqB5uMkQIlqykS2M
	vxVPc+Zz3CkDg/lREeObsgP90eptaLuLuOmnZR74FOnymL+WUgc6bIh1rcM3TrvKT/UL
	5uyA==
X-Gm-Message-State: APjAAAXpPrOeH1K0Wqu7S7lN7LLpmOocIWjq4n8kw3pcY/qDsh75R5Br
	3VM8e+4y1up2VzwRodsYmBBfvRkc
X-Google-Smtp-Source: APXvYqwQo9wX6s6DwDn0wXKvrFc9LVj12oKft45CJXj997Yt16iABIyk2dEv1BrFAhOzR5Q0jDusIA==
X-Received: by 2002:a05:6000:45:: with SMTP id
	k5mr1575120wrx.261.1556782056515; 
	Thu, 02 May 2019 00:27:36 -0700 (PDT)
Received: from localhost.localdomain ([176.230.64.186])
	by smtp.gmail.com with ESMTPSA id z5sm8769289wre.70.2019.05.02.00.27.34
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 00:27:35 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu,  2 May 2019 10:26:39 +0300
Message-Id: <20190502072641.4667-26-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502072641.4667-1-arilou@gmail.com>
References: <20190502072641.4667-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH v8 25/27] kvm: Add API to read/write a CPU MSR
 value
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
Cc: liran.alon@oracle.com, alex.bennee@linaro.org, Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190502072639.GcQmFuM7YXTYqAcSOCamy-Z7o6Pd9PjId7cFNEAPN0M@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 accel/kvm/kvm-all.c  | 39 +++++++++++++++++++++++++++++++++++++++
 include/sysemu/kvm.h |  2 ++
 2 files changed, 41 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 524c4ddfbd..35207d910b 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2444,6 +2444,45 @@ void kvm_remove_all_breakpoints(CPUState *cpu)
 }
 #endif /* !KVM_CAP_SET_GUEST_DEBUG */
 
+int kvm_arch_read_msr(CPUState *cpu, uint32_t index, uint64_t *value)
+{
+    struct {
+        struct kvm_msrs info;
+        struct kvm_msr_entry entries[1];
+    } msr_data;
+    int ret;
+
+    msr_data.info.nmsrs = 1;
+    msr_data.entries[0].index = index;
+    ret = kvm_vcpu_ioctl(cpu, KVM_GET_MSRS, &msr_data);
+    if (ret < 0) {
+        return ret;
+    }
+
+    *value = msr_data.entries[0].data;
+    return 0;
+}
+
+int kvm_arch_write_msr(CPUState *cpu, uint32_t index, uint64_t value)
+{
+    struct {
+        struct kvm_msrs info;
+        struct kvm_msr_entry entries[1];
+    } msr_data;
+    int ret;
+
+    msr_data.info.nmsrs = 1;
+    msr_data.entries[0].index = index;
+    msr_data.entries[0].reserved = 0;
+    msr_data.entries[0].data = value;
+    ret = kvm_vcpu_ioctl(cpu, KVM_SET_MSRS, &msr_data);
+    if (ret < 0) {
+        return ret;
+    }
+
+    return 0;
+}
+
 static int kvm_set_signal_mask(CPUState *cpu, const sigset_t *sigset)
 {
     KVMState *s = kvm_state;
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index a6d1cd190f..409b1a5444 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -462,6 +462,8 @@ int kvm_vm_check_extension(KVMState *s, unsigned int extension);
 uint32_t kvm_arch_get_supported_cpuid(KVMState *env, uint32_t function,
                                       uint32_t index, int reg);
 uint32_t kvm_arch_get_supported_msr_feature(KVMState *s, uint32_t index);
+int kvm_arch_read_msr(CPUState *cpu, uint32_t index, uint64_t *value);
+int kvm_arch_write_msr(CPUState *cpu, uint32_t index, uint64_t value);
 
 
 void kvm_set_sigmask_len(KVMState *s, unsigned int sigmask_len);
-- 
2.20.1


