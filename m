Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFFBC28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 10:37:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 695E724213
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 10:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X1sEQNqZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 695E724213
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51034 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWIR2-0002St-MT
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 06:37:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWI6g-0002js-OO
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:16:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWI6f-0006eO-RV
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:16:22 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:39180)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hWI6f-0006dD-K0
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:16:21 -0400
Received: by mail-wm1-x32f.google.com with SMTP id z23so3460006wma.4
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 03:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=9uHkcMcsE9fyEwD5PKdvI++8JESJlTBOyqyYuFuuSZE=;
	b=X1sEQNqZbd4mlCH6UlYXnKT8C5RngBph4LPyHKT0/zM7GR4nhpA75kDAL+Hms7IWCA
	LrOnEJ6LlbWNxqgyqqvyfyS2/DFzGpTD1PA4kWiA9DwJ46B76SBNb/1v6vjcyaQHzYS1
	70Rc20sQy7y0EIWNLUDJ0nszdSw27mARIMVgSlLx/ZOeJf8KD8iL+SRmDLIwGRyqruo5
	761cw5G/Kgaqx8qOr64v3MwwQblCnwTZi7qcV0qncZjr8L8NH2dxfySxr2jkLKwKh3Gt
	fEAoYbVu3zuixIMvgWGbsmPtQxil7MHDQ007hkIclLv10jqDwD6W0r8TAxpCg+b1YFqI
	u7Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=9uHkcMcsE9fyEwD5PKdvI++8JESJlTBOyqyYuFuuSZE=;
	b=ngmkxG520l0WXvNZPhQuljcQeEzK0m84pEj1xkT3ttreFNj+rMIuB3UlE1vqurexmr
	huVN9QpVtd1tHPtNCSOWOgk+XQo9+59Ggq+8tBGtm99BKcyw63OCWdqCB0zDmcJurCpg
	RJHtuvhEbRq6VLC36n8Q3MWdo3C6wTu8ahu6oTcK1qsI8AUt4ny6xBpsTD16brWkxvHl
	u9mFmxDe//BBswa3Ud4ANcv/oVcmL/4XeWhMgNt0yRtljUOTFqX9yybxDaocMYtz+gHJ
	HCh+e5r6euQGaaxY81iFtS9v5D0AL8dlYZGalzMvjXPVNuJjfXijMHDQPat2r2srBN+B
	TMxg==
X-Gm-Message-State: APjAAAXyoLA/UxeZCz8mb3P9HsKEe6o5DFbytfLIDDLDzDNo/VVts30c
	cLEh1+ul7TZOEpQj1uyHhrjjlA==
X-Google-Smtp-Source: APXvYqyIkMhQYYZ0CApOcZbBcjaNPMmTg9qio/noONhXDjVQsco7L5f9nddIuw1x9kixtBGT+qikNg==
X-Received: by 2002:a1c:6154:: with SMTP id v81mr1648078wmb.92.1559211380553; 
	Thu, 30 May 2019 03:16:20 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	h90sm7066459wrh.15.2019.05.30.03.16.10
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 30 May 2019 03:16:18 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 86F201FFA6;
	Thu, 30 May 2019 11:16:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 30 May 2019 11:15:55 +0100
Message-Id: <20190530101603.22254-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190530101603.22254-1-alex.bennee@linaro.org>
References: <20190530101603.22254-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::32f
Subject: [Qemu-devel] [PATCH  v1 18/26] tests/vm: proper guest shutdown
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
Message-Id: <20190520124716.30472-7-kraxel@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/vm/basevm.py | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 395eefaec94..f27178f3c7c 100755
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


