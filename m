Return-Path: <SRS0=55mG=TM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D10C04A6B
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2019 16:51:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EC462133D
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2019 16:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eO2KUUE6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EC462133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45265 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hPrgx-0000fp-3s
	for qemu-devel@archiver.kernel.org; Sun, 12 May 2019 12:51:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sp3478@gmail.com>) id 1hPq7z-0003YL-Ox
	for qemu-devel@nongnu.org; Sun, 12 May 2019 11:11:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sp3478@gmail.com>) id 1hPq7x-0006I0-N1
	for qemu-devel@nongnu.org; Sun, 12 May 2019 11:11:02 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:45298)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sp3478@gmail.com>)
	id 1hPq7u-0006Aa-Gx; Sun, 12 May 2019 11:10:58 -0400
Received: by mail-pl1-x643.google.com with SMTP id a5so5114082pls.12;
	Sun, 12 May 2019 08:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=Ebt6rBfRioXzugo4iVq6Vhz0P1s14Wfm0wmZbroY6M0=;
	b=eO2KUUE6D4fgHyQyg57EYPfd+EhrlMSrIqDxhEkSDV7yrvaqgQmHPbqIYl54IRvnuM
	H+rxL17QlBu/nkwqSUeASrM9Vqj5w7O9KXrYuI1OW6tgDfI+hv8bBzKu57TJ0fp/leEQ
	9M4KZEfHgtTvOeC+G4eEilDHYBt1oml1AtNjeSbC5YCxgmIjM5s3ZpeeulCqTncqT4wb
	6kXl9bj3I1iX+uVBS449DVw6fazRSYzueece4hE7H7ar+rNNblLtwo3NzL39x5DyYriT
	ugNR/fJk2brRhlVnpskQoTksDXIWtfqZ5Au76UZMNgUaDObqwcZQttlcI0izEhZKGoq5
	Emjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=Ebt6rBfRioXzugo4iVq6Vhz0P1s14Wfm0wmZbroY6M0=;
	b=SzZO71rnCtsDlmYio6ga3e0dJ2xNHYBOeIXxZAHURS3vTuub8y2hZ+wQLB7GIKOkV8
	kEv9zS9IjVkFZJ5dL1OAA+WNC6kWQp30+qAjHt4ecYCN1yDLAFV4HGFPTu7aMQ68MQ33
	3rukwtS+F5ZG8ZA/gJ2SlZJw24UVQsjyJqNFeXZYbBL8Svz1o+6AJOmRH7eL/hcN7psq
	fmv4WNO41NEA3B1ysGbXQw7SlV2cj7q2vUMTLIFaTevOiMh5MjjRgmDpjImOOg9khhwG
	/kiAvPTrUDXM4WbH7yNxnJb0F9jXWLn7rHKvq0DTWMg1JpuAruRdNqse+VustU1/+z5z
	HXGw==
X-Gm-Message-State: APjAAAXgoopHSC91FEiIClHHH1g6/ArMiBlZ+pJ8vTDEOxK2iYpvHbud
	Nr2NsSPMSnfh2Zo8wqGoVNn5/RkvtlGq6KaJ
X-Google-Smtp-Source: APXvYqxTJXlZ8c/E4KS2V2dnXWN/Nu47w23zjAjsnltpPAxYD9RttA9k/otn+PFDp1AT5f0EwWYb/Q==
X-Received: by 2002:a17:902:aa5:: with SMTP id
	34mr25718171plp.263.1557673853989; 
	Sun, 12 May 2019 08:10:53 -0700 (PDT)
Received: from LEGENDTANG-MB0.ust.hk (wf120-214.ust.hk. [175.159.120.214])
	by smtp.googlemail.com with ESMTPSA id
	v66sm7533220pfa.38.2019.05.12.08.10.50
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sun, 12 May 2019 08:10:52 -0700 (PDT)
From: Wensheng Tang <sp3478@gmail.com>
To: qemu-block@nongnu.org
Date: Sun, 12 May 2019 23:10:48 +0800
Message-Id: <20190512151048.72412-1-sp3478@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::643
X-Mailman-Approved-At: Sun, 12 May 2019 12:47:49 -0400
Subject: [Qemu-devel] [PATCH] block: Make block error codes consistent
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
Cc: Kevin Wolf <kwolf@redhat.com>, Wensheng Tang <sp3478@gmail.com>,
	"open list:All patches CC here" <qemu-devel@nongnu.org>,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We should keep the error handling consistent. ENOMEDIUM is more meaningful than ENOENT a when driver cannot be loaded.
---
 block.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block.c b/block.c
index 5c2c6aa..6685be7 100644
--- a/block.c
+++ b/block.c
@@ -770,7 +770,7 @@ static int find_image_format(BlockBackend *file, const char *filename,
     if (!drv) {
         error_setg(errp, "Could not determine image format: No compatible "
                    "driver found");
-        ret = -ENOENT;
+        ret = -ENOMEDIUM;
     }
     *pdrv = drv;
     return ret;
@@ -1619,7 +1619,7 @@ static int bdrv_fill_options(QDict **options, const char *filename,
         drv = bdrv_find_format(drvname);
         if (!drv) {
             error_setg(errp, "Unknown driver '%s'", drvname);
-            return -ENOENT;
+            return -ENOMEDIUM;
         }
         /* If the user has explicitly specified the driver, this choice should
          * override the BDRV_O_PROTOCOL flag */
@@ -1655,7 +1655,7 @@ static int bdrv_fill_options(QDict **options, const char *filename,
         if (filename) {
             drv = bdrv_find_protocol(filename, parse_filename, errp);
             if (!drv) {
-                return -EINVAL;
+                return -ENOMEDIUM;
             }
 
             drvname = drv->format_name;
-- 
2.20.1 (Apple Git-117)


