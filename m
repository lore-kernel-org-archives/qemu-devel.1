Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08C0C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 17:26:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EA4720774
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 17:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MvXvYcM4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EA4720774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGnK1-0004av-Kj
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 13:26:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51088)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <flukshun@gmail.com>) id 1jGmiT-0003SW-A2
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 12:47:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <flukshun@gmail.com>) id 1jGmiS-0007vQ-5N
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 12:47:49 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:34801)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <flukshun@gmail.com>)
 id 1jGmiS-0007v8-0W; Tue, 24 Mar 2020 12:47:48 -0400
Received: by mail-ot1-x341.google.com with SMTP id j16so17699797otl.1;
 Tue, 24 Mar 2020 09:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=2fuYUPCJuYkPjACVZLJEBgaE+J81FBCDK3U9qpFDHAY=;
 b=MvXvYcM4GKriw2qm1GQUUO1kC3qjC6t57C2XVjfHXowg97aEqFjzcnSt2sVIVVAXNv
 G1uZ8/n3n2CvyozwTZ432jJVXD6qof3Itf6fwIq7Lkryd/0+177X9UqJvvpkTLxKoy0e
 4GW7Zj63muMzC3HbhbJui3rQwUiJUJ0D7nmh2f0XXNyid519JeN3vJ8/tFQ7PdtjZiC+
 JjkqDtZew9mtGZP085ytq+GDEf5X1f54AdXvFNiwIz8nvQU9x/eftIkh/CiY6BdbkT60
 MlanWUnVcm/zkBCKJ8mdU3DfqTxpKg9XN9YyeUHZzgf51TNuB/ewFaCxryA9cVZ0YjJr
 IOaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=2fuYUPCJuYkPjACVZLJEBgaE+J81FBCDK3U9qpFDHAY=;
 b=iKqA8qsR0E+kRjGPZhEze1XhVPRg8LasGFRP1p86Zx1MjFdpPzLGxJvo1L1z59hE95
 WvlPE9u7HVVK53yxSRLjo61OMBdyJbubUoFg/WOa1j2u6ir8hbG6KFlTKIzApSTPRksN
 Zn3wEHGBnKs8OSdxM7ie9HReY8ZxYmwocvdUAEazo15T489d29Z3W3kcOqC7rl1B7BQa
 fEkTEvS66OPUssqYaeOSu3PEXx/tS9bSiDfQyUFZumjmiWwlyk+m+6/PZwIEOxj4fvCy
 P7xERji1AmnGpjEe5enMZY6UMFL73/cCRrMcarUI5LfADd3NA7UGc72i1CtoK3Dherel
 bl7w==
X-Gm-Message-State: ANhLgQ1L2IafWLZ4zXwffDgqNu9KAfQ2+swON3EUzaDeZ6xE6nVe8/9z
 hXVWTaZPRQgREcUkC7qkhm0ergmY2wI=
X-Google-Smtp-Source: ADFU+vsUacAU8LOG47iyWyUDyEVBhA/ZdxSvlFyCl3sG7O6IK9tXjaGFAiL+ixYqDq4S5ORAwaLPTA==
X-Received: by 2002:a9d:412:: with SMTP id 18mr22000135otc.134.1585068466581; 
 Tue, 24 Mar 2020 09:47:46 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id g130sm6431258oif.13.2020.03.24.09.47.44
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 24 Mar 2020 09:47:44 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PULL for-5.0 3/5] qga-win: prevent crash when executing
 guest-file-read with large count
Date: Tue, 24 Mar 2020 11:46:51 -0500
Message-Id: <20200324164653.19449-4-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200324164653.19449-1-mdroth@linux.vnet.ibm.com>
References: <20200324164653.19449-1-mdroth@linux.vnet.ibm.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
X-Mailman-Approved-At: Tue, 24 Mar 2020 13:24:17 -0400
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
Cc: peter.maydell@linaro.org, qemu-stable@nongnu.org,
 Basil Salman <basil@daynix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Basil Salman <basil@daynix.com>

guest-file-read command is currently implemented to read from a
file handle count number of bytes. when executed with a very large count number
qemu-ga crashes.
after some digging turns out that qemu-ga crashes after trying to allocate
a buffer large enough to save the data read in it, the buffer was allocated using
g_malloc0 which is not fail safe, and results a crash in case of failure.
g_malloc0 was replaced with g_try_malloc0() which returns NULL on failure,
A check was added for that case in order to prevent qemu-ga from crashing
and to send a response to the qemu-ga client accordingly.

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1594054

Signed-off-by: Basil Salman <basil@daynix.com>
Reported-by: Fakhri Zulkifli <mohdfakhrizulkifli@gmail.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/commands-win32.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 9c744d6405..b49920e201 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -343,7 +343,13 @@ GuestFileRead *qmp_guest_file_read(int64_t handle, bool has_count,
     }
 
     fh = gfh->fh;
-    buf = g_malloc0(count+1);
+    buf = g_try_malloc0(count + 1);
+    if (!buf) {
+        error_setg(errp,
+                   "failed to allocate sufficient memory "
+                   "to complete the requested service");
+        return NULL;
+    }
     is_ok = ReadFile(fh, buf, count, &read_count, NULL);
     if (!is_ok) {
         error_setg_win32(errp, GetLastError(), "failed to read file");
-- 
2.17.1


