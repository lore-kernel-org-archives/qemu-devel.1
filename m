Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E321C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:24:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3361206CA
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEFRu2sZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3361206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDwir-0000ZT-5L
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:24:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58360)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwL5-0003cs-CE; Thu, 03 Sep 2020 17:00:11 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:42526)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwL3-0007QS-N4; Thu, 03 Sep 2020 17:00:11 -0400
Received: by mail-ot1-x342.google.com with SMTP id g10so3992228otq.9;
 Thu, 03 Sep 2020 14:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=7UAh7dZ1laqTWozprEx5nPTnEIvgRC8w7jofjPe6YO0=;
 b=JEFRu2sZFq3ja9z7tLWV1F/iRzHEOhN+mJp2K/M4VyNy9Ya/o2b8xs+zUTC1dKTNq+
 QbNrqJ4N81lzx2T2JIgnyFvZ+nCu+e+R9Jpof3jm7w7P6+VeOOyGoYnBv2s1+IzbFL2F
 9ACTJz5UcR70gr8jQRxwN/P60TfI5QArFF4nAoAo//PO4Mg+fVoedRG1jLSPkOMItJYK
 tH26av25n5DRo0xa45YWR0PzUO/bYfMAjmjJm4GgM956ZjhgnvnjBGyJacvFrs1400Yg
 RxscifyoN586y12TImKH1K9PX0QFsVbd+DUm9UeqZGc+dDanlekEAMPBb1kr21F67zhE
 6N5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=7UAh7dZ1laqTWozprEx5nPTnEIvgRC8w7jofjPe6YO0=;
 b=c+nXz972wB0M9XHsU8roJo74SsSq5hbfL8LRGqyweoVwmm8vJN99OjLUdNx/Yvl+9r
 krsS8N6AULO53yjlyxZslvbjLhgQ7Lu8n3sPEn9wvF9kpprvbL3qcbx+Luz0zQ1cJssR
 Vkwrow0WUzoJY5sEfU4UqihgIJ2G0wAP7JKxr2kxHgAx+xElc/u+w1LBmpxDjdVxlgHW
 W9TlsD8cWY6o8lCwV0h3lszM8au5IfLShqzLQkU9w5dg1cSGLeT/15YJtNkozDhY10ZG
 xeq/XJ379485b5+N391f4JkUF2hW1vNFe9K5J+lgC4pVumPa/O3Hk4T2T+t3vWFtYzZN
 idaQ==
X-Gm-Message-State: AOAM5306zbHjaDfKc2mbT6iXP9Q81JnNXkSRU3IDxUNcrUvj5YJNXK/0
 y6ElLMEyKrJEgXJy+UoYcuD39aIAqZo=
X-Google-Smtp-Source: ABdhPJyBsoRhRW17F6C3WGXhJPxBz3NBPS6Kun7Evf0ssvarkOsFHbeWdNIzgtD/aXzc//7rI8eQWQ==
X-Received: by 2002:a9d:1c8a:: with SMTP id l10mr3220047ota.230.1599166807842; 
 Thu, 03 Sep 2020 14:00:07 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id q184sm828224ooq.40.2020.09.03.14.00.06
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 14:00:07 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 21/77] virtiofsd: stay below fs.file-max sysctl value
 (CVE-2020-10717)
Date: Thu,  3 Sep 2020 15:58:39 -0500
Message-Id: <20200903205935.27832-22-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=flukshun@gmail.com; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

The system-wide fs.file-max sysctl value determines how many files can
be open.  It defaults to a value calculated based on the machine's RAM
size.  Previously virtiofsd would try to set RLIMIT_NOFILE to 1,000,000
and this allowed the FUSE client to exhaust the number of open files
system-wide on Linux hosts with less than 10 GB of RAM!

Take fs.file-max into account when choosing the default RLIMIT_NOFILE
value.

Fixes: CVE-2020-10717
Reported-by: Yuval Avrahami <yavrahami@paloaltonetworks.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20200501140644.220940-3-stefanha@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
(cherry picked from commit 8c1d353d107b4fc344e27f2f08ea7fa25de2eea2)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 tools/virtiofsd/helper.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c
index dc59f38af0..00a1ef666a 100644
--- a/tools/virtiofsd/helper.c
+++ b/tools/virtiofsd/helper.c
@@ -176,7 +176,8 @@ void fuse_cmdline_help(void)
            "                               default: no_xattr\n"
            "    --rlimit-nofile=<num>      set maximum number of file descriptors\n"
            "                               (0 leaves rlimit unchanged)\n"
-           "                               default: 1,000,000 if the current rlimit is lower\n"
+           "                               default: min(1000000, fs.file-max - 16384)\n"
+           "                                        if the current rlimit is lower\n"
            );
 }
 
@@ -199,9 +200,32 @@ static int fuse_helper_opt_proc(void *data, const char *arg, int key,
 
 static unsigned long get_default_rlimit_nofile(void)
 {
+    g_autofree gchar *file_max_str = NULL;
+    const rlim_t reserved_fds = 16384; /* leave at least this many fds free */
     rlim_t max_fds = 1000000; /* our default RLIMIT_NOFILE target */
+    rlim_t file_max;
     struct rlimit rlim;
 
+    /*
+     * Reduce max_fds below the system-wide maximum, if necessary.  This
+     * ensures there are fds available for other processes so we don't
+     * cause resource exhaustion.
+     */
+    if (!g_file_get_contents("/proc/sys/fs/file-max", &file_max_str,
+                             NULL, NULL)) {
+        fuse_log(FUSE_LOG_ERR, "can't read /proc/sys/fs/file-max\n");
+        exit(1);
+    }
+    file_max = g_ascii_strtoull(file_max_str, NULL, 10);
+    if (file_max < 2 * reserved_fds) {
+        fuse_log(FUSE_LOG_ERR,
+                 "The fs.file-max sysctl is too low (%lu) to allow a "
+                 "reasonable number of open files.\n",
+                 (unsigned long)file_max);
+        exit(1);
+    }
+    max_fds = MIN(file_max - reserved_fds, max_fds);
+
     if (getrlimit(RLIMIT_NOFILE, &rlim) < 0) {
         fuse_log(FUSE_LOG_ERR, "getrlimit(RLIMIT_NOFILE): %m\n");
         exit(1);
-- 
2.17.1


