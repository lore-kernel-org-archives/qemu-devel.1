Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4C0C28CC3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 09:12:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE58F212F5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 09:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jrjz6t7i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE58F212F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47150 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZAuz-0000yo-1R
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 05:12:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39433)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hZAp3-00049I-LO
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:06:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hZAp1-0004Yk-Uf
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:06:05 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:52972)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hZAp1-0004Og-DP
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:06:03 -0400
Received: by mail-wm1-x32f.google.com with SMTP id s3so1214914wms.2
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 02:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gEge0ZwKN/zoSSUTfhu4Nam9XSCwRb2HyAYOFmNXZHE=;
 b=Jrjz6t7ihJQGYki1ve73MhmpkWG8s2o/OEF56FwMl5+iJRn/Xt1XT9hbj7aYWi7l/1
 UZxFYIpP23xfa5g0opH03aKtMD+A3aCL2mW5SOUkrsGj4YeaYwx+wHirupLBFOuNJl8f
 VAshmcxpS8jmcmmTCOlhijPuzv4jUwm4VwRFNVbeAdyVTSU985g4YaGw4cokGclbKJ/T
 iWpUG9N718ggNYG1SWOQDChZV1ZuqfDPMw0zPn6R1315fP8rY++ibZLdK6IR5Nng8PE5
 q4pi5G9gTiBQfZt4VJgmQhDlDNPKRy17b5sJQYxGA8psvc0YSWDI9AAqCj16uJNqkHGq
 8vhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gEge0ZwKN/zoSSUTfhu4Nam9XSCwRb2HyAYOFmNXZHE=;
 b=PF2acfCXT6JJCHCHd3r11xPNbpyiSLrXyfZDgKeWfQF/8Tlw472/tcJXINW9ICLZax
 LLg/udN5ke362tFQ0XQgKa2m/6Eq/87j69RNSih3N8xjNP+K3dTt5IOdNetLJN7Lrpm1
 mmCOOjBs57pGZuYg7utLG2zfo/N+4mxFbiHPA3PyMu9gR9JJ93MKfAIM8c/JUxnLf333
 SisY2oFjl2hX1zL28Rx0fa9K+8jTu9iCYS/va7COAr+n4zLumaE6OxkcvRpZ4DFhONe+
 dPCdYJcGtHQgx5V6iWHbLVFjcZuHL817lsR1Q7gOIHKc2XIBA4zsWaLjXLjkGC5iA87V
 0A1w==
X-Gm-Message-State: APjAAAWraZD108u90eZ1eSc3BslB1/C3XgxzjK75ctRcyGEVkxFMMGHU
 jd1BDxTVqhPUYKl9N5QEScSAUA==
X-Google-Smtp-Source: APXvYqwlWPB8tv0hFI3HkiB+5Ws88ifekct7O+nZR8qaFY2DrwuycF5WUOeeUkx+SbL+qReNEL8H+Q==
X-Received: by 2002:a1c:9e92:: with SMTP id h140mr2710828wme.82.1559898361131; 
 Fri, 07 Jun 2019 02:06:01 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id k2sm1256475wrx.84.2019.06.07.02.05.54
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 07 Jun 2019 02:05:57 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B5D781FF99;
 Fri,  7 Jun 2019 10:05:52 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Fri,  7 Jun 2019 10:05:08 +0100
Message-Id: <20190607090552.12434-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190607090552.12434-1-alex.bennee@linaro.org>
References: <20190607090552.12434-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
Subject: [Qemu-devel] [PULL 09/52] tests/vm: Port basevm to Python 3
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wainer dos Santos Moschetta <wainersm@redhat.com>

Fixed tests/vm/basevm.py to run with Python 3:
 - hashlib.sha1() requires an binary encoded object.
 - uses floor division ("//") (PEP 238).
 - decode bytes to unicode when needed.

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190329210804.22121-3-wainersm@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 0556bdcf9e..083befce9f 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -85,12 +85,12 @@ class BaseVM(object):
             if not sha256sum:
                 return True
             checksum = subprocess.check_output(["sha256sum", fname]).split()[0]
-            return sha256sum == checksum
+            return sha256sum == checksum.decode()
 
         cache_dir = os.path.expanduser("~/.cache/qemu-vm/download")
         if not os.path.exists(cache_dir):
             os.makedirs(cache_dir)
-        fname = os.path.join(cache_dir, hashlib.sha1(url).hexdigest())
+        fname = os.path.join(cache_dir, hashlib.sha1(url.encode()).hexdigest())
         if os.path.exists(fname) and check_sha256sum(fname):
             return fname
         logging.debug("Downloading %s to %s...", url, fname)
@@ -134,7 +134,7 @@ class BaseVM(object):
         raise NotImplementedError
 
     def add_source_dir(self, src_dir):
-        name = "data-" + hashlib.sha1(src_dir).hexdigest()[:5]
+        name = "data-" + hashlib.sha1(src_dir.encode()).hexdigest()[:5]
         tarfile = os.path.join(self._tmpdir, name + ".tar")
         logging.debug("Creating archive %s for src_dir dir: %s", tarfile, src_dir)
         subprocess.check_call(["./scripts/archive-source.sh", tarfile],
@@ -204,7 +204,7 @@ def parse_args(vmcls):
 
     def get_default_jobs():
         if kvm_available(vmcls.arch):
-            return multiprocessing.cpu_count() / 2
+            return multiprocessing.cpu_count() // 2
         else:
             return 1
 
-- 
2.20.1


