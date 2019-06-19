Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B034C31E5B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 19:57:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BA4F20B1F
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 19:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rxqFVkAI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BA4F20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41510 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdghX-0003Jy-EJ
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 15:56:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53971)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hdgRe-0006AW-IM
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 15:40:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hdgRc-0000Al-Io
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 15:40:34 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:39008)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hdgRa-00007A-Pr
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 15:40:30 -0400
Received: by mail-wr1-x42e.google.com with SMTP id x4so487840wrt.6
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2019 12:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XPPAW9sETduxZJ0ooFzD4w+7btkzMy95F7Mgcr+ef2Q=;
 b=rxqFVkAIueAr1gkdbJPVfgsA4HfIDUpegE4dnUx3mBtXWfbr0IC8WBqkHqj0+0DUfL
 3xk+Lp/BZVqSgKAO83vlk1r6L2j1LxOJ9rVoIvNkUkGsWYnukmkYG043FT/8WZAN1xnt
 gqdxmT8X6XSJrssBodM3SBLPtv7V1w7Vi/HybQaxA+kXV2opOzOhaRY1sirQxEBTO89S
 WhxvT5WKTuhwIwyFEWdi4nsjTkPPM4miy8uKDeJdibAG8jW1IAMTlOUm3y+e9wr+kg6B
 RpmqTPnET2VCqx/Uan99kQcqwDoGMN/HRjOPWuFHOsLZOBwCPCNkfSbPKK68V22qde7B
 k2Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XPPAW9sETduxZJ0ooFzD4w+7btkzMy95F7Mgcr+ef2Q=;
 b=PecIkEs8iO/0gZIte8x554+nhZ9giTU2gGnh8gvZMQ793gzMflCs0j087D7W6h3EBy
 aieqvcNosqACOmC3G+B5DHYp1ZCtbPOFqMexTGZ0SCAMt881YKJ4bu2sQAAkj4L7F9Wh
 3T1krZ8odLJ/ACYQephpBo6WQj8orb2ikRA3/SvTGzOiCpf2AMMUNN/XAr1Lf8suEBpC
 BSwXbKythm9ul/VEoCvlxR19H+8S5bSa3JslCxEsoqTwIdAoe7SaJgGvuwYOgTLB6LAF
 rSQxdZWMk6GfVNVYu/Ub28BXRurwjUPun1N5t0ooZAEJYSM00K5rhMya1vyfLsfDS0HM
 Jdyw==
X-Gm-Message-State: APjAAAUPKaMAuiImXAAasdeVqiOtO4of1MFWAZlrQVUp7z6bTc7XkXrf
 UMSnA0tzI6FNrTMcj6M/JEXCWw==
X-Google-Smtp-Source: APXvYqyQJ3F7R6BDKj086DqngrKCLhq7ddVn56j56JTw3h0u7Oe+LDHahgzuem3IpXko//D6dOOH5g==
X-Received: by 2002:a5d:618d:: with SMTP id j13mr10421354wru.195.1560973228499; 
 Wed, 19 Jun 2019 12:40:28 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id t14sm14845097wrr.33.2019.06.19.12.40.23
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 19 Jun 2019 12:40:26 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 210121FF98;
 Wed, 19 Jun 2019 20:40:22 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 19 Jun 2019 20:40:12 +0100
Message-Id: <20190619194021.8240-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190619194021.8240-1-alex.bennee@linaro.org>
References: <20190619194021.8240-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42e
Subject: [Qemu-devel] [PATCH  v1 08/17] tests/vm: proper guest shutdown
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
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

When not running in snapshot mode ask the guest to poweroff and wait for
this to finish instead of simply quitting qemu, so the guest can flush
pending updates to disk.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190617043858.8290-5-kraxel@redhat.com>
[AJB: added tags]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/vm/basevm.py | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 395eefaec9..f27178f3c7 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -51,6 +51,8 @@ class BaseVM(object):
     name = "#base"
     # The guest architecture, to be overridden by subclasses
     arch = "#arch"
+    # command to halt the guest, can be overridden by subclasses
+    poweroff = "poweroff"
     def __init__(self, debug=False, vcpus=None):
         self._guest = None
         self._tmpdir = os.path.realpath(tempfile.mkdtemp(prefix="vm-test-",
@@ -202,6 +204,10 @@ class BaseVM(object):
     def wait(self):
         self._guest.wait()
 
+    def graceful_shutdown(self):
+        self.ssh_root(self.poweroff)
+        self._guest.wait()
+
     def qmp(self, *args, **kwargs):
         return self._guest.qmp(*args, **kwargs)
 
@@ -278,11 +284,13 @@ def main(vmcls):
         traceback.print_exc()
         return 2
 
-    if args.interactive:
-        if vm.ssh(*cmd) == 0:
-            return 0
+    exitcode = 0
+    if vm.ssh(*cmd) != 0:
+        exitcode = 3
+    if exitcode != 0 and args.interactive:
         vm.ssh()
-        return 3
-    else:
-        if vm.ssh(*cmd) != 0:
-            return 3
+
+    if not args.snapshot:
+        vm.graceful_shutdown()
+
+    return exitcode
-- 
2.20.1


