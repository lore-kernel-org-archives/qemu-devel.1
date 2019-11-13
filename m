Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D06BC17442
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 14:47:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E04A6222C9
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 14:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZgtqet8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E04A6222C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUtvZ-0007BG-Kr
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 09:47:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54555)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iUtni-0005ro-TV
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 09:39:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iUtnh-0006LM-Ll
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 09:39:18 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:53331)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iUtnh-0006L7-FL
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 09:39:17 -0500
Received: by mail-wm1-x32a.google.com with SMTP id u18so2263335wmc.3
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2019 06:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=pQu82Uaslki9sDRmDSEOZxkk8VrP+Tw6ygHKYigroK8=;
 b=PZgtqet8mzO3nGNaugWE73kPl8iRDG/esg7WFCgCdi76+ckXLd2MwTUO+7hDSG8iD/
 lDx+K1FrRpYVsogjZWbEg38ERtyNCLCJ1zs0vJlAB6WelSdT8Bcny8+poI0BuFaRCkjL
 fiL5GWsDL3vNYnMqmC7LqyPbBBy4g43iQVzVxjfRnTDFKKfckNecQTo92WfJQyhOpHaG
 YecI6AfJRDWVcgfeLW1UlmG8ib0KhcMki70ZXImTSbYlY6cKqNqEPRVlw2CJoT3P/nb/
 t2E/6UR5GdeOtJ6cGNAWOHqeKcJSvvofnGoU0fej5dSY33bZI1zyPuRAmw31+XdKwdyN
 1Obg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=pQu82Uaslki9sDRmDSEOZxkk8VrP+Tw6ygHKYigroK8=;
 b=ZlNzEw0IMeg5Bn/Om15uXrH6OxuMoyugeTev6gqPX/EwWZx1KASujXc8ugRRpmGzAP
 NLgwPeemvLd/MkRMS+uLyH11630MwooaNeUlGRn9bngPQDNzkXlih7RIRkjh+ubdRiPB
 v4CBP0/vvY4PX8V2hj15bdCkPkW6aQnD9r19D5aYlcJA6l/RmnAoML3/KbUL7t/6OGTN
 ZZFR4LLaEJch601zt5wkYjx/QnNn8DzxtGqaNmgYbmsz7G+iNS2c3zov5sqKgkzTaN8N
 vIVtt/7dVVLZn0XsxhF4CixpoXCIfpntTNsoAY8Wd2Nu1tBcVReEdXLZ/pSsK4EBrvCq
 U56g==
X-Gm-Message-State: APjAAAXNVIEsMIYZqNOHxT5EZ6vH71vRlGS+GpM3eRpYGq4JkLTJBb2t
 yVPoNwAglpPZLVNWDRi/MNGtm90x
X-Google-Smtp-Source: APXvYqxdivET+mj2LzU/MpeGr0KuGjnoFF3cIxLRZpJTT1yPpIwUnMenw9yVkGeAyASutRZraGwMNw==
X-Received: by 2002:a1c:96d5:: with SMTP id y204mr2993846wmd.63.1573655956177; 
 Wed, 13 Nov 2019 06:39:16 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id s11sm2965823wrr.43.2019.11.13.06.39.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 13 Nov 2019 06:39:15 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/16] accel: pass object to accel_init_machine
Date: Wed, 13 Nov 2019 15:38:59 +0100
Message-Id: <1573655945-14912-11-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1573655945-14912-1-git-send-email-pbonzini@redhat.com>
References: <1573655945-14912-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32a
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
Cc: thuth@redhat.com, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We will have to set QOM properties before accel_init_machine, based on the
options provided to -accel.  Construct the object outside it so that it
will be possible to insert the iteration between object_new_with_class
and accel_init_machine.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/accel.c          | 6 ++----
 include/sysemu/accel.h | 2 +-
 vl.c                   | 4 +++-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/accel/accel.c b/accel/accel.c
index 74eda68..822e945 100644
--- a/accel/accel.c
+++ b/accel/accel.c
@@ -52,11 +52,9 @@ AccelClass *accel_find(const char *opt_name)
     return ac;
 }
 
-int accel_init_machine(AccelClass *acc, MachineState *ms)
+int accel_init_machine(AccelState *accel, MachineState *ms)
 {
-    ObjectClass *oc = OBJECT_CLASS(acc);
-    const char *cname = object_class_get_name(oc);
-    AccelState *accel = ACCEL(object_new(cname));
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
index 6e406d4..c8ec906 100644
--- a/vl.c
+++ b/vl.c
@@ -2846,6 +2846,7 @@ static int do_configure_accelerator(void *opaque, QemuOpts *opts, Error **errp)
     bool *p_init_failed = opaque;
     const char *acc = qemu_opt_get(opts, "accel");
     AccelClass *ac = accel_find(acc);
+    AccelState *accel;
     int ret;
 
     if (!ac) {
@@ -2853,7 +2854,8 @@ static int do_configure_accelerator(void *opaque, QemuOpts *opts, Error **errp)
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



