Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF03CC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:43:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A014F206E7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kT45kTez"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A014F206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDx1R-0004X5-Ov
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:43:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59126)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLk-0004a2-K0; Thu, 03 Sep 2020 17:00:52 -0400
Received: from mail-oo1-xc43.google.com ([2607:f8b0:4864:20::c43]:41887)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLi-0007md-GZ; Thu, 03 Sep 2020 17:00:52 -0400
Received: by mail-oo1-xc43.google.com with SMTP id t3so1129153ook.8;
 Thu, 03 Sep 2020 14:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=bxWeFhlr2Nkz7Asmr51rIj2c32EFg7f8nnap9EUbZGc=;
 b=kT45kTezXOFjY1kIdOLpucs61FR/RPAJfX7isq+8hAJk4plBdlqs2kl5Bv7UNdC7EV
 StaJpRbM1QTTajuONhlFGKyVccrF1P8xqPMKXbT7ORd3M7xkrnIe0O0yC2lce6dFYM1U
 gZTZWDMrCMUhOAOd6cvc3lL6OMNyBtORtIaftYUshbjEL0V/yKIOKzBR62siGA0sRtow
 2n55NGxJAVYD30evZ+kH8xSP/q4ix1ofe8N6io1wi/z+X6zJYmB0DqwSbOh4FbHsegCA
 UT4801Puv0YYXIITx4eiIq9Mp88776gDBw1L3gJx9wJH4mETofYsN76PdOcVA8CGwqA9
 tEXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=bxWeFhlr2Nkz7Asmr51rIj2c32EFg7f8nnap9EUbZGc=;
 b=MRoBNumSG6Xi7y7rwGyKq6DF2apcaviyCkaQWC043ZX3JTlN7P9nyzsjs/FdCOS3Al
 l/lu7dyTtyOpvREfz/qJJMVdPCvEI7omMq9KXi2K2ovw/Q7M6Nlp+DvXK/LHNWJNvrF3
 PFa6sv0X+o7eCKDZtPSpi/ssmCQDhz1JtiCDqOdCnaR6LS6CyM8hMHbSmEMt2RxFdw4Z
 HIbfvDjExKSYOiAQyYtQ+2M7SfHI26q2Sb63yU4z7MZS3oq8Yg94d2zN+6BYT5aC+hw8
 OiL/3K3i1KduXXHWjsxreqrOBn8hIKGDntgqUIXMUio1w+2VPIRnUpXA6o3ubXaJUu/g
 Q8CQ==
X-Gm-Message-State: AOAM533/phTPD8oeG2u1Pi9Ad7kcrHf0DnrCBpS7OipY4rpWDDrUzlEB
 1fICnF3N5lW1iCLYU+3sDI5qTNnEVjI=
X-Google-Smtp-Source: ABdhPJyU/u8kUV0VF/KzCStoEHPeLSNKtOUe7Wrhekedl7Ea23lzleq/F+U2QatcX/qaLi6P+FEMiQ==
X-Received: by 2002:a4a:d549:: with SMTP id q9mr3346616oos.74.1599166848839;
 Thu, 03 Sep 2020 14:00:48 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id 22sm722522oin.26.2020.09.03.14.00.48
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 14:00:48 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/77] 9p: Lock directory streams with a CoMutex
Date: Thu,  3 Sep 2020 15:58:22 -0500
Message-Id: <20200903205935.27832-5-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::c43;
 envelope-from=flukshun@gmail.com; helo=mail-oo1-xc43.google.com
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
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

Locking was introduced in QEMU 2.7 to address the deprecation of
readdir_r(3) in glibc 2.24. It turns out that the frontend code is
the worst place to handle a critical section with a pthread mutex:
the code runs in a coroutine on behalf of the QEMU mainloop and then
yields control, waiting for the fsdev backend to process the request
in a worker thread. If the client resends another readdir request for
the same fid before the previous one finally unlocked the mutex, we're
deadlocked.

This never bit us because the linux client serializes readdir requests
for the same fid, but it is quite easy to demonstrate with a custom
client.

A good solution could be to narrow the critical section in the worker
thread code and to return a copy of the dirent to the frontend, but
this causes quite some changes in both 9p.c and codir.c. So, instead
of that, in order for people to easily backport the fix to older QEMU
versions, let's simply use a CoMutex since all the users for this
sit in coroutines.

Fixes: 7cde47d4a89d ("9p: add locking to V9fsDir")
Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Message-Id: <158981894794.109297.3530035833368944254.stgit@bahia.lan>
Signed-off-by: Greg Kurz <groug@kaod.org>
(cherry picked from commit ed463454efd0ac3042ff772bfe1b1d846dc281a5)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/9pfs/9p.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
index b8f72a3bd9..c381fe091a 100644
--- a/hw/9pfs/9p.h
+++ b/hw/9pfs/9p.h
@@ -197,22 +197,22 @@ typedef struct V9fsXattr
 
 typedef struct V9fsDir {
     DIR *stream;
-    QemuMutex readdir_mutex;
+    CoMutex readdir_mutex;
 } V9fsDir;
 
 static inline void v9fs_readdir_lock(V9fsDir *dir)
 {
-    qemu_mutex_lock(&dir->readdir_mutex);
+    qemu_co_mutex_lock(&dir->readdir_mutex);
 }
 
 static inline void v9fs_readdir_unlock(V9fsDir *dir)
 {
-    qemu_mutex_unlock(&dir->readdir_mutex);
+    qemu_co_mutex_unlock(&dir->readdir_mutex);
 }
 
 static inline void v9fs_readdir_init(V9fsDir *dir)
 {
-    qemu_mutex_init(&dir->readdir_mutex);
+    qemu_co_mutex_init(&dir->readdir_mutex);
 }
 
 /*
-- 
2.17.1


