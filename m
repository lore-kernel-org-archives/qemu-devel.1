Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98720C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 19:14:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 628A32072E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 19:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQQZXd0H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 628A32072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioXpV-0001Nr-HD
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 14:14:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46251)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1ioX4v-0003MZ-Jy
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:26:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1ioX4u-000508-Bz
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:26:13 -0500
Received: from mail-qv1-xf44.google.com ([2607:f8b0:4864:20::f44]:44709)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1ioX4u-0004zT-8L; Mon, 06 Jan 2020 13:26:12 -0500
Received: by mail-qv1-xf44.google.com with SMTP id n8so19408060qvg.11;
 Mon, 06 Jan 2020 10:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mpfIHJqJRcqC4Yq+ELUmZkb3CWZtgP1HlVj632oKpm4=;
 b=SQQZXd0Hkm27bw09ihFgZpDdMnFMt5UqLm7MMQo1Baw8csh13X325ESiZ2a1n8di4I
 cyg1Ew9ipVOzN8liH9UcttZCbJLe/gOj2CM40aXfsn8Sbo3RHMztenxxNu6gS4pnHQW2
 fWwuDVvHANdc1mvbwIi77g+qf0bq9yOpjg1ibzdqD5vqS1tWIjiGF+HkxCnoBEd00G4S
 35z8jlkaqxPX7FaBTq5cGBn2qP5Wylc58mLQtvWfuDSFe6TAORRbyHpo8oFZTowueK79
 zod7gGyH4aCn3f+f7Ni46cHhb5oe26WybhsHJnQ3MrLmDno1hagR+BiWfNIZKsaNhib9
 G/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mpfIHJqJRcqC4Yq+ELUmZkb3CWZtgP1HlVj632oKpm4=;
 b=eZbYU4SBhVA6NP7OJgYB+h3uefhkwV09yiyaCDyF54/OGha9rpzLSRYl8n3gcaqBvQ
 dPz4T9fgjhZSrXTnU5/y4VdgLNVowK0imO95qYaZKul4itMUc8+BkkEfrHKiyfu8jC27
 B+mBC34qp8kyEpgbEfy67pdBTTaymaR87uc5uVKdazZiTaVogoUuadPSI1AOATfcP+Oa
 jd+GQ/2ZITImLNvIDl29X2sXQYB/9DQoPe0YNtJ6yg3IzW8A7D+u/9jfzfl06l+cOSyG
 1KHPT9K7fPafpQgGlamAL/IJeXipmWkA3YDBW1Uupl5zYN8eTicNE645dKK8lWGksBnV
 Ofgg==
X-Gm-Message-State: APjAAAUc6XOednrUgJjv5ECToPUsTYxYBOXBkQneKpRAGXX8xZvcjrz6
 bhZMGFsQUM4PAUiRBJURlkMoKtH7
X-Google-Smtp-Source: APXvYqxmtVPcSIQ61YfaX5ax6qApQhozK+8b0/vmjFHP/QdsenqVJrYHT3fEy/D5ZOY2OaML8pv2SA==
X-Received: by 2002:a05:6214:118d:: with SMTP id
 t13mr78133928qvv.5.1578335171686; 
 Mon, 06 Jan 2020 10:26:11 -0800 (PST)
Received: from rekt.ibmuc.com ([2804:431:c7c6:655b:9e1c:e865:3705:e1df])
 by smtp.gmail.com with ESMTPSA id b81sm21026522qkc.135.2020.01.06.10.26.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 10:26:11 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 44/59] 9p-local.c: remove unneeded label in
 local_unlinkat_common()
Date: Mon,  6 Jan 2020 15:24:10 -0300
Message-Id: <20200106182425.20312-45-danielhb413@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106182425.20312-1-danielhb413@gmail.com>
References: <20200106182425.20312-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f44
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
Cc: qemu-trivial@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

'err_out' can be replaced by 'return ret' in the error conditions
the jump was being made.

CC: Greg Kurz <groug@kaod.org>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/9pfs/9p-local.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index ca641390fb..f9bdd2ad7c 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -1094,12 +1094,12 @@ static int local_unlinkat_common(FsContext *ctx, int dirfd, const char *name,
 
             fd = openat_dir(dirfd, name);
             if (fd == -1) {
-                goto err_out;
+                return ret;
             }
             ret = unlinkat(fd, VIRTFS_META_DIR, AT_REMOVEDIR);
             close_preserve_errno(fd);
             if (ret < 0 && errno != ENOENT) {
-                goto err_out;
+                return ret;
             }
         }
         map_dirfd = openat_dir(dirfd, VIRTFS_META_DIR);
@@ -1107,16 +1107,14 @@ static int local_unlinkat_common(FsContext *ctx, int dirfd, const char *name,
             ret = unlinkat(map_dirfd, name, 0);
             close_preserve_errno(map_dirfd);
             if (ret < 0 && errno != ENOENT) {
-                goto err_out;
+                return ret;
             }
         } else if (errno != ENOENT) {
-            goto err_out;
+            return ret;
         }
     }
 
-    ret = unlinkat(dirfd, name, flags);
-err_out:
-    return ret;
+    return unlinkat(dirfd, name, flags);
 }
 
 static int local_remove(FsContext *ctx, const char *path)
-- 
2.24.1


