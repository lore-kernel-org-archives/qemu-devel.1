Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECDFC433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 17:41:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B17E32087F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 17:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qp3uAKvi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B17E32087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsW7h-00070o-Op
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 13:41:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35902)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hsW36-00067D-Fs
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 13:36:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hsW35-0000Sn-9k
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 13:36:32 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:36278)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
 id 1hsW35-0000SV-4K; Tue, 30 Jul 2019 13:36:31 -0400
Received: by mail-pl1-x641.google.com with SMTP id k8so29190848plt.3;
 Tue, 30 Jul 2019 10:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WeED2N/xrRXHqk+R3uuiNy7p3rAfCPFvDRDie7m+ELM=;
 b=qp3uAKviqkfeBIM9MIhXrztFnkqmqUWbrS8MqIiQ5C4NPufwyt7IVWJSqbqLscOVT5
 MWhFTXSdwGzRhbu31GJxJbD5d4I/DKE9OkCzaCVF5ws+eY4B+6xQ9NsB3Cb1l4+SMd7S
 dDfvWxSFNNaG321fR28pX1SgryqRCc9+H7azrRvC18j+8EJK+Z+8gC4RSt4DkfnBLxWT
 x9zOhh62PJHaJIsuR9ReWE3wO64nPwnSw/o7f6rXoCxWkkvvQX0oiEmCDacmTLChiV9v
 XWZgU6JXyn39ElQbB0+X+rX90VdENUbu8k6gCjc93fqEH/Yfk76mYjrD3SuYFxoYfmkI
 thfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WeED2N/xrRXHqk+R3uuiNy7p3rAfCPFvDRDie7m+ELM=;
 b=k0eHI6tKLjN/2gc46IbZhla+Kl6xqNCTzqqKU6v6Fu9HIMeNT0JkMnsw4oz1HgbIg6
 B03eJJwAm4sztqOvaFJBag7HG7DrXeXAEAJDlUZQvc/Bvo0AkQXRqxEvg36v5pWtBCQ9
 JCarAcStRV7zky+hflRP6dRqGo+D0I12d8g4TscuHS9y6QlCkWD9QEiDoeDHXg4YC8uv
 /Fhixm31yFAh1HmZvZslh5TzulaqHm8bDvHnEfARsrJ7KVnfuIsBIDtMQTNcqrE9/Q9u
 kMI0uG5LLISd1XcAGR2kFa5nPjwCPeufWMSPvtDZleLbSmC1OV3mbi9F5jBTW54x89VY
 bspA==
X-Gm-Message-State: APjAAAUWFC34t27l50JsO70DS0AmCQc5B64FN8kOGvgD6N+fOBqqh9Mu
 RwlM7520hKiDlAou51ezi5Nj3AQaI+mqeQ==
X-Google-Smtp-Source: APXvYqz8a57OYeh8SToMuLF1BntaaMs+IP8K8g7VTQwnDBH37gMsD/21FTZhqdSaamVQeyuHW7qrcA==
X-Received: by 2002:a17:902:16f:: with SMTP id
 102mr112077523plb.94.1564508189898; 
 Tue, 30 Jul 2019 10:36:29 -0700 (PDT)
Received: from localhost.localdomain ([136.233.9.97])
 by smtp.gmail.com with ESMTPSA id q24sm59122895pjp.14.2019.07.30.10.36.24
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 30 Jul 2019 10:36:29 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Tue, 30 Jul 2019 23:04:37 +0530
Message-Id: <20190730173441.26486-13-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190730173441.26486-1-mehta.aaru20@gmail.com>
References: <20190730173441.26486-1-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PATCH v8 12/16] qemu-img: adds option to use aio
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 saket.sinha89@gmail.com, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
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


