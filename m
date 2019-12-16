Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA268C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:12:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75BB3206CB
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OUso2ReG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75BB3206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igoIV-0002cu-GI
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 06:12:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50038)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1igoE5-0005GE-2Q
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:07:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1igoE2-0003dM-Uy
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:07:43 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:47031)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1igoE2-0003bZ-OB
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:07:42 -0500
Received: by mail-wr1-x433.google.com with SMTP id z7so6667559wrl.13
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 03:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7bvQ1VKDvRAorzg0rdjBH3tuWJxl25cthST4/KYuWTc=;
 b=OUso2ReGobunB2AZAsiZhj92belsSBh212Tf7G3ih/Fr6BOqa7S2MPihhvRnnnfOJG
 4I4xnlx56IGewnrTHtnE2TrLUIiBM9uedSJlrcsXgax+UDzhHbkNQ4QjfczXu6Vq8i5b
 PyQrHC3B7IKTgAbGHeY6hLBn+ySZfrSu/k9zukDAG1MQqTuYIoTxYtNMDgGWNSrO4/UV
 MOYiDUTdr37SQb3cWQTIPT7Sct4ZUExoGceFgrUWKGh/W9jGiP41fzpvPjYbYUgsd59N
 j6L4YdPLmpQJsDV7PcZgQkXk5QYqn9pLluPb8GWsDDvtTngrWth7JikKrd+BmQ5OFqJZ
 AW/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7bvQ1VKDvRAorzg0rdjBH3tuWJxl25cthST4/KYuWTc=;
 b=elYUZy0/D9gaMHOxnSSLa2V1QRGInHCtCscyHUZq4dZIGgNiUP5NrOL7056EM4OufR
 JnX7RhDs6F8PgTVLbE7HMCx+YvO7T/COLsurVyFbKlFSvqA+rtwKSbbJYkmMSKVoPa4s
 QGvZYixwtZSWZdRnG+LxDKLj9tdkrEuhr7Os+Gtst+Dyh+9osHnXdzBi0gUxPs2py4op
 vIicHWyUWr+XYhQHry1QblyJqbllBkBvBKoF6WVDEMr9ZVIC/utwI8L25oi7ticOj1NO
 UVhRo9Hprpcl4rRvvW/MzyWqTBBHRpN23nt9xP6Ck1cQ9rQOLqLwts1kUqKvDBFm2KZc
 mJyA==
X-Gm-Message-State: APjAAAU/mf1SSHwvR7u7dnuE4Gd1F+MhsOKBG3OArPiZhgWjJyMXIpGn
 6/ToQhFZery2WGyAzs99bGzFZg==
X-Google-Smtp-Source: APXvYqy4tfSv4WqYKXapA/sJ5NaF30yXgQ0HpwrIGJztNdMMVLqF4qQBPYBeKwmHOHUdIcX/rbvJFw==
X-Received: by 2002:a5d:51c1:: with SMTP id n1mr29255562wrv.335.1576494461681; 
 Mon, 16 Dec 2019 03:07:41 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u10sm20122522wmd.1.2019.12.16.03.07.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 03:07:37 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9A1B21FF92;
 Mon, 16 Dec 2019 11:07:32 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 05/16] iotests: Skip test 060 if it is not possible to
 create large files
Date: Mon, 16 Dec 2019 11:07:21 +0000
Message-Id: <20191216110732.24027-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216110732.24027-1-alex.bennee@linaro.org>
References: <20191216110732.24027-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
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
 stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 richard.henderson@linaro.org, f4bug@amsat.org, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

Test 060 fails in the arm64, s390x and ppc64le LXD containers on Travis
(which we will hopefully enable in our CI soon). These containers
apparently do not allow large files to be created. The repair process
in test 060 creates a file of 64 GiB, so test first whether such large
files are possible and skip the test if that's not the case.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20191204154618.23560-3-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/qemu-iotests/060 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/qemu-iotests/060 b/tests/qemu-iotests/060
index b91d8321bb8..d96f17a4846 100755
--- a/tests/qemu-iotests/060
+++ b/tests/qemu-iotests/060
@@ -49,6 +49,9 @@ _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
 
+# The repair process will create a large file - so check for availability first
+_require_large_file 64G
+
 rt_offset=65536  # 0x10000 (XXX: just an assumption)
 rb_offset=131072 # 0x20000 (XXX: just an assumption)
 l1_offset=196608 # 0x30000 (XXX: just an assumption)
-- 
2.20.1


