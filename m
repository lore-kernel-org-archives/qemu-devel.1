Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D18AC28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 10:27:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49C41218DA
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 10:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O56u2QoN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49C41218DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50695 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWIHL-0002zt-GS
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 06:27:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWIFE-0001EL-Ez
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:25:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWIFC-0000Gq-VK
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:25:12 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35939)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hWIFC-00004y-NL
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:25:10 -0400
Received: by mail-wm1-x344.google.com with SMTP id v22so3489000wml.1
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 03:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=cCiZUh4L2IhfBkOcPLSzMZiMaGor1Q+neTC7jHeJYrM=;
	b=O56u2QoNY9oNO8vrbzs8wgl/wHsOmo9d5QufBecCQecm5KrjpChZR3S2U7kgXObvfR
	rMGKqnjBJDmXRpIpAAHwYH2npDiBOs+ww7v6n/xpA/w+k/2zHoNaVlAxe4r+vkPCpbZT
	egN9fcGcBhC6WYjYAho8ZG25WTGl+0tDYvpAPuKlLy1WoRSKbKVWLTMgneANYbWeJaZ+
	yEyocS1D8ySUvO9vg3e3Mr7yYZTA56aIbP++3TJxDfxW5HzAhfITUHt9PF03YUxRCh49
	6Yum5wjefv8ofdDmhH8eU91vKlO/NpuAJ6OtN16fB3nS036HoI5C2APU4XBgsbSbF4J0
	eyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=cCiZUh4L2IhfBkOcPLSzMZiMaGor1Q+neTC7jHeJYrM=;
	b=eOtnPpI4G2qVVXcF1pkmq8V2jrXskSeDDm6E/vvwSpc1Umhh2oQXqQ3BPJt07CuDKf
	6+ih07BEiHtGz4dS9HW0vLxHkvlqMyVK6t1alU6UMiv0Ta9S+sAfvdlJ42D3zeqcp73y
	EmEcwBuss4d+RxaYJ8O07ZXOlJ4yNVviiKjUhkKwkrff/KZu6ggW2S2qUnZ9tdK4H0YM
	If1/dLSdmgeBDVOKXGxUzBwRp/KDblvn8JO7hus0ji99PaqM1k+6hdA3lme4hiC4vIM1
	fzcYrQe5Bb9WNDJuBCzm1lYTtlLiqxmImmEePacxpWl6OE9cojZBVg2bEwYK6kVM+vFB
	yPQw==
X-Gm-Message-State: APjAAAUPppNzAiJLiIZZIP+W2zOR1RTm7jJOipj4wHFmBdTdFeiY1EkI
	5fMyOqqxq23WuymbMisK8sGQ+Q==
X-Google-Smtp-Source: APXvYqzqGGBcw7DFlPv+otwQ0w3RiZKgcp8+SLyvczVN3qOKx/Avebiidsp25pQR1it9FVAZvTuIWg==
X-Received: by 2002:a05:600c:c4:: with SMTP id u4mr1809023wmm.96.1559211902477;
	Thu, 30 May 2019 03:25:02 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	h90sm7115328wrh.15.2019.05.30.03.25.00
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 30 May 2019 03:25:00 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 351D61FF9E;
	Thu, 30 May 2019 11:16:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 30 May 2019 11:15:51 +0100
Message-Id: <20190530101603.22254-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190530101603.22254-1-alex.bennee@linaro.org>
References: <20190530101603.22254-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH  v1 14/26] tests/vm: python3 fixes
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
	Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

Add proper unicode handling when processing strings.
Also need to explicitly say we want int not float.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190520124716.30472-3-kraxel@redhat.com>
[AJB: fix conflicts with tests/vm: Port basevm to Python 3]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/vm/basevm.py | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 083befce9f5..4847549592d 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -73,7 +73,7 @@ class BaseVM(object):
             "-vnc", "127.0.0.1:0,to=20",
             "-serial", "file:%s" % os.path.join(self._tmpdir, "serial.out")]
         if vcpus and vcpus > 1:
-            self._args += ["-smp", str(vcpus)]
+            self._args += ["-smp", "%d" % vcpus]
         if kvm_available(self.arch):
             self._args += ["-enable-kvm"]
         else:
@@ -85,12 +85,13 @@ class BaseVM(object):
             if not sha256sum:
                 return True
             checksum = subprocess.check_output(["sha256sum", fname]).split()[0]
-            return sha256sum == checksum.decode()
+            return sha256sum == checksum.decode("utf-8")
 
         cache_dir = os.path.expanduser("~/.cache/qemu-vm/download")
         if not os.path.exists(cache_dir):
             os.makedirs(cache_dir)
-        fname = os.path.join(cache_dir, hashlib.sha1(url.encode()).hexdigest())
+        fname = os.path.join(cache_dir,
+                             hashlib.sha1(url.encode("utf-8")).hexdigest())
         if os.path.exists(fname) and check_sha256sum(fname):
             return fname
         logging.debug("Downloading %s to %s...", url, fname)
@@ -134,7 +135,7 @@ class BaseVM(object):
         raise NotImplementedError
 
     def add_source_dir(self, src_dir):
-        name = "data-" + hashlib.sha1(src_dir.encode()).hexdigest()[:5]
+        name = "data-" + hashlib.sha1(src_dir.encode("utf-8")).hexdigest()[:5]
         tarfile = os.path.join(self._tmpdir, name + ".tar")
         logging.debug("Creating archive %s for src_dir dir: %s", tarfile, src_dir)
         subprocess.check_call(["./scripts/archive-source.sh", tarfile],
@@ -256,7 +257,7 @@ def main(vmcls):
             vm.add_source_dir(args.build_qemu)
             cmd = [vm.BUILD_SCRIPT.format(
                    configure_opts = " ".join(argv),
-                   jobs=args.jobs,
+                   jobs=int(args.jobs),
                    target=args.build_target,
                    verbose = "V=1" if args.verbose else "")]
         else:
-- 
2.20.1


