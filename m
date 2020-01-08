Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDF4C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:34:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2518C206DB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uVAAq1O5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2518C206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipAXk-0005II-Rg
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 07:34:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60200)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipAWD-0003ZN-Uz
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipAWC-0004CF-JV
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:01 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:36677)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ipAWC-0004Bg-D1
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:00 -0500
Received: by mail-wm1-x32d.google.com with SMTP id p17so2323114wma.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 04:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Gy9btQ6/hiFDb+yxtplkQokqmOK4xY8N+OZWF2JIRzg=;
 b=uVAAq1O5zbSUP4gUAYETzx/Q1eW++7FFfF1E7r9RL4hvDqaLlY2ynJSlOhKZYCc+8e
 xLXzS8pQ5CNs8PecKzp7lCPVDS9DZ/LI745N6iXvw7/hkAMcr1Y8OlJ0lsvOEXc/5EFa
 3vyukwO+D5yy6ht18JdKVthcI/4f90oxMTXpnH5DSKUbOaaFx9O9/6R5blFbs+CyyCVe
 L7MsWdQIy5zvhUd0nDmWXd8xHMp6mNhDmtQpicYpW+ewoHCYbS3WbtX/EsMq1OXPIXcy
 0IawvP3TOjuNS7N/2zVBbSnPEzP70YcyRudNUC03wcNXPur94v8ARpI7lf6axZa+WfFQ
 MAkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=Gy9btQ6/hiFDb+yxtplkQokqmOK4xY8N+OZWF2JIRzg=;
 b=QRUq4WInDq1zCFrIBwoeC1GxbyTI/lcEdfYE7+iIYD2XPxJXkmdUTw1ol/kmZ4xt2b
 evt6uF7LYsIL1SQ0tqWV9cDKGf2mmI0SMZv2FwHo0VtDyzeYbshYbQOuba1C7sLuvQRP
 dGhuPEL61bYS3z+hd0vcOLz3BWSmarqAETq8FythYeZ84zN7zQKWO4gpX10cMp8rYjUy
 10BQ08mBsj+KT0jWIMlp5vFbFfRcobIm8JbeI0M3BWH/xUJA8StLZey6m04AntqhBDBK
 xhk+OJKZFzMHTlhLuoAPLHa77xF2Gv71bxZPffZRbx5FM/EFyoRAVWhoRVsPOIciiT4Q
 Xwaw==
X-Gm-Message-State: APjAAAUV5bAuYdvrGA6P7e6oqjUc7ET9uQDYYNKhwNz5mJh7nS/VUJKA
 hgFAQuvYayvOp5uLFX2L50rpS4eh
X-Google-Smtp-Source: APXvYqxnaRJGuAXC10yDrED+U3B6O/guHPlCxhLbplE72TC6qq7sGS2xCsVqacVfX6DoqVzL+PV0Ww==
X-Received: by 2002:a05:600c:22d3:: with SMTP id
 19mr3525935wmg.92.1578486779147; 
 Wed, 08 Jan 2020 04:32:59 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id o4sm4037750wrw.97.2020.01.08.04.32.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 08 Jan 2020 04:32:58 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/38] accel/kvm: Make "kernel_irqchip" default on
Date: Wed,  8 Jan 2020 13:32:19 +0100
Message-Id: <1578486775-52247-3-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1578486775-52247-1-git-send-email-pbonzini@redhat.com>
References: <1578486775-52247-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32d
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
Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Xiaoyao Li <xiaoyao.li@intel.com>

