Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA13C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 06:18:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19F8720863
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 06:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAILzZqN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19F8720863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47154 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSy6q-0003FO-Tf
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 02:18:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kernellwp@gmail.com>) id 1hSy5y-0002vY-GN
	for qemu-devel@nongnu.org; Tue, 21 May 2019 02:17:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kernellwp@gmail.com>) id 1hSy5x-00013a-HV
	for qemu-devel@nongnu.org; Tue, 21 May 2019 02:17:54 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:44550)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kernellwp@gmail.com>) id 1hSy5x-00012l-BX
	for qemu-devel@nongnu.org; Tue, 21 May 2019 02:17:53 -0400
Received: by mail-pf1-x443.google.com with SMTP id g9so8477506pfo.11
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 23:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=J0uuieNJWIEqFucVVL6HHob/1V+xJ9X3pNwzM9VDJZ0=;
	b=iAILzZqNIPswUqlH8JOZ7+vNDvmfXLVoXJIxX2pMr6K+W+bYWxejR2GHSWRq5E47A9
	+VOfS8YbrQHfhFr7ihHe+UDBs8GsWPVm81gOqbikTXUXTinXaK5hYC9uAXP7euPrkAfO
	W3z6pM1PlpsNwjc9CsNyroG7N/i0J/9W/pNuTtwQQA+p2+FPHbalQl4hDooMHBBpiEN5
	2kicJrYTxu1HzkN0+pbwtNM4BG2RgcgDdPdSPEQ4ZAXh+ARZzdnmstNsaTbUrM8BeTh3
	EawOZc3DzJIcULJcNysgL7W1kitDu+KytOK29j4bZlaQ3PjMG64tGQ/8f/P6Cc5JOZOR
	NJ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=J0uuieNJWIEqFucVVL6HHob/1V+xJ9X3pNwzM9VDJZ0=;
	b=EY6A81G1lEKnywancFNMjwdEl8mvpQdL5yb9+HWavO5GgM7W0XG9/SYF+c1nO0tJx2
	YGqhhSiBrfMEY3Rdo19rmFajD7H1glfF0mR7S0M3YqbGQm75E/v/YSfuK7bMKvxof1B2
	Qq/PEoRSYrukUkxMVk4iKOb4Q1tkHMNxvl7HYfECa3LaA/cTyU+JkJjjWxDOJP075GlL
	4MT6f0wxOUfQD33kP8Z+hgCRahU8RpyFRuiEEKMtBxvtnEsemMzNp4fp2CfMVB1IyvIB
	C86EJHs+wsOSBSSX5bGnmWDNo18lcO+QPFZ5kKkaL6KjZlwZTNpNiZkuf1o1LqL2WVel
	Zz3Q==
X-Gm-Message-State: APjAAAX+WF5JWBBwC3B1nwRxQGDm/HLvqf18PSwYd1A0i9AoHHkpxgam
	YBRtIfBLCDQev+5+KCa5Wk1qrQCU
X-Google-Smtp-Source: APXvYqw2zFKfTVHfge7XSBqtWwR0RD497wZjCcT/BNKF+0TPFWkQe97zoVI6lF5pwDcUzRZL6LH/JQ==
X-Received: by 2002:a63:1460:: with SMTP id 32mr80416982pgu.319.1558419471484; 
	Mon, 20 May 2019 23:17:51 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.123])
	by smtp.googlemail.com with ESMTPSA id
	o66sm23112295pfb.184.2019.05.20.23.17.49
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 20 May 2019 23:17:51 -0700 (PDT)
From: Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To: qemu-devel@nongnu.org,
	kvm@vger.kernel.org
Date: Tue, 21 May 2019 14:17:47 +0800
Message-Id: <1558419467-7155-1-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH] kvm: support guest access CORE cstate
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wanpeng Li <wanpengli@tencent.com>

Allow guest reads CORE cstate when exposing host CPU power management capabilities 
to the guest. PKG cstate is restricted to avoid a guest to get the whole package 
information in multi-tenant scenario.

Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 linux-headers/linux/kvm.h | 4 +++-
 target/i386/kvm.c         | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index b53ee59..d648fde 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -696,9 +696,11 @@ struct kvm_ioeventfd {
 #define KVM_X86_DISABLE_EXITS_MWAIT          (1 << 0)
 #define KVM_X86_DISABLE_EXITS_HLT            (1 << 1)
 #define KVM_X86_DISABLE_EXITS_PAUSE          (1 << 2)
+#define KVM_X86_DISABLE_EXITS_CSTATE         (1 << 3)
 #define KVM_X86_DISABLE_VALID_EXITS          (KVM_X86_DISABLE_EXITS_MWAIT | \
                                               KVM_X86_DISABLE_EXITS_HLT | \
-                                              KVM_X86_DISABLE_EXITS_PAUSE)
+                                              KVM_X86_DISABLE_EXITS_PAUSE | \
+                                              KVM_X86_DISABLE_EXITS_CSTATE)
 
 /* for KVM_ENABLE_CAP */
 struct kvm_enable_cap {
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 3b29ce5..49a0cc1 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1645,7 +1645,8 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         if (disable_exits) {
             disable_exits &= (KVM_X86_DISABLE_EXITS_MWAIT |
                               KVM_X86_DISABLE_EXITS_HLT |
-                              KVM_X86_DISABLE_EXITS_PAUSE);
+                              KVM_X86_DISABLE_EXITS_PAUSE |
+                              KVM_X86_DISABLE_EXITS_CSTATE);
         }
 
         ret = kvm_vm_enable_cap(s, KVM_CAP_X86_DISABLE_EXITS, 0,
-- 
2.7.4


