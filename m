Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FCAC28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 10:27:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3230125729
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 10:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L+hNcliv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3230125729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50699 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWIHb-0003Dq-DA
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 06:27:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWI6b-0002dd-3r
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:16:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWI6Z-0006Yz-Ng
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:16:16 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38314)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hWI6Z-0006YD-HC
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:16:15 -0400
Received: by mail-wm1-x341.google.com with SMTP id t5so3468383wmh.3
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 03:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=VBYJNdKck0NWEjbEOdu/UU5WU/f6QnZI7h23fVKWf28=;
	b=L+hNclivWdfxNoKP9Bg5hf2z80o79jIPVIg4SR5HEfYzUFc0vWnf2F0ue9qFLldiEr
	4yetA3dJhZqKAfepklZYFmo3CBXUB7GQMX779pmL7qUCq2OcCUO96v41Oj9fYvhfh75d
	Ir5YciGcITLKee7uQfSBYGC7EIQwgO8+gPNoiH9ppdsNdqLHwm2cP4eUeWREWkMAJWux
	U34GYK2BWqxf3aWSTlkA5QK/wrGRnVncjLDlbe68dv7XghiQVQyUIatFosPGgYWWpspx
	aDL9dcVlYmOxUJOHm8ASEM1sR6cZHLV8plAYkZ3hksyqP1csrWrUo8SIg8gRDsIWEW/9
	ur7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=VBYJNdKck0NWEjbEOdu/UU5WU/f6QnZI7h23fVKWf28=;
	b=tZ0jFSZj1rZ/8qDXBfFpoC8VSqKi+amoTlpTRY9Ii58J1dp+iiAdrKRiF9rtMeByLi
	dmfXZYXYEobVO3dzc23trAVKEWlpnsiljkd+0Nl3zwN8zRFoZK1HgZjUbzCK72Ven7kO
	0Z0N9GvZEKwqkRYM1Nvd3bOnzoLLOUR3Ivl66UaTGN6kFdXKVdVs77IHpMwP1tTZKcBF
	gvBOAjxczYiNlmRcz3sbA5fa2TFmNIaBPpfgMNad2nqAnGpTzpK8+uV3Yxc9J78U0Gac
	nnhD6EoHocXFbyRnfNCZAxsshmX1r4rEkgYAK+Xoji9gQbkuj2f+/aYPgie2voQrvwi1
	1YbQ==
X-Gm-Message-State: APjAAAUymBS4Reb/jtuk0Nba8+u+cuXGyo9X9moVRbkWFV4mz9EC8ns0
	LSH5LUFgQbZ1YxkwYl9BCyBf8A==
X-Google-Smtp-Source: APXvYqwh5uWhkwqzfkXG5uWnOwaQfz//Eyss57ef36H+vxIXMZtK7lvQI5WSB+zFlqczjj0Um/xt0g==
X-Received: by 2002:a1c:e3d7:: with SMTP id a206mr1840893wmh.7.1559211374442; 
	Thu, 30 May 2019 03:16:14 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id t4sm2364980wmi.41.2019.05.30.03.16.07
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 30 May 2019 03:16:09 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id D623D1FF9A;
	Thu, 30 May 2019 11:16:04 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 30 May 2019 11:15:47 +0100
Message-Id: <20190530101603.22254-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190530101603.22254-1-alex.bennee@linaro.org>
References: <20190530101603.22254-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH  v1 10/26] tests/vm: Port basevm to Python 3
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
Cc: Fam Zheng <fam@euphon.net>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Wainer dos Santos Moschetta <wainersm@redhat.com>
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
---
 tests/vm/basevm.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 0556bdcf9e9..083befce9f5 100755
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


