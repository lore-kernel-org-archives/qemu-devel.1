Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34EC0C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 15:06:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 059F720786
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 15:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWbKEzDJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 059F720786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlDAv-0007Qv-9B
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 11:06:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58378)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCRA-0004aj-1y; Tue, 16 Jun 2020 10:19:40 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:43071)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCR8-00072y-I3; Tue, 16 Jun 2020 10:19:39 -0400
Received: by mail-ot1-x343.google.com with SMTP id u23so16059903otq.10;
 Tue, 16 Jun 2020 07:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=3JNcCSJ/kBeHtX0/zO54ZJ/KkiPaS7XdkWk5gBIKMaU=;
 b=SWbKEzDJXTlhOGPRxCBUq/VSJTxerFgtd6Js8v/0C6pZP42/d7VmKVUtNVp/Ng7zTN
 52+wKw8QPoE5L3GseyveeiAvhscfGg05acMSggGQYZ7MeTYj4A4rr2StJIrEnBm1SK41
 qs23tYmEvDUio+nvdlADrPrJCuiCeroXxaBtNcSgCplPB+WJjxq5knzcdgRFE0pTnnOq
 RWxdCWfJ2jWDLV9QpG1RQ+Be9nT8/OdmLsS/j4nWOYOmmppIrEn4UZsoLSeW9mhiZDnh
 6yukUJ7MPA2zmnIEv/3/LNLS7UgXcHuAJ944JjlvGhtg12Mc89IZZ+CWcPVkW+zy+jYu
 gsgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=3JNcCSJ/kBeHtX0/zO54ZJ/KkiPaS7XdkWk5gBIKMaU=;
 b=Dwqnd/3/D75KU6Of0/09k40jEmzNRbV7vDozPz1FzTQRV4g1wbnUcGOo8/9KbNH5HD
 jARK12Iz/Ne531ID0QrS21iK6B763J/wK6uReCHfEqBHswd4eVTv1AI7R/ZDYi5saPvJ
 H01YHa2/0YwXic08zeaDhXr5zHYUpK4oFer2QLJqElWQ0vnEihHYEAJ5CsjWr+UhKXyx
 nrKslOj0VzjDwLoxXUhbfHlfSedVVh8EyfVvcerZgbqLocPr6iqJXBvOrHbmiar218wf
 ONbbgctxCqxhp8vs67DsNp6XQ7WW8Povokeic2vzWVo8/1+eThvwVGpI0TjPnQX/z5+k
 Vogg==
X-Gm-Message-State: AOAM530sZIOaMHL5ElgEHYzUdF2Cm0b0HDRPpo/WmmtbdY4MN/uu/5DY
 FgxOP49CtuKh7hZe3d36Y0lDy5X8LIU=
X-Google-Smtp-Source: ABdhPJy0zRa7wP88F5KjuCugrmlQdMpDBcO2hNniESaGdgXtaIWBf1ofT9K0oNIf88rlsLAmNZd08g==
X-Received: by 2002:a9d:2de6:: with SMTP id g93mr2787749otb.28.1592317175739; 
 Tue, 16 Jun 2020 07:19:35 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id w1sm4123203ooq.1.2020.06.16.07.19.34
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 16 Jun 2020 07:19:35 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 72/78] 9p: Lock directory streams with a CoMutex
Date: Tue, 16 Jun 2020 09:15:41 -0500
Message-Id: <20200616141547.24664-73-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
References: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=flukshun@gmail.com; helo=mail-ot1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
index 3904f82901..069c86333f 100644
--- a/hw/9pfs/9p.h
+++ b/hw/9pfs/9p.h
@@ -186,22 +186,22 @@ typedef struct V9fsXattr
 
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


