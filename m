Return-Path: <SRS0=55mG=TM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1497BC04A6B
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2019 16:49:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5D4C2133D
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2019 16:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4T5nwde"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5D4C2133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45210 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hPres-0007Zx-PC
	for qemu-devel@archiver.kernel.org; Sun, 12 May 2019 12:49:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sp3478@gmail.com>) id 1hPqgY-0001ZT-Vd
	for qemu-devel@nongnu.org; Sun, 12 May 2019 11:46:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sp3478@gmail.com>) id 1hPqgY-0001pF-38
	for qemu-devel@nongnu.org; Sun, 12 May 2019 11:46:46 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:46803)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sp3478@gmail.com>)
	id 1hPqgW-0001me-03; Sun, 12 May 2019 11:46:44 -0400
Received: by mail-pl1-x643.google.com with SMTP id r18so380273pls.13;
	Sun, 12 May 2019 08:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=Kik0fJl/2iMZFqWKyvyA3O5RdlpXtiD5DVAADEVguEA=;
	b=Q4T5nwdeGOGTx/WILyk4aNyX8RTfTcUGnynWG1mW4nzRFTwOFGEkycEIxOPIZZTm/D
	skUCn1Yrjg2uXnGPWbfQ/QSgpNo7yBCHRFJ2OJkkKFg8O2tQNKLbWuLymOmv3DlEYl6a
	8fGZXBvkEUmsmEugQa91tsEex+EWAxAAO6JpVcUF7YHS/uN9J+CQC1wZFJ+VigfwXcJ7
	nXQruyaWJlK/CBnp1lv0xXRG0AfFmzezbW6Rfr8auX6xFap6ImaRFzEKTfvFNVmcgwFU
	dhO2/YxbSt+G8ZJTrDaPy2GH2QuGOj/w3pTDVWQaQUbstBy0ftA3z0YhuLEnSfyrlScZ
	HT+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=Kik0fJl/2iMZFqWKyvyA3O5RdlpXtiD5DVAADEVguEA=;
	b=AnRIRL96sO4LhzENQJgh/rp+JJ/+5jD9JqL5lI9Qxi3nJG6cf4qqv3Xbc/icjMpv3J
	5bLG+08INVrllQ6xRVbt9wIkRYHtLs906Paiiy/xToCVBdFDCd/44RoYEkHT5kH9nCEt
	nVHzHyqmQ3msE5zWja/iiyiviVaMhHGesAmWDVCt69tnyRT4IeVbZ77oHzMKkGw768Bn
	kyEnQ1Pl1Yo8isv21CmcElN+2uVz9NWy80bcpbcA/18aTrf+Skky1wLqt6GORt37Fnxs
	vApVrPBqds3VHjSUjaYQnsiamfDFR05wgDMEcVW8uIRDA0izQZ6hmT63kNLZtgMvgcUH
	HaDA==
X-Gm-Message-State: APjAAAVQkrvF5+Z4s5NumajOTO5N7dupa3rABXhBtfdjMBL+4Bca8iZX
	jh5em5dlbWF53d+6W7UB7KQJbkXsjVmeE9EB
X-Google-Smtp-Source: APXvYqxqjz2bXKEJkIkWaf3IffyGJh1V8pVh/26ag0S7U7h4e9WzN9gqG4RNRvEAtv4kZLdUqTMiLg==
X-Received: by 2002:a17:902:5995:: with SMTP id
	p21mr25975831pli.216.1557676002463; 
	Sun, 12 May 2019 08:46:42 -0700 (PDT)
Received: from LEGENDTANG-MB0.ust.hk (wf120-214.ust.hk. [175.159.120.214])
	by smtp.googlemail.com with ESMTPSA id
	125sm2382037pge.45.2019.05.12.08.46.40
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sun, 12 May 2019 08:46:41 -0700 (PDT)
From: Wensheng Tang <sp3478@gmail.com>
To: qemu-block@nongnu.org
Date: Sun, 12 May 2019 23:46:20 +0800
Message-Id: <20190512154620.84143-1-sp3478@gmail.com>
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

(The last email does not include signed-off-by line. Please ignoreit)

We should keep the error handling consistent. ENOMEDIUM is more meaningful than ENOENT a when driver cannot be loaded.

Signed-off-by: Wensheng Tang <sp3478@gmail.com>
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


