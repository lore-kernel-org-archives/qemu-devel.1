Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01E0C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:15:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE4AB2072B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCRZDY7v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE4AB2072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihYEh-00065S-1g
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 07:15:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47200)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY2z-0006F3-Tg
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY2x-0000Ot-WB
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:21 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:50297)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ihY2x-0000LV-Lu
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:19 -0500
Received: by mail-wm1-x334.google.com with SMTP id a5so1561974wmb.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 04:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=68N7S2GMWXB6Wxfq+Q7vQW0ttC/7iAxjGXgUq3dx0c4=;
 b=eCRZDY7v49kCODUceKl1GPUf1+RP/6J6WZUaJEEklcJn2DbVAbNCaZXxptQVY/7Irb
 +jvtGwbV3MJmCWJ4oOV/krEmr+zcuCH9fhn/XulNT9TiMGnTDrZ+Xa8dEV58AHsUfR/T
 ErQ867xmBJf0h2yNWXoqVJ+tpTSgW0SRGnld+u13qZoWFlCTLEd1HtWBcqZbG26yAlYp
 bXDOGPNQ0VCLlwYNi2XM+3utmaCX/ubOfH4L2pcpAOryHVwxvJamMY6fH1oJQMgJJrdo
 fVlWc7iwV61GKTSZVG40IrWAG9hpO5LVszVsDBO+I9k/iQQtNgEz75+4E3WYYMnwaUIz
 576A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=68N7S2GMWXB6Wxfq+Q7vQW0ttC/7iAxjGXgUq3dx0c4=;
 b=tsdv7BzmBUOsXiyQ9Aa/vC05h/DtD4SxXquELx6QQR2cDdLlbrAS+CYV1bddzcd25f
 Q1yiSqbYO7145XMJQkh6qc/sDa+wAkx1K+ve/AFH3GK/fFcuKv22nU5DiwWpapJXHWJv
 cLQlM3aGWVheBGJn4pCsGH0Qk+EW8emBnnN48e3NJ09LkMjU9Cwn6OwXJUXceA/VjBXO
 jqDjqIDBNUNUsZURVYjegLjm2kIjarrp2BVStvqAZnvVmKMM+cgppRwJlVC6SPTBQdws
 L8T4665vj7hn8+mAvXE+ZoHB+0n2q3p8xiDRIUqGOf8EcuVzPXE5NAGVztveuQ6s0IQ0
 nVfQ==
X-Gm-Message-State: APjAAAWk7sURdp/pL6XhVNkRQtzEsYDrsGGQMDTdMERYaphR4W1S4JOi
 7Fj31/JvIz4sbrl30rmvLEXOwhgw
X-Google-Smtp-Source: APXvYqyDnMvO7HM8FOEYLEr8FM/K6w2OOgaCFbU4gpF+fu6RoIf3cFEZl+oq4bIL7bn/JF8qn6eOwg==
X-Received: by 2002:a7b:c936:: with SMTP id h22mr2723031wml.115.1576670598269; 
 Wed, 18 Dec 2019 04:03:18 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n67sm2236838wmf.46.2019.12.18.04.03.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Dec 2019 04:03:17 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 23/87] accel: pass object to accel_init_machine
Date: Wed, 18 Dec 2019 13:01:49 +0100
Message-Id: <1576670573-48048-24-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
References: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::334
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

We will have to set QOM properties before accel_init_machine, based on the
options provided to -accel.  Construct the object outside it so that it
will be possible to iterate on properties between object_new_with_class
and accel_init_machine.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/accel.c          | 4 ++--
 include/sysemu/accel.h | 2 +-
 vl.c                   | 4 +++-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/accel/accel.c b/accel/accel.c
index dd38a46..1c5c3a6 100644
--- a/accel/accel.c
+++ b/accel/accel.c
@@ -46,9 +46,9 @@ AccelClass *accel_find(const char *opt_name)
     return ac;
 }
 
-int accel_init_machine(AccelClass *acc, MachineState *ms)
+int accel_init_machine(AccelState *accel, MachineState *ms)
 {
-    AccelState *accel = ACCEL(object_new_with_class(OBJECT_CLASS(acc)));
+    AccelClass *acc = ACCEL_GET_CLASS(accel);
     int ret;
     ms->accelerator = accel;
     *(acc->allowed) = true;
diff --git a/include/sysemu/accel.h b/include/sysemu/accel.h
index 90b6213..22cac0f 100644
--- a/include/sysemu/accel.h
+++ b/include/sysemu/accel.h
@@ -67,7 +67,7 @@ typedef struct AccelClass {
 extern unsigned long tcg_tb_size;
 
 AccelClass *accel_find(const char *opt_name);
-int accel_init_machine(AccelClass *acc, MachineState *ms);
+int accel_init_machine(AccelState *accel, MachineState *ms);
 
 /* Called just before os_setup_post (ie just before drop OS privs) */
 void accel_setup_post(MachineState *ms);
diff --git a/vl.c b/vl.c
index 65e6b75..b2f00cc 100644
--- a/vl.c
+++ b/vl.c
@@ -2716,6 +2716,7 @@ static int do_configure_accelerator(void *opaque, QemuOpts *opts, Error **errp)
     bool *p_init_failed = opaque;
     const char *acc = qemu_opt_get(opts, "accel");
     AccelClass *ac = accel_find(acc);
+    AccelState *accel;
     int ret;
 
     if (!ac) {
@@ -2723,7 +2724,8 @@ static int do_configure_accelerator(void *opaque, QemuOpts *opts, Error **errp)
         error_report("invalid accelerator %s", acc);
         return 0;
     }
-    ret = accel_init_machine(ac, current_machine);
+    accel = ACCEL(object_new_with_class(OBJECT_CLASS(ac)));
+    ret = accel_init_machine(accel, current_machine);
     if (ret < 0) {
         *p_init_failed = true;
         error_report("failed to initialize %s: %s",
-- 
1.8.3.1



