Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20607C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 02:10:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0B2D20652
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 02:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epvkVwzN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0B2D20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54156 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1he90I-0000Eh-52
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 22:10:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41258)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1he8a6-0006e7-2x
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 21:43:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1he8a3-0006el-8O
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 21:43:09 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:38435)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1he8a2-0006L3-O2
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 21:43:06 -0400
Received: by mail-wm1-x335.google.com with SMTP id s15so4890394wmj.3
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2019 18:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=HWP1ufHEPv6v1c0xa0Nf5LyDIweD+0VGMlRLkFfhXBk=;
 b=epvkVwzNHao0+h5TuSqE8dKInBhPJV2vf+3ns4HkLHF+IsSKhDjLWZrDCZzKGopEc6
 mlzSVS5gCx62gcPUsFiEIJ0w16aVhG4QfCu2Do7QgY5XoALhufZWdsxnFSqp1d+wN1oA
 Q2St/IXhO1mrk81N1ABSFuscTrd7AHiaRDkXJA12d88uBf7cTxUDy7jDQuNpPAL99B7S
 zz1EFft+HK8SCQpE9srKyk2R9bDDI3c+zUprq4Y8arPUsqqNlKs2zrDyQxWr/5Hw4JrA
 ORQwlwf40ZLcJ/s/5yoyFQPabttTUb8eRgk52F7TA7WF6sXD74VMnS1IHpZXd340nhym
 6UEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=HWP1ufHEPv6v1c0xa0Nf5LyDIweD+0VGMlRLkFfhXBk=;
 b=iAykJ9TNmJv+AtUtpbtjduIxcEBUE7VPcrVwI2jdJKtTQZXxPTOn9YpMX5Ynk0tgS6
 +aJYf7AtJozod/fxrev4KZEFATAm952fptVtIbuRDj1nieNf3Q5ELj8XHeYZIzchEnD+
 Phhv4anetX5PH/yNnB2MnQv5rkVynIp9u5gsRw4GW5/HtsGoOMJ0Oov75RVSb6bNMZ+J
 JrF1GTQO+3WCVLIAhXCZCQqcH6bVENw5aeTLX+srqJNHfX75DhIdOpkkncg3F7gkg4Ig
 YZ9hAGinX/ghxkHbaQ4DgD7EtfdKP1jV1UV8dDPyRwsj0mz2qL8kI9Hk80tSDg6gohEy
 HAyA==
X-Gm-Message-State: APjAAAVPmy3WmAOKWSkdvipGrKIjFE0eiMk6E2gDIvnzo6YIDnRZ6ttL
 wN+TdYcYemwHDp0iJ9fLGxZuI6L1
X-Google-Smtp-Source: APXvYqxBaLgkxh39ik+M/tc0A0xbClld3Y2XXJ/9vr2tTEd8EQSE1LOF/HOPFX1m1kfWAfd9TWGBzQ==
X-Received: by 2002:a1c:a842:: with SMTP id r63mr1500107wme.117.1561081368051; 
 Thu, 20 Jun 2019 18:42:48 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id d1sm1123125wru.41.2019.06.20.18.42.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Jun 2019 18:42:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 21 Jun 2019 03:42:20 +0200
Message-Id: <1561081350-3723-16-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1561081350-3723-1-git-send-email-pbonzini@redhat.com>
References: <1561081350-3723-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
Subject: [Qemu-devel] [PULL 15/25] target/i386: kvm: Use symbolic constant
 for #DB/#BP exception constants
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
Cc: Liran Alon <liran.alon@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Liran Alon <liran.alon@oracle.com>

Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
Reviewed-by: Krish Sadhukhan <krish.sadhukhan@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
Message-Id: <20190619162140.133674-4-liran.alon@oracle.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 26d8c61..c763643 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -3345,9 +3345,9 @@ static int kvm_guest_debug_workarounds(X86CPU *cpu)
     unsigned long reinject_trap = 0;
 
     if (!kvm_has_vcpu_events()) {
-        if (env->exception_injected == 1) {
+        if (env->exception_injected == EXCP01_DB) {
             reinject_trap = KVM_GUESTDBG_INJECT_DB;
-        } else if (env->exception_injected == 3) {
+        } else if (env->exception_injected == EXCP03_INT3) {
             reinject_trap = KVM_GUESTDBG_INJECT_BP;
         }
         env->exception_injected = -1;
@@ -3859,8 +3859,8 @@ static int kvm_handle_debug(X86CPU *cpu,
     int ret = 0;
     int n;
 
-    if (arch_info->exception == 1) {
-        if (arch_info->dr6 & (1 << 14)) {
+    if (arch_info->exception == EXCP01_DB) {
+        if (arch_info->dr6 & DR6_BS) {
             if (cs->singlestep_enabled) {
                 ret = EXCP_DEBUG;
             }
-- 
1.8.3.1



