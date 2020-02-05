Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5BCC35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 21:36:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7BE72072B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 21:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qGqdd/0x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7BE72072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izSLL-0001bW-53
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 16:36:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47297)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1izSJ0-0005F3-O5
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 16:33:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1izSIz-000695-KB
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 16:33:54 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430]:36880)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1izSIz-000684-Dw
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 16:33:53 -0500
Received: by mail-pf1-x430.google.com with SMTP id p14so1883309pfn.4
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2020 13:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=u1zXQRTCt65TSYwJmTXjVmOnrC3M0DDokMmWoCnk7AI=;
 b=qGqdd/0xD0gvMFcvR5BE7RJBtSb6tNz9tRwXs3pt0ZzRayk8YDKDXhsWRDUh3pxUPx
 q4iHrqbPCXvNVD9uTrsFPkdJO0TsJl9v+JGMMmwF5Sx9EjhwE+NkXiETsRjGn4ZRxN8Q
 BHp3EoEgc0dwhWH15BkZiZH0AsFpJchzuhMomzzA62F4ofSxLUU0nvzj7z3HB44n48XX
 PEj0UELwiFrFFE3DTp7LzbM4N/OJDxDDrp0iNRRiOPczR3V2Ig6RJV1cP+0QP5WNh0+T
 cMqklLqkSp/mCL09Ek5RFLu06Q5Wfq0a842gtm9bxJwWnbdyFuJNp3fGPT4qtENVvOVb
 QHJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=u1zXQRTCt65TSYwJmTXjVmOnrC3M0DDokMmWoCnk7AI=;
 b=kCVdMU1FtJTbN2v+oHqm0YBDRx4AT5ucCmBLz4NKdkkSpaoTHQKEfEf9xV0IWkwVtA
 OPhjpyNGdVLiimdCOoAs1ET+EOqzcIJTGfNFoYKwDh10kriXToLf7eZBzX6iW1++IuUM
 Swi5qzhS7yaQgigOc9M+fbrp9XOWODuKyKQJTJWYxT3h1vEdqBBhM16t1W6VrqEGQuhH
 v2CI39pCVrRHtKVL0GL+N3QOPk3zlScNqDfuHqliECrGz/1/Cck0w5jTDm6sRY5lo/52
 R5KtUHAlOHfDF2RbElIcIBrrvNm2Oca+2T176Zl5ajpRq3qEnew/2ZYojERIQuUWZEj5
 lHug==
X-Gm-Message-State: APjAAAVGrlKha66t81isXQHE0kbCA3mzINfyQFB2hSk7SmUCN/wlE3X0
 OU8Wj89jc/Kg7yS/4BAxIj2B9Fa0K6o=
X-Google-Smtp-Source: APXvYqxxgwOgnKxKvjUX9TKTprlfKqyONxsB2Y/7F4qzSRT2ZWErP98bxDLyOsQV8l1FdH50FXcH+w==
X-Received: by 2002:a63:d60a:: with SMTP id q10mr11548460pgg.244.1580938432093; 
 Wed, 05 Feb 2020 13:33:52 -0800 (PST)
Received: from Rfoley-MA01.usrd.futurewei.com ([12.111.81.71])
 by smtp.gmail.com with ESMTPSA id p4sm724576pgh.14.2020.02.05.13.33.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 13:33:51 -0800 (PST)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 04/14] tests/vm: give wait_ssh() option to wait for root
Date: Wed,  5 Feb 2020 16:29:10 -0500
Message-Id: <20200205212920.467-5-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200205212920.467-1-robert.foley@linaro.org>
References: <20200205212920.467-1-robert.foley@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::430
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
Cc: fam@euphon.net, philmd@redhat.com, alex.bennee@linaro.org,
 robert.foley@linaro.org, peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Allow wait_ssh to wait for root user to be ready.
This solves the issue where we perform a wait_ssh()
successfully, but the root user is not yet ready
to be logged in.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 tests/vm/basevm.py | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 4de358ae22..a29099f6f1 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -314,7 +314,7 @@ class BaseVM(object):
     def print_step(self, text):
         sys.stderr.write("### %s ...\n" % text)
 
-    def wait_ssh(self, seconds=300):
+    def wait_ssh(self, wait_root=False, seconds=300):
         # Allow more time for VM to boot under TCG.
         if not kvm_available(self.arch):
             seconds *= self.tcg_ssh_timeout_multiplier
@@ -322,7 +322,10 @@ class BaseVM(object):
         endtime = starttime + datetime.timedelta(seconds=seconds)
         guest_up = False
         while datetime.datetime.now() < endtime:
-            if self.ssh("exit 0") == 0:
+            if wait_root and self.ssh_root("exit 0") == 0:
+                guest_up = True
+                break
+            elif self.ssh("exit 0") == 0:
                 guest_up = True
                 break
             seconds = (endtime - datetime.datetime.now()).total_seconds()
@@ -333,7 +336,6 @@ class BaseVM(object):
 
     def shutdown(self):
         self._guest.shutdown()
-
     def wait(self):
         self._guest.wait()
 
-- 
2.17.1


