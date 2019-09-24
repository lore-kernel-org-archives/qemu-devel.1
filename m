Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3EB2C432C2
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 22:50:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC19E20872
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 22:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gVa29m0V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC19E20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCtdV-0006PE-B5
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 18:50:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55616)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iCrw3-0002aI-VV
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:01:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iCrw1-0004Vs-96
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:01:23 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:41599)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iCrw0-0004Ty-VB
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:01:21 -0400
Received: by mail-wr1-x42c.google.com with SMTP id h7so3622391wrw.8
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 14:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RFoZbProsl24GA9ZfU+Hct4z0J5aF/FHMg4gqIlMnro=;
 b=gVa29m0VMXun0GPCn1Vf/T25M9g6r5Oyxjov/2XLvgVN4KWvs+fxiKtgS7t8TfidFw
 BbuoHBWMSJnoALXYlUUxdE80a8UeNLpSwKh89EayLe+Ucm0BwCvR3ppMvnbHfl3dbCHp
 2m1VcBdNbwMNkGbr90GqM3XKqRTu69qMG0QrW4cAwbefCudbSYjz9a9H4r3JIjtlyagp
 E+o1+dRFPlorvghpAjtFG32i/dj+E6fdB89biafWZ+HTkK2LF9VQx2W7V/bc2+ziXzb8
 qXZGOzvYoPPi+9KH8VDWjb98NF7J7IkezzXInZeayw2t9ezFDZIZMdUXKZJ32oF/bkaw
 IdQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RFoZbProsl24GA9ZfU+Hct4z0J5aF/FHMg4gqIlMnro=;
 b=JlxlMFcvhWVElHZ75v37gIAC1Iux+ye8lKnNc9sB6xoq/ABF9vGr6q4ueSF5MWrpAJ
 8GG25RBLKeEeEAsAc7kp6aCxituNcMa1Ex1Q1vtKOmnxni5OEy9j2IQYmTJVhC+xxAjX
 f7jhoi6+riScvf87X6HDb3klhXxrE1YfJ6lXZZFTXlYXV01llzZW9jWtoSNXcLWhgFin
 8aHp1k4gPr+BxFciKUIUee5WctLpXqJ+Vdsbj23gnnrrdHFbe7E8IPssZSvfkaY019Ij
 CmdZuMLHkKt1v620F7BvJrx9U+DUGvTzt3y6a1ynQMaBbGYeD8P97c9VeUvRwP//9FGc
 Ptmw==
X-Gm-Message-State: APjAAAVCJJkC6H6KYnhp7Tvc8oHX1OGVEWMSDrI5WSpFZh55DAzY0SGV
 nP+j5Er/x32IGrJOGYoGb8vnWA==
X-Google-Smtp-Source: APXvYqz7hr6T0xC0js4yP50KaLLDe1VgUeTNvERYOEbHhRWhGdaHrZ+pZB/xV6q+co7Qrq4WXuLkig==
X-Received: by 2002:a5d:45cb:: with SMTP id b11mr4848127wrs.109.1569358878150; 
 Tue, 24 Sep 2019 14:01:18 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y3sm3477438wrw.83.2019.09.24.14.01.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2019 14:01:15 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2AF371FF9F;
 Tue, 24 Sep 2019 22:01:08 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 15/33] tests/docker: reduce scary warnings by cleaning up
 clean up
Date: Tue, 24 Sep 2019 22:00:48 +0100
Message-Id: <20190924210106.27117-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190924210106.27117-1-alex.bennee@linaro.org>
References: <20190924210106.27117-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, jsnow@redhat.com,
 f4bug@amsat.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There was in the clean-up code caused by attempting to inspect images
which finished before we got there. Clean up the clean up code by:

  - only track the one instance at a time
  - use --filter for docker ps instead of doing it by hand
  - just call docker rm -f to be done with it
  - use uuid.uuid4() for a random uid

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - drop the try/except approach and be smarter
  - use uuid4 as uuid1 can generate clashes in parallel builds

fixup! tests/docker: reduce scary warnings by cleaning up clean up
---
 tests/docker/docker.py | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 29613afd489..3112892fdf5 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -215,7 +215,7 @@ class Docker(object):
     """ Running Docker commands """
     def __init__(self):
         self._command = _guess_engine_command()
-        self._instances = []
+        self._instance = None
         atexit.register(self._kill_instances)
         signal.signal(signal.SIGTERM, self._kill_instances)
         signal.signal(signal.SIGHUP, self._kill_instances)
@@ -234,21 +234,19 @@ class Docker(object):
         cmd = ["ps", "-q"]
         if not only_active:
             cmd.append("-a")
+
+        filter = "--filter=label=com.qemu.instance.uuid"
+        if only_known:
+            if self._instance:
+                filter += "=%s" % (self._instance)
+            else:
+                # no point trying to kill, we finished
+                return
+
+        print("filter=%s" % (filter))
+        cmd.append(filter)
         for i in self._output(cmd).split():
-            resp = self._output(["inspect", i])
-            labels = json.loads(resp)[0]["Config"]["Labels"]
-            active = json.loads(resp)[0]["State"]["Running"]
-            if not labels:
-                continue
-            instance_uuid = labels.get("com.qemu.instance.uuid", None)
-            if not instance_uuid:
-                continue
-            if only_known and instance_uuid not in self._instances:
-                continue
-            print("Terminating", i)
-            if active:
-                self._do(["kill", i])
-            self._do(["rm", i])
+            self._do(["rm", "-f", i])
 
     def clean(self):
         self._do_kill_instances(False, False)
@@ -325,9 +323,9 @@ class Docker(object):
         return checksum == _text_checksum(_dockerfile_preprocess(dockerfile))
 
     def run(self, cmd, keep, quiet, as_user=False):
-        label = uuid.uuid1().hex
+        label = uuid.uuid4().hex
         if not keep:
-            self._instances.append(label)
+            self._instance = label
 
         if as_user:
             uid = os.getuid()
@@ -340,7 +338,7 @@ class Docker(object):
                              "com.qemu.instance.uuid=" + label] + cmd,
                              quiet=quiet)
         if not keep:
-            self._instances.remove(label)
+            self._instance = None
         return ret
 
     def command(self, cmd, argv, quiet):
-- 
2.20.1


