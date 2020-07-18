Return-Path: <SRS0=NumX=A5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10382C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2020 13:21:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCFF52070E
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2020 13:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXdjPDq1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCFF52070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwmmG-0006AF-Vk
	for qemu-devel@archiver.kernel.org; Sat, 18 Jul 2020 09:21:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36638)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jwmlO-0005Ra-Q9; Sat, 18 Jul 2020 09:20:26 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:45852)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jwmlM-00076U-Ou; Sat, 18 Jul 2020 09:20:26 -0400
Received: by mail-ed1-x543.google.com with SMTP id d16so9710196edz.12;
 Sat, 18 Jul 2020 06:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=4NLSltG9Fq3+LyMw+KBm7QH7SD3tZnrczJ80c5oFSjw=;
 b=mXdjPDq1Cn5Ejvp3JzrkWRpS9otBVNR5iGguunluWen1j0lvUkWH8ATvJwAN8SxKEp
 qQWQivpvjazGYcuYsatkmrYZcYn8yTOWjyoAEppzaL2kvnxBQYluhc7991gEJE3gbs9D
 OjKLweRGVBcZ3rI0hX09DhDVP2c5EAiJ521gAIo+AA7tVs2kyDUoOSFs/MIy8d8URpK3
 BoRbQdzYo3eAJWJWFvsgokxQijnFX1cbaMI/3laX6axrNcGKnHOTNfWpx4A5CIEHTlzV
 KcmnTPTgqtfjgiRa6hYuhcajiqgeGq80J5sYe+Gh6Jhxuy3jPGV30FR5gxI6QCH1VHtQ
 Uvmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=4NLSltG9Fq3+LyMw+KBm7QH7SD3tZnrczJ80c5oFSjw=;
 b=LWkbRvMljCdduVX0y20Ig/MZuwzE6pcStZGKmjuS/UePv9q5HeZwWjMgpyhVfc0ena
 ODM4khBML9BXaB1f6ct7jmdgwAL2i/yVmabQ58YHl+CvS6HkvsFCmM2Bh/AddFpWmb3s
 qJ0+qOK38ye3ZBfb1i55ohdXd+edX6C5mpwUuDfVgvAVcIfl4QC5eyRiXxHMDWPg+dyu
 6g1+cZrlX8fR/o5OUyGs8UVtS3ROsJtnDo2gWDV7ke0o76UPWLMNaG9rTmXJYKbcbeDN
 1zCoN66PJRXwKxel6xPWr3diC84bEUyvyQ4EyR+UesD4DMkTStPayLe44Nf/z5jSwiaF
 b9xQ==
X-Gm-Message-State: AOAM5336J6aEthUYRFKWtcDnhTq251AaDy8s0uMYIkxdcS5Qj9HxERZV
 cMViXRZH5Q8nGmqSM8kUdJ9IpdKVnEm4d8fIO4iTUV5e/W8=
X-Google-Smtp-Source: ABdhPJwCII0hGfj6Y+cQQhji5L/5SoYZc+bSSrnUqlXx4eXZNo2JcfwApePdvnWPTWnzfp2hFZ2xntU8m/XsoTViWug=
X-Received: by 2002:a05:6402:3049:: with SMTP id
 bu9mr14055126edb.232.1595078422431; 
 Sat, 18 Jul 2020 06:20:22 -0700 (PDT)
MIME-Version: 1.0
From: David CARLIER <devnexen@gmail.com>
Date: Sat, 18 Jul 2020 14:20:11 +0100
Message-ID: <CA+XhMqwtUrSpCqNGEETBijewzvmpno8OAX_PKSShDP_gUQ-3VQ@mail.gmail.com>
Subject: [PATCH 2/3] exec: posix_madvise usage on SunOS.
To: qemu-devel <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=devnexen@gmail.com; helo=mail-ed1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From a9e3cced279ae55a59847ba232f7828bc2479367 Mon Sep 17 00:00:00 2001
From: David Carlier <devnexen@gmail.com>
Date: Sat, 18 Jul 2020 13:29:44 +0100
Subject: [PATCH 2/3] exec: posix_madvise usage on SunOS.

with _XOPEN_SOURCE set, the older mman.h API based on caddr_t handling
is not accessible thus using posix_madvise here.

Signed-off-by: David Carlier <devnexen@gmail.com>
---
 exec.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/exec.c b/exec.c
index 6f381f98e2..0466a75b89 100644
--- a/exec.c
+++ b/exec.c
@@ -3964,7 +3964,15 @@ int ram_block_discard_range(RAMBlock *rb,
uint64_t start, size_t length)
              * fallocate'd away).
              */
 #if defined(CONFIG_MADVISE)
+#if !defined(CONFIG_SOLARIS)
             ret =  madvise(host_startaddr, length, MADV_DONTNEED);
+#else
+        /*
+         * mmap and its caddr_t based api is not accessible
+         * with _XOPEN_SOURCE set on illumos
+         */
+            ret =  posix_madvise(host_startaddr, length, POSIX_MADV_DONTNEED);
+#endif
             if (ret) {
                 ret = -errno;
                 error_report("ram_block_discard_range: Failed to
discard range "
-- 
2.25.4

