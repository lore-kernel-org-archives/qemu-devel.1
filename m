Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088A4C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:32:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C90D32171F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Em/cuWMm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C90D32171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs7dS-0001ME-1u
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 11:32:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44053)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hs7QP-0008Eu-EV
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:18:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hs7QO-0001PE-9w
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:18:57 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:46720)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
 id 1hs7QO-0001O9-2Q; Mon, 29 Jul 2019 11:18:56 -0400
Received: by mail-pg1-x541.google.com with SMTP id k189so9382771pgk.13;
 Mon, 29 Jul 2019 08:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WSpSTIHXOrvOaCUkGHFuQSPMR43SBs+6E3PxPGPC7o8=;
 b=Em/cuWMmFKQc6ZdVMU/a859hLnYCxrqXRu9c/c5uEVt9nQy5Dq5uzXlfC1YXLXhNil
 m/y+Hvdn0iZ/HgEVYH3jSOfVpPXGG6pTFVKdUUwo4SqBJJDk2++Gj0p2ZPeD5u9hFiAp
 4nJkTvTlgusOQqSj/YH1yseHo8g3DvjNYMTm/bfwW0MHUGq96vjzNfxX83B5FcYWPho0
 FEeD8Glf3MhUE9E0sFOtdDd3Lcai025kKzkNU+PE7tXWeBcQlfhh6bFBpvhcXfkWdiSa
 +HBy08W3YuTB9+2M3nd01RwYO79yifgeHAK0ckIzW75bOcA6CVstTPJ4+RlACpSkn+/t
 ukwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WSpSTIHXOrvOaCUkGHFuQSPMR43SBs+6E3PxPGPC7o8=;
 b=DZN3koz8Vk55qnZoXj/1A/gJVWjGr55coXmLD25QqZlE4mt9/ZLsjzB3ft0qRumc4c
 ww35+hB9FyML7kgOVfyRTlbzjgo4HsUZB8wUQPkYi7x0pYA7rhnjPhw30CInIiRaKgcy
 PRIm+7d38GnpP83uC5vP+7e2RvDRQRd/YT0Z/J6jarUCVAovKhYloMInQwb1mU549bfI
 zTUU93zpgaY340c7pxLoYAJ4d436AcBYIwd74G1xcRcknnFiSF6Ll8LDm3Gv5+a8eCXf
 tMYa+cOc3HT1GhSxRAQmd9nr5IJ1fsCUN5gcDXOY4N4/ALtPg/nQDZTxWYICper6gbp4
 rnsw==
X-Gm-Message-State: APjAAAXFW2RF7ei5OcAtqcc+LJBkHqWEdxOKIxHLO/Z2nFAdXuc+x/oj
 X9inJIFqlf0h9U1NtAEguJE2yhVj4wh0cg==
X-Google-Smtp-Source: APXvYqx7EaXu3DwiEMu5ofLpR/FxsqgM3Etvw/oGp7nOtyz03NXfz97sumOI3HmqSwCpVMn8zwQ9mw==
X-Received: by 2002:a62:1ccd:: with SMTP id
 c196mr37507676pfc.102.1564413534801; 
 Mon, 29 Jul 2019 08:18:54 -0700 (PDT)
Received: from localhost.localdomain ([136.233.9.97])
 by smtp.gmail.com with ESMTPSA id h129sm58693941pfb.110.2019.07.29.08.18.47
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 29 Jul 2019 08:18:54 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 29 Jul 2019 20:46:48 +0530
Message-Id: <20190729151651.21306-13-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190729151651.21306-1-mehta.aaru20@gmail.com>
References: <20190729151651.21306-1-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH v7 12/15] qemu-img: adds option to use aio
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Sergio Lopez <slp@redhat.com>,
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
 qemu-img.c    | 10 +++++++++-
 qemu-img.texi |  5 ++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 79983772de..3fc8dac0b1 100644
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
@@ -4234,6 +4235,13 @@ static int img_bench(int argc, char **argv)
             break;
         case 'n':
             flags |= BDRV_O_NATIVE_AIO;
+        case 'i':
+            ret = bdrv_parse_aio(optarg, &flags);
+            if (ret < 0) {
+                error_report("Invalid aio option: %s", optarg);
+                ret = -1;
+                goto out;
+            }
             break;
         case 'o':
         {
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


