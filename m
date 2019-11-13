Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68413C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 14:41:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FFAD222D3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 14:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFgVDQT0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FFAD222D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUtpR-0007jv-06
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 09:41:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54511)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iUtnf-0005m1-OG
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 09:39:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iUtne-0006KH-Jv
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 09:39:15 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:35908)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iUtne-0006Jt-Dj
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 09:39:14 -0500
Received: by mail-wr1-x441.google.com with SMTP id r10so2659016wrx.3
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2019 06:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=04DgeNC9vfzASWfCYcrOuTaV0nl4hE4YtksZoBBJzpM=;
 b=mFgVDQT0R2WoA2hwT/zTC4fqohWKyBeYrk+M9RZ8g8/ggUav/aBzcVRDWXMnMGr8Tv
 pqLOMzepX+E2hDjvoh/T7oXyPIl3f7tkE5//gNauYYyhSy1etsVVlHF2YwzHNg2+zcMF
 iRlVNwHmiHqKP7GRaVJ7uRL6FoHYZ/kDhtzGR/HrTi2Newr80Eb1whTByOefV4icYadT
 EEraEB5e/15S1xeYPUnVT9DamTA8m8ApoGVKNUHOoWhUXRJ8hlqfsuc8zmQ9KuHt4I8p
 /qNBHySWE3ZkTkAkqKb7nJGB+R/dUu99orFznU2cB0Nve6n0Se07I68aYVikEDf8zwnz
 9Z2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=04DgeNC9vfzASWfCYcrOuTaV0nl4hE4YtksZoBBJzpM=;
 b=AzkYQXGk1EQcozzJ2ziiHDFCVpNFIJi7sCrdKz/v+Uhlk1gUPJ033GNLiyDRONLhfA
 HHtFFrVZTPpowDgNmrEkkwL0PUe+kIUuIqu9FyETJP5wAeuNlDmg/+jFbh8UxEl9NO7R
 hMlJhU+cxmfj34gulKSL5xwaU55MjhlbTSIAMhfic/U2TSGSv+GB67rxxvfClvQnMyWP
 Qcrxnfn4C6tkrHcpP9BWVBsMvsZKLzxbvcaDmbgbn6OE5wLCCFRXt/Dc08FD3yGo8OFh
 Kx3f2jWR2S63JW2FwtFbLbMdZBNZGk6SwMf7bkZdxlY8/DDdstFUKd/GwSYwuVTlwa39
 18Pg==
X-Gm-Message-State: APjAAAWcdQBF6XGzkbMrRdgOrj0NLEPRpjlT+Wo0NnBKTs76tqpwhOpT
 s9uw3QOrjE6lXaAugR/tIIs/wCgA
X-Google-Smtp-Source: APXvYqzkbdvF6nahA7MzSMxfnYw7Ty4nmru8yvnOHdhpihtJz7hNUa8rB6FNoc01SXiWvwJHziPkxw==
X-Received: by 2002:a5d:4810:: with SMTP id l16mr3010699wrq.127.1573655953255; 
 Wed, 13 Nov 2019 06:39:13 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id s11sm2965823wrr.43.2019.11.13.06.39.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 13 Nov 2019 06:39:12 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/16] vl: warn for unavailable accelerators, clarify messages
Date: Wed, 13 Nov 2019 15:38:56 +0100
Message-Id: <1573655945-14912-8-git-send-email-pbonzini@redhat.com>
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

So far, specifying an accelerator that was not compiled in did not result
in an error; fix that.

While at it, clarify the mysterious "Back to TCG" message.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 vl.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/vl.c b/vl.c
index dd895db..843b263 100644
--- a/vl.c
+++ b/vl.c
@@ -2853,6 +2853,8 @@ static int do_configure_accelerator(void *opaque, QemuOpts *opts, Error **errp)
     int ret;
 
     if (!ac) {
+        *p_init_failed = true;
+        error_report("invalid accelerator %s", acc);
         return 0;
     }
     ret = accel_init_machine(ac, current_machine);
@@ -2907,6 +2909,9 @@ static void configure_accelerators(const char *progname)
              */
             if (accel_find(*tmp)) {
                 qemu_opts_parse_noisily(qemu_find_opts("accel"), *tmp, true);
+            } else {
+                init_failed = true;
+                error_report("invalid accelerator %s", *tmp);
             }
         }
     } else {
@@ -2926,7 +2931,7 @@ static void configure_accelerators(const char *progname)
 
     if (init_failed) {
         AccelClass *ac = ACCEL_GET_CLASS(current_machine->accelerator);
-        error_report("Back to %s accelerator", ac->name);
+        error_report("falling back to %s", ac->name);
     }
 
     if (!tcg_enabled() && use_icount) {
-- 
1.8.3.1



