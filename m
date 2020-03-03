Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1127CC3F2D7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 15:08:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D41362073D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 15:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VCcgBaZ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D41362073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j99A6-0007Qq-1L
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 10:08:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42574)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j997s-000367-P7
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 10:06:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j997r-0001jG-R9
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 10:06:28 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42133)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j997r-0001j2-Km
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 10:06:27 -0500
Received: by mail-wr1-x444.google.com with SMTP id z11so4737445wro.9
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2020 07:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PvyE/wDJzCAUXXdIR5tpKONlcMYLdIwfZqfJA8Zfq+Y=;
 b=VCcgBaZ5LBRJDSn7859AL+dCLtFIfNwRjC+jBQ0RqPU16qRT/rUloXc2UhyktKDQ8O
 qq71ZWlohGEUI8wjGPwgQ+LH1kmc2r15vkucTwd8YoVbhsOKpOZNrAozy/sSYOINfLO/
 Ax4qF0PSJwZ4MWkhYjwtcmYRcauXRqI8xrtV6q9ZL94W8XL7FXDO9s8wlJLfHwkloA7B
 1ipIMOsfTZfyNnzpJjYOuuzr7OIlHMKA6lCXa7zkYL2PWSY/b+nBqSRlDYbGa6A0pKUD
 RbZZj6GtLTLsJoypknTTHkvlql14VBviDcdwVHAy+oq7UD5wUnqB9f1T4LDADFIDasjM
 w9Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PvyE/wDJzCAUXXdIR5tpKONlcMYLdIwfZqfJA8Zfq+Y=;
 b=I+unIddXZFfxJj2ebPBSlDQ5qI64edbauuzmTkpbxGsIPKlkNWr4jPBqUab1Bc9xXF
 qS2WwQKsz9YzJFfdr/nYeRjmrL/vHuzVWmOwCOnSUmp2bJnI32Urv/cXQx4Yueu5/P4z
 vggs3yB14HOQ17qWnOq9TIBA8AXREgOKJfXXHKeZWnkveTU5os+Tgs+jMkvLJWcwrs+l
 WGOBVvwFRhS+wyQg5IWnHRbXXIMz+Sbuia1FCuAak288sUr9xSYD7RdXYXpip6osDiDN
 pJ3peAwg+9U5eukcDgoJPlIwlUIy8RJNbO5DbCcTsY46w77eoU2D+/cmyN+0gUFd0ZwQ
 4ufw==
X-Gm-Message-State: ANhLgQ3Xd9K9Pr1+uy60JjQk4t7LozZvAJXqs1NgpRDsyylfRafYO73p
 F4a7E44QjpWHz3j/L7eDAPUlgQ==
X-Google-Smtp-Source: ADFU+vtbBq24WphECc0DQ3H+r/8fjtzq4rO+pdBZk+SnKMG/ngygqzfkn1NKeTHgEkZwVXUDxSeXyQ==
X-Received: by 2002:a5d:42c6:: with SMTP id t6mr6253621wrr.394.1583247986633; 
 Tue, 03 Mar 2020 07:06:26 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z13sm6040160wrv.94.2020.03.03.07.06.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2020 07:06:24 -0800 (PST)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C40951FF8F;
 Tue,  3 Mar 2020 15:06:22 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 2/9] tests/vm: Debug mode shows ssh output.
Date: Tue,  3 Mar 2020 15:06:15 +0000
Message-Id: <20200303150622.20133-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200303150622.20133-1-alex.bennee@linaro.org>
References: <20200303150622.20133-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Fam Zheng <fam@euphon.net>, Peter Puhov <peter.puhov@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Robert Foley <robert.foley@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Robert Foley <robert.foley@linaro.org>

Add changes to tests/vm/basevm.py so that during debug mode we show ssh output.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200219163537.22098-3-robert.foley@linaro.org>
---
 tests/vm/basevm.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 4dee6647e6e..c99725b8c0d 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -120,11 +120,16 @@ class BaseVM(object):
         return fname
 
     def _ssh_do(self, user, cmd, check):
-        ssh_cmd = ["ssh", "-q", "-t",
+        ssh_cmd = ["ssh",
+                   "-t",
                    "-o", "StrictHostKeyChecking=no",
                    "-o", "UserKnownHostsFile=" + os.devnull,
                    "-o", "ConnectTimeout=1",
                    "-p", self.ssh_port, "-i", self._ssh_key_file]
+        # If not in debug mode, set ssh to quiet mode to
+        # avoid printing the results of commands.
+        if not self.debug:
+            ssh_cmd.append("-q")
         for var in self.envvars:
             ssh_cmd += ['-o', "SendEnv=%s" % var ]
         assert not isinstance(cmd, str)
-- 
2.20.1


