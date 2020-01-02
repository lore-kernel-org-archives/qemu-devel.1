Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48F4C2D0C2
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 20:40:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86FE2217F4
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 20:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GNRbQAtd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86FE2217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1in7H6-0006sv-Mi
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 15:40:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60700)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vkuznets@redhat.com>) id 1in7Fo-0006Mk-O5
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 15:39:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vkuznets@redhat.com>) id 1in7Fl-0005h0-JH
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 15:39:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49931
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1in7Fl-0005e2-90
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 15:39:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577997572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=HrfCK1QPyPXAIrlAxt77MiVzXUuynRW1i8LBbOji5no=;
 b=GNRbQAtda4q2gBNL6BoosMIlMqAgFHHjuS5H415AWZ5jwQ8zc/IOwGZQO8CcMhN4KUa6vt
 Ls8IVZ+i2feewl2273eJ8nWG4EAR4wUpzKv65KcCPCbvEqHa86a/vnaHlUB+VjJzQeP3Ss
 EKCQXKv9060Cdwi49dYXlTrC39yC/V4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-djk5YzoWOzqtxbhGNC09Cw-1; Thu, 02 Jan 2020 15:39:30 -0500
Received: by mail-wr1-f69.google.com with SMTP id c6so12749913wrm.18
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2020 12:39:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HdJ1z9wb24OxKxH741pTHVVs3e2Xgo9DyszdOYCOlyo=;
 b=K+piVlalJwJNuPkJRifcGkBtE/cNJYaPCBH3592QL/+XDhfeN5glHNf88qHzHm8MyF
 SQqYdenUm0eCDBKxzjnPUyLI4vBpemWzwzpFarLuFIFs7ggT+7Rjlw6NfW2B7hNfwOcu
 ZRssbO4DUOfz9OkgK0IF35H0sA7Fn6IJQlorEZ3Hwh2rLtWMddpYDzZImPPtNEp7J7pQ
 A5IEXAIfxm4mKUitwjH9Xgx3wnBLzG1j9g/5VHzOKGB3y7KX2UKSAYj/mid1X/VFeU4s
 fpeDPg+HuQ0qYJPzcwmAnz/Hp874E9+no4foHaBqQvq1os7jHLyLIryWTMhTFFDjZyja
 ADZA==
X-Gm-Message-State: APjAAAUymYS8asxGp2ivDXoxbbVqVzBeL1oCW0ggNUzygUks3X21if82
 zFHlIgfislXwc4GDuemU/Q24gLXvt0ODDTYM+s8PzPm/F+/EEgMsTGeXkXCN8gDgrCo7R8yy8Qw
 nXvxWCtrHheZLQn8=
X-Received: by 2002:a5d:4cc9:: with SMTP id c9mr81477915wrt.70.1577997569231; 
 Thu, 02 Jan 2020 12:39:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqyKj7PdPPD5LxuFeEUvtTY5IfJhSndNgG/MIRQjIIti+HwO7vatVxeDrEziHtdrHvDJQVkATQ==
X-Received: by 2002:a5d:4cc9:: with SMTP id c9mr81477900wrt.70.1577997568998; 
 Thu, 02 Jan 2020 12:39:28 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
 by smtp.gmail.com with ESMTPSA id r15sm9521172wmh.21.2020.01.02.12.39.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2020 12:39:28 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC] i386/kvm: fix enlightened VMCS with fine-grained VMX
 feature enablement
Date: Thu,  2 Jan 2020 21:39:26 +0100
Message-Id: <20200102203926.1179743-1-vkuznets@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-MC-Unique: djk5YzoWOzqtxbhGNC09Cw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Liran Alon <liran.alon@oracle.com>,
 Roman Kagan <rkagan@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When enlightened VMCS is enabled, certain VMX controls disappear, e.g.
posted interrupts for PINBASED_CTLS. With fine-grained VMX feature
enablement QEMU tries to do KVM_SET_MSRS with default (matching CPU
model) values and fails as KVM doesn't allow to set now-unsupported
controls.

The ideal solution for the issue would probably be to re-read VMX
feature MSRs after enabling KVM_CAP_HYPERV_ENLIGHTENED_VMCS, however,
this doesn't seem to be possible: currently, KVM returns global
&vmcs_config.nested values for VMX MSRs when userspace does KVM_GET_MSR.

It is also possible to modify KVM to apply 'evmcs filtering' to VMX
MSRs when userspace tries to set them and hide the issue but this doesn't
seem to be entirely correct.

It is unfortunate that we now need to support the list of VMX features
disabled by enlightened VMCS in QEMU. When (and if) enlightened VMCS v2
arrives we'll need to fix QEMU and allow previously disabled features.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
- I don't quite like this workaround myself, thus RFC. I'm sure someone
 will suggest a better alternative.
---
 target/i386/kvm.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 0b511906e3fe..1b0589b79358 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1198,6 +1198,30 @@ static int hyperv_handle_properties(CPUState *cs,
         }
=20
         if (!r) {
+            /*
+             * Certain VMX controls are unsupported when enlightened VMCS =
is
+             * enabled, filter them out here so we don't attempt to set th=
em
+             * with KVM_SET_MSR even if they are supported by CPU model.
+             * The list below is for eVMCS version 1.
+             */
+            env->features[FEAT_VMX_PINBASED_CTLS] &=3D
+                ~(VMX_PIN_BASED_VMX_PREEMPTION_TIMER |
+                  VMX_PIN_BASED_POSTED_INTR);
+            env->features[FEAT_VMX_SECONDARY_CTLS] &=3D
+                ~(VMX_SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY |
+                  VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
+                  VMX_SECONDARY_EXEC_APIC_REGISTER_VIRT |
+                  VMX_SECONDARY_EXEC_ENABLE_PML |
+                  VMX_SECONDARY_EXEC_ENABLE_VMFUNC |
+                  VMX_SECONDARY_EXEC_SHADOW_VMCS |
+                  /* VMX_SECONDARY_EXEC_TSC_SCALING | */
+                  VMX_SECONDARY_EXEC_PAUSE_LOOP_EXITING);
+            env->features[FEAT_VMX_ENTRY_CTLS] &=3D
+                ~VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL;
+            env->features[FEAT_VMX_EXIT_CTLS] &=3D
+                ~VMX_VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL;
+            env->features[FEAT_VMX_VMFUNC] &=3D ~MSR_VMX_VMFUNC_EPT_SWITCH=
ING;
+
             env->features[FEAT_HV_RECOMM_EAX] |=3D
                 HV_ENLIGHTENED_VMCS_RECOMMENDED;
             env->features[FEAT_HV_NESTED_EAX] =3D evmcs_version;
--=20
2.24.1


