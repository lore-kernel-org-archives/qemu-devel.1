Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E5CC07542
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 08:10:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01B8C21721
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 08:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vEeVKQRP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01B8C21721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41735 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVAiE-0003r1-8I
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 04:10:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hVAcT-00082s-Fs
	for qemu-devel@nongnu.org; Mon, 27 May 2019 04:04:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hVAcN-0002Yt-QZ
	for qemu-devel@nongnu.org; Mon, 27 May 2019 04:04:31 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:35745)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
	id 1hVAcL-0002OA-JV; Mon, 27 May 2019 04:04:26 -0400
Received: by mail-pg1-x543.google.com with SMTP id t1so8669966pgc.2;
	Mon, 27 May 2019 01:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=MFg2cgK1UD9qppoRZ6lodJb1OfcqVBWlAqCRvi/E8TQ=;
	b=vEeVKQRP1HzDNXw/l2c6xsCYrNcPnXy248/ntoSjdrB8t+qsFQuTi8isiSSrbJUdRV
	4bi/ypUQpPRLg6EX4dJAXXQPpy+00cT+IanpbwtyABVzhGxLM1Na01/ZlwHTXPFBejJQ
	Aw6B8IUIyu9jXSJL5SWYOtlEokdoQTyFAaMCEDtCN7gSmPXCYkb+XmImnAEj7DgqobEX
	iKshDgZOjLsnB5CEgjZzmn+XrwCFaSaOl1OoCbvYXgDL4z+jc6oIBQTdHHB4kkwzWXke
	67TFtadwek9dYO+j2y8lHS8gWdYyso9dfeto4LVLPu3MJ/RqB3fs0MFxCzE4a4RcaX8+
	Lblg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=MFg2cgK1UD9qppoRZ6lodJb1OfcqVBWlAqCRvi/E8TQ=;
	b=QVmj5/0ZkSZkV/b7gnmJCgCYQgqJOPGgN/4VqTcE2nLqo7gfxF5kM2ZEFbNQZX41pa
	8QppGBO6PAafgyhLlohKrKZzyIOevWPljDkVtS+Ac6Ua9SayXf0pNCPlkZlX/HkS+48R
	7oI+1v16b7r/5v3mFsdamJafx4BQuXm2tgTzI7JnOm/3drHlm12buZUGKRMGd3CS2iGo
	6MBK2Y2HqMwxX/G0StU18QLQHiJGaAoZ5VRduVEUihBHp9sncX6pNv/732bhTJCMP4Dy
	W1rIARLLyU7C/T2gYGPRPdSBzO6/g/3xcAYcXtO2IIIou6J3fcLlxCENIuATBSaYYuaS
	nZKw==
X-Gm-Message-State: APjAAAVwdkZVTsIKHiv8HEAh7JEpfgjkvGqb9mVMmwBx43o6IiHujArn
	01xQHO0Xgt5XGyjKsqxFi50Lw+IHhEpUAA==
X-Google-Smtp-Source: APXvYqx2kZ6riUoghHRvFuiXYVdNqkyzkuixO0sqMPa9IoRsvp9CcXRW/cKTZR8iY136kYvuQx6ltw==
X-Received: by 2002:a63:2b92:: with SMTP id
	r140mr37337317pgr.363.1558944263225; 
	Mon, 27 May 2019 01:04:23 -0700 (PDT)
Received: from localhost.localdomain ([120.57.119.140])
	by smtp.gmail.com with ESMTPSA id
	j5sm10030853pfa.15.2019.05.27.01.04.18
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 27 May 2019 01:04:22 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 27 May 2019 13:33:26 +0530
Message-Id: <20190527080327.10780-8-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190527080327.10780-1-mehta.aaru20@gmail.com>
References: <20190527080327.10780-1-mehta.aaru20@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PATCH v3 7/8] blockdev: accept io_uring as option
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
	Max Reitz <mreitz@redhat.com>, saket.sinha89@gmail.com,
	Stefan Hajnoczi <stefanha@redhat.com>, Julia Suvorova <jusual@mail.ru>,
	Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
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


