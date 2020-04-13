Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB376C2BA2B
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 20:41:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 808FA206DA
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 20:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="biHJ7c2Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 808FA206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jO5tb-0001n0-Lk
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 16:41:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34958)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jO5sr-0000yY-Md
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 16:40:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jO5sq-0003Rz-KD
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 16:40:45 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:45338)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jO5sq-0003RP-Dh
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 16:40:44 -0400
Received: by mail-wr1-x432.google.com with SMTP id v5so11635858wrp.12
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2020 13:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=41dnSW14EdDvEOvenf0xilVesJ/VyYm5m6Di/l78nEQ=;
 b=biHJ7c2ZjTzmJBD5YRVKIeLnQeOkwnqzSaSYe+vvA6AdJyGLW73jII7YiCE9GW1Iau
 rlp2vCfNk/FNAoAvaH5Lc2JEgqQErI1qsGUgQOyWRZ3ZxxDGUFvcM/h32VjTO2/g68pl
 EjxVBUPLb/FPi2EHs/wMc+FXF2Rle8BQ3k6vZUTo7ZdA/4KCzyoTii1xv2cY+UwvrNcB
 Rp4QSbURrRFWHCoP56U6cZffaRR/s5AzrZBeuL66jDsRZlSZPgYLEFaVAohYfZe1AH4X
 41YN9IVl74uMt08BICYRtgSL4Sg7ADeCF7Gb4ZRX5ECFXPB2U7XPDWJI/Q0+39k4qFmu
 4KqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=41dnSW14EdDvEOvenf0xilVesJ/VyYm5m6Di/l78nEQ=;
 b=Kj/LrJT9VQ+BO4n5HRafcqlSeVcxAXAwNsRYI4bkvzY9PJZm0ExHEd1NRvemnIcmHS
 Em9HCLtt+Nz6d906/nluMWORKUQ2ScA/R+Hj+ihhd/zHr/IkhB/YklQcUBdN29+ev0wi
 xcLKYq/VU+fPsQr8zhFl/Y7xHbBJkJy6+7v9zENNSivi8v2iw6mB2WkTCOSXCQDYcKM1
 GsiGiup5ae3qj7VgobUh6qW8OPwXGNQHILNFETg1aWLN6SGB+ixd9OU/T4zC9DT6gifF
 i3OlLiOoW2uqr/u0UlD6Hkj9SrDYbSEZkrFwU9yzc8kj5zd5DGRFV1Xm+e1TnZ517LMs
 eKtQ==
X-Gm-Message-State: AGi0Puan4/SRQ2DgA41dV6fqf6g7VS+f9VwQfzDFWWnips4YxmJW3BYF
 XB5Q6mLmnNWLjcujweKSU8X7kUHeKb8=
X-Google-Smtp-Source: APiQypJo6E74HGhiEPJSA3PuO80vX+YrLdTJHYGuNwuheFlLUElEBgSEWgDXaIGiHM15DzG8XoIOag==
X-Received: by 2002:adf:f3c5:: with SMTP id g5mr20072500wrp.230.1586810442520; 
 Mon, 13 Apr 2020 13:40:42 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id k8sm14389389wrm.52.2020.04.13.13.40.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2020 13:40:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1 v3 7/7] qga/commands-win32: Add missing
 error-propagation code
Date: Mon, 13 Apr 2020 22:40:35 +0200
Message-Id: <20200413204036.30757-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: 20200412224517.12869-1-f4bug@amsat.org
References: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
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
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Running the coccinelle script produced:

  $ spatch \
    --macro-file scripts/cocci-macro-file.h --include-headers \
    --sp-file scripts/coccinelle/find-missing-error_propagate.cocci \
    --keep-comments --smpl-spacing --dir .
  HANDLING: ./qga/commands-win32.c
  [[manual check required: error_propagate() might be missing in acquire_privilege() ./qga/commands-win32.c:1344:4]]
  [[manual check required: error_propagate() might be missing in acquire_privilege() ./qga/commands-win32.c:1360:4]]
  [[manual check required: error_propagate() might be missing in check_suspend_mode() ./qga/commands-win32.c:1343:4]]
  [[manual check required: error_propagate() might be missing in check_suspend_mode() ./qga/commands-win32.c:1359:4]]

Add the missing error_propagate() after review.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .../use-error_abort-in-instance_init.cocci    | 17 ++++--------
 qga/commands-win32.c                          | 26 +++++++++++++------
 2 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/scripts/coccinelle/use-error_abort-in-instance_init.cocci b/scripts/coccinelle/use-error_abort-in-instance_init.cocci
index 8302d74a0c..706c60163c 100644
--- a/scripts/coccinelle/use-error_abort-in-instance_init.cocci
+++ b/scripts/coccinelle/use-error_abort-in-instance_init.cocci
@@ -24,29 +24,22 @@ identifier instance_initfn;
     info.instance_init = instance_initfn;
 
 
-@ use_error_abort @
+@ use_error_abort_in_instance_init @
 identifier match_instance_init.instance_initfn;
-identifier func_with_error;
-expression parentobj, propname, childobj, size, type, errp;
+identifier func_with_error != {qbus_create_inplace, object_initialize_child};
 position pos;
 @@
 void instance_initfn(...)
 {
    <+...
-(
-   object_initialize_child(parentobj, propname,
-                           childobj, size, type,
-                           errp, NULL);
-|
    func_with_error@pos(...,
 -                           NULL);
 +                           &error_abort);
-)
    ...+>
 }
 
 
-@script:python depends on use_error_abort && !has_qapi_error@
-p << use_error_abort.pos;
+@ depends on use_error_abort_in_instance_init && !has_qapi_error @
 @@
-print('[[manual edit required, %s misses #include "qapi/error.h"]]' % p[0].file)
+    #include ...
++   #include "qapi/error.h"
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index b49920e201..8b66098056 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -1341,13 +1341,18 @@ void qmp_guest_suspend_disk(Error **errp)
 
     *mode = GUEST_SUSPEND_MODE_DISK;
     check_suspend_mode(*mode, &local_err);
+    if (local_err) {
+        goto out;
+    }
     acquire_privilege(SE_SHUTDOWN_NAME, &local_err);
+    if (local_err) {
+        goto out;
+    }
     execute_async(do_suspend, mode, &local_err);
 
-    if (local_err) {
-        error_propagate(errp, local_err);
-        g_free(mode);
-    }
+out:
+    error_propagate(errp, local_err);
+    g_free(mode);
 }
 
 void qmp_guest_suspend_ram(Error **errp)
@@ -1357,13 +1362,18 @@ void qmp_guest_suspend_ram(Error **errp)
 
     *mode = GUEST_SUSPEND_MODE_RAM;
     check_suspend_mode(*mode, &local_err);
+    if (local_err) {
+        goto out;
+    }
     acquire_privilege(SE_SHUTDOWN_NAME, &local_err);
+    if (local_err) {
+        goto out;
+    }
     execute_async(do_suspend, mode, &local_err);
 
-    if (local_err) {
-        error_propagate(errp, local_err);
-        g_free(mode);
-    }
+out:
+    error_propagate(errp, local_err);
+    g_free(mode);
 }
 
 void qmp_guest_suspend_hybrid(Error **errp)
-- 
2.21.1