Commit 11bc4a13d1f4 ("kvm: convert "-machine kernel_irqchip" to an
accelerator property") moves kernel_irqchip property from "-machine" to
"-accel kvm", but it forgets to set the default value of
kernel_irqchip_allowed and kernel_irqchip_split.

Also cleaning up the three useless members (kernel_irqchip_allowed,
kernel_irqchip_required, kernel_irqchip_split) in struct MachineState.

Fixes: 11bc4a13d1f4 ("kvm: convert "-machine kernel_irqchip" to an accelerator property")
Reported-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Message-Id: <20191228104326.21732-1-xiaoyao.li@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c | 19 +++++++++++++------
 include/hw/boards.h |  3 ---
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index b2f1a5b..1ada2f4 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -98,7 +98,7 @@ struct KVMState
     int kvm_shadow_mem;
     bool kernel_irqchip_allowed;
     bool kernel_irqchip_required;
-    bool kernel_irqchip_split;
+    OnOffAuto kernel_irqchip_split;
     bool sync_mmu;
     bool manual_dirty_log_protect;
     /* The man page (and posix) say ioctl numbers are signed int, but
@@ -1783,6 +1783,7 @@ static void kvm_irqchip_create(KVMState *s)
 {
     int ret;
 
+    assert(s->kernel_irqchip_split != ON_OFF_AUTO_AUTO);
     if (kvm_check_extension(s, KVM_CAP_IRQCHIP)) {
         ;
     } else if (kvm_check_extension(s, KVM_CAP_S390_IRQCHIP)) {
@@ -1799,7 +1800,7 @@ static void kvm_irqchip_create(KVMState *s)
      * in-kernel irqchip for us */
     ret = kvm_arch_irqchip_create(s);
     if (ret == 0) {
-        if (s->kernel_irqchip_split) {
+        if (s->kernel_irqchip_split == ON_OFF_AUTO_ON) {
             perror("Split IRQ chip mode not supported.");
             exit(1);
         } else {
@@ -2070,6 +2071,10 @@ static int kvm_init(MachineState *ms)
         goto err;
     }
 
+    if (s->kernel_irqchip_split == ON_OFF_AUTO_AUTO) {
+        s->kernel_irqchip_split = mc->default_kernel_irqchip_split ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
+    }
+
     if (s->kernel_irqchip_allowed) {
         kvm_irqchip_create(s);
     }
@@ -3005,17 +3010,17 @@ static void kvm_set_kernel_irqchip(Object *obj, Visitor *v,
         case ON_OFF_SPLIT_ON:
             s->kernel_irqchip_allowed = true;
             s->kernel_irqchip_required = true;
-            s->kernel_irqchip_split = false;
+            s->kernel_irqchip_split = ON_OFF_AUTO_OFF;
             break;
         case ON_OFF_SPLIT_OFF:
             s->kernel_irqchip_allowed = false;
             s->kernel_irqchip_required = false;
-            s->kernel_irqchip_split = false;
+            s->kernel_irqchip_split = ON_OFF_AUTO_OFF;
             break;
         case ON_OFF_SPLIT_SPLIT:
             s->kernel_irqchip_allowed = true;
             s->kernel_irqchip_required = true;
-            s->kernel_irqchip_split = true;
+            s->kernel_irqchip_split = ON_OFF_AUTO_ON;
             break;
         default:
             /* The value was checked in visit_type_OnOffSplit() above. If
@@ -3038,7 +3043,7 @@ bool kvm_kernel_irqchip_required(void)
 
 bool kvm_kernel_irqchip_split(void)
 {
-    return kvm_state->kernel_irqchip_split;
+    return kvm_state->kernel_irqchip_split == ON_OFF_AUTO_ON;
 }
 
 static void kvm_accel_instance_init(Object *obj)
@@ -3046,6 +3051,8 @@ static void kvm_accel_instance_init(Object *obj)
     KVMState *s = KVM_STATE(obj);
 
     s->kvm_shadow_mem = -1;
+    s->kernel_irqchip_allowed = true;
+    s->kernel_irqchip_split = ON_OFF_AUTO_AUTO;
 }
 
 static void kvm_accel_class_init(ObjectClass *oc, void *data)
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 61f8bb8..fb1b43d 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -271,9 +271,6 @@ struct MachineState {
 
     /*< public >*/
 
-    bool kernel_irqchip_allowed;
-    bool kernel_irqchip_required;
-    bool kernel_irqchip_split;
     char *dtb;
     char *dumpdtb;
     int phandle_start;
-- 
1.8.3.1



