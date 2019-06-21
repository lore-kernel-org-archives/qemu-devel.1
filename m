Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203C1C48BE1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 01:47:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0CDA2064B
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 01:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IyoNP/6p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0CDA2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54036 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1he8ea-00007J-4X
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 21:47:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40660)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1he8Za-0006Mz-JZ
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 21:42:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1he8ZY-00067U-Oz
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 21:42:38 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45207)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1he8ZY-00063B-FQ
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 21:42:36 -0400
Received: by mail-wr1-x441.google.com with SMTP id f9so4835735wre.12
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2019 18:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ke6hwa+fUFiQaqvIXIEK/11GyBhYea2HOMTU01E3LaM=;
 b=IyoNP/6ptTM8HBOKHvDS5lB1tDNwLGh+Ow/pn6lkL/mWEX/K6j6+ovwRE0re71Ynrb
 s9uJyuw12yY+x7wkVqiSoJm8n6V3UTYnH2BTzQbJEKK4KF4xTSWBaXz4OLiQubZrH6su
 Ire3KSXhHNE+bwTgpGc/ydy0q7yskieUglLJcWML0kQxsGDnykjrPIth3W2coptEqbjc
 P1WTyOMGh6TcxbhXBqNXgruMrYh6wdUyGlYiMyXMteWtLxehyeKgIlL2XU3eWGGFckeB
 OiB8CopisPr+OoORCYmGVjU2yVbP10Z6C0vrcmnJsl6RHQPutq3YJKT+ctrAjiSS6mpc
 hPzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=ke6hwa+fUFiQaqvIXIEK/11GyBhYea2HOMTU01E3LaM=;
 b=d5UdpuBmkDvElASDqMi9uE0nD7oWtDnYPFg6VnPnIck3TXSmX6VCAim2+X2ET5+QPC
 jvdFaQtFWGVuq7vPxNHgem8MHfYGfVojv/IPiC+wLxKIA7z5HXk2iSZ5E7NkNhXHE3HG
 U8mnhdr2yv8qE9MR0oAeSdmUhmiU0pRK3YhC3GsOJGw64JSbr9RmKAHIY8euh6zVBAzY
 vXyy8RfhkN/GbtLA9mgj4ySskunK2ndUk0QeYwCPoLfWfMa5lWPwMr9uSzMCoXE/1JAx
 war0Na6gzjDW+1tcFRToWlEhYp8t8oKmeswc6KV92fxWE3aw+BbBjSqzDTuXVke58A+E
 SZzQ==
X-Gm-Message-State: APjAAAX5eVqS11pBrD++4Ni7d3SDZV5BcFH5NonW8WYII8AhTtTvQlMc
 RpUNE+NKOurRyx94lxNO+5/Rfn7O
X-Google-Smtp-Source: APXvYqwj3CGIbRPyjSFg43SBAlvmqTPfKESTTiyduaqTX22hc2LKscQmzKt87ULbpVV6WNLW4JifBQ==
X-Received: by 2002:a5d:53ca:: with SMTP id a10mr31482978wrw.131.1561081353825; 
 Thu, 20 Jun 2019 18:42:33 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id d1sm1123125wru.41.2019.06.20.18.42.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Jun 2019 18:42:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 21 Jun 2019 03:42:07 +0200
Message-Id: <1561081350-3723-3-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1561081350-3723-1-git-send-email-pbonzini@redhat.com>
References: <1561081350-3723-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PULL 02/25] hax: Honor CPUState::halted
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
Cc: Colin Xu <colin.xu@intel.com>, Yu Ning <yu.ning@intel.com>,
 Chuanxiao Dong <chuanxiao.dong@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Colin Xu <colin.xu@intel.com>

QEMU tracks whether a vcpu is halted using CPUState::halted. E.g.,
after initialization or reset, halted is 0 for the BSP (vcpu 0)
and 1 for the APs (vcpu 1, 2, ...). A halted vcpu should not be
handed to the hypervisor to run (e.g. hax_vcpu_run()).

Under HAXM, Android Emulator sometimes boots into a "vcpu shutdown
request" error while executing in SeaBIOS, with the HAXM driver
logging a guest triple fault in vcpu 1, 2, ... at RIP 0x3. That is
ultimately because the HAX accelerator asks HAXM to run those APs
when they are still in the halted state.

