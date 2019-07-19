Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E097C76195
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 13:38:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFA2F2173B
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 13:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOQdnhvH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFA2F2173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoT5Q-0003CA-ML
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 09:38:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38164)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hoT4Y-0007qy-J1
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:37:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hoT4X-0008FB-DS
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:37:18 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:45346)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
 id 1hoT4X-0008EZ-3u; Fri, 19 Jul 2019 09:37:17 -0400
Received: by mail-pl1-x643.google.com with SMTP id y8so15650929plr.12;
 Fri, 19 Jul 2019 06:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jzhlY8te3PlNHDmc9x8zhHaloKwuy+F9m+jxMy+Rp1s=;
 b=SOQdnhvHIuhpKDXnQoFTnbkSwQX81px8IoHFjnbtIPVKdeLC5rtwORFlTNwJog6omH
 T3Ln0de8V9W/T1kijbghNOKqomb/freI10FvwBb49+Dr3SsOavOM1OeI80QwxwSaADsO
 cFv6dQms6FtY+BWDSCWhg7ENqWY7fPAizB9Nt+bSfj/VJ9JGKbzM/5Q8rUN7nlVX2pdC
 TSHcqRcpDD3xBHMCOjcU4Ip2NIJRI9q6Fmg7FeJc9wcuJcKzE7gWlR3zrCwxNF6MBYB/
 7hFHjC593RNsqHF4Mzb4DtjZZ36xmYDZZ5Tk1f6SdWZSv/xfNTsHxXcZjfpBdQiSmm3O
 H/GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jzhlY8te3PlNHDmc9x8zhHaloKwuy+F9m+jxMy+Rp1s=;
 b=k8KDpaedlfdnMXpkeYIalU9ofj6OAy33cr8E5hhEjwKT2OAMgUMSCWC5kW6zooH+oS
 MDJwjWF1dPWIGR6IF7fXUGQiACBU939DrrFV8Cawks/bZnIUlhiesSZUHPhwC/Poth84
 KrN4LkxQMxzbV6OdRN8TXumttIIolhEHslUyeuRqq3WJhM5C+lgzu+2627hV7JGVCxLD
 LwWAEDk6PP8v6ZJPYRoOejf6eU7Wj1NkRZ+Gf5VKEy5XbvChuaXnckgdzu7g98umYIA9
 axM7Wi0C5VpfWm34Eg8AHKXM/A/Pojd3f+/0fq3lO1Pqq+CBJWVslQDQ0vlU10gyAfKW
 7X4A==
X-Gm-Message-State: APjAAAXw1GEd4ZsOxGg521w8+V8XCbIjJqn9saswWr2KUSv/IaElqxy7
 Qs+i2juHDlqB1Ol16Fwbk1zsODZB9/8=
X-Google-Smtp-Source: APXvYqzFhnF9adiDSbwGQUyWBVF19V7Y77AaR6br4mVELUBX7Q2ufUjZs0vP8KhL1ZE6G6nKcYiWNg==
X-Received: by 2002:a17:902:9689:: with SMTP id
 n9mr57823441plp.241.1563543435867; 
 Fri, 19 Jul 2019 06:37:15 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:433:31a4:f2fb:dab8:3a89:c056])
 by smtp.gmail.com with ESMTPSA id 11sm31895369pfw.33.2019.07.19.06.37.08
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 19 Jul 2019 06:37:15 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 19 Jul 2019 19:05:27 +0530
Message-Id: <20190719133530.28688-12-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190719133530.28688-1-mehta.aaru20@gmail.com>
References: <20190719133530.28688-1-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: [Qemu-devel] [PATCH v6 11/14] qemu-io: adds option to use aio engine
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

Use -i AIOMODE instead of -k.

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
---
 qemu-io.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/qemu-io.c b/qemu-io.c
index f64eca6940..3cee06248e 100644
--- a/qemu-io.c
+++ b/qemu-io.c
@@ -130,7 +130,7 @@ static void open_help(void)
 " -C, -- use copy-on-read\n"
 " -n, -- disable host cache, short for -t none\n"
 " -U, -- force shared permissions\n"
-" -k, -- use kernel AIO implementation (on Linux only)\n"
+" -i, -- use AIO mode (threads, native or io_uring)"
 " -t, -- use the given cache mode for the image\n"
 " -d, -- use the given discard mode for the image\n"
 " -o, -- options to be given to the block driver"
@@ -187,9 +187,6 @@ static int open_f(BlockBackend *blk, int argc, char **argv)
         case 'r':
             readonly = 1;
             break;
-        case 'k':
-            flags |= BDRV_O_NATIVE_AIO;
-            break;
         case 't':
             if (bdrv_parse_cache_mode(optarg, &flags, &writethrough) < 0) {
                 error_report("Invalid cache option: %s", optarg);
@@ -204,6 +201,13 @@ static int open_f(BlockBackend *blk, int argc, char **argv)
                 return -EINVAL;
             }
             break;
+        case 'i':
+            if (bdrv_parse_aio(optarg, &flags) < 0) {
+                error_report("Invalid aio option: %s", optarg);
+                qemu_opts_reset(&empty_opts);
+                return -EINVAL;
+            }
+            break;
         case 'o':
             if (imageOpts) {
                 printf("--image-opts and 'open -o' are mutually exclusive\n");
@@ -291,7 +295,7 @@ static void usage(const char *name)
 "  -n, --nocache        disable host cache, short for -t none\n"
 "  -C, --copy-on-read   enable copy-on-read\n"
 "  -m, --misalign       misalign allocations for O_DIRECT\n"
-"  -k, --native-aio     use kernel AIO implementation (on Linux only)\n"
+"  -i, --aio=MODE       use AIO mode (threads, native or io_uring)\n"
 "  -t, --cache=MODE     use the given cache mode for the image\n"
 "  -d, --discard=MODE   use the given discard mode for the image\n"
 "  -T, --trace [[enable=]<pattern>][,events=<file>][,file=<file>]\n"
@@ -489,7 +493,7 @@ static QemuOptsList file_opts = {
 int main(int argc, char **argv)
 {
     int readonly = 0;
-    const char *sopt = "hVc:d:f:rsnCmkt:T:U";
+    const char *sopt = "hVc:d:f:rsnCmit:T:U";
     const struct option lopt[] = {
         { "help", no_argument, NULL, 'h' },
         { "version", no_argument, NULL, 'V' },
@@ -500,7 +504,7 @@ int main(int argc, char **argv)
         { "nocache", no_argument, NULL, 'n' },
         { "copy-on-read", no_argument, NULL, 'C' },
         { "misalign", no_argument, NULL, 'm' },
-        { "native-aio", no_argument, NULL, 'k' },
+        { "aio", required_argument, NULL, 'i' },
         { "discard", required_argument, NULL, 'd' },
         { "cache", required_argument, NULL, 't' },
         { "trace", required_argument, NULL, 'T' },
@@ -565,8 +569,11 @@ int main(int argc, char **argv)
         case 'm':
             qemuio_misalign = true;
             break;
-        case 'k':
-            flags |= BDRV_O_NATIVE_AIO;
+        case 'i':
+            if (bdrv_parse_aio(optarg, &flags) < 0) {
+                error_report("Invalid aio option: %s", optarg);
+                exit(1);
+            }
             break;
         case 't':
             if (bdrv_parse_cache_mode(optarg, &flags, &writethrough) < 0) {
-- 
2.21.0


