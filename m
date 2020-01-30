Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419B9C35240
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 11:40:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EDF8206F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 11:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lwJIruzm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EDF8206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ix8BE-0002wm-6e
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 06:40:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36055)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ix89p-0001IU-MU
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:38:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ix89n-0008SZ-Sb
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:38:49 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36135)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ix89n-0008Qy-M3
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:38:47 -0500
Received: by mail-wr1-x442.google.com with SMTP id z3so3659662wru.3
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 03:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=M9KSOTkD2gWoA2RLWk5PfVdgjpzXgtuWL43hbZNcZ5Q=;
 b=lwJIruzmDYfg3vjvfNBmnbGbxYzty8zs/v83Q8SinaJDm6mhushLklxoxbkVcicPT9
 fObAPmErAgSEBtqg2rgjxfRXo2AafrsAwVnILKYEVEAGq5ri4pckcR+O2nVNyX+Kr4cz
 PZfzsC6eVszGiJie8GRgoU2KW5Q4xSFuQOrRftrVDz5OckT4tIQTVFI9PKLO4IDXkb6D
 WHbPdKHurn7mGBNGHq7+DdzmUH8Bf+rApiEEXGC3/8SOAMccvqz85Ppo5gb66vfM8OPJ
 xXMfODk9RsfYOcq+sbxSHLUBkbI/uM5mh/6G9NSmJBTzrNSe+4VGZwPmKkVezMOpK+LT
 dTjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=M9KSOTkD2gWoA2RLWk5PfVdgjpzXgtuWL43hbZNcZ5Q=;
 b=qNCWjJLBn7QG4G9g9ouTavGQA492gMb70zfUM3CLzTV4xr9hbzcZitO4pVqvlI8m/T
 +TQajaSsLhjITIuknSU5OAUS/ovNtX+4RwTkIzCib565BGd7Rm5vfiop2xKTC86vXmVv
 +z5TZttv432oiiPt0MSllm0C5jKEL3eWTk2kyy5jgD1jw7SFPPD0AajOKVZM4SPhByCg
 EmpKAQr0dgnhdkNidI/PvTp5g76ouDRT4Q36znEYOWQDtaDZKam7wxBRw2xH/9sosePi
 1hE44fnQIEDQRGMEEz+rc+xRct8Wohfn2i/ng4+NB3Mta8ZXhWnb3Qt5ofA1NVreNryl
 BG1w==
X-Gm-Message-State: APjAAAXa5BLxo+gt4sI9zrD+bkmQGMhX1JKDaiaisDetxyavKV7drhtZ
 8OWTIbQR+g/BABJ9pI6o3dX7mMF1fa0=
X-Google-Smtp-Source: APXvYqyCDuX9fba8FaR157Gxilrbq42vxKXCKm1yqjPne4roAkNgJrBA9nAK23dSqU/uVjUbEuYAEQ==
X-Received: by 2002:adf:e5cf:: with SMTP id a15mr4926326wrn.140.1580384325785; 
 Thu, 30 Jan 2020 03:38:45 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id i2sm6275325wmb.28.2020.01.30.03.38.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2020 03:38:43 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 610901FF8F;
 Thu, 30 Jan 2020 11:32:23 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 02/12] tests/docker: better handle symlinked libs
Date: Thu, 30 Jan 2020 11:32:13 +0000
Message-Id: <20200130113223.31046-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200130113223.31046-1-alex.bennee@linaro.org>
References: <20200130113223.31046-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When we are copying we want to ensure we grab the first
resolution (the found in path section). However even that binary might
be a symlink so lets make sure we chase the symlinks to copy the right
binary to where it can be found.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/docker.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 31d8adf836..7dfca63fe4 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -109,7 +109,7 @@ def _get_so_libs(executable):
     ensure theright data is copied."""
 
     libs = []
-    ldd_re = re.compile(r"(/.*/)(\S*)")
+    ldd_re = re.compile(r"(?:\S+ => )?(\S*) \(:?0x[0-9a-f]+\)")
     try:
         ldd_output = subprocess.check_output(["ldd", executable]).decode('utf-8')
         for line in ldd_output.split("\n"):
@@ -145,7 +145,8 @@ def _copy_binary_with_libs(src, bin_dest, dest_dir):
     if libs:
         for l in libs:
             so_path = os.path.dirname(l)
-            _copy_with_mkdir(l, dest_dir, so_path)
+            real_l = os.path.realpath(l)
+            _copy_with_mkdir(real_l, dest_dir, so_path)
 
 
 def _check_binfmt_misc(executable):
-- 
2.20.1