Normally, the vcpu thread for an AP will start by looping in
qemu_wait_io_event(), until the BSP kicks it via a pair of IPIs
(INIT followed by SIPI). But because the HAX accelerator does not
honor cpu->halted, it allows the AP vcpu thread to proceed to
hax_vcpu_run() as soon as it receives any kick, even if the kick
does not come from the BSP. It turns out that emulator has a
worker thread which periodically kicks every vcpu thread (possibly
to collect CPU usage data), and if one of these kicks comes before
those by the BSP, the AP will start execution from the wrong RIP,
resulting in the aforementioned SMP boot failure.

The solution is inspired by the KVM accelerator (credit to
Chuanxiao Dong <chuanxiao.dong@intel.com> for the pointer):

1. Get rid of questionable logic that unconditionally resets
   cpu->halted before hax_vcpu_run(). Instead, only reset it at the
   right moments (there are only a few "unhalt" events).
2. Add a check for cpu->halted before hax_vcpu_run().

Note that although the non-Unrestricted Guest (!ug_platform) code
path also forcibly resets cpu->halted, it is left untouched,
because only the UG code path supports SMP guests.

The patch is first merged to android emulator with Change-Id:
I9c5752cc737fd305d7eace1768ea12a07309d716

Cc: Yu Ning <yu.ning@intel.com>
Cc: Chuanxiao Dong <chuanxiao.dong@intel.com>
Signed-off-by: Colin Xu <colin.xu@intel.com>
Message-Id: <20190610021939.13669-1-colin.xu@intel.com>
---
 cpus.c                |  1 -
 target/i386/hax-all.c | 36 ++++++++++++++++++++++++++++++++++--
 2 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/cpus.c b/cpus.c
index dde3b7b..1af51b7 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1594,7 +1594,6 @@ static void *qemu_hax_cpu_thread_fn(void *arg)
 
     cpu->thread_id = qemu_get_thread_id();
     cpu->created = true;
-    cpu->halted = 0;
     current_cpu = cpu;
 
     hax_init_vcpu(cpu);
diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
index 64fd51a..9e7b779 100644
--- a/target/i386/hax-all.c
+++ b/target/i386/hax-all.c
@@ -471,13 +471,35 @@ static int hax_vcpu_hax_exec(CPUArchState *env)
         return 0;
     }
 
-    cpu->halted = 0;
-
     if (cpu->interrupt_request & CPU_INTERRUPT_POLL) {
         cpu->interrupt_request &= ~CPU_INTERRUPT_POLL;
         apic_poll_irq(x86_cpu->apic_state);
     }
 
+    /* After a vcpu is halted (either because it is an AP and has just been
+     * reset, or because it has executed the HLT instruction), it will not be
+     * run (hax_vcpu_run()) until it is unhalted. The next few if blocks check
+     * for events that may change the halted state of this vcpu:
+     *  a) Maskable interrupt, when RFLAGS.IF is 1;
+     *     Note: env->eflags may not reflect the current RFLAGS state, because
+     *           it is not updated after each hax_vcpu_run(). We cannot afford
+     *           to fail to recognize any unhalt-by-maskable-interrupt event
+     *           (in which case the vcpu will halt forever), and yet we cannot
+     *           afford the overhead of hax_vcpu_sync_state(). The current
+     *           solution is to err on the side of caution and have the HLT
+     *           handler (see case HAX_EXIT_HLT below) unconditionally set the
+     *           IF_MASK bit in env->eflags, which, in effect, disables the
+     *           RFLAGS.IF check.
+     *  b) NMI;
+     *  c) INIT signal;
+     *  d) SIPI signal.
+     */
+    if (((cpu->interrupt_request & CPU_INTERRUPT_HARD) &&
+         (env->eflags & IF_MASK)) ||
+        (cpu->interrupt_request & CPU_INTERRUPT_NMI)) {
+        cpu->halted = 0;
+    }
+
     if (cpu->interrupt_request & CPU_INTERRUPT_INIT) {
         DPRINTF("\nhax_vcpu_hax_exec: handling INIT for %d\n",
                 cpu->cpu_index);
@@ -493,6 +515,16 @@ static int hax_vcpu_hax_exec(CPUArchState *env)
         hax_vcpu_sync_state(env, 1);
     }
 
+    if (cpu->halted) {
+        /* If this vcpu is halted, we must not ask HAXM to run it. Instead, we
+         * break out of hax_smp_cpu_exec() as if this vcpu had executed HLT.
+         * That way, this vcpu thread will be trapped in qemu_wait_io_event(),
+         * until the vcpu is unhalted.
+         */
+        cpu->exception_index = EXCP_HLT;
+        return 0;
+    }
+
     do {
         int hax_ret;
 
-- 
1.8.3.1



