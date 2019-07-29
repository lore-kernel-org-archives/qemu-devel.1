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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 499FFC433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:25:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D833206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egrjgr0i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D833206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs7Wg-00059X-C6
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 11:25:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44112)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hs7QY-00009e-8Q
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:19:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hs7QX-0001sZ-8Z
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:19:06 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:44276)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
 id 1hs7QX-0001rg-2P; Mon, 29 Jul 2019 11:19:05 -0400
Received: by mail-pf1-x444.google.com with SMTP id t16so28171466pfe.11;
 Mon, 29 Jul 2019 08:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8Jsn3Ev/tFZXw6IbvpTxlQm6I+B/bXy4T/ob5FeHHf8=;
 b=egrjgr0iDOvJRKZRixvkypwwDcc53Q7eYsPq6wbYfsYxVqfPUxvtKl8aIojdsgUR8N
 qvfPk+omRIqb9roKtvjgdAQn3myZy2PxrdrZF91tsfnY5TxSUgL3JUqqVBBvxxlSFphx
 iZEOTLNmyveLOgNWab93mhdn084p+1Rx2/Xenkl6/ZaGN6Zn56ZfegLH62zhKsjxUGl8
 RWM8yOoxt3p9qaj4bVsROS/669/PfQFGGxss2jma41QYHdlvQzI4gu+4E91doWBkJ/Rl
 tq9bGNv4kBi7uLxKyTNgp28og6UdDna+9sFpDgOHZFYRbocregGTirj/ebsmF0Ik/O9L
 bQ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8Jsn3Ev/tFZXw6IbvpTxlQm6I+B/bXy4T/ob5FeHHf8=;
 b=iAP6f2WDpywpptDUCabAth+Y10fhj5bea5GtZveeB1qIlHMYa1FNXVIiUuDapoWKW8
 rCz/MdbSJSZTtR3mEACu3YUTmvyXaKVbY3EtBZsYHlnNJtwiwmrInZ5BO8f07BfTngwB
 imt14OwG6jGmDIV8uwYDwdkftzI4/jD2avWKuDGYlJ1XkiuOE40AWKpRJvuekcHsbL8o
 j+tn1iVgUg8N+ub4qLD5CmCNvK4WHVjxfnB6jWFqsMzR3BI5mlM7DAhU5aN67ZMeTAop
 zhvchDdiLpsKEMXbBIQIq6gh0AwhoDd/2wzzZXr4wPwg1XZDMUJr8C2hQygRUcnDwD37
 zFaw==
X-Gm-Message-State: APjAAAU03RAiqzxPWho/T1AWoOhLh/nJ7w7apaytG1DkCbO2I9Nrpgfh
 3vPWuaaJT2QYOPc6ZAGzlzDg8vXOA3bfmA==
X-Google-Smtp-Source: APXvYqzw1zxSJIG8qHfV3GudlgKWwfpeXuKYVZME47vZFv2LMyHfZb/C73jrB/dFIVMfJVBD5J6buw==
X-Received: by 2002:a17:90a:bd0b:: with SMTP id
 y11mr107350588pjr.141.1564413543789; 
 Mon, 29 Jul 2019 08:19:03 -0700 (PDT)
Received: from localhost.localdomain ([136.233.9.97])
 by smtp.gmail.com with ESMTPSA id h129sm58693941pfb.110.2019.07.29.08.18.55
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 29 Jul 2019 08:19:03 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 29 Jul 2019 20:46:49 +0530
Message-Id: <20190729151651.21306-14-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190729151651.21306-1-mehta.aaru20@gmail.com>
References: <20190729151651.21306-1-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH v7 13/15] qemu-nbd: adds option for aio engines
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


