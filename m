Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9EBC433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 23:48:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A70FB206A3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 23:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gv1XNJJG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A70FB206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htKoF-0000nF-W1
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 19:48:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60941)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mehta.aaru20@gmail.com>) id 1htKiJ-0007Ip-FU
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 19:42:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mehta.aaru20@gmail.com>) id 1htKiI-0003TE-86
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 19:42:27 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:40475)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
 id 1htKiH-0003RS-7a; Thu, 01 Aug 2019 19:42:25 -0400
Received: by mail-pg1-x541.google.com with SMTP id w10so35054851pgj.7;
 Thu, 01 Aug 2019 16:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WeED2N/xrRXHqk+R3uuiNy7p3rAfCPFvDRDie7m+ELM=;
 b=Gv1XNJJG/aZKueZZZhyqU5J46YtC6MD5SEFlMYE4DFd0rlb8pXf7Md7DTNYi9NOXar
 OcpY6Km/MfzWUSLdKtiZSjyQ+66sZqQIk2+EqK2zJTU54RIHtWTW/1Vy0UJ+WTvzfnyb
 Q0TRKkA2SaULN+EkwLPf49Q00eru4YfeAUpLYXtkY76cy9HcpvVOtp+isTmOWiqcSfIl
 eNhtwjwdL7swXPiJh0SQQevSN+Abzn7hMlvMq8cBDimiCeicl+VI/UEERcgrtKvag64Q
 IRVp5aRvSyeaTFvP2OEZGRantmC/BZ0VMUe2YZSef9dukNYNt4lFEHflnrUnr/RN89uG
 s/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WeED2N/xrRXHqk+R3uuiNy7p3rAfCPFvDRDie7m+ELM=;
 b=k8ZMENjua+LwtxEswkmrdGirUMTV0dt2TXtS0zfxmR7+tKvrfs22DazhSz2C36R6Qb
 uNTq/FXixzfbgc/nSnloYii8y0RKmGQOHWH1HjmRMm1e8nVNQKqgHrBFuMDytv4lXJoU
 l3qmvqLWDm0KVfyTDfIa1uVdhYEp8RwCcWW9cIIdSAXnWnRk40ZnOSgVftC0sWCDdC40
 v7nz7qsxeMftsoNPLv0E8x6pupMv/rGJc3GuxUF2FgVP2R/wuPJ9rofRNd+LYiQ+e79c
 EqPI2Lc3fYeMhhpJoJGgHNJ0aEV/hPem7qjo9zCYRT1Rbgjne8P2H16GV643FWfCcb5b
 S8Uw==
X-Gm-Message-State: APjAAAVFKGxRBJo2PnuJ9lEXKSnQEydRNk+XvwUHV6MUSP3ith08M8TJ
 kW30pc108QTuxJFDI4YtGvkFN4bOKjM4CQ==
X-Google-Smtp-Source: APXvYqy/xCxc7gW0i283Si7AItH+WSbgemt/rObzTBv2TxbHMjtyvu+fLlJzYjJi2F1o9/KS5r6LVw==
X-Received: by 2002:a63:e48:: with SMTP id 8mr34066731pgo.389.1564702943751;
 Thu, 01 Aug 2019 16:42:23 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:572:3de5:765:cb16:92cd:ee3e])
 by smtp.gmail.com with ESMTPSA id
 g18sm117975426pgm.9.2019.08.01.16.42.17
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 01 Aug 2019 16:42:23 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri,  2 Aug 2019 05:10:26 +0530
Message-Id: <20190801234031.29561-13-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190801234031.29561-1-mehta.aaru20@gmail.com>
References: <20190801234031.29561-1-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH v9 12/17] qemu-img: adds option to use aio
 engine for benchmarking
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
Cc: Kevin Wolf <kwolf@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 saket.sinha89@gmail.com, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefan@redhat.com>, Julia Suvorova <jusual@mail.ru>,
 Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
