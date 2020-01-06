Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB1FC33C9B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:58:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDAEA2072A
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0AwercU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDAEA2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioXaB-00035D-Td
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 13:58:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46272)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1ioX4w-0003OX-Uo
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:26:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1ioX4v-00051U-Q0
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:26:14 -0500
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:41165)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1ioX4v-000515-M6; Mon, 06 Jan 2020 13:26:13 -0500
Received: by mail-qk1-x742.google.com with SMTP id x129so40279331qke.8;
 Mon, 06 Jan 2020 10:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8LtGJFRoLm+1QViJT/TSBBPXd3MZMx440gcj2kcTdA4=;
 b=E0AwercUzSfgtOPsdaKwCargU5p1STDCJT25acr9PLcWwNzJVhZNBfbIIoAOJElWNh
 pRx3+aoOoI+GvsMLVeyfpdl3RUmg+qa9GgpwKCsg43/7KB6s6UY/CggIQ7wUhkPqXlwt
 BdNAry1dcFq5VH4T3oSmu1XC6++yaN5dZFLiaTkw5OSyR5qPzuL58r5MyERrG4yax8Lh
 F7fvShSFdDgJwsXlpuiVGLwQsS0y8pj9MjZb58sFCTuRDCFvX9NBh7IXwXWl2/hyxmcW
 S3SD9J8TRBalKqXLNoE7zjL9p7Llz5I/SSbrpEQQ202liFEqK/bqlgJUNX/8vYTWVjkf
 lDRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8LtGJFRoLm+1QViJT/TSBBPXd3MZMx440gcj2kcTdA4=;
 b=cH5euehgyJ24DDx0P4K8ChUK/3u1V6bZe+2xagLnDD2onKKpKCvyskwTzp9ME4VMVO
 SA6r5Fx68hv/BrYsqRuGUHICaZcE6kui5eUxCcGlPy0jXT93Dh6s7IJskn0toXC9Qeja
 HMS/VgnpBG3PvP3A2k1GorGMv4ppK0ZmQnjpyuJ5BJ83TQoh9bEuWqiLhzZjCJJOHaZJ
 z977ENCQz9q5ad8+IskETDg2NhytwUrl5eVN/7oVaIRQaNl/zhyX0pLFo0VLKiSAZJ3s
 UHJwPWAG2ivpLQpwXxZggyCJ8085ECAp8d2OSONoGO8dvpacEsVSUFekjVeiwoiEozXl
 u1jQ==
X-Gm-Message-State: APjAAAVQdoTliDm5Jx2QqWPvF7nLt2xYdV/bfBRk5+QLI++UTh4GvpEJ
 bpoVvH2mMyOIQzKVC+2bYO9tX7BH
X-Google-Smtp-Source: APXvYqy/Z+2Py4bryxprBQK1r7tzlXhDuL+n9PFjlwc5OSvUfaRZzVCcIsfcph9Pz8WVncG1rCwivw==
X-Received: by 2002:a37:6794:: with SMTP id
 b142mr85101702qkc.216.1578335173136; 
 Mon, 06 Jan 2020 10:26:13 -0800 (PST)
Received: from rekt.ibmuc.com ([2804:431:c7c6:655b:9e1c:e865:3705:e1df])
 by smtp.gmail.com with ESMTPSA id b81sm21026522qkc.135.2020.01.06.10.26.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 10:26:12 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 45/59] 9pfs/9p.c: remove unneeded labels
Date: Mon,  6 Jan 2020 15:24:11 -0300
Message-Id: <20200106182425.20312-46-danielhb413@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106182425.20312-1-danielhb413@gmail.com>
References: <20200106182425.20312-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::742
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
Cc: qemu-trivial@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

'out' label in v9fs_xattr_write() and 'out_nofid' label in
v9fs_complete_rename() can be replaced by appropriate return
calls.

CC: Greg Kurz <groug@kaod.org>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/9pfs/9p.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 520177f40c..be2beba4cd 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -2464,8 +2464,7 @@ static int v9fs_xattr_write(V9fsState *s, V9fsPDU *pdu, V9fsFidState *fidp,
 
 
     if (fidp->fs.xattr.len < off) {
-        err = -ENOSPC;
-        goto out;
+        return -ENOSPC;
     }
     write_count = fidp->fs.xattr.len - off;
     if (write_count > count) {
@@ -2491,7 +2490,7 @@ static int v9fs_xattr_write(V9fsState *s, V9fsPDU *pdu, V9fsFidState *fidp,
         off += to_copy;
         write_count -= to_copy;
     }
-out:
+
     return err;
 }
 
@@ -3056,8 +3055,7 @@ static int coroutine_fn v9fs_complete_rename(V9fsPDU *pdu, V9fsFidState *fidp,
     if (newdirfid != -1) {
         dirfidp = get_fid(pdu, newdirfid);
         if (dirfidp == NULL) {
-            err = -ENOENT;
-            goto out_nofid;
+            return -ENOENT;
         }
         if (fidp->fid_type != P9_FID_NONE) {
             err = -EINVAL;
@@ -3100,7 +3098,6 @@ out:
         put_fid(pdu, dirfidp);
     }
     v9fs_path_free(&new_path);
-out_nofid:
     return err;
 }
 
-- 
2.24.1


