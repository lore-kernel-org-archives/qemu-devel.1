Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB55C43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:02:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C21DA20684
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ju8X7eDJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C21DA20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDwMp-0005v8-Vh
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:02:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwKr-00038x-Sz; Thu, 03 Sep 2020 16:59:57 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:38595)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwKp-0007L4-R3; Thu, 03 Sep 2020 16:59:57 -0400
Received: by mail-oi1-x244.google.com with SMTP id y6so4511523oie.5;
 Thu, 03 Sep 2020 13:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=l6xlQJHOv7dE9T6NcBrhJXAaTtTntr3y7qC5ZPuIlyE=;
 b=Ju8X7eDJBDWIZ/ftmBP6PQKMZUrjC4yQDoSKIYEveB8PMZZBFgshceJXS7WdpQ3+og
 qTd6sKLqU22g630PezRVi+N/DZ60DXHULrTJvaf8iRpJNQH3IuVl1PJuaaWZ1wagydY9
 RQ9PKwJPK5aHOS2xWXEEgwsccdjoU2w8li6//d2pesARyk6NYfl13Yex0zvevTJ1YwL7
 8d34qTLt3FNnmcGmX1JMP0PhGqr1xSUKNuZ3tI+RtX+HXYoOS36Di+5eJ4lzgzkwrC6H
 BZ7MSkbPSltzkZyJhyheVwFF9hDAEYD46uLtIt0z7KBLGzKp1xp5rX3E08fLL/8sK5FL
 dh7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=l6xlQJHOv7dE9T6NcBrhJXAaTtTntr3y7qC5ZPuIlyE=;
 b=GctU440dxVDxwcPQUHlGCutCxaWlMap2UAeXJFTSDcNrsPbFoQQmURzX6eM3RZqqVt
 wrUYEapu/5qjwxnm9qH/0PryltYaDdxu9gg8cJhbYis7P3hqxLBNyBHeWbfdddyb6FnD
 aP5PfygT8nlE8jPPNRuRgqeuOs///6IEvkfyyoTisAwp85VATZVQUeWHHecpeap3LHhr
 OFkxFj4bTsZ8cL1UojxOp8IpVksACvu54np3ovDkThbvc/kT0vKuiSRzlMh/zvSXoxAR
 BjDhVD8oFKUxDk3IJhI6sOzG/9mZUQvDu7CsRCwVdtFpKiB7ei0A9UGTUIde22YXLYDS
 daAg==
X-Gm-Message-State: AOAM531Typ1Yz57YnUl5cFShW5yBjiJUetuccgFZG80C2xu8/F++5shB
 8p7+xCitSy73MNJFN46teG8YrD6+I0c=
X-Google-Smtp-Source: ABdhPJyNvG8jRaAfFGH7RKA9jD7Gsv0p3mUYK68UHEjMR/K23SQsIynjcyrsLbM3aXTNw8Bd0hQLOw==
X-Received: by 2002:aca:2b0c:: with SMTP id i12mr3392493oik.77.1599166794177; 
 Thu, 03 Sep 2020 13:59:54 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id b79sm713535oii.33.2020.09.03.13.59.53
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 13:59:53 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/77] 9pfs: local: ignore O_NOATIME if we don't have
 permissions
Date: Thu,  3 Sep 2020 15:58:29 -0500
Message-Id: <20200903205935.27832-12-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=flukshun@gmail.com; helo=mail-oi1-x244.google.com
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
Cc: Greg Kurz <groug@kaod.org>, qemu-stable@nongnu.org,
 Omar Sandoval <osandov@fb.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Omar Sandoval <osandov@fb.com>

QEMU's local 9pfs server passes through O_NOATIME from the client. If
the QEMU process doesn't have permissions to use O_NOATIME (namely, it
does not own the file nor have the CAP_FOWNER capability), the open will
fail. This causes issues when from the client's point of view, it
believes it has permissions to use O_NOATIME (e.g., a process running as
root in the virtual machine). Additionally, overlayfs on Linux opens
files on the lower layer using O_NOATIME, so in this case a 9pfs mount
can't be used as a lower layer for overlayfs (cf.
https://github.com/osandov/drgn/blob/dabfe1971951701da13863dbe6d8a1d172ad9650/vmtest/onoatimehack.c
and https://github.com/NixOS/nixpkgs/issues/54509).

Luckily, O_NOATIME is effectively a hint, and is often ignored by, e.g.,
network filesystems. open(2) notes that O_NOATIME "may not be effective
on all filesystems. One example is NFS, where the server maintains the
access time." This means that we can honor it when possible but fall
back to ignoring it.

Acked-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
Message-Id: <e9bee604e8df528584693a4ec474ded6295ce8ad.1587149256.git.osandov@fb.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
(cherry picked from commit a5804fcf7b22fc7d1f9ec794dd284c7d504bd16b)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/9pfs/9p-util.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/9pfs/9p-util.h b/hw/9pfs/9p-util.h
index 79ed6b233e..546f46dc7d 100644
--- a/hw/9pfs/9p-util.h
+++ b/hw/9pfs/9p-util.h
@@ -37,9 +37,22 @@ static inline int openat_file(int dirfd, const char *name, int flags,
 {
     int fd, serrno, ret;
 
+again:
     fd = openat(dirfd, name, flags | O_NOFOLLOW | O_NOCTTY | O_NONBLOCK,
                 mode);
     if (fd == -1) {
+        if (errno == EPERM && (flags & O_NOATIME)) {
+            /*
+             * The client passed O_NOATIME but we lack permissions to honor it.
+             * Rather than failing the open, fall back without O_NOATIME. This
+             * doesn't break the semantics on the client side, as the Linux
+             * open(2) man page notes that O_NOATIME "may not be effective on
+             * all filesystems". In particular, NFS and other network
+             * filesystems ignore it entirely.
+             */
+            flags &= ~O_NOATIME;
+            goto again;
+        }
         return -1;
     }
 
-- 
2.17.1