---
 qemu-img-cmds.hx |  4 ++--
 qemu-img.c       | 11 ++++++++++-
 qemu-img.texi    |  5 ++++-
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
index 1c93e6d185..77b5a8dda8 100644
--- a/qemu-img-cmds.hx
+++ b/qemu-img-cmds.hx
@@ -20,9 +20,9 @@ STEXI
 ETEXI
 
 DEF("bench", img_bench,
-    "bench [-c count] [-d depth] [-f fmt] [--flush-interval=flush_interval] [-n] [--no-drain] [-o offset] [--pattern=pattern] [-q] [-s buffer_size] [-S step_size] [-t cache] [-w] [-U] filename")
+    "bench [-c count] [-d depth] [-f fmt] [--flush-interval=flush_interval] [-n] [--no-drain] [-o offset] [--pattern=pattern] [-q] [-s buffer_size] [-S step_size] [-t cache] [-i aio] [-w] [-U] filename")
 STEXI
-@item bench [-c @var{count}] [-d @var{depth}] [-f @var{fmt}] [--flush-interval=@var{flush_interval}] [-n] [--no-drain] [-o @var{offset}] [--pattern=@var{pattern}] [-q] [-s @var{buffer_size}] [-S @var{step_size}] [-t @var{cache}] [-w] [-U] @var{filename}
+@item bench [-c @var{count}] [-d @var{depth}] [-f @var{fmt}] [--flush-interval=@var{flush_interval}] [-n] [--no-drain] [-o @var{offset}] [--pattern=@var{pattern}] [-q] [-s @var{buffer_size}] [-S @var{step_size}] [-t @var{cache}] [-i @var{aio}] [-w] [-U] @var{filename}
 ETEXI
 
 DEF("check", img_check,
diff --git a/qemu-img.c b/qemu-img.c
index 79983772de..27ac33f7d7 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -4192,7 +4192,8 @@ static int img_bench(int argc, char **argv)
             {"force-share", no_argument, 0, 'U'},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":hc:d:f:no:qs:S:t:wU", long_options, NULL);
+        c = getopt_long(argc, argv, ":hc:d:f:ni:o:qs:S:t:wU", long_options,
+                        NULL);
         if (c == -1) {
             break;
         }
@@ -4235,6 +4236,14 @@ static int img_bench(int argc, char **argv)
         case 'n':
             flags |= BDRV_O_NATIVE_AIO;
             break;
+        case 'i':
+            ret = bdrv_parse_aio(optarg, &flags);
+            if (ret < 0) {
+                error_report("Invalid aio option: %s", optarg);
+                ret = -1;
+                goto out;
+            }
+            break;
         case 'o':
         {
             offset = cvtnum(optarg);
diff --git a/qemu-img.texi b/qemu-img.texi
index c8e9bba515..0a2eccea85 100644
--- a/qemu-img.texi
+++ b/qemu-img.texi
@@ -206,7 +206,7 @@ Command description:
 Amends the image format specific @var{options} for the image file
 @var{filename}. Not all file formats support this operation.
 
-@item bench [-c @var{count}] [-d @var{depth}] [-f @var{fmt}] [--flush-interval=@var{flush_interval}] [-n] [--no-drain] [-o @var{offset}] [--pattern=@var{pattern}] [-q] [-s @var{buffer_size}] [-S @var{step_size}] [-t @var{cache}] [-w] [-U] @var{filename}
+@item bench [-c @var{count}] [-d @var{depth}] [-f @var{fmt}] [--flush-interval=@var{flush_interval}] [-n] [-i @var{aio}][--no-drain] [-o @var{offset}] [--pattern=@var{pattern}] [-q] [-s @var{buffer_size}] [-S @var{step_size}] [-t @var{cache}] [-w] [-U] @var{filename}
 
 Run a simple sequential I/O benchmark on the specified image. If @code{-w} is
 specified, a write test is performed, otherwise a read test is performed.
@@ -227,6 +227,9 @@ If @code{-n} is specified, the native AIO backend is used if possible. On
 Linux, this option only works if @code{-t none} or @code{-t directsync} is
 specified as well.
 
+If @code{-i} is specified, aio option can be used to specify different AIO
+backends: @var{threads}, @var{native} or @var{io_uring}.
+
 For write tests, by default a buffer filled with zeros is written. This can be
 overridden with a pattern byte specified by @var{pattern}.
 
-- 
2.21.0


