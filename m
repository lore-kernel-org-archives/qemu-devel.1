Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0BC7C072B5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 23:58:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA5D5216B7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 23:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pCu8Efb1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA5D5216B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:32825 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTEeT-0007Hs-S1
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 19:58:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hTEcQ-0005iQ-1n
	for qemu-devel@nongnu.org; Tue, 21 May 2019 19:56:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hTEYz-0001oN-Th
	for qemu-devel@nongnu.org; Tue, 21 May 2019 19:52:58 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:41490)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
	id 1hTEYz-0001nm-O7; Tue, 21 May 2019 19:52:57 -0400
Received: by mail-pl1-x644.google.com with SMTP id f12so114243plt.8;
	Tue, 21 May 2019 16:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=bhbpjK0JQSStbd9y2pHNMHs1B0N4hnvXiiUW+QxkFQ4=;
	b=pCu8Efb1/mghqX2oFjPAH4VPTNqfsIR9hradxpChsTVT/5d0/8+HfAS68CZSYhbBnx
	v3tQDkf7V+dKDe+27A6TDUh6L4E33z6Iyu7+HbBCp5Rn/p748OBHZjQsgdDi8I8ncG53
	JZxs1S6GzV/b9TzowH3uDlNbLFEhzla45xV4nNj1xYlSSdifRoejE4M/aGfyoB0m5pWM
	qso6WN2t7946wCZgjVgZcStcGEMGW8WTAjobb4SJGl/vCuRzRdE4eGvPtySyJBF4IVuz
	oMeaJATNwytjqJiVt+xKMrSUUL8tCiuFNTtL9wT4KJLhrUo5y5VOW9AVZ2VUxKqz8qFV
	amgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=bhbpjK0JQSStbd9y2pHNMHs1B0N4hnvXiiUW+QxkFQ4=;
	b=AwoYs3IO/2devXNHsl8PutwNcujwRdIxhiFMiGa7uWgQ/yKwecvKNndCeOOTowijyS
	/ntxgFWIDlW3ynIXauMAOkSEGpxYs3VoaVWvFfe5t/fr5H7Q5ShoCH4wYidKhWNhiHUW
	j59vSj/4ODbTDvIc1CP4HUCJEzQ0r0MfxzkNdbF5kYuK6u8/AMUxohx+dx4oHYpBxFaP
	xHtLwdYbT2Zi4nGi8TID0ckuhvwcFri6Jr6nY59t3oPgChejvsp352gwFnJDtHb1d+sM
	dE5Y141aoUYgqjQAXn2A0PKPBZssa9FYnxsUtnVvDPvoRV+qgFQ9wnw/Oh0m0L9f7rjD
	U9iQ==
X-Gm-Message-State: APjAAAW3Zd68X46M9Bu4oSAyiB63/XPMB+/OqpaGFIPey+ZMv/gqpfDj
	+LIJKBtp20gXgwmybjgcBG5jjSs3M2TIyg==
X-Google-Smtp-Source: APXvYqzP6YHMsqEBTfn2Aid7dGuCCRcejMNgdc6FiqDH7CCC6K+JdYK7nw8tWg78JhFFvUrbA1QPMg==
X-Received: by 2002:a17:902:28c9:: with SMTP id
	f67mr67267566plb.190.1558482776506; 
	Tue, 21 May 2019 16:52:56 -0700 (PDT)
Received: from localhost.localdomain ([120.57.118.207])
	by smtp.gmail.com with ESMTPSA id
	e5sm51571752pgh.35.2019.05.21.16.52.53
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 21 May 2019 16:52:55 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 05:22:13 +0530
Message-Id: <20190521235215.31341-8-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190521235215.31341-1-mehta.aaru20@gmail.com>
References: <20190521235215.31341-1-mehta.aaru20@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [RFC PATCH 7/9] blockdev: accept io_uring as option
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: saket.sinha89@gmail.com, Julia Suvorova <jusual@mail.ru>,
	qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
	Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
---
 blockdev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/blockdev.c b/blockdev.c
index 79fbac8450..b44b9d660d 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -386,6 +386,8 @@ static void extract_common_blockdev_options(QemuOpts *opts, int *bdrv_flags,
         if ((aio = qemu_opt_get(opts, "aio")) != NULL) {
             if (!strcmp(aio, "native")) {
                 *bdrv_flags |= BDRV_O_NATIVE_AIO;
+            } else if (!strcmp(aio, "io_uring")) {
+                *bdrv_flags |= BDRV_O_IO_URING;
             } else if (!strcmp(aio, "threads")) {
                 /* this is the default */
             } else {
@@ -4547,7 +4549,7 @@ QemuOptsList qemu_common_drive_opts = {
         },{
             .name = "aio",
             .type = QEMU_OPT_STRING,
-            .help = "host AIO implementation (threads, native)",
+            .help = "host AIO implementation (threads, native, io_uring)",
         },{
             .name = BDRV_OPT_CACHE_WB,
             .type = QEMU_OPT_BOOL,
--
2.17.1

