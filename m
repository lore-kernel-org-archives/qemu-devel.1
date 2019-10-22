Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90860CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 19:37:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50B89214B2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 19:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kktoz4rO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50B89214B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMzyP-0007ru-FL
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 15:37:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37518)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iMznU-0004wD-Gk
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 15:26:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iMznT-00026K-5t
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 15:26:24 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:39319)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iMznT-00024J-07
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 15:26:23 -0400
Received: by mail-wm1-x334.google.com with SMTP id r141so7674554wme.4
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 12:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QOLEg7xmqkR0qKe9FHUO6HsPeD95QlCUJggtiyjFmQ0=;
 b=Kktoz4rOjD3/indQ0VnDxTqVO+Y5ncCJyy4TthePZts3N2wTjWiX177UIH8VP1A37T
 Q7uyO0PnELr56Hs37bqYt+iF1yHZpBg4ik8MXhbqNEjILVcGKSaWfvJjIBQQZs4OEi1Q
 +5lIjkOoB3o71bpUvW6u+VOjqRdRduEfsAApITDbNpQp2iS6fV8H5MCRC9mE+DMriGsj
 4ox2VeykM7uV95e5wDG0JPaqD8KrLwm6Cz1lY/wpvpxFa6BHF4zJtX9uXtwj5vXgIlXG
 91o8J7XUscm/lyZMxd8YviLLj66pDshIFpVolsdv6Z+92JVDFvmq6LdlXH06rZJKVQ0A
 2HXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QOLEg7xmqkR0qKe9FHUO6HsPeD95QlCUJggtiyjFmQ0=;
 b=L8iXTu8ppvGeFs8O8o3aN0RP9NouwFPemKtd7zYu1HkP92nU6glbeNOZTumBBzFEGx
 dOfBxYyCBbk+EdVCELIg9XwWve5UfUFuOOUHr0EEyHJ+31YPCtVuexRQEQQcj/bM6GTH
 ueVpTCQEFmborNVDn0b2sa6nhvbcmUKtL0qWnzGKqyEZdqDrUiMjjwGaC6wc+pAXvxTG
 C/feVdsxVX691MvLvddQEtNdZk8vNRmjTi9p5l/WQepMGb67MyJvrVx3ZirI7/9Unojz
 A/RnzvAQmfqrPLmvfeX9WPxtt6M7ldCY59FYA68mJ3KJf8YNIx5QbnDnYjZSyMNiC7js
 5tzw==
X-Gm-Message-State: APjAAAXgrikiLedHk+6M99eoZt+7IShH2fHVGMcwc4Xp+VufKKLCgPIi
 4eAjHW50/QMqqUZeqzjHS0UCow==
X-Google-Smtp-Source: APXvYqyy7s7Rj2O8j/UEncfQTx1m0pcgZqvmbXQsimErEF2gjJ5hXCW9eVvdGaPMSWMqgWFegYyRSA==
X-Received: by 2002:a1c:35c3:: with SMTP id c186mr4277780wma.94.1571772380832; 
 Tue, 22 Oct 2019 12:26:20 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s13sm17352070wmc.28.2019.10.22.12.26.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2019 12:26:19 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DC0D01FFA6;
 Tue, 22 Oct 2019 20:17:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 18/19] iotests: Enable more tests in the 'auto' group to
 improve test coverage
Date: Tue, 22 Oct 2019 20:17:03 +0100
Message-Id: <20191022191704.6134-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191022191704.6134-1-alex.bennee@linaro.org>
References: <20191022191704.6134-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::334
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
Cc: fam@euphon.net, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, berrange@redhat.com,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 stefanb@linux.vnet.ibm.com, richard.henderson@linaro.org, f4bug@amsat.org,
 Max Reitz <mreitz@redhat.com>, cota@braap.org, stefanha@redhat.com,
 marcandre.lureau@redhat.com, pbonzini@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

According to Kevin, tests 030, 040 and 041 are among the most valuable
tests that we have, so we should always run them if possible, even if
they take a little bit longer.

According to Max, it would be good to have a test for iothreads and
migration. 127 and 256 seem to be good candidates for iothreads. For
migration, let's enable 091, 181, and 203 (which also tests iothreads).

Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20191022072135.11188-6-thuth@redhat.com>
---
 tests/qemu-iotests/group | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index a73df279e5e..33b499ed410 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -51,7 +51,7 @@
 027 rw auto quick
 028 rw backing quick
 029 rw auto quick
-030 rw backing
+030 rw auto backing
 031 rw auto quick
 032 rw auto quick
 033 rw auto quick
@@ -61,8 +61,8 @@
 037 rw auto backing quick
 038 rw auto backing quick
 039 rw auto quick
-040 rw
-041 rw backing
+040 rw auto
+041 rw auto backing
 042 rw auto quick
 043 rw auto backing
 044 rw
@@ -112,7 +112,7 @@
 088 rw quick
 089 rw auto quick
 090 rw auto quick
-091 rw migration
+091 rw auto migration
 092 rw quick
 093 throttle
 094 rw quick
@@ -148,7 +148,7 @@
 124 rw backing
 125 rw
 126 rw auto backing
-127 rw backing quick
+127 rw auto backing quick
 128 rw quick
 129 rw quick
 130 rw auto quick
@@ -197,7 +197,7 @@
 177 rw auto quick
 178 img
 179 rw auto quick
-181 rw migration
+181 rw auto migration
 182 rw quick
 183 rw migration
 184 rw auto quick
@@ -218,7 +218,7 @@
 200 rw
 201 rw migration
 202 rw quick
-203 rw migration
+203 rw auto migration
 204 rw quick
 205 rw quick
 206 rw
@@ -270,7 +270,7 @@
 253 rw quick
 254 rw backing quick
 255 rw quick
-256 rw quick
+256 rw auto quick
 257 rw
 258 rw quick
 260 rw quick
-- 
2.20.1


