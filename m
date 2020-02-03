Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B77C3524D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:10:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2D4C2070A
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XokhQpBE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2D4C2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyXkd-0008El-W2
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 04:10:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47641)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iyXje-0006Rx-Gf
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:09:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iyXjd-0000kR-FU
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:09:38 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:39238)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iyXjd-0000in-9O
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:09:37 -0500
Received: by mail-wr1-x430.google.com with SMTP id y11so16895623wrt.6
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 01:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bJVPdPbPDIO3CTMf6DLXKYbai7SRpNMMODbXla883Mo=;
 b=XokhQpBEFKzmF8nRsZ9RJY1J/AQyd26oqfHgx+wbyUV1Oh0dSPdxdjzUJM4DsgmFK7
 8py4dQapULoyZWQ2k+oZSdZ5tQKu0jyulFU1/BbicZqe2nPq5HcysUMkT+ZfmZZPCEBR
 sWFuQuPeakm/vD2+40FsZ6waFS2LoSqKhOxPxl4K38pg/yc7ZxNiFUILGf5Erzf0MiL2
 9rww/xocFSEkxoIWgY+hspoNvsPbnddWJbXYloBFWCyCTUFgJj9MOggwl+meOUKMsJYn
 jLnHi2LoVqK8fO4FSAUybb25TqkcMwej8DGy5R1VDVGVEnep9bJNqXkDFwlAYvZR6Eoz
 e/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bJVPdPbPDIO3CTMf6DLXKYbai7SRpNMMODbXla883Mo=;
 b=JbOxgSqES9UPYqpNuXq8w8D8mpP7vAKJr04d6OERIPLoBLHyQixTE/iB4QMoSFTEi8
 Kd+n1p549RdT02WOYqDoPJuInMX/C+Ohsn7cI1Yz4qki4mciQqFz33nvsmr9pDRLL38N
 xSbLjEMBCAO69eGBxrOgqeieTSI09Hx8cKOxUWW46mn+Pr8V4W8xkGjUWDAFjjawqGfn
 WYwe2HpS5kv5ZNKDyWi7mNkcM6P+t8Y5J0Tywm3FqcvcdtnFobnHXNsK0VB7AMc6YMrI
 zulde+ba31DoRxJOCPIoqyD1IfQcfTcqJwxs93FprD1dO0wp+YgPhDWVQYi45w8xPhGi
 nd/Q==
X-Gm-Message-State: APjAAAVa4whmiZvEVEgAn7WKzZknEM2IoN5GfvTgKz4CITN4ZcwwfadZ
 Q/kYSzfiHK6fX40aQzS06n+kuA==
X-Google-Smtp-Source: APXvYqy2JhCJlYK10qraXWswULM98zKzuU64pAam0tPUrXbb5Iv6qse7SHz2eqLneujum4IGCYGaGQ==
X-Received: by 2002:adf:ea8a:: with SMTP id s10mr13469585wrm.278.1580720976318; 
 Mon, 03 Feb 2020 01:09:36 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y8sm21941926wma.10.2020.02.03.01.09.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 01:09:34 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 83FB71FF8F;
 Mon,  3 Feb 2020 09:09:32 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 02/17] tests/docker: better handle symlinked libs
Date: Mon,  3 Feb 2020 09:09:17 +0000
Message-Id: <20200203090932.19147-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200203090932.19147-1-alex.bennee@linaro.org>
References: <20200203090932.19147-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

---
v3
  - fix comment
  - fix grouping extraction
  - try/except on IndexError
---
 tests/docker/docker.py | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 31d8adf836e..d8268c11117 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -106,18 +106,19 @@ def _get_so_libs(executable):
     """Return a list of libraries associated with an executable.
 
     The paths may be symbolic links which would need to be resolved to
-    ensure theright data is copied."""
+    ensure the right data is copied."""
 
     libs = []
-    ldd_re = re.compile(r"(/.*/)(\S*)")
+    ldd_re = re.compile(r"(?:\S+ => )?(\S*) \(:?0x[0-9a-f]+\)")
     try:
         ldd_output = subprocess.check_output(["ldd", executable]).decode('utf-8')
         for line in ldd_output.split("\n"):
             search = ldd_re.search(line)
-            if search and len(search.groups()) == 2:
-                so_path = search.groups()[0]
-                so_lib = search.groups()[1]
-                libs.append("%s/%s" % (so_path, so_lib))
+            if search:
+                try:
+                    libs.append(s.group(1))
+                except IndexError:
+                    pass
     except subprocess.CalledProcessError:
         print("%s had no associated libraries (static build?)" % (executable))
 
@@ -145,7 +146,8 @@ def _copy_binary_with_libs(src, bin_dest, dest_dir):
     if libs:
         for l in libs:
             so_path = os.path.dirname(l)
-            _copy_with_mkdir(l, dest_dir, so_path)
+            real_l = os.path.realpath(l)
+            _copy_with_mkdir(real_l, dest_dir, so_path)
 
 
 def _check_binfmt_misc(executable):
-- 
2.20.1


