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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F403C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 23:49:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29376206A3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 23:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BaK/ICHt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29376206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htKpR-0002fE-GQ
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 19:49:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32888)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mehta.aaru20@gmail.com>) id 1htKiT-0007YI-IY
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 19:42:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mehta.aaru20@gmail.com>) id 1htKiS-0003dS-24
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 19:42:37 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:41298)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
 id 1htKiQ-0003aI-5i; Thu, 01 Aug 2019 19:42:34 -0400
Received: by mail-pf1-x441.google.com with SMTP id m30so34965962pff.8;
 Thu, 01 Aug 2019 16:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=g0K4nld1/KlLZhCdPIvk0WNLZIE9E/uK4u0beC76QwY=;
 b=BaK/ICHt2M3Q7tAxYg/Aq6azr7ZK2Bmj7ZRWNPbN9+TSH6iTS7mwuf0IMvIkAg4RCa
 /1afST0XY15IscBFBTMOBZY/3PMzYMVLrs8tWHrdNxmbXfVXTnoVAyFopFkkQqEQwEZT
 ZGFcqweRQYMV8pFFkRiPt2K86LMNzvX2jzXZFbIHqqe7c7ZXZyiySDcuYqUFKmi1kT2R
 rzsNachVdzKjUoymfikjyythpBb329aXBIt/rJdttciqdlZhPupj69r6OXor0kyCL0kF
 YAwupyBBhmPNgx8eRnsBk0qUYSbD/ptay6QnkUUbRq3YN1zBis6OtMrSkMyb2f5smJo1
 vC6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=g0K4nld1/KlLZhCdPIvk0WNLZIE9E/uK4u0beC76QwY=;
 b=cGb3ZgoryZAkNO3Y/EN9BBHA9k1GxfO3wMEUlMt1F1yIdNauGAseM4kuWFmGeLHbQR
 Yf41WXyQPuq2Yn+XtnNOf75R9Db+/NbL+yRP7D7tDGvtoHjm94Yaooe+KD6DcTizeVw/
 J+fYmB208YkAqcZIlISByVZEL2WVHQwNpVa2hsokef1vSVskC4IWKA1ENoK5xAvABs/A
 JBBdD5RrkfS9XTkzvQGFYHZID53IKALLtihLGBAKQHs1olzXjcHi++K5zrwtpUaMkDDa
 yzpyoaLcf64TISMOSBOaPZ9EKAA9z4w6QTu5p5HwGV30zvsR++7Q5ZpX7gVNcBu1h8Ha
 yj2w==
X-Gm-Message-State: APjAAAVauq8rDMXITQhlmhzPaJysjmVMHODGiiX6y/dJfMzdNakK9q1a
 YvWvrLQ0vPLRfpymc7lmUBThtgxgp6pDjg==
X-Google-Smtp-Source: APXvYqwJBzCoItMLqCLs8bNcjONWc6NgjBKjiOr05qI6AeafiuMMDjUsZVvXagxH8P8kmtZCLfCEMw==
X-Received: by 2002:a63:2364:: with SMTP id
 u36mr117542082pgm.449.1564702951868; 
 Thu, 01 Aug 2019 16:42:31 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:572:3de5:765:cb16:92cd:ee3e])
 by smtp.gmail.com with ESMTPSA id
 g18sm117975426pgm.9.2019.08.01.16.42.24
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 01 Aug 2019 16:42:31 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri,  2 Aug 2019 05:10:27 +0530
Message-Id: <20190801234031.29561-14-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190801234031.29561-1-mehta.aaru20@gmail.com>
References: <20190801234031.29561-1-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH v9 13/17] qemu-nbd: adds option for aio engines
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
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Acked-by: Eric Blake <eblake@redhat.com>
---
 qemu-nbd.c    | 12 ++++--------
 qemu-nbd.texi |  4 ++--
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/qemu-nbd.c b/qemu-nbd.c
index a8cb39e510..7bb479f3c0 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -135,7 +135,7 @@ static void usage(const char *name)
 "                            '[ID_OR_NAME]'\n"
 "  -n, --nocache             disable host cache\n"
 "      --cache=MODE          set cache mode (none, writeback, ...)\n"
-"      --aio=MODE            set AIO mode (native or threads)\n"
+"      --aio=MODE            set AIO mode (native, io_uring or threads)\n"
 "      --discard=MODE        set discard mode (ignore, unmap)\n"
 "      --detect-zeroes=MODE  set detect-zeroes mode (off, on, unmap)\n"
 "      --image-opts          treat FILE as a full set of image options\n"
@@ -718,13 +718,9 @@ int main(int argc, char **argv)
                 exit(EXIT_FAILURE);
             }
             seen_aio = true;
-            if (!strcmp(optarg, "native")) {
-                flags |= BDRV_O_NATIVE_AIO;
-            } else if (!strcmp(optarg, "threads")) {
-                /* this is the default */
-            } else {
-               error_report("invalid aio mode `%s'", optarg);
-               exit(EXIT_FAILURE);
+            if (bdrv_parse_aio(optarg, &flags) < 0) {
+                error_report("Invalid aio mode '%s'", optarg);
+                exit(EXIT_FAILURE);
             }
             break;
         case QEMU_NBD_OPT_DISCARD:
diff --git a/qemu-nbd.texi b/qemu-nbd.texi
index 7f55657722..3ee3e4bdee 100644
--- a/qemu-nbd.texi
+++ b/qemu-nbd.texi
@@ -77,8 +77,8 @@ as an read-only device, @var{snapshot_param} format is
 The cache mode to be used with the file.  See the documentation of
 the emulator's @code{-drive cache=...} option for allowed values.
 @item --aio=@var{aio}
-Set the asynchronous I/O mode between @samp{threads} (the default)
-and @samp{native} (Linux only).
+Set the asynchronous I/O mode between @samp{threads} (the default),
+@samp{native} (Linux only) and @samp{io_uring} (Linux 5.1+).
 @item --discard=@var{discard}
 Control whether @dfn{discard} (also known as @dfn{trim} or @dfn{unmap})
 requests are ignored or passed to the filesystem.  @var{discard} is one of
-- 
2.21.0


