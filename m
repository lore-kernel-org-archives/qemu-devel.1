Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3F4C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 17:19:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49056217D7
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 17:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zeaxHLxx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49056217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58309 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOmhZ-0007jp-Fi
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 13:19:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hOmU6-0003oV-T5
	for qemu-devel@nongnu.org; Thu, 09 May 2019 13:05:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hOmU4-0008Ci-LU
	for qemu-devel@nongnu.org; Thu, 09 May 2019 13:05:30 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:56074)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hOmU4-00086D-B5
	for qemu-devel@nongnu.org; Thu, 09 May 2019 13:05:28 -0400
Received: by mail-wm1-x32c.google.com with SMTP id y2so4152735wmi.5
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 10:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=muJ0lhsFZDTe5BSnwOJzWaWmbULUUdO9c3pN21PKLLc=;
	b=zeaxHLxxcJQveWOqTBef0MWfX70Bj7Y1sFIH5+gmKF3irTA9bmFTKeNHKbKrBC5Dym
	OTwYpa10ks0jhN0KHt5p+htPZVJIXyj7pdLAi5n5fvd0GoWhnozmD37SdayOESID47gj
	yzpuhulsGC8IQ+1F/19VZsuUGnxfSJIw/iV1fwZrR76WmKnH0v8b/AKAYxTeKz50l9b2
	cZSd4nO1ZWx2k1twx/Yc+2YgXfMPF2h4NjMm0VTm9bhlkT+oVwkI6sM5DGCylC0jzaIU
	3ZtL7AMbyOInLJJ8AE3TAHqEUV5LVSiSD9inSe5oL37vx8VedSmPXp6wYA1p+lFAwdfM
	K9sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=muJ0lhsFZDTe5BSnwOJzWaWmbULUUdO9c3pN21PKLLc=;
	b=GqCvU8c6e/fWRpUsgpKJQ8sT+jZrOGKRtCPJ5o32MwPXQq1vtDnOuB0GZmqNaVPB/W
	DezxH2Wh2VELqGcchlsYK3IfwyDIi6WaDefFuy/eQR8bNn3sY4NyfmjFyWLp4khX7Wxh
	5DVnBVmXlU7bjcSCC3FwUoE63cOwDpIsp9Up3ZVUkbzv1aMt/oJtbebxX9cFZOT+8GxJ
	2n+jEuPG7aqBx8bt4Q5Vi1z6R8oV3mcAtsdXMJ6qa3YCtCsXYj3DXwzozQOb0nAKky/3
	73jcH7O2Icphj3Jror/AaLPEmEu/xBHpzVjf9iX1jvSejvjNsWu7HJYmhF9P6tplSlCU
	T+BA==
X-Gm-Message-State: APjAAAUAIYaPoQFexBy3k/mV+fy6NZVPApP8iQHECkbzaOxARcergGNE
	HnNXHPvw1XQofBXgHc1aafeibw==
X-Google-Smtp-Source: APXvYqyvOjaClIcV1sYTaUvLOlWqkYiD3UmmLAnsvG4P8abeM/e5j5OU36HlSaA4qwFqzEcx7JF/0w==
X-Received: by 2002:a05:600c:552:: with SMTP id
	k18mr3743590wmc.67.1557421521849; 
	Thu, 09 May 2019 10:05:21 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	a184sm3939204wmh.36.2019.05.09.10.05.20
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 09 May 2019 10:05:20 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 609E41FFA3;
	Thu,  9 May 2019 17:59:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  9 May 2019 17:59:04 +0100
Message-Id: <20190509165912.10512-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190509165912.10512-1-alex.bennee@linaro.org>
References: <20190509165912.10512-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::32c
Subject: [Qemu-devel] [PATCH v1 16/23] tests/qemu-iotests/005: Add a sanity
 check for large sparse file support
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
	"open list:Block layer core" <qemu-block@nongnu.org>,
	Max Reitz <mreitz@redhat.com>, qemu-arm@nongnu.org,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

"check -raw 005" fails when running on certain filesystems - these do not
support such large sparse files. Use the same check as in test 220 to
skip the test in this case.

Suggested-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190502084506.8009-2-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/qemu-iotests/005 | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tests/qemu-iotests/005 b/tests/qemu-iotests/005
index 2fef63af882..9c7681c19bc 100755
--- a/tests/qemu-iotests/005
+++ b/tests/qemu-iotests/005
@@ -55,6 +55,15 @@ if [ "$IMGPROTO" = "sheepdog" ]; then
     _notrun "image protocol $IMGPROTO does not support large image sizes"
 fi
 
+# Sanity check: For raw, we require a file system that permits the creation
+# of a HUGE (but very sparse) file. Check we can create it before continuing.
+if [ "$IMGFMT" = "raw" ]; then
+    if ! truncate --size=5T "$TEST_IMG"; then
+        _notrun "file system on $TEST_DIR does not support large enough files"
+    fi
+    rm "$TEST_IMG"
+fi
+
 echo
 echo "creating large image"
 _make_test_img 5000G
-- 
2.20.1


