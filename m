Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BD9C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:09:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD25B206CA
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLPz1M+b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD25B206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDwU0-0001Lp-27
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:09:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLG-0003yR-P0; Thu, 03 Sep 2020 17:00:24 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:35038)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLC-0007Zf-Pl; Thu, 03 Sep 2020 17:00:21 -0400
Received: by mail-ot1-x341.google.com with SMTP id i4so4036940ota.2;
 Thu, 03 Sep 2020 14:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=I5YcjEc0mYbCjhyXYUDK76xwxAk1fFbjDKhJ0jp6vus=;
 b=nLPz1M+bXftucc7WA0xXBzmflqfoMKy7Yu4FNYrIFWx20+DTO4Gboyy9yRQvnNA/Lq
 obrw/vcK+8CbJ7Xzi8gICDeL8zAqXzqnZGJvCaOGK0Se6J9ZNSL2q5R+cefSa3Dacmut
 2juUm7JAl2u+N0Xlc+555Ou4MRbISF0yhxYumhyKhdtpJU522dwkBSMczJB/NqhoJYdW
 N7JNchpCTJToBPn8gGnTFWv7+WqkRwTEz5fDrLAo8XmQaOiXrvyaRDEnj5cmbLcGJNJT
 T/2yj4Kw0UN+u0FZEVPOr5mz3MZmHQ0mArKM4uUmsv7B36BmJN6q9GgzXbM7Zay2CDKD
 rlGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=I5YcjEc0mYbCjhyXYUDK76xwxAk1fFbjDKhJ0jp6vus=;
 b=XhqivyrBB2q5mOhfJoYUAjlEqbaX16RUqDmenTJDD7QawW/66sW5mDJAar+JN03H1H
 l2Zn/GCvm7O7vGXLf5KFja0UC8sk/PitSOgNjSw48z1ZWINLCf31JDs8FmOVnlu61VmG
 Her9E2ynnDnO3KO+cfON7cygSgcK682jMEE1ouKFz6E9EBaSrRpiZ3qx76rV7mgZk5wE
 BckjmyYEmjiLZlrWuc1oXz75bpoIVvqVpn3m9LvYl3D0m66/86eDCiOqx0VsJ/udtTfz
 gaPv1uWbuHVGhrzbVcnamMOD4dmafYwZr2g/46sy9ylUkzYi8ElxaJwjGUe1kGHo3KNB
 Ij9Q==
X-Gm-Message-State: AOAM531hJp+rKG3Uj63IBbZ85kp5jV3xWOPogH0pGFcibe/p/MR+VCY7
 cBe5WwnkBdauSEGLj1dRE+yXVuL6YPs=
X-Google-Smtp-Source: ABdhPJwJKMhr3VktPGcVQa/Ad4uBsZ7hDB3ZtYenDazGEDA94jfU0X0y/2lpLYwqycDIvaRg7X/X7g==
X-Received: by 2002:a9d:4e90:: with SMTP id v16mr3048185otk.363.1599166817059; 
 Thu, 03 Sep 2020 14:00:17 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id f50sm767889otf.47.2020.09.03.14.00.16
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 14:00:16 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 29/77] memory: Revert "memory: accept mismatching sizes in
 memory_region_access_valid"
Date: Thu,  3 Sep 2020 15:58:47 -0500
Message-Id: <20200903205935.27832-30-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=flukshun@gmail.com; helo=mail-ot1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-stable@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Michael S. Tsirkin" <mst@redhat.com>

Memory API documentation documents valid .min_access_size and .max_access_size
fields and explains that any access outside these boundaries is blocked.

This is what devices seem to assume.

However this is not what the implementation does: it simply
ignores the boundaries unless there's an "accepts" callback.

Naturally, this breaks a bunch of devices.

Revert to the documented behaviour.

Devices that want to allow any access can just drop the valid field,
or add the impl field to have accesses converted to appropriate
length.

Cc: qemu-stable@nongnu.org
Reviewed-by: Richard Henderson <rth@twiddle.net>
Fixes: CVE-2020-13754
Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1842363
Fixes: a014ed07bd5a ("memory: accept mismatching sizes in memory_region_access_valid")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20200610134731.1514409-1-mst@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 5d971f9e672507210e77d020d89e0e89165c8fc9)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 memory.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/memory.c b/memory.c
index 601b749906..e31aed6446 100644
--- a/memory.c
+++ b/memory.c
@@ -1352,35 +1352,24 @@ bool memory_region_access_valid(MemoryRegion *mr,
                                 bool is_write,
                                 MemTxAttrs attrs)
 {
-    int access_size_min, access_size_max;
-    int access_size, i;
-
-    if (!mr->ops->valid.unaligned && (addr & (size - 1))) {
+    if (mr->ops->valid.accepts
+        && !mr->ops->valid.accepts(mr->opaque, addr, size, is_write, attrs)) {
         return false;
     }
 
-    if (!mr->ops->valid.accepts) {
-        return true;
-    }
-
-    access_size_min = mr->ops->valid.min_access_size;
-    if (!mr->ops->valid.min_access_size) {
-        access_size_min = 1;
+    if (!mr->ops->valid.unaligned && (addr & (size - 1))) {
+        return false;
     }
 
-    access_size_max = mr->ops->valid.max_access_size;
+    /* Treat zero as compatibility all valid */
     if (!mr->ops->valid.max_access_size) {
-        access_size_max = 4;
+        return true;
     }
 
-    access_size = MAX(MIN(size, access_size_max), access_size_min);
-    for (i = 0; i < size; i += access_size) {
-        if (!mr->ops->valid.accepts(mr->opaque, addr + i, access_size,
-                                    is_write, attrs)) {
-            return false;
-        }
+    if (size > mr->ops->valid.max_access_size
+        || size < mr->ops->valid.min_access_size) {
+        return false;
     }
-
     return true;
 }
 
-- 
2.17.1


