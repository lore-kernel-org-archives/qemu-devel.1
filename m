Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA98CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 19:32:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D4BC20B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 19:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DeZOUmjD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D4BC20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMztY-0003Ox-MI
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 15:32:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37484)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iMznT-0004ui-Pl
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 15:26:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iMznS-00025d-Hv
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 15:26:23 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39676)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iMznS-000231-Bc
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 15:26:22 -0400
Received: by mail-wr1-x444.google.com with SMTP id a11so3263349wra.6
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 12:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ffy3OIxeLVHFunzuVFuVov7mBJ8H3hjvxjkH7Fg2UW8=;
 b=DeZOUmjDWJZljWTWukP1OOJQim057RBUXLM1kYBxDtwpvPX24KvtItGmbY4HqBEddQ
 2kZEsZHigqpp6YKWThQvvbJjK6MvHe7B+BkTTUPeKepqkPWIm5dIvAw8lxtjxUWhQbQH
 59bFNHWByiYe5z4vBH+8TUeiOteF9LyAwx7ait1RHxAh01XoWQyMDMnA0fWH6JvVn7P5
 XkLQKU2OYy2/d9Fg0hx9ZG30pIaB6WIav/x5xM5eUeteFos1opn7MtbFjnH895Njp3T5
 sKvz7QR4uUkwRET81ePNEf+bs+IINR5t+Utd6DvQEJ54Fl7CQuCXF/a8sqPL/D15vtk5
 S2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ffy3OIxeLVHFunzuVFuVov7mBJ8H3hjvxjkH7Fg2UW8=;
 b=EuCbJcJH5A2jxmQr9zPWiv1HsNxoFkb06fH8/M7dNOijhhhUWN6O7iy/eal656ifkP
 ifGhuk2os7CeoviSTmsKLM+GyThS01OHI91XW6QXSR13NsSTjcn1eMv++NaOCQMqeR0M
 De1ogYsAZTJy+NNsBHDvuzbcn36mnHItR8VxOZsSHJL6V/abFj+Ue558RPbaZoJRwJYh
 m2/08MjTwc3GT31LPHKQEfSfSIKD9DbfOJJQ3movIIVJErz3UAHkBNeka7ayeascE7+N
 T5jYD8XDoN1aH2YebULD6UWRxLKRAHRX2uGc7/d9Yt5eBiUzzhVRJkwIA3qNy1v47FVE
 wXWQ==
X-Gm-Message-State: APjAAAV8GRfhZ93SnOcfT9jYQ/as6Gm8rqufzK29uK4KwaRdT2HA+ngG
 dtpBCOSBbhCYZeC5s5ZD7VlMLA==
X-Google-Smtp-Source: APXvYqyLHxUiR2wExjDGzRw94SuCZW555UyjjRscbBJGROFNhOM2xk5zn8s8vXb30QsVibCRbMKjqQ==
X-Received: by 2002:adf:9b9d:: with SMTP id d29mr4943329wrc.293.1571772379700; 
 Tue, 22 Oct 2019 12:26:19 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 37sm30238721wrc.96.2019.10.22.12.26.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2019 12:26:19 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B01BA1FFA3;
 Tue, 22 Oct 2019 20:17:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 16/19] iotests: Test 183 does not work on macOS and OpenBSD
Date: Tue, 22 Oct 2019 20:17:01 +0100
Message-Id: <20191022191704.6134-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191022191704.6134-1-alex.bennee@linaro.org>
References: <20191022191704.6134-1-alex.bennee@linaro.org>
MIME-Version: 1.0
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

In the long term, we might want to add test 183 to the "auto" group
(but it still fails occasionally, so we cannot do that yet). However,
when running 183 in Cirrus-CI on macOS, or with our vm-build-openbsd
target, it currently always fails with an "Timeout waiting for return
on handle 0" error.

Let's mark it as supported only on systems where the test is working
fine (i.e. Linux, FreeBSD and NetBSD).

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20191022072135.11188-4-thuth@redhat.com>
---
 tests/qemu-iotests/183 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qemu-iotests/183 b/tests/qemu-iotests/183
index 04fb344d08e..ab5a7089549 100755
--- a/tests/qemu-iotests/183
+++ b/tests/qemu-iotests/183
@@ -42,6 +42,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 . ./common.qemu
 
+_supported_os Linux FreeBSD NetBSD
 _supported_fmt qcow2 raw qed quorum
 _supported_proto file
 
-- 
2.20.1


