Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C496C28CC7
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 14:03:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2CD720679
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 14:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwom0+2z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2CD720679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46858 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haKtd-0005Ne-4O
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 10:03:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51496)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mehta.aaru20@gmail.com>) id 1haKhF-0000uV-NR
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 09:50:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mehta.aaru20@gmail.com>) id 1haKhE-0002Kj-Lc
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 09:50:49 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:37433)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
 id 1haKhE-0002KO-Ef; Mon, 10 Jun 2019 09:50:48 -0400
Received: by mail-pf1-x441.google.com with SMTP id 19so4520026pfa.4;
 Mon, 10 Jun 2019 06:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=xq7PK0y6uXgG+XBSKAgO5X/znyGlJsBRbpNQw098uuk=;
 b=dwom0+2zTAa5cFDtsSbROUQxjnKi3OYhoFp8OA15yRoO+Mm/shvSPQxWGeRGmqDmk2
 gNphADwotUC7p5cXDz2wrB9MhGRwtMI1jWdKxcGAqxMVNQ+FJjqrZe7Hbo+Luc7iRil2
 zuMAxQ6BUXEmWx37Mv6WedumF/yugLXazEOe6esLQYrFhT1QvtZ4zVGfH2kavpqSbryU
 f8P93HoOMLZxZZ5SE27bjnW2x+INvOxzRIZHAz2cwmaRFLzfsJvSwu3N/bVFdle+Ys3H
 d4T0UHKWa40cISxuSJB5Ytoi+O7gmP1jHpu+OSNGpLLt4yLSlkY6uu+36sIs5ram+ErR
 kpUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=xq7PK0y6uXgG+XBSKAgO5X/znyGlJsBRbpNQw098uuk=;
 b=AtCQoFQxZbD2VCCtAWzNoX5biWWAZDneiQh1RT2sCdwcGeGmUcBhRcck6CkxPLhqFJ
 UNsNAXzQ8dLZmXr+AULVNMrzt01jSRirGAVhpbJciTfAm6Iqg/W2p+cNilo6ZxUPr3AM
 i1PTEneqHcuGC1Gau5VSoDj+6sA15NLNmytQM/8uW8703GDLrLldrHKpvD+PRA/JSA+R
 eiuUuqX5bxl3ZUqM3djpb/hxy5Lzgb9nezl3zhubpcKEHMD8aCtW7rodZPtPQPyv96jJ
 wCtWmL1fUSXwJicLaE90LijOYO1ek6MTvawD3XXNXKiBIZDwgXj9jDcAhMoTa8CyTfDo
 YeIQ==
X-Gm-Message-State: APjAAAVzPLlXo380EW7GP2jxsUmzKL+9Pxhse9koXpGDMewugDEWwzQP
 K9oYmXBaA56ow4MeJ6jViKEaXAlIAzsWPg==
X-Google-Smtp-Source: APXvYqxwiZYHC2VRPmfK1Z7PZXElEmL7Ca7bd0y8wv7Z/tiISJcEXASUvY9MBofUbcvF+iG9gXSb6g==
X-Received: by 2002:a17:90a:1706:: with SMTP id
 z6mr20726300pjd.108.1560174647071; 
 Mon, 10 Jun 2019 06:50:47 -0700 (PDT)
Received: from localhost.localdomain ([136.233.9.100])
 by smtp.gmail.com with ESMTPSA id d4sm13969837pfc.149.2019.06.10.06.50.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Jun 2019 06:50:46 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 10 Jun 2019 19:19:04 +0530
Message-Id: <20190610134905.22294-12-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190610134905.22294-1-mehta.aaru20@gmail.com>
References: <20190610134905.22294-1-mehta.aaru20@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH v5 11/12] qemu-io: adds support for io_uring
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
 Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 saket.sinha89@gmail.com, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Julia Suvorova <jusual@mail.ru>, Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
---
 qemu-io.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/qemu-io.c b/qemu-io.c
index 8d5d5911cb..54b82151c4 100644
--- a/qemu-io.c
+++ b/qemu-io.c
@@ -129,6 +129,7 @@ static void open_help(void)
 " -n, -- disable host cache, short for -t none\n"
 " -U, -- force shared permissions\n"
 " -k, -- use kernel AIO implementation (on Linux only)\n"
+" -i  -- use kernel io_uring (Linux 5.1+)\n"
 " -t, -- use the given cache mode for the image\n"
 " -d, -- use the given discard mode for the image\n"
 " -o, -- options to be given to the block driver"
@@ -188,6 +189,11 @@ static int open_f(BlockBackend *blk, int argc, char **argv)
         case 'k':
             flags |= BDRV_O_NATIVE_AIO;
             break;
+#ifdef CONFIG_LINUX_IO_URING
+        case 'i':
+            flags |= BDRV_O_IO_URING;
+            break;
+#endif
         case 't':
             if (bdrv_parse_cache_mode(optarg, &flags, &writethrough) < 0) {
                 error_report("Invalid cache option: %s", optarg);
@@ -290,6 +296,7 @@ static void usage(const char *name)
 "  -C, --copy-on-read   enable copy-on-read\n"
 "  -m, --misalign       misalign allocations for O_DIRECT\n"
 "  -k, --native-aio     use kernel AIO implementation (on Linux only)\n"
+"  -i  --io_uring       use kernel io_uring (Linux 5.1+)\n"
 "  -t, --cache=MODE     use the given cache mode for the image\n"
 "  -d, --discard=MODE   use the given discard mode for the image\n"
 "  -T, --trace [[enable=]<pattern>][,events=<file>][,file=<file>]\n"
@@ -499,6 +506,7 @@ int main(int argc, char **argv)
         { "copy-on-read", no_argument, NULL, 'C' },
         { "misalign", no_argument, NULL, 'm' },
         { "native-aio", no_argument, NULL, 'k' },
+        { "io_uring", no_argument, NULL, 'i' },
         { "discard", required_argument, NULL, 'd' },
         { "cache", required_argument, NULL, 't' },
         { "trace", required_argument, NULL, 'T' },
@@ -566,6 +574,11 @@ int main(int argc, char **argv)
         case 'k':
             flags |= BDRV_O_NATIVE_AIO;
             break;
+#ifdef CONFIG_LINUX_IO_URING
+        case 'i':
+            flags |= BDRV_O_IO_URING;
+            break;
+#endif
         case 't':
             if (bdrv_parse_cache_mode(optarg, &flags, &writethrough) < 0) {
                 error_report("Invalid cache option: %s", optarg);
-- 
2.17.1


