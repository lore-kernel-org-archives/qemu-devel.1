Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B8BC28CC3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 09:58:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EF7C20B7C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 09:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UMd1PW81"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EF7C20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47696 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZBdp-00060g-5t
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 05:58:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42203)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hZAvT-0002FZ-Ak
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:12:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hZAvQ-0004z0-P7
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:12:43 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36633)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hZAvQ-0004py-Dg
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:12:40 -0400
Received: by mail-wm1-x342.google.com with SMTP id u8so1159985wmm.1
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 02:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OhQM4ORyyZtDRv68wtOcg3+xNW2e7yr94fMwCAempbk=;
 b=UMd1PW81Nj/a3TRplm/lgKp2JXzvoHSJjTtZll+c7phGlQWKWg5mwWODsWvI8+kmDL
 IVHMaE9yVLb3cnlOZODLztG3EBldrEDme4wzEaQ6RetdQB3ATrDs8fiX4V74uRIHRQE0
 xeDWyFzu8EUy+3VUQlgO19fHB25paTllhKVcUW0B7Gy9n9RMHMb3ExApVE/s9Pi84O/k
 eiSEk/o+oYhx9bGWDgw6+7R9+FJ25/mbhs0umEPjRB/hJGn6/nZprASBU9zzmmgMLNxf
 nBrwr1IBKPLeXIGEs3irxDU/JD2l3JZcbEpl5BX4xsuWbHXHZJBlNhAL1asmwwq91I5f
 Cucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OhQM4ORyyZtDRv68wtOcg3+xNW2e7yr94fMwCAempbk=;
 b=DA3MzbaPsaMlAFZI+5j6xevFJ5uOu90sRUB4KMdfZ74Tmy+0xDx6Ty2cVAwn9zcqPk
 A+6zgfeV3FZ3Cy1wkVFYHdqGw4kbym2dOP9cYhqr3HKG8/RicouxdobG6OBnaxy9NFCw
 3mEN7NQDbBHkrzK/BtBnIjrBpeh621lChGMVZEo6W5qFtXDQb+Uee2utX9WlNqifOO5W
 I0JwRmuAilA5zGxAmR309UunXoVSj9bSl1Dqil+SzxXBW8AYkXbO+E1bdjq9HSR9hN7d
 qwK9cDOaga1SxNIfLD0xK/r/AZYVvjMTud+aNXTb22RvT1g7m2SXlgjvX4VpLMXdNdCr
 hh0Q==
X-Gm-Message-State: APjAAAWqUVjfrEuv6SoyUvw2AKwLgkFBhjoHzm0lPR8k3xqhpDB4w5lX
 cMSVKh7PAEdYuh8JGj0Ro8LZAA==
X-Google-Smtp-Source: APXvYqwR2WoFhETcC0+cb0jjzvNQM6kyeAStJmVvsXAaTwZHA+AUOXZQkx7HeSKxfucuFyS0geO9yw==
X-Received: by 2002:a1c:5412:: with SMTP id i18mr2798141wmb.11.1559898756112; 
 Fri, 07 Jun 2019 02:12:36 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id k13sm1066954wmj.10.2019.06.07.02.12.30
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 07 Jun 2019 02:12:32 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0E0901FF87;
 Fri,  7 Jun 2019 10:05:53 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Fri,  7 Jun 2019 10:05:12 +0100
Message-Id: <20190607090552.12434-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190607090552.12434-1-alex.bennee@linaro.org>
References: <20190607090552.12434-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PULL 13/52] tests/vm: python3 fixes
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
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
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

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 083befce9f..4847549592 100755
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


