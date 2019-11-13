Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671D7C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 14:44:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31C36222CD
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 14:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TnFge3x3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31C36222CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUtt3-00048T-UT
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 09:44:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54483)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iUtnd-0005ih-WF
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 09:39:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iUtnc-0006JU-Vk
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 09:39:13 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33032)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iUtnc-0006JB-OX
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 09:39:12 -0500
Received: by mail-wr1-x441.google.com with SMTP id w9so2667432wrr.0
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2019 06:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=BMoj3pLYyIvpZE90nhRpNRgweOStTA6dPJpbWeqyIqQ=;
 b=TnFge3x3+IgpnvnFjoTBzC6C4TgEH73eBp9JvzN1Z+Log2Wks1dYzLUXF4qbkO0V0W
 Qh+SfD6hrwB69FBBj4r3gpD7VsGpnRYY/+yLZQ5WM/uG/jVAICo933BuzltwN3tdIi+g
 OOe9+bzfeTW1XgqlpE0mqNVX5uxNrc3OylpzHns2+5GFMRmUsXs+mxHfuSBVljt7U4qX
 XkQNi1T1R5Bg0ZuuCHuAlRdCzu0UAeKWO+yE0JDp975/gPjSJGPr7b31GKS+ghniuIVx
 5p6zoZfEbbMM6J2p3CA77ulnPe+glSfrXw5eOiz70nOa3PSreb3tilY60dpA7WJFyWwE
 ixZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=BMoj3pLYyIvpZE90nhRpNRgweOStTA6dPJpbWeqyIqQ=;
 b=r3em8jgcnZKCtf9gBk12MGvhQARflrD/JhXxNOjnET1XTW1o2taCnaQ0tHpKfCTWoF
 MY0n6GVGZ0C2PG2egzjlEzlKnMP3HigJQGbEXd8kLJjflEnxS8bCrangiawjvqP1nF2K
 Q0sb+Hqzy4HUbEA9uVOYkxXLE1VLTPgz2id7WyqGwvL6ovbe5qCrhoiZDCP7lOiP/EM4
 Rg3hj0nWxpaivUMRxWHUdksxyDO53INLVbqkF9ik5yxeJ1Z8b+cKh621OgELMj01Ul51
 Ly6itNXoFfybS5iN5n112Na43fAaXBMZLOtjwEiNKrIJhgf7+WPaITYM1L6jixLEaP7e
 FIng==
X-Gm-Message-State: APjAAAVFUN8agImoWV+7w/BQra0yerg7TtnKCvP2CXaKaHQti6ceI6Dn
 VOJ/w5hzgU/98R/KiCKblx+N9+8S
X-Google-Smtp-Source: APXvYqyU5bACf/fUSCh/UMDpw/ZTXwjkL+n/6PZA6pDio2/uZlRNeM/6FAkz70Qmrlte2HILhEAplw==
X-Received: by 2002:adf:fa0b:: with SMTP id m11mr3365936wrr.279.1573655951103; 
 Wed, 13 Nov 2019 06:39:11 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id s11sm2965823wrr.43.2019.11.13.06.39.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 13 Nov 2019 06:39:10 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/16] vl: move icount configuration earlier
Date: Wed, 13 Nov 2019 15:38:53 +0100
Message-Id: <1573655945-14912-5-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1573655945-14912-1-git-send-email-pbonzini@redhat.com>
References: <1573655945-14912-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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

Once qemu_tcg_configure is turned into a QOM property setter, it will not
be able to set a default value for mttcg_enabled.  Setting the default will
move to the TCG init_machine method, which currently runs after "-icount"
is processed.

However, it is harmless to do configure_icount for all accelerators; we will
just fail later if a non-TCG accelerator being selected.  So do that.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 vl.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/vl.c b/vl.c
index fc9e70f..dbc99d7 100644
--- a/vl.c
+++ b/vl.c
@@ -2829,11 +2829,7 @@ static void user_register_global_props(void)
 
 static int do_configure_icount(void *opaque, QemuOpts *opts, Error **errp)
 {
-    if (tcg_enabled()) {
-        configure_icount(opts, errp);
-    } else {
-        error_setg(errp, "-icount is not allowed with hardware virtualization");
-    }
+    configure_icount(opts, errp);
     return 0;
 }
 
@@ -2854,6 +2850,9 @@ static void configure_accelerators(const char *progname)
     bool init_failed = false;
     AccelClass *acc = NULL;
 
+    qemu_opts_foreach(qemu_find_opts("icount"),
+                      do_configure_icount, NULL, &error_fatal);
+
     accel = qemu_opt_get(qemu_get_machine_opts(), "accel");
     if (accel == NULL) {
         /* Select the default accelerator */
@@ -2901,11 +2900,13 @@ static void configure_accelerators(const char *progname)
         error_report("Back to %s accelerator", acc->name);
     }
 
-    qemu_opts_foreach(qemu_find_opts("icount"),
-                      do_configure_icount, NULL, &error_fatal);
-
     qemu_opts_foreach(qemu_find_opts("accel"),
                       do_configure_accelerator, NULL, &error_fatal);
+
+    if (!tcg_enabled() && use_icount) {
+        error_report("-icount is not allowed with hardware virtualization");
+        exit(1);
+    }
 }
 
 int main(int argc, char **argv, char **envp)
-- 
1.8.3.1



