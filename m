Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6CEBC04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 12:47:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6BF222ADB
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 12:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n+X/NxBb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6BF222ADB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34627 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXmNM-0000Xp-Oi
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 08:47:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hXmKn-0007F5-IS
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 08:45:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hXmFL-0008TR-PX
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 08:39:28 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:34116)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
	id 1hXmFL-0008R7-K9; Mon, 03 Jun 2019 08:39:27 -0400
Received: by mail-pf1-x442.google.com with SMTP id c85so1764766pfc.1;
	Mon, 03 Jun 2019 05:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=K42CkPeucn8W+B9II/bfKD2EsCVdQuGyHCr2h0lXa8c=;
	b=n+X/NxBbs+Hq5iDd8EJXRunXYWS19W1ohehfKN5ZQ+oDJ4zjqN9Y7ICL5fzLsAL/VF
	LCrbLgmNkNeSRCF9Xz1XTp8T9KEgFr/3XKD4YMkQ8X4nMKggVKXomQBpKRGK+Kamu2us
	6qDgPyGd5Gr6djULxU3m6aEhnxpZa8C9fAT/nu27H+HpF1kbaA4N+EQj9Zrcn95q/Tch
	DuD1wfmi94DUkAElixlp1iIjBtzHDF16RoOOiJcooZX0/MS6VPgofs1v5fUe7Z0zDTPI
	0J7ChZV1MS5thn7tk4Jp26zn+cAvdEyBDcLuKKMP4nQSNFLmzjY+dZbn+Y/r5wmODuLe
	NDPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=K42CkPeucn8W+B9II/bfKD2EsCVdQuGyHCr2h0lXa8c=;
	b=gk1eNgEtdSwrUIskOgkPDc6Dbe1dE9GLCFojIQHD9FG5VzLrzfoprocWKOKA3Vaffs
	EVkItYSufbielPpJLAYG6UzofZYVZx6+CYCjXOAS+c38LtGgzCA6fD2bLDAik+WL0ChY
	oVaEEhwgw9xdm4SV/f3nIPSzzzrtzp3civrCsu5yN+BiHf1EAKR2n4yLKn1p3ut6xwy6
	u8f8oLhrZHdRCR1lvZFa8kvXq3WxM3lSQu/62wXZk3SNg7wDaNkoFy8y+qgLfQWeN9l3
	pAzQxXqJHNnJgUZYo3BHynUyEBl+PjfQdn3Q/NyYUErP5KZO1q3gznocRoS9gbPvzO0q
	pLsg==
X-Gm-Message-State: APjAAAWJOhgtwj7tubGETqaeHv98gWXkwBoHLUdSEHBbXyLfgInR22OZ
	of0NolKVq1HQ7FwRtjOwAb2vkf6yEa3s4g==
X-Google-Smtp-Source: APXvYqzxUDtkvYmYzexVz2tGG3u/FzIydbknrZ6oCErX0tBtLwqoKYwifYNM6vJ/WwFQjS0zdZE0VQ==
X-Received: by 2002:a63:dc15:: with SMTP id s21mr14644859pgg.215.1559565566293;
	Mon, 03 Jun 2019 05:39:26 -0700 (PDT)
Received: from localhost.localdomain ([136.233.9.100])
	by smtp.gmail.com with ESMTPSA id
	k14sm34860257pga.5.2019.06.03.05.39.20
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Jun 2019 05:39:25 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon,  3 Jun 2019 18:08:21 +0530
Message-Id: <20190603123823.32661-8-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190603123823.32661-1-mehta.aaru20@gmail.com>
References: <20190603123823.32661-1-mehta.aaru20@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH v4 7/9] blockdev: accept io_uring as option
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
	qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
	Max Reitz <mreitz@redhat.com>, saket.sinha89@gmail.com,
	Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Julia Suvorova <jusual@mail.ru>, Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
---
 blockdev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/blockdev.c b/blockdev.c
index 17c2d801d7..58a9e69268 100644
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
@@ -4568,7 +4570,7 @@ QemuOptsList qemu_common_drive_opts = {
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


