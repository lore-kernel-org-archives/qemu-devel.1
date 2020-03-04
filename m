Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C9AC3F2CD
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 10:04:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A34A42072D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 10:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KrCKUIKj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A34A42072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9Qsv-0001sr-R9
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 05:04:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41610)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j9Qqn-0006zd-KL
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 05:02:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j9Qqm-0000P3-CP
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 05:02:01 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:34279)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j9Qqm-0000KW-6C
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 05:02:00 -0500
Received: by mail-wr1-x432.google.com with SMTP id z15so1621682wrl.1
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2020 02:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iAaxlo38yaH/aDkZ3KTpVwewFX+cb3wfaOvBPGIDGsc=;
 b=KrCKUIKjTyQ7CyIy9hSrRr6uLcDHt/qWqVpvVKYFH3D1yFi/peDHjbKVeXcL46TLpA
 lBK51FG0o1jdgrLBiZE9M27Wl14ngT1Fi5n5Ra6kc/vQt1RMWaJg91TAlgTnk0QBNXXF
 v7rFJQbqRZ5jwfaLwSsALnmfNacKoSVJdC5r+l/nwZvgsiqSQ23w9zO1DkHS07+U+PAb
 gY47fLHlCCBgFMakEobNSqkYjSYcDD50CILNb8+0WTks44vJfa3eeBLGMxwqgjuZzgZT
 ZbTTDVoN27sR4pOspNxPkmkzAL39rKtdQV89Vp0BGeFmBv0gya1JTMWy8eIhLIQXxMXh
 yt9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iAaxlo38yaH/aDkZ3KTpVwewFX+cb3wfaOvBPGIDGsc=;
 b=Z7SaqKMd6oiS1JvSE4Mc9K5JB298QXsM1r1v0ewXPVJ+/EODldZdmc4Y00cwd1q8pn
 bjGGZFGclB5ckWCOMOjIpvKqxyRcm6jUjivOPqOlpJUd3lmLtDYT+N05ZUZRa06AnmhW
 ItqinVw/0m7f9KNass6TSlqlPzx2Q4ID/Nojyh9Hdl9bF42Xw0At7l8vHkV2+ohEfq6Q
 AO7URLu2t2yLiegpBHkiH6z09pok1xuKchv54BTMoXr30v+TXT7rVBhr5XqasqhtgcpW
 MYnsLQOG6arp12ml0WH2LsUqK469xS8+6Oshl9ngbvhJ9tQL71K2YEMzNm6PFnWdtTFi
 2o4g==
X-Gm-Message-State: ANhLgQ05OzOLC5tjdP3IEC8YcJwsXRioST9lkcdqDf1ZkMLm/XKokTwe
 ElqVebsgY9WmU3mhM/Iwppg0pA==
X-Google-Smtp-Source: ADFU+vsUryNkkDiKfZugobzWPBxtyNSPWvPR5uZARy8jPja12THKiDTnW2sFR47kCaDVryNJtZlhog==
X-Received: by 2002:adf:f7c1:: with SMTP id a1mr3289626wrq.299.1583316119092; 
 Wed, 04 Mar 2020 02:01:59 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w1sm3254552wmc.11.2020.03.04.02.01.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2020 02:01:55 -0800 (PST)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 17F631FF8F;
 Wed,  4 Mar 2020 10:01:55 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 2/9] tests/vm: Debug mode shows ssh output.
Date: Wed,  4 Mar 2020 10:01:47 +0000
Message-Id: <20200304100154.14822-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200304100154.14822-1-alex.bennee@linaro.org>
References: <20200304100154.14822-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
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
Cc: Fam Zheng <fam@euphon.net>, Robert Foley <robert.foley@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Peter Puhov <peter.puhov@linaro.org>,
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
Message-Id: <20200303150622.20133-3-alex.bennee@linaro.org>

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


